+++
title = "Lessons Learned from a Failure"
slug = "lessons-learned-from-failure"
date = 2018-05-08
draft = false
toc = false
categories = ["Musings", "Life"]
tags = ["life", "work", "learning"]
#images = ["/images/posts/2018-04-07-home-depot.jpg"]
+++

At work, am known as someone who gets things done. Even when problems seem insurmountable, I eagerly tackle them and come up with novel out-of-the-box solutions. However, recently, I was in charge of delivering a portion of the product, and it did not go well. I had to get things done by mid-April. However, it wasn't until early May that the work was complete.

Unfortunately, for a significant portion of this time, I was blocked by an external contractor. While there is plenty of blame I could levy towards them, I determined that there are three lessons I want to take away from this situation. By making these small changes, I can make future projects a success:

## Lesson #1: Determine the MVP (Minimally Viable Product)

### Problem

The first mistake I made was giving the contractor the complete design, which included features that wouldn't be needed for the initial release. This resulted in a bloated initial scope and increased the time it took to produce the library I was relying upon.

### Solution

In the future, I will first determine the minimally viable product. I will pursue this first before trying to incorporate future enhancements.

## Lesson #2: Review, Review, Review

### Problem

When the contractor finally produced the required code, while it was functionally correct, it was very sloppy and required a lot of refactoring until it was in a usable state.

### Solution

Instead of simply being focused on the end result and reviewing when the code is completed, I will schedule code reviews at predefined milestones to give earlier corrections.

## Lesson #3: Stay on Task

### Problem

There was a fair amount of testing and last-mile coding that was required after the contractor delivered the required library. Rather than performing these actions in parallel with the contractor's efforts, I did not start them until after the library was delivered, further exacerbating a slipped schedule.

### Solution

Although I wear a lot of different hats, I will focus on the task at hand, mocking whatever I can to ensure that my portion of the code is tested and complete, ready for external code to drop in and integrate. I will not let myself get distracted by less critical tasks when I am blocked, naively assuming that everything will work, forgetting about last-mine efforts.
