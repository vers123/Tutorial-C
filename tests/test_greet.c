#include "greet.h"
#include "test_framework.h"

static void test_greet_message(void) {
    TF_ASSERT_STR_EQ(greet_message(), "Hello, World!");
}

static void test_add(void) {
    TF_ASSERT_INT_EQ(add(1, 2), 3);
    TF_ASSERT_INT_EQ(add(-1, 1), 0);
    TF_ASSERT_INT_EQ(add(0, 0), 0);
    TF_ASSERT_INT_EQ(add(-2, -3), -5);
}

int main(void) {
    TF_RUN(test_greet_message);
    TF_RUN(test_add);
    TF_REPORT();
}
