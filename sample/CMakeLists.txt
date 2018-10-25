cmake_minimum_required(VERSION 3.9)
project(sample C)

add_custom_target(all_samples)

file(GLOB_RECURSE MQSAMPLE_HDRS "./*.h")

include_directories(
  ${LIBMQ_INCLUDE_DIRS}
  .
)

macro(add folder name)
  add_executable(${name} ${folder}/${name}.c ${ARGN} ${MQSAMPLE_HDRS})
  target_link_libraries(
    ${name}
    ${LDFLAGS}
    ${MQ_LIBRARIES}
    ${NSS_LIBRARIES}
    ${NSPR_LIBRARIES}
  )
  add_dependencies(${name} all_samples)
endmacro()

add(. client client.c)

add_custom_command(
  PRE_BUILD
  OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/server_stuff.o
	COMMAND cd ${CMAKE_CURRENT_SOURCE_DIR} && ld -r -b binary sample/server.jpg sample/index.html sample/main.js -o server_stuff.o
	COMMENT "Creating server_stuff.o"
)

add_custom_target(
  server_generation
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/server_stuff.o
)

add_executable(server server.c server-files.c server_stuff.o ${MQSAMPLE_HDRS})
target_link_libraries(server
	${LDFLAGS}
	${MQ_LIBRARIES}
	${NSS_LIBRARIES}
	${NSPR_LIBRARIES}
)
set_source_files_properties(server_stuff.o
                            PROPERTIES GENERATED TRUE)

add_dependencies(server all_samples)
add_dependencies(server server_generation)
