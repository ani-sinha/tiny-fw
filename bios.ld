/*
 * Linker script for the tiny firmware.
 *
 * Copyright 2025 Amazon.com.
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

SECTIONS
{
     . = 0xffff0000;
    .text : {
        *(.text*)
    }

    /* Discard unnecessary sections */
    /DISCARD/ : {
        *(.eh_frame)
        *(.eh_frame_hdr)
        *(.eh_frame*)
        *(.note*)
        *(.comment*)
        *(.gnu*)
        *(.debug*)
        *(.gcc_except_table*)
        *(.comment)
        *(COMMON)
        *(.note*)
    }
}
