CC 	= gcc
CFLAGS  = -Wall -Wextra -g -MMD -MP
INCLUDE = -I ./include
TARGET  = linglan

SRCS 	= $(wildcard src/*.c)
OBJDIR  = obj
OBJS	= $(patsubst src/%.c,$(OBJDIR)/%.o,$(SRCS))
DEPS	= $(OBJS:.o=.d)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^
	@echo "构建成功: ./$(TARGET)"

$(OBJDIR)/%.o: src/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

-include $(DEPS)

.PHONY: all clean
clean:
	rm -rf $(OBJDIR) $(TARGET)
	@echo "已清理构建文件"
