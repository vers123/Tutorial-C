#ifndef TEST_FRAMEWORK_H
#define TEST_FRAMEWORK_H

#include <stdio.h>
#include <string.h>

static int tf_failures = 0;
static int tf_checks = 0;

#define TF_ASSERT(cond, ...)                                                                       \
    do {                                                                                           \
        tf_checks++;                                                                               \
        if (!(cond)) {                                                                             \
            tf_failures++;                                                                         \
            fprintf(stderr, "FAIL %s:%d: ", __FILE__, __LINE__);                                   \
            fprintf(stderr, __VA_ARGS__);                                                          \
            fprintf(stderr, "\n");                                                                 \
        }                                                                                          \
    } while (0)

#define TF_ASSERT_STR_EQ(actual, expected)                                                         \
    TF_ASSERT(strcmp((actual), (expected)) == 0, "expected \"%s\", got \"%s\"",                    \
              (const char *)(expected), (const char *)(actual))

#define TF_ASSERT_INT_EQ(actual, expected)                                                         \
    TF_ASSERT((actual) == (expected), "expected %d, got %d", (int)(expected), (int)(actual))

#define TF_RUN(fn)                                                                                 \
    do {                                                                                           \
        printf("  running %s\n", #fn);                                                             \
        fn();                                                                                      \
    } while (0)

#define TF_REPORT()                                                                                \
    do {                                                                                           \
        if (tf_failures == 0) {                                                                    \
            printf("All %d checks passed.\n", tf_checks);                                          \
            return 0;                                                                              \
        }                                                                                          \
        fprintf(stderr, "%d/%d checks failed.\n", tf_failures, tf_checks);                         \
        return 1;                                                                                  \
    } while (0)

#endif /* TEST_FRAMEWORK_H */
