# bfork
R library for spawning and managing multiple processes (**b**asic process **fork**ing for
R). A paper thin wrapper around `fork()` and `waitpid()`.

The package consists of three major functions `fork`, `wait`, and `waitall`.

### Example 1
```r
    # destination for plots
    dest <- "/path/to/dest/"

    # example function to be forked
    fn <- function() {
        Sys.sleep(1) # simulate some work
        img_name <- paste("child", i, sep="-")
        png(paste(dest, img_name, ".png", sep=""))
        plot(0,0, xlim=c(0,2), ylim=c(0,2), type="n") # create canvas
        text(1,1, paste("Child [", i, "]: Hello, World!", sep="")) # write text to canvas
        dev.off()
    }
    
    starttime <- Sys.time()

    # fork the child processes
    for(i in 1:10) {
        fork(fn)
    }
    
    # wait for all processes to finish
    waitall()

    endtime <- Sys.time()

    print(paste("Total time taken to run 10 1s processes: ",
                round(endtime - starttime, 2), "s", sep=""))
    # Output: (Time taken may vary)
    #   Total time taken to run 10 1s processes: 1.68s
    #   Ten images at `dest` with "Child [<child number>]: Hello, World!" in the center
```

### Example 2
```r
    # example functions to be forked
    fn1 <- function() {
        Sys.sleep(2) # simulate some work
        print("Multiple")
    }

    fn2 <- function() {
        Sys.sleep(5) # simulate more work
        print("Processes")
    }

    print("Hello")

    # fork the processes
    pid1 = fork(fn2)
    pid2 = fork(fn1)

    # wait for both functions to finish
    pid1 = wait(pid1)
    pid2 = wait(pid2)
    # Output:
    #   Hello
    #   Multiple
    #   Processes
```

**Note:**: While the above example does use `print` it is not advised to do so when forking
processes

## Why `bfork`

Because time is important, so why waste it.

## Who is `bfork` written for

If you have a R script that calls the same function that has a long runtime
multiple times which also sends its output to a separate file, `bfork` is
for you. E.g. if you're like me and you make a lot of plots in loops (See
Example 1)
