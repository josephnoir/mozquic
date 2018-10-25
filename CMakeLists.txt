cmake_minimum_required(VERSION 3.8)
project(mozquic)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++0x" )

include(GNUInstallDirs)

# -- FILES ---------------------------------------------------------------------

file(GLOB_RECURSE LIBMQ_HEADERS "cs/*.h")

set(LIBMQ_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/.")

include_directories(${LIBMQ_INCLUDE_DIRS})

set(LIBMQ_FILES
  API.cpp
  Ack.cpp
  Handshake.cpp
  Logging.cpp
  MozQuic.cpp
  NSSHelper.cpp
  Packetization.cpp
  Ping.cpp
  Sender.cpp
  StatelessReset.cpp
  Streams.cpp
  Timer.cpp
  TransportExtension.cpp
)

# -- DEPENDENCIES  -------------------------------------------------------------

find_package(NSS)
if (NSS_FOUND)
  include_directories(${NSS_INCLUDE_DIRS})
else ()
  message(FATAL_ERROR "Could not find NSS.")
endif ()

find_package(NSPR)
if(NSPR_FOUND)
  include_directories(${NSPR_INCLUDE_DIRS})
endif()

# -- LIBRARY -------------------------------------------------------------------

add_library(mozquic SHARED
  ${LIBMQ_FILES}
  ${LIBMQ_HEADERS}
)
target_link_libraries(mozquic
  ${NSS_LIBRARIES}
  ${NSPR_LIBRARIES}
)

# -- SAMPLES  ------------------------------------------------------------------

set(MQ_LIBRARIES "mozquic")
add_subdirectory(sample)
