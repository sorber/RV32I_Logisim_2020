
.section .startup_code
.global _start

_start:
    nop
	lui		sp, %hi(__estack)
	addi	sp,sp,%lo(__estack)
    # Clear static storage before entering C, including on a restart.
    la      t0, __sbss
    la      t1, __ebss
1:
    bgeu    t0, t1, 2f
    sw      zero, 0(t0)
    addi    t0, t0, 4
    j       1b
2:
    jal     main
