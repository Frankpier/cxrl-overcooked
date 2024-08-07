# CMake generated Testfile for 
# Source directory: /home/frankpier/overcooked_ws/src/cx_overcooked
# Build directory: /home/frankpier/overcooked_ws/build/cx_overcooked
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(flake8 "/usr/bin/python3" "-u" "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/run_test.py" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/flake8.xunit.xml" "--package-name" "cx_overcooked" "--output-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/ament_flake8/flake8.txt" "--command" "/usr/lib64/ros2-humble/bin/ament_flake8" "--xunit-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/flake8.xunit.xml")
set_tests_properties(flake8 PROPERTIES  LABELS "flake8;linter" TIMEOUT "60" WORKING_DIRECTORY "/home/frankpier/overcooked_ws/src/cx_overcooked" _BACKTRACE_TRIPLES "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/ament_add_test.cmake;125;add_test;/usr/lib64/ros2-humble/share/ament_cmake_flake8/cmake/ament_flake8.cmake;63;ament_add_test;/usr/lib64/ros2-humble/share/ament_cmake_flake8/cmake/ament_cmake_flake8_lint_hook.cmake;18;ament_flake8;/usr/lib64/ros2-humble/share/ament_cmake_flake8/cmake/ament_cmake_flake8_lint_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;21;ament_execute_extensions;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_package.cmake;66;ament_execute_extensions;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;29;ament_package;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;0;")
add_test(lint_cmake "/usr/bin/python3" "-u" "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/run_test.py" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/lint_cmake.xunit.xml" "--package-name" "cx_overcooked" "--output-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/ament_lint_cmake/lint_cmake.txt" "--command" "/usr/lib64/ros2-humble/bin/ament_lint_cmake" "--xunit-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/lint_cmake.xunit.xml")
set_tests_properties(lint_cmake PROPERTIES  LABELS "lint_cmake;linter" TIMEOUT "60" WORKING_DIRECTORY "/home/frankpier/overcooked_ws/src/cx_overcooked" _BACKTRACE_TRIPLES "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/ament_add_test.cmake;125;add_test;/usr/lib64/ros2-humble/share/ament_cmake_lint_cmake/cmake/ament_lint_cmake.cmake;47;ament_add_test;/usr/lib64/ros2-humble/share/ament_cmake_lint_cmake/cmake/ament_cmake_lint_cmake_lint_hook.cmake;21;ament_lint_cmake;/usr/lib64/ros2-humble/share/ament_cmake_lint_cmake/cmake/ament_cmake_lint_cmake_lint_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;21;ament_execute_extensions;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_package.cmake;66;ament_execute_extensions;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;29;ament_package;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;0;")
add_test(pep257 "/usr/bin/python3" "-u" "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/run_test.py" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/pep257.xunit.xml" "--package-name" "cx_overcooked" "--output-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/ament_pep257/pep257.txt" "--command" "/usr/lib64/ros2-humble/bin/ament_pep257" "--xunit-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/pep257.xunit.xml")
set_tests_properties(pep257 PROPERTIES  LABELS "pep257;linter" TIMEOUT "60" WORKING_DIRECTORY "/home/frankpier/overcooked_ws/src/cx_overcooked" _BACKTRACE_TRIPLES "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/ament_add_test.cmake;125;add_test;/usr/lib64/ros2-humble/share/ament_cmake_pep257/cmake/ament_pep257.cmake;41;ament_add_test;/usr/lib64/ros2-humble/share/ament_cmake_pep257/cmake/ament_cmake_pep257_lint_hook.cmake;18;ament_pep257;/usr/lib64/ros2-humble/share/ament_cmake_pep257/cmake/ament_cmake_pep257_lint_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;21;ament_execute_extensions;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_package.cmake;66;ament_execute_extensions;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;29;ament_package;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;0;")
add_test(xmllint "/usr/bin/python3" "-u" "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/run_test.py" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/xmllint.xunit.xml" "--package-name" "cx_overcooked" "--output-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/ament_xmllint/xmllint.txt" "--command" "/usr/lib64/ros2-humble/bin/ament_xmllint" "--xunit-file" "/home/frankpier/overcooked_ws/build/cx_overcooked/test_results/cx_overcooked/xmllint.xunit.xml")
set_tests_properties(xmllint PROPERTIES  LABELS "xmllint;linter" TIMEOUT "60" WORKING_DIRECTORY "/home/frankpier/overcooked_ws/src/cx_overcooked" _BACKTRACE_TRIPLES "/usr/lib64/ros2-humble/share/ament_cmake_test/cmake/ament_add_test.cmake;125;add_test;/usr/lib64/ros2-humble/share/ament_cmake_xmllint/cmake/ament_xmllint.cmake;50;ament_add_test;/usr/lib64/ros2-humble/share/ament_cmake_xmllint/cmake/ament_cmake_xmllint_lint_hook.cmake;18;ament_xmllint;/usr/lib64/ros2-humble/share/ament_cmake_xmllint/cmake/ament_cmake_xmllint_lint_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;21;ament_execute_extensions;/usr/lib64/ros2-humble/share/ament_lint_auto/cmake/ament_lint_auto_package_hook.cmake;0;;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_execute_extensions.cmake;48;include;/usr/lib64/ros2-humble/share/ament_cmake_core/cmake/core/ament_package.cmake;66;ament_execute_extensions;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;29;ament_package;/home/frankpier/overcooked_ws/src/cx_overcooked/CMakeLists.txt;0;")
