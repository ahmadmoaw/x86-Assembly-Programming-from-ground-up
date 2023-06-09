.include "linux.s"

.section .data
    temp_buffer:
        .ascii "\0\0\0\0\0\0\0\0\0\0\0"

.section .text
.globl _start

_start:
    movl %esp, %ebp

    pushl $temp_buffer
    pushl $824
    call integer2string
    addl $8, %esp

    pushl $temp_buffer
    call count_chars
    addl $4, %esp

    movl %eax, %edx
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $temp_buffer, %ecx
    int $LINUX_SYSCALL_INT

    pushl $STDOUT
    call write_newline

    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $LINUX_SYSCALL_INT
