ENTRY(start)
SECTIONS
{
  . = 0x100000; /* load at 1MiB */
  .text : { *(.text*) }
  .rodata : { *(.rodata*) }
  .data : { *(.data*) }
  .bss : { *(.bss*) }
}
