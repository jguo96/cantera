#! /bin/bash
# Need to build SUNDIALS with -fPIC and set(CMAKE_MACOSX_RPATH 1)
# Need to have configured programming environment to 'intel' (see CharlesX/EnvironmentSetup for NERSC)
# MUST build Cantera using git-shipped Eigen version, and build CharlesX with a local version 3.2.9
export CANTERA_DIR=$UTILITIES_ROOT/Cantera/2.4.0
export SUN_INCLUDE=$UTILITIES_ROOT/Sundials/sundials-2.7.0/include
export SUN_LIB=$UTILITIES_ROOT/Sundials/sundials-2.7.0/lib
export BOOST_DIR=$UTILITIES_ROOT/boost/1.55.0

scons -j20 build prefix=$CANTERA_DIR \
  CXX=CC CC=cc FORTRAN=ftn python_package=none python3_package='n'\
  optimize_flags='-O3' \
  thread_flags='' \
  warning_flags='-Wall' \
  env_vars='all' \
  sundials_include=$SUN_INCLUDE sundials_libdir=$SUN_LIB \
  boost_inc_dir=$BOOST_DIR/include f90_interface=n system_eigen=n \
  renamed_shared_libraries=n
# above line necessary for -lcantera_shared error in scons test

if [ -z "SCONS_TEST" ]; then
    scons -j20 test
fi
scons -j20 install
