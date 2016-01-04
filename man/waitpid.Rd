\name{waitpid}
\alias{waitpid}
\title{Wait for a pid to finish}
\description{
    Halts execution until the process identified by the pid given as\cr
    an argument terminates.
}
\usage{
    waitpid(child_pid)
}
\arguments{
    \item{child_pid}{the pid of the child process to wait for}
}
\seealso{
    \code{\link{fork}}.\cr
    \code{\link{wait}}.
}
\examples{
    ## create a function to be run as a separate process
    fn <- function() {
        Sys.sleep(4)
        print("World!")
    }

    ## fork the process
    pid <- fork(fn)

    ## do work in the parent process
    print("Hello")

    ## wait for the child process
    waitpid(pid)
}
\keyword{file}
