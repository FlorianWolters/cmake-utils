@ECHO OFF

SETLOCAL EnableDelayedExpansion
CLS

SET BUILD_SUFFIX=-build
FOR /D %%G in (*) DO (
  IF "%%G:~-7" neq %BUILD_SUFFIX% (
    cmake -G"Unix Makefiles" -B%%G%BUILD_SUFFIX% -H%%G
    cmake --build %%G%BUILD_SUFFIX%
  )
)

PAUSE
