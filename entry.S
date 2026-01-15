.global start
.section .text
start:
    cli
    xor %ax, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %ss
    mov $0x9000, %esp     # stack
    call kernel_main
.hang:
    hlt
    jmp .hang
