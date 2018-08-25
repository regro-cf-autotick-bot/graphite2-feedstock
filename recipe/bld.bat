REM I cannot for the life of me figure out how Cygwin/MSYS2 figures out its
REM root directory, which it uses to find the /etc/fstab which *sometimes*
REM affects the choice of the cygdrive prefix. But, regardless of *why*,
REM I find that we need this to work:
mkdir %BUILD_PREFIX%\Library\etc
echo none / cygdrive binary,user 0 0 >%BUILD_PREFIX%\Library\etc\fstab
echo none /tmp usertemp binary,posix=0 0 0 >>%BUILD_PREFIX%\Library\etc\fstab

set CXXFLAGS=%CXXFLAGS% -std=gnu++17
set MSYS2_ARG_CONV_EXCL="-DCMAKE_INSTALL_PREFIX="

mkdir build
cd build
cmake "-GMSYS Makefiles" ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DBUILD_SHARED_LIBS=ON ^
      -DGRAPHITE2_COMPARE_RENDERER=ON ^
      ..
if errorlevel 1 exit 1

make
if errorlevel 1 exit 1

make install
if errorlevel 1 exit 1
