#!/bin/bash

mkdir build
cd build
CC=clang CXX=clang++ cmake ..
make
