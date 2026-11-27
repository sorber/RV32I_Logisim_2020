

MEMORY
{
    rom (rx)    : ORIGIN = 0x00000000, LENGTH = 4K
    ram (rw)    : ORIGIN = 0x10000000, LENGTH = 4K
}

__max_heap_size = 0x100;    /* symbol */
__max_stack_size = 0x100;

ENTRY(_start)

SECTIONS
{
    .text :
    {
        KEEP(*(.startup_code))

        *(.text*)
        __etext = .;
    } > rom

    /* Place initialized data at the RAM origin for the flat RAM image. */
    .data :
    {
        *(.rodata*)
        *(.data*)
        *(.sdata*)
        __edata = .;
    } > ram

    .bss (NOLOAD) :
    {
        . = ALIGN(4);
        __sbss = .;
        *(.bss*)
        *(.sbss*)
        *(COMMON)
        . = ALIGN(4);
        __ebss = .;
    } > ram

    .stack (NOLOAD) :
    {
        . = ALIGN(4);
        . = . + __max_stack_size;
        . = ALIGN(4);
        __estack = .;
    } > ram

}