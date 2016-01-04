\name{wait}
\alias{wait}
\title{Wait for all children processes to finish}
\description{
    Halts execution until all child processes terminate.
}
\usage{
    wait()
}
\seealso{
    \code{\link{fork}}.\cr
    \code{\link{waitpid}}.
}
\examples{
    ## destination for plots
    dest <- "/path/to/dest/"

    ## example function to be forked
    fn <- function() {
        Sys.sleep(1) # simulate some work
        img_name <- paste("child", i, sep="-")
        png(paste(dest, img_name, ".png", sep=""))
        plot(0,0, xlim=c(0,2), ylim=c(0,2), type="n")
        text(1,1, paste("Child [", i, "]: Hello, World!", sep=""))
        dev.off()
    }
    
    starttime <- Sys.time()

    ## fork the child processes
    for(i in 1:10) {
        fork(fn)
    }
    
    ## wait for all processes to finish
    wait()

    endtime <- Sys.time()

    print(paste("Total time taken to run 10 1s processes: ",
                round(endtime - starttime, 2), "s", sep=""))
    ## Output: (Time taken may vary)
    ##   Total time taken to run 10 1s processes: 1.68s
}
\keyword{file}
