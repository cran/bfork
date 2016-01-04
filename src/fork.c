/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <R.h>
#include <Rdefines.h>

SEXP bfork_fork(SEXP fn) {
    SEXP res;
    pid_t pid;
    if((pid = fork()) == 0) {
        PROTECT(res = eval(lang1(fn), R_GlobalEnv));
        PROTECT(res = eval(lang2(install("q"), mkString("no")), R_GlobalEnv));
        UNPROTECT(2);
    }

    return ScalarInteger(pid);
}

SEXP bfork_wait(SEXP child_pid) {
    int npid;
    switch(TYPEOF(child_pid)) {
        case INTSXP:
            npid = *(INTEGER(child_pid));
            break;
        case REALSXP:
            npid = *(REAL(child_pid));
            break;
        default:
            PROTECT(eval(lang2(install("q"), mkString("no")), R_GlobalEnv));
            UNPROTECT(1);
    }
    pid_t retpid = waitpid(npid, NULL, 0);
    return ScalarInteger(retpid);
}

SEXP bfork_waitall() {
    while(waitpid(-1, NULL, 0) > 0);
    return R_NilValue;
}
