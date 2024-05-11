.pos 0x100
                ld $n, r0               # r0 = address of n
                ld (r0), r0             # r0 = n (number of students)
                ld $s, r1               # r1 = address of s
                ld (r1), r3             # r3 = s = address of student 0
                mov r0, r2              # counter for loop, initialized to n
calc:           beq r2, end_calc        # branch if counter reach 0, all grades calculated
                dec r2                  # decrement counter
                ld 4(r3), r5            # for storing sum
                ld 8(r3), r6
                add r6, r5              # r5 += r6
                ld 12(r3), r6
                add r6, r5              # r5 += r6
                ld 16(r3), r6
                add r6, r5              # r5 += r6
                shr $2, r5              # compute average by shifting right
                st r5, 20(r3)           # storing average
                ld $24, r4              # size of struct student
                add r4, r3              # move to next student
                br calc
end_calc:       mov r0, r2              # counter for loop, initialized to n
sort:           beq r2, end_sort        # branch if counter reachs 0, sort complete
                dec r2                  # decrement counter
                ld $1, r3               # counter for inner loop
                ld (r1), r5             # r5 = s = address of student 0
loop:           mov r2, r4              #
                not r4                  #
                inc r4                  #
                add r3, r4              # r4 = r3 - r2
                bgt r4, end_loop        # end loop if r3 - r2 > 0, i.e. j - i > 0, ***r4 no longer in use***
                ld 20(r5), r4
                ld 44(r5), r6
                not r6
                inc r6
                add r4, r6
                bgt r6, swap            # check if need to swap
                br continue             # if not, continue looping
swap:           ld (r5), r4             # otherwise, swap each component
                ld 24(r5), r6
                st r6, (r5)
                st r4, 24(r5)           # swaps student number

                ld 4(r5), r4
                ld 28(r5), r6
                st r6, 4(r5)
                st r4, 28(r5)           # swaps grade[0]

                ld 8(r5), r4
                ld 32(r5), r6
                st r6, 8(r5)
                st r4, 32(r5)           # swaps grade[1]

                ld 12(r5), r4
                ld 36(r5), r6
                st r6, 12(r5)
                st r4, 36(r5)           # swaps grade[2]

                ld 16(r5), r4
                ld 40(r5), r6
                st r6, 16(r5)
                st r4, 40(r5)           # swaps grade[3]

                ld 20(r5), r4
                ld 44(r5), r6
                st r6, 20(r5)
                st r4, 44(r5)           # swaps average grade
                
continue:       ld $24, r4
                add r4, r5              # move to next student
                inc r3                  # increment counter
                br loop
end_loop:       br sort                 # inner loop finished
end_sort:       shr $1, r0              # middle position in list
                mov r0, r2              #
                mov r0, r3              #
                shl $3, r2              #
                shl $4, r3              # compute 24 * middle position
                add r2, r3              # avoid offset too big
                ld (r1), r1             # base address
                add r1, r3              # base + offset
                ld (r3), r4             # answer (student number)
                ld $m, r0               # r0 = address of m
                st r4, (r0)             # m = answer
                halt
.pos 0x4000
n:      .long 5         # number of student
m:      .long 0         # answer
s:      .long base      # address of the array
base:   .long 0001
        .long 8         # grade 0
        .long 60        # grade 1
        .long 78        # grade 2
        .long 90        # grade 3
        .long 0         # average 1

        .long 0002
        .long 9         # grade 0
        .long 15        # grade 1
        .long 50        # grade 4
        .long 82        # grade 3
        .long 0         # average 2
        
        .long 0003
        .long 90        # grade 0
        .long 10        # grade 1
        .long 5         # grade 2
        .long 100       # grade 3
        .long 0         # average 3
        
        .long 0004
        .long 90        # grade 0
        .long 10        # grade 1
        .long 50        # grade 2
        .long 10        # grade 3
        .long 0         # average 4
        
        .long 0005
        .long 90        # grade 0
        .long 1         # grade 1
        .long 50        # grade 2
        .long 1         # grade 3
        .long 0         # average 5