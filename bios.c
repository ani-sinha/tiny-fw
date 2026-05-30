/*
 * Tiny firmware code to test vmfwupdate device
 *
 * Copyright (c) 2025 Amazon.com, Inc.
 * Copyright (c) 2025 Matter Labs.
 *
 * Author:
 *   Alex Graf <graf@amazon.com>
 *   Harald Hoyer <hh@matterlabs.dev>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

asm(".code16gcc");

asm("_entry:\n"
    "  xor %ax, %ax\n"
    "  mov %ax, %es\n" /* ES = 0 */
    "  mov %ax, %ss\n" /* SS = 0 */
    "  mov %ax, %sp\n" /* SP = 0, it will wrap */
    "  mov %cs, %ax\n"
    "  mov %ax, %ds\n" /* DS = CS, so we can access .rodata */
    "  jmp main\n");

static inline __attribute__((always_inline)) void outb(unsigned short port,
                                                       unsigned char value) {
    asm volatile ("outb %%al, %%dx" : : "d"(port), "a"(value));
}

static inline __attribute__((always_inline)) unsigned char inb(unsigned short port) {
    unsigned char value;
    asm volatile ("inb %%dx, %%al" : "=a"(value) : "d"(port));
    return value;
}

static inline __attribute__((always_inline)) void puts(const char *s) {
    while (*s) {
        outb(0x3f8, *s++); // use port 0x403 for debugcon
    }
}

void __attribute__((naked)) main(void) {
    puts("Hello World\n");
#if 0
    // Reset system via keyboard controller
    while (inb(0x64) & 2) ; // Wait for input buffer empty
    outb(0x64, 0xFE);       // Reset command
#endif
    for (;;) {
        asm("hlt");
    }
}

// Entry point that will be placed at 0xfffffff0
void __attribute__((section(".entry"))) __attribute__((naked)) entry(void) {
    asm("jmp _entry");
}
