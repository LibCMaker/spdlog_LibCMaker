# ****************************************************************************
#  Project:  LibCMaker
#  Purpose:  A CMake build scripts for build libraries with CMake
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2026 NikitaFeodonit
#
#    This file is part of the LibCMaker project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************


#-----------------------------------------------------------------------
# Library version
#

set(spdlog_lib_VERSION "1.17.0" CACHE STRING "spdlog_lib_VERSION")
set(spdlog_sha256
  "d8862955c6d74e5846b3f580b1605d2428b11d97a410d86e2fb13e857cd3a744"
  CACHE STRING "spdlog_sha256"
)


#-----------------------------------------------------------------------
# spdlog options
#

option(SPDLOG_BUILD_ALL "Build all artifacts" OFF)

# build shared option
option(SPDLOG_BUILD_SHARED "Build shared library" ${BUILD_SHARED_LIBS})

# precompiled headers option
option(SPDLOG_ENABLE_PCH "Build static or shared library using precompiled header to speed up compilation time" OFF)

# build position independent code
option(SPDLOG_BUILD_PIC "Build position independent code (-fPIC)" OFF)

# debug build postfix
set(SPDLOG_DEBUG_POSTFIX "d" CACHE STRING "Filename postfix for libraries in debug builds")

# example options
option(SPDLOG_BUILD_EXAMPLE "Build example" OFF)
option(SPDLOG_BUILD_EXAMPLE_HO "Build header only example" OFF)

# testing options
option(SPDLOG_BUILD_TESTS "Build tests" OFF)
option(SPDLOG_BUILD_TESTS_HO "Build tests using the header only version" OFF)

# bench options
option(SPDLOG_BUILD_BENCH "Build benchmarks (Requires https://github.com/google/benchmark.git to be installed)" OFF)

# sanitizer options
option(SPDLOG_SANITIZE_ADDRESS "Enable address sanitizer in tests" OFF)
option(SPDLOG_SANITIZE_THREAD "Enable thread sanitizer in tests" OFF)

# warning options
option(SPDLOG_BUILD_WARNINGS "Enable compiler warnings" OFF)

# install options
option(SPDLOG_SYSTEM_INCLUDES "Include as system headers (skip for clang-tidy)." OFF)
option(SPDLOG_INSTALL "Generate the install target" ON)
option(SPDLOG_USE_STD_FORMAT "Use std::format instead of fmt library." OFF)
option(SPDLOG_FMT_EXTERNAL "Use external fmt library instead of bundled" ON)
option(SPDLOG_FMT_EXTERNAL_HO "Use external fmt header-only library instead of bundled" OFF)
option(SPDLOG_NO_EXCEPTIONS "Compile with -fno-exceptions. Call abort() on any spdlog exceptions" OFF)
option(SPDLOG_NO_TZ_OFFSET "Omit %z timezone offset (use on platforms without tm_gmtoff)" OFF)

# misc tweakme options
set(SPDLOG_WCHAR_SUPPORT OFF CACHE BOOL "non supported option" FORCE)
set(SPDLOG_WCHAR_FILENAMES OFF CACHE BOOL "non supported option" FORCE)
set(SPDLOG_WCHAR_CONSOLE OFF CACHE BOOL "non supported option" FORCE)

if(MSVC)
    option(SPDLOG_MSVC_UTF8 "Enable/disable msvc /utf-8 flag required by fmt lib" ON)
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
    option(SPDLOG_CLOCK_COARSE "Use CLOCK_REALTIME_COARSE instead of the regular clock," OFF)
else()
    set(SPDLOG_CLOCK_COARSE OFF CACHE BOOL "non supported option" FORCE)
endif()

option(SPDLOG_PREVENT_CHILD_FD "Prevent from child processes to inherit log file descriptors" OFF)
option(SPDLOG_NO_THREAD_ID "prevent spdlog from querying the thread id on each log call if thread id is not needed" OFF)
option(SPDLOG_NO_TLS "prevent spdlog from using thread local storage" OFF)
option(
    SPDLOG_NO_ATOMIC_LEVELS
    "prevent spdlog from using of std::atomic log levels (use only if your code never modifies log levels concurrently"
    OFF)
option(SPDLOG_DISABLE_DEFAULT_LOGGER "Disable default logger creation" OFF)
option(SPDLOG_FWRITE_UNLOCKED "Use the unlocked variant of fwrite. Leave this on unless your libc doesn't have it" ON)

# clang-tidy
option(SPDLOG_TIDY "run clang-tidy" OFF)


#-----------------------------------------------------------------------
# Unpack, configure and build the required libraries
#

include(FetchContent)

FetchContent_Declare(
  spdlog
  URL ${CMAKE_CURRENT_LIST_DIR}/source/spdlog-${spdlog_lib_VERSION}.tar.gz
  URL_HASH SHA256=${spdlog_sha256}
  OVERRIDE_FIND_PACKAGE
)

FetchContent_MakeAvailable(spdlog)
