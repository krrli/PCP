cmake_minimum_required(VERSION 3.8)
project(Uebung1)

set(CMAKE_C_STANDARD 11)

set(SOURCE_FILES main.c stack.c stack.h)
add_executable(Uebung1 ${SOURCE_FILES})