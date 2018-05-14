+++
title = "Java Fixed Work Pool"
slug = "java-fixed-work-pool"
date = 2018-05-09
draft = false
toc = false
categories = ["Geek"]
tags = ["Java", "work"]
#images = ["/images/posts/2018-04-07-home-depot.jpg"]
+++

At work I needed to create a fixed Java work pool. By "fixed", I mean a pool that has no queue: it has a maximum number of workers, and it should not store work if it has no capacity to immediately process.

## Introducing the Players

To accomplish this, I used the following classes:

* `ThreadPoolExecutor` -- Executes work jobs
* `LinkedBlockingQueue` -- Passes jobs to the thread pool
* `ExecutorCompletionService` -- Gets results back from thread pool executions, and provides synchronization

## Instantiation

I created the main thread pool using the following code:

```java
ThreadPoolExecutor executorService = new ThreadPoolExecutor(
    0, // corePoolSize, I set 0 as our work is not "bursty"
       // and waiting to spin up a new thread is not a
       // big deal as we have long-running workers
   maxSize, // The maximum size/capacity of the thread pool
   0, // keep alive time, same reason as corePoolSize, plus a
      // non-zero value will increase time waiting by completion service
      // (see later in this post for details)
   TimeUnit.SECONDS,
   new LinkedBlockingQueue<>(
        1 // Only have a queue size of 1 as we are not actually queuing,
          // it is simply a staging area to pass a job to the queue
    )
);
```

Next, I created the completion service:

```java
ExecutorCompletionService<Msg> completionService =
    new ExecutorCompletionService<>(executorService);
```

## Adding Work

To add a new job, it is given to the completion service (who hands it off to the tread pool). A `Future<Msg>` object is returned, which is a handle to the running thread.

```java
Future<Msg> future = completionService.submit(
    new MsgHandler(message) // Must implement the Callable interface
);
```

## Capacity Check

In order to check to see if new work can be added to the work pool, `ExecutorCompletionService.getPoolSize()` is compared against the `maxSize` passed to ThreadPoolExecutor upon initialization. Note that this only works because I set the keep alive time in `ThreadPoolExecutor` to 0. Otherwise, there would be a delay between capacity availability, and when it would be reported by this algorithm. I'm not sure if there is a better way if ThreadPoolExecutor's keep alive is not zero.

```java
if (completionService.getPoolSize() < maxSize) {
    // has capcity
} else {
    // does not have capcity
}
```

I initially used `ExecutorCompletionService.getActiveCount()`. However, there is a tiny delay between when a job is added to the pool, and when it becomes active. This results in a race condition where my program would think it had capacity, when in fact, it did not. Because I used a `LinkedBlockingQueue` with `ExecutorCompletionService.getPoolSize()`, this drastically reduces the possibility of a race condition. When a job gets added to a `LinkedBlockingQueue`, the call blocks until someone on the other end picks up the message. However, this puts a lot of importance into the capacity check. With this design, if you try to add work when there is no capacity, the main thread will hang until one of the threads in the pool becomes available.


## Blocking vs Polling

While the capacity check could be called repeatedly with some amount of sleep, I didn't want to have this type of polling mechanism. Either you have to set the polling time short, and you waste CPU cycles, robbing it from a thread doing actual work, or you set the polling time longer, and then get into a situation where the program is sleeping, when it could have moved on to the next job. In effect, polling is like one of my kids repeatedly asking: "Are where there yet? Are we there yet? ...", ad nauseam.

Instead, I opted to use a blocking call. If the capacity check (as specified above) indicates the thread is full, I use the `ExecutorCompletionService.take()`. This call blocks until any working thread becomes available. Note that even if you have capacity, this call will block until a thread becomes free. If the thread pool is completely empty and you call this, your program will dead lock.

```java
if (completionService.getPoolSize() < maxSize) {
    // has capcity
} else {
    // does not have capcity ...

    completionService.take()

    // ... but now it does
}

/* Either way, at this point, we are
   guarenteed to have capcity in our thread pool */
```

## Wrapping Up

This is a short rundown of my design, and some snares I encountered along the way. Hopefully this is helpful, and let me know if you have any tips or suggestions!
