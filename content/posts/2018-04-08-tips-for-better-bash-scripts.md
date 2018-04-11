+++
title = "Three Tips For Better Bash Scripts"
slug = "three-tips-better-bash-scripts"
date = 2018-04-08
draft = false
toc = false
categories = ["Geek"]
tags = ["Bash", "scripting", "Linux", "Windows"]
#images = ["/images/posts/2018-04-07-home-depot.jpg"]
+++

Bash is everywhere. It is on Linux (obviously), on OSX, and is even on Windows with the new Linux Subsystem. However, writing scripts can be a bit tricky. However, here are three tips that I've found useful when writing Bash scripts.

## Tip 1: Use Flags

There are three flags that will make bash scripting easier and save you a lot of frustrations:

### Abort on Errors (-e)

When Bash executes a command that fails, by default, it will simply move onto executing the next command. This can lead to some really nasty bugs. For example:

```bash
cd /some/directory/that/does/not/exist
rm -frv
```

In this example, the `cd` command will fail and then it will delete the *current* directory! A lot of heartache could be avoided by using something like this:

```bash
set -e # Enable: Abort on errors
cd /some/directory/that/does/not/exist # This command fails, so bash will exit
rm -frv # This command will never be run
```

### Abort on Undefined Variables (-u)

By default, undefined variables will resolved to an empty string. Let's continue our terrible example:

```bash
cd $some_variable_that_does_not_exist
rm -frv
```

In this example, the `cd` command will change the *current* directory, and all the files there. Contrast that to the following:

```bash
set -u # Enable: Abort on undefined variables
cd $some_variable_that_does_not_exist # The variable is undefined, so bash will exit
rm -frv # This command will never be run
```


### Enable Debug eXecution (-x)

Bash scripts can be really tough to debug. Enabling the debug execution mode will cause bash to print out every command before execution. For example, the following script:

```bash
#!/bin/bash
set -x # Enable: Debug execution
for x in a b c d e f g; do
    echo $x
done
```

Will output the following:

```
+ for x in a b c d e f g
+ echo a
a
+ for x in a b c d e f g
+ echo b
b
+ for x in a b c d e f g
+ echo c
c
+ for x in a b c d e f g
+ echo d
d
+ for x in a b c d e f g
+ echo e
e
+ for x in a b c d e f g
+ echo f
f
+ for x in a b c d e f g
+ echo g
g
```

## Tip 2: Use Signal Handlers

In Bash scripts, you'll often need to create temporary files. If the script crashes in the middle, those files can be left hanging around. At best, this can be a nuisance. Depending on the contents, this can even be a security risk.

Take this example:

```bash
set -e # Enable: Abort on errors
mkdir -p /tmp/cache.$$
./configure --prefix=/tmp/cache.$$
make install
rm -fr /tmp/cache.$$
```

This script will create a temporary directory (side note: `$$` resolves to the PID of the script, to ensure that if the script is run two times concurrently, they won't step on each other) that will be used for installation. If the `./configure` or `make install` command fails, the script will abort and then the temporary directory will be left over.

We can ensure that the cleanup will always be run (other than if the script is killed using -9), by utilizing a signal handler:

```bash
set -e # Enable: Abort on errors

function cleanup {
    echo "Cleaning remporary directories..."
    rm -r /tmp/cache.$$
}

trap cleanup EXIT # run cleanup() right before the script exits

mkdir -p /tmp/cache.$$
./configure --prefix=/tmp/cache.$$
make install
```

Now, regardless if the script executed successfully, had an error, or even if someone interrupted with ^C, the cleanup will still happen.

## Tip 3: Use ShellCheck

Finally, {{<a ShellCheck "https://www.shellcheck.net/">}} is a static analysis tool for Bash. I have found ShellCheck to be invaluable, as it finds and reports potential pitfalls and errors. You can either run using the online tool, download it as a standalone tool, or run it as part of your editor or IDE. Personally, it run it using {{<a ALE "https://github.com/w0rp/ale">}} with the {{<a NeoVim "https://neovim.io/">}} editor.

That's it! I hope that you find at least one of these tips useful :)
