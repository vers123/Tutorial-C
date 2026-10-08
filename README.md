# Tutorial C

一个 C 语言教学项目，构建系统通用化，新增源码或测试文件无需修改构建脚本。

## 目录结构

| 目录 | 说明 |
|------|------|
| `src/` | 源码（`main.c` 为主程序，其余自动汇入核心库） |
| `include/` | 头文件 |
| `lib/` | 库 |
| `tests/` | 测试（每个 `.c` 文件独立可执行） |
| `doc/` | 文档 |
| `tools/` | 工具 |

## 构建

### CMake（推荐）

    mkdir -p build && cd build
    cmake ..
    make
    ./linglan

可选：`-DENABLE_SANITIZERS=ON` 开启 ASan + UBSan。

### Makefile

    make            # 默认 debug
    make debug
    make release
    ./linglan

## 测试

    make test                 # 默认 debug
    make SANITIZE=1 test      # ASan + UBSan
    make check                # 严格警告 + clean + 全量构建 + 测试

CMake 路线：

    cd build
    cmake ..
    make
    ctest --output-on-failure

## 格式化

    make format               # 需要 clang-format

## 清理

    # CMake
    cd build && make clean

    # Makefile
    make clean

## 约定

- 新增源码放在 `src/`，会自动加入核心库（`main.c` 除外）。
- 新增测试放在 `tests/`，包含 `main()`，使用 `test_framework.h`
  中的 `TF_*` 宏；构建系统自动发现并执行。
- 提交前建议 `make format`。

## License

MIT

