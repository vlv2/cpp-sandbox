#include <fmt/format.h>
#include <spdlog/spdlog.h>

int main() {
    fmt::print(FMT_STRING("Hello World! - from fmt\n"));
    spdlog::log(spdlog::level::info, "Hello World! - from spdlog\n");
    return 1;
}
