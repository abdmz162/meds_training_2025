ENTRY(_start)

SECTIONS
{
  . = 0x80000000;
  .text : { *(.text) }

  . = 0x80001000;
  .data : { *(.data) }

  .bss : {
    *(.bss)
    stack_top = .;
  }

  . = ALIGN(8);
  .tohost : { *(.tohost) }
}

