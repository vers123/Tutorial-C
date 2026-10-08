cmake_minimum_required(VERSION 3.10)
project(linglan C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_executable(${PROJECT_NAME}
    src/main.c
)

target_include_directories(${PROJECT_NAME} PRIVATE include)

if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -g)
endif()
