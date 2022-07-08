.text
main:
addi $a0 $zero 32   #len_str
addi $a1 $zero 0    #*str
addi $a2 $zero 4    #len_pattern
addi $a3 $zero 400  #*pattern

#brute_force:
sub $t2 $a0 $a2  #calculate len_str - len_pattern
addi $t0 $zero 0  #i = 0
addi $v0 $zero 0  #cnt = 0

loop1:
slt $t3 $t2 $t0  #if(len_str - len_pattern)<i t3 = 1
bne $t3 $zero next1
addi $t1 $zero 0  #j = 0

loop2:
slt $t3 $t1 $a2  # t3 = j < len_substring ? 1 : 0
beq $t3 $zero next2
add $t4 $t0 $t1  # i + j
add $t5 $t4 $a1  # string + (i+j)
lb $t6 0($t5)  
add $t5 $t1 $a3  # substring + j 
lb $t7 0($t5)  
bne $t6 $t7 next2
addi $t1 $t1 1
j loop2

next2:
bne $t1 $a2 else
addi $v0 $v0 1
else:
addi $t0 $t0 1
j loop1

next1:
addi $t4 $zero 0x4000	# LED
sll $t4 $t4 16
addi $t4 $t4 0x000C
sw $v0 0($t4)

addi $s0 $zero 0

Print:
srl $t0 $s0 12	# every 12 times changes 1 logit
andi $t0 $t0 3	# get last 2 logits
addi $t1 $zero 0

beq $t0 $t1 an0
addi $t1 $t1 1
beq $t0 $t1 an1
addi $t1 $t1 1
beq $t0 $t1 an2
addi $t1 $t1 1
beq $t0 $t1 an3

an0:
addi $s1 $zero 0x100
andi $t2 $v0 0x000F 
j an_exit

an1:
addi $s1 $zero 0x200
andi $t2 $v0 0x00F0
srl $t2 $t2 4
j an_exit

an2:
addi $s1 $zero 0x400
andi $t2 $v0 0x0F00
srl $t2 $t2 8
j an_exit

an3:
addi $s1 $zero 0x800
andi $t2 $v0 0xF000
srl $t2 $t2 1

an_exit:
addi $t1 $zero 0
beq $t2 $t1 bcd0

addi $t1 $zero 1
beq $t2 $t1 bcd1

addi $t1 $zero 2
beq $t2 $t1 bcd2

addi $t1 $zero 3
beq $t2 $t1 bcd3

addi $t1 $zero 4
beq $t2 $t1 bcd4

addi $t1 $zero 5
beq $t2 $t1 bcd5

addi $t1 $zero 6
beq $t2 $t1 bcd6

addi $t1 $zero 7
beq $t2 $t1 bcd7

addi $t1 $zero 8
beq $t2 $t1 bcd8

addi $t1 $zero 9
beq $t2 $t1 bcd9

addi $t1 $zero 10
beq $t2 $t1 bcda

addi $t1 $zero 11
beq $t2 $t1 bcdb

addi $t1 $zero 12
beq $t2 $t1 bcdc

addi $t1 $zero 13
beq $t2 $t1 bcdd

addi $t1 $zero 14
beq $t2 $t1 bcde

addi $t1 $zero 15
beq $t2 $t1 bcdf

bcd0:
addi $t3 $zero 0x003F
j bcd_exit

bcd1:
addi $t3 $zero 0x0006
j bcd_exit

bcd2:
addi $t3 $zero 0x005B
j bcd_exit

bcd3:
addi $t3 $zero 0x004F
j bcd_exit

bcd4:
addi $t3 $zero 0x0066
j bcd_exit

bcd5:
addi $t3 $zero 0x006D
j bcd_exit

bcd6:
addi $t3 $zero 0x007D
j bcd_exit

bcd7:
addi $t3 $zero 0x0007
j bcd_exit

bcd8:
addi $t3 $zero 0x007F
j bcd_exit

bcd9:
addi $t3 $zero 0x006F
j bcd_exit

bcda:
addi $t3 $zero 0x0077
j bcd_exit

bcdb:
addi $t3 $zero 0x007C
j bcd_exit

bcdc:
addi $t3 $zero 0x0039
j bcd_exit

bcdd:
addi $t3 $zero 0x005E
j bcd_exit

bcde:
addi $t3 $zero 0x0079
j bcd_exit

bcdf:
addi $t3 $zero 0x0071

bcd_exit:
add $s2 $s1 $t3
addi $t4 $zero 0x4000
sll $t4 $t4 16
addi $t4 $t4 0x0010
sw $s2 0($t4)
addi $s0 $s0 1
j Print
