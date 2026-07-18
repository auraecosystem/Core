#include <stdio.h>
#include <stdlib.h>

// Global trackers for memory allocations
static int g_allocations = 0;
static int g_deallocations = 0;

// Custom debug malloc function wrapper
static inline void* debug_malloc(size_t size, const char* file, int line) {
    void* ptr = malloc(size);
    if (ptr) {
        g_allocations++;
        // Uncomment the line below if you want to trace exact byte origins:
        // printf("[ALLOC] %p (%zu bytes) at %s:%d\n", ptr, size, file, line);
    }
    return ptr;
}

// Custom debug free function wrapper
static inline void debug_free(void* ptr, const char* file, int line) {
    if (ptr) {
        g_deallocations++;
        // Uncomment the line below if you want to trace exact clear actions:
        // printf("[FREE] %p at %s:%d\n", ptr, file, line);
    }
    free(ptr);
}

// Intercept standard C memory control workflows
#define malloc(size) debug_malloc(size, __FILE__, __LINE__)
#define free(ptr) debug_free(ptr, __FILE__, __LINE__)

// Call this clean summary function right before your main function exits
static inline void report_memory_leaks(void) {
    printf("\n=== MEMORY TRACKING REPORT ===\n");
    printf("Total Objects Allocated: %d\n", g_allocations);
    printf("Total Objects Freed:     %d\n", g_deallocations);
    
    if (g_allocations == g_deallocations) {
        printf("Result: PERFECT! No memory leaks detected.\n");
    } else {
        printf("Result: LEAK DETECTED! Missing %d free() operations.\n", 
               (g_allocations - g_deallocations));
    }
    printf("==============================\n");
}
