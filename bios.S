/*
 * Tiny firmware code to test vmfwupdate device
 *
 * Copyright (c) 2025 Amazon.com, Inc.
 * Copyright (c) 2025 Matter Labs
 *
 * Author:
 *   Alex Graf <graf@amazon.com>
 *   Harald Hoyer <hh@matterlabs.dev>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

.code16

_start:
99:
// Print "Hello World"
    mov     $0x3f8, %edx
    mov     $'H', %al
    out     %al, (%dx)
    mov     $'e', %al
    out     %al, (%dx)
    mov     $'l', %al
    out     %al, (%dx)
    mov     $'l', %al
    out     %al, (%dx)
    mov     $'o', %al
    out     %al, (%dx)
    mov     $' ', %al
    out     %al, (%dx)
    mov     $'W', %al
    out     %al, (%dx)
    mov     $'o', %al
    out     %al, (%dx)
    mov     $'r', %al
    out     %al, (%dx)
    mov     $'l', %al
    out     %al, (%dx)
    mov     $'d', %al
    out     %al, (%dx)
    mov     $'\n', %al
    out     %al, (%dx)

// Reset system via keyboard controller
1:
    // Wait for input buffer empty
    mov     $0x64,%edx
    in      (%dx),%al
    test    $0x2,%al
    jne     1b

    // Reset command
    mov     $0xfe,%al
    out     %al,(%dx)

2:
    hlt
    jmp     2b
    ud2

97:
.fill (0xFFF0 - (97b - 99b))
    jmp     _start
    ud2
98:
.fill (0xFFFF - (98b - 99b))
.byte 0
