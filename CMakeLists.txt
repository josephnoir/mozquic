cmake_minimum_required(VERSION 3.5)
project(mozquic)

set(CMAKE_MODULE_PATH .)
SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++0x" )

include(GNUInstallDirs)
include_directories(../dist/public/nss/)

set (
	MOZQUIC_FILES
	
	Ack.cpp
	API.cpp
	Handshake.cpp
	Logging.cpp
	Logging.h
	MozQuic.cpp
	MozQuic.h
	NSSHelper.cpp
	NSSHelper.h
	Packetization.cpp
	Packetization.h
	Ping.cpp
	Sender.cpp
	Sender.h
	StatelessReset.cpp
	Streams.cpp
	Streams.h
	Timer.cpp
	Timer.h
	TransportExtension.cpp
	TransportExtension.h
)

#### DEPENDENCIES ####
find_package(NSS)
if (NSS_FOUND)
  include_directories(${NSS_INCLUDE_DIRS})
else ()
  message(FATAL_ERROR "Could not find NSS.")
endif ()

#### LIBRARY AND EXECUTABLES ####

set(LIBMOZQUIC_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/.")

# ... something to build the library
add_library(mozquic SHARED
	${MOZQUIC_FILES}
)
target_link_libraries(mozquic
  ${NSS_LIBRARIES}
)

