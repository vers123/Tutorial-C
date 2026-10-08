# Tutorial C

一个 C 语言教学项目。

## 目录结构

| 目录 | 说明 |
|------|------|
| `src/` | 源码 |
| `include/` | 头文件 |
| `lib/` | 库 |
| `tests/` | 测试 |
| `doc/` | 文档 |
| `tools/` | 工具 |

## 构建

### CMake（推荐）

    mkdir -p build && cd build
    cmake ..
    make
    ./linglan

### Makefile

    make
    ./linglan

## 清理

    # CMake
    cd build && make clean

    # Makefile
    make clean

## License

MIT
