find_package(fmt)
find_package(spdlog)
# find_package(Protobuf)
# find_package(absl)
find_package(nlohmann_json)
find_package(CLI11)
find_package(quickfix)
# find_package(gRPC)

add_executable(main main.cpp)
target_link_libraries(
    main
    PRIVATE project_options 
            project_warnings
    PRIVATE fmt::fmt 
            spdlog::spdlog
)