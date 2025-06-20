.section .text
.globl _start

_start:
    la sp, stack_top         # Initialize stack pointer

    la a0, num
    ld a0, 0(a0)             # Load 64-bit input into a0

    jal ra, factorial        # Call factorial(num)

    la t0, result
    sd a0, 0(t0)             # Store result

    j write_tohost           # Terminate

# Recursive factorial
factorial:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd a0, 8(sp)

    li t0, 1
    ble a0, t0, base_case

    addi a0, a0, -1
    jal ra, factorial

    ld t1, 8(sp)
    mul a0, a0, t1

    j end_factorial

base_case:
    li a0, 1

end_factorial:
    ld ra, 16(sp)
    addi sp, sp, 24
    ret

# Exit loop for bare-metal SPIKE
write_tohost:
    li t5, 1
    la t0, tohost
    sd t5, 0(t0)
    j write_tohost


.section .data
.align 8
num:    .dword 5          # Input number
result: .dword 0          # Output factorial

.section .bss
.align 16
stack_bottom: .skip 4096  # 4KB stack
.global stack_top
stack_top:

.section ".tohost", "aw", @progbits
.align 8
.global tohost
tohost: .dword 0
.align 8
.global fromhost
fromhost: .dword 0

