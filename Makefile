CC          = gcc
INCLUDE     = -I include
TARGET      = linglan

BASE_CFLAGS    = -Wall -Wextra -MMD -MP
DEBUG_CFLAGS   = -g -O0 -DDEBUG
RELEASE_CFLAGS = -O2 -DNDEBUG

BUILD ?= debug

ifeq ($(BUILD),release)
CFLAGS  = $(BASE_CFLAGS) $(RELEASE_CFLAGS)
OBJDIR  = obj/release
else
CFLAGS  = $(BASE_CFLAGS) $(DEBUG_CFLAGS)
OBJDIR  = obj/debug
endif

CFLAGS += $(CFLAGS_EXTRA)

SANITIZE ?= 0
ifeq ($(SANITIZE),1)
CFLAGS  += -fsanitize=address,undefined -fno-omit-frame-pointer
LDFLAGS += -fsanitize=address,undefined
endif

SRCS        = $(wildcard src/*.c)
OBJS        = $(patsubst src/%.c,$(OBJDIR)/%.o,$(SRCS))
DEPS        = $(OBJS:.o=.d)
LIB_OBJS    = $(filter-out $(OBJDIR)/main.o,$(OBJS))

TEST_SRCS   = $(wildcard tests/*.c)
TEST_BINS   = $(patsubst tests/%.c,%,$(TEST_SRCS))

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
	@echo "构建成功: ./$(TARGET)  (BUILD=$(BUILD))"

$(OBJDIR)/%.o: src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(TEST_BINS): %: tests/%.c $(LIB_OBJS)
	$(CC) $(CFLAGS) $(INCLUDE) $(LDFLAGS) -o $@ $< $(LIB_OBJS)

test: $(TEST_BINS)
	@for t in $(TEST_BINS); do \
		echo "运行 $$t"; \
		./$$t || exit 1; \
	done
	@echo "所有测试通过"

run: $(TARGET)
	./$(TARGET)

debug:
	@$(MAKE) BUILD=debug

release:
	@$(MAKE) BUILD=release

check:
	@$(MAKE) clean
	@$(MAKE) BUILD=debug CFLAGS_EXTRA="-Wpedantic -Wshadow -Wconversion" all test

format:
	@command -v clang-format >/dev/null 2>&1 || { echo "未安装 clang-format，请先安装"; exit 1; }
	@find src include tests -type f \( -name '*.c' -o -name '*.h' \) -print0 | xargs -0 clang-format -i
	@echo "代码已格式化"

clean:
	rm -rf obj $(TARGET) $(TEST_BINS)
	@echo "已清理构建文件"

-include $(DEPS)

.PHONY: all test run debug release check format clean

