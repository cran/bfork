\name{fork}
\alias{fork}
\title{Fork a new process}
\description{
  Create a new process given a function.
}
\usage{
    fork(fn)
}
\arguments{
    \item{fn}{a function that takes no arguments and returns no arguments
              that will be run in a new process}
}
\seealso{
    \code{\link{wait}}.\cr
    \code{\link{waitall}}.
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
    wait(pid)
}
\keyword{file}
