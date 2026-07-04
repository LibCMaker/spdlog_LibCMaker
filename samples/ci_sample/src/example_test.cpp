/*****************************************************************************
 * Project:  LibCMaker
 * Purpose:  A CMake build scripts for build libraries with CMake
 * Author:   NikitaFeodonit, nfeodonit@yandex.com
 *****************************************************************************
 *   Copyright (c) 2017-2026 NikitaFeodonit
 *
 *    This file is part of the LibCMaker project.
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published
 *    by the Free Software Foundation, either version 3 of the License,
 *    or (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *    See the GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program. If not, see <http://www.gnu.org/licenses/>.
 ****************************************************************************/

// The code is based on the code from
// <spdlog src>/tests/test_misc.cpp

#include "spdlog/spdlog.h"
#include "spdlog/sinks/ostream_sink.h"
#include "spdlog/pattern_formatter.h"

#include "gtest/gtest.h"

template<class T>
std::string log_info(const T &what, spdlog::level::level_enum logger_level = spdlog::level::info)
{

    std::ostringstream oss;
    auto oss_sink = std::make_shared<spdlog::sinks::ostream_sink_mt>(oss);

    spdlog::logger oss_logger("oss", oss_sink);
    oss_logger.set_level(logger_level);
    oss_logger.set_pattern("%v");
    oss_logger.info(what);

    return oss.str().substr(0, oss.str().length() - strlen(spdlog::details::os::default_eol));
}

TEST(basic_logging, basic_logging)
{
    // const char
    EXPECT_TRUE(log_info("Hello") == "Hello");
    EXPECT_TRUE(log_info("").empty());

    // std::string
    EXPECT_TRUE(log_info(std::string("Hello")) == "Hello");
    EXPECT_TRUE(log_info(std::string()).empty());

    // Numbers
    EXPECT_TRUE(log_info(5) == "5");
    EXPECT_TRUE(log_info(5.6) == "5.6");
}

TEST(log_levels, log_levels)
{
    EXPECT_TRUE(log_info("Hello", spdlog::level::err).empty());
    EXPECT_TRUE(log_info("Hello", spdlog::level::critical).empty());
    EXPECT_TRUE(log_info("Hello", spdlog::level::info) == "Hello");
    EXPECT_TRUE(log_info("Hello", spdlog::level::debug) == "Hello");
    EXPECT_TRUE(log_info("Hello", spdlog::level::trace) == "Hello");
}

TEST(level_to_string_view, convert_to_string_view)
{
    EXPECT_TRUE(spdlog::level::to_string_view(spdlog::level::trace) == "trace");
    EXPECT_TRUE(spdlog::level::to_string_view(spdlog::level::debug) == "debug");
    EXPECT_TRUE(spdlog::level::to_string_view(spdlog::level::info) == "info");
    EXPECT_TRUE(spdlog::level::to_string_view(spdlog::level::warn) == "warning");
    EXPECT_TRUE(spdlog::level::to_string_view(spdlog::level::err) == "error");
    EXPECT_TRUE(spdlog::level::to_string_view(spdlog::level::critical) == "critical");
    EXPECT_TRUE(spdlog::level::to_string_view(spdlog::level::off) == "off");
}

TEST(to_short_c_str, convert_to_short_c_str)
{
    EXPECT_TRUE(std::string(spdlog::level::to_short_c_str(spdlog::level::trace)) == "T");
    EXPECT_TRUE(std::string(spdlog::level::to_short_c_str(spdlog::level::debug)) == "D");
    EXPECT_TRUE(std::string(spdlog::level::to_short_c_str(spdlog::level::info)) == "I");
    EXPECT_TRUE(std::string(spdlog::level::to_short_c_str(spdlog::level::warn)) == "W");
    EXPECT_TRUE(std::string(spdlog::level::to_short_c_str(spdlog::level::err)) == "E");
    EXPECT_TRUE(std::string(spdlog::level::to_short_c_str(spdlog::level::critical)) == "C");
    EXPECT_TRUE(std::string(spdlog::level::to_short_c_str(spdlog::level::off)) == "O");
}
