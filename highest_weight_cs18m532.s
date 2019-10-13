/**********************************************************************************
* file: highest_weight_cs18m532.s                                                         *
* Assembly code to determine number having heighest weight(total number of bits)  *
***********************************************************************************/

@ BSS section
.bss


@ DATA SECTION
.data
data_start:	.word 0x205A15E3 ;#(0010 0000 0101 1010 0001 0101 1101 0011 : 13)
			.word 0x256C8700 ;#(0010 0101 0110 1100 1000 0111 0000 0000 : 11)
			.word 0x393134F8 ;#(0011 1001 0011 0001 0011 0100 1111 1000 : 15)
data_end:	.word 0x295468F2 ;#(0010 1001 0101 0100 0110 1000 1111 0010 : 14)

Output: NUM: .word 0x0;
        WEIGHT: .word 0x0; 

@ TEXT section
.text

.global _main

_main:
    LDR   r0, =data_start	@ load address of data_start in r0
    LDR   r8, =data_end 	@ load address of data_end in r8
    LDR   r3, [r8]			@ Load the end number on r3
    MOV	  r1, #0			@ Register r1 to represent the weight of the number
    MOV   r2, #0			@ Register r2 to represent the num with height weight
read_loop:
    LDR	  r4, [r0], #4		@ Load the number in r4
    MOV   r5, r4			@ Mov to r5 for bit manipulation
    MOV   r6, #0            @ Load the weight counter for this iteration
    MOV   r7, #32			@ for 32 bit comparision
weight_loop:	
    ANDS  r8, r5, #0x1      @ AND LSB with 1
    ADDNE r6, r6, #1		@ Add 1 if the 
    LSR   r5, r5, #1        @ Shift the number by 1
    SUB   r7, #1            @ Decrement bit counter
    CMP   r7, #0            @ Check for bit counter 
    BNE   weight_loop       @ loopthrough all the bits
    CMP   r6, r1            @ Compare r1 and r5
    MOVCS r1, r6            @ Store r5 to r1 as it has more 1 bits
    MOVCS r2, r4			@ Store the number r2 
    CMP	  r4, r3			@ Compare r4 with r3
    BNE	  read_loop			@ Jump to read next entry on the set

out:
    LDR r8, =NUM
    STR r2, [r8]
    LDR r8, =WEIGHT
    STR r1, [r8]

