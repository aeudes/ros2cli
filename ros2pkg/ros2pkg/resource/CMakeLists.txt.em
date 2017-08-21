cmake_minimum_required(VERSION 3.5)
project(@(project_name))

# Default to C99
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 99)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

@[for deb in dependencies]@
find_package(@deb REQUIRED)
@[end for]@

@[if create_cpp_exe]@
include_directories(
@[for deb in dependencies]@
  ${@(deb)_INCLUDE_DIRS}
@[end for]@
)

add_executable(${PROJECT_NAME} src/@(cpp_exe_name))

@[for deb in dependencies]@
target_link_libraries(${PROJECT_NAME} ${@(deb)_LIBRARIES})
@[end for]@

install(TARGETS ${PROJECT_NAME}
  DESTINATION lib/${PROJECT_NAME})
@[end if]@

if(BUILD_TESTING)
@[if build_tool == 'ament_cmake']@
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
@[end if]@
endif()

ament_package()
