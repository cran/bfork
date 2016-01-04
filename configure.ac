AC_INIT([bfork], [0.1], [danlrobertson89@gmail.com])
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
    echo "could not determine R_HOME"
    exit 1
fi
if [[ "${OS}" == "Windows_NT" ]]; then
    echo "can not install bfork on Windows"
    exit 1
else
    UNAME=$(uname -s)
    if ! [[ "$UNAME" == "Linux" ]] || [[ "$UNAME" == "Darwin" ]]; then
        echo "could not determine the OS"
        exit 1
    fi
fi
CC=`"${R_HOME}/bin/R" CMD config CC`
CFLAGS=`"${R_HOME}/bin/R" CMD config CFLAGS`
LDFLAGS=`"${R_HOME}/bin/R" CMD config LDFLAGS`
AC_PROG_CC
AC_CONFIG_HEADERS([src/config.h])
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
