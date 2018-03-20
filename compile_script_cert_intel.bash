#! /bin/bash
# Need to build SUNDIALS with -fPIC and set(CMAKE_MACOSX_RPATH 1)
export CANTERA_DIR=~/local/cantera/2.4.0/
export SUN_INCLUDE=~/local/sundials/2.7.0/include
export SUN_LIB=~/local/sundials/2.7.0/lib
export BOOST_DIR=/share/apps/lib/boost/1.63.0/mvapich2-2.2b-intel-16/include
export EIGEN_INCLUDE=~/local/eigen/3.2.9/eigen/

scons -j24 build prefix=$CANTERA_DIR \
  CXX=icpc CC=icc FORTRAN=ifort python_package=full \
  optimize_flags='-O3 -ip' \
  env_vars='all' \
  sundials_include=$SUN_INCLUDE sundials_libdir=$SUN_LIB \
  boost_inc_dir=$BOOST_DIR f90_interface=y system_eigen=y \
  extra_inc_dirs=$EIGEN_INCLUDE
if [ -z "SCONS_TEST" ]; then
    scons -j24 test
fi
scons -j24 install
