.data
arr: .long 3, 12, 5, 8, 2, 15       # Array of 6 elements
outp_sorted: .asciz "Sorted array: %ld %ld %ld %ld %ld %ld\n"  # Output format string for sorted array

.text
.global _main
.extern _printf

print_array:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ebx         # Load the address of the array into %ebx
    movl 12(%ebp), %ecx        # Load the format string into %ecx

    pushl (%ebx)               # Push each array element onto the stack
    pushl 4(%ebx)
    pushl 8(%ebx)
    pushl 12(%ebx)
    pushl 16(%ebx)
    pushl 20(%ebx)
    pushl %ecx                 # Push the format string onto the stack
    call _printf               # Call printf to print the array
    addl $28, %esp             # Clean up the stack (6 elements + format string = 7*4 bytes)

    movl %ebp, %esp
    popl %ebp
    ret

bubble_sort_desc:
    pushl %ebp
    movl %esp, %ebp
    subl $16, %esp

    movl $6, -4(%ebp)          # Set loop bound (number of elements) to 6

outer_loop:
    decl -4(%ebp)              # Decrement outer loop counter
    cmpl $0, -4(%ebp)          # Compare counter with 0
    jle end_sort               # If counter <= 0, sorting is done

    movl $0, -8(%ebp)          # Initialize inner loop counter to 0

inner_loop:
    movl -8(%ebp), %edx        # Load inner loop counter into %edx
    movl 8(%ebp), %ebx         # Load the address of the array into %ebx

    movl (%ebx, %edx, 4), %eax # Load arr[j] into %eax
    movl 4(%ebx, %edx, 4), %ecx # Load arr[j+1] into %ecx

    cmpl %ecx, %eax            # Compare arr[j] with arr[j+1] for descending order
    jge no_swap                # If arr[j] >= arr[j+1], no need to swap

    # Swap arr[j] and arr[j+1]
    movl %ecx, (%ebx, %edx, 4) # Store arr[j+1] into arr[j]
    movl %eax, 4(%ebx, %edx, 4) # Store arr[j] into arr[j+1]

no_swap:
    incl -8(%ebp)              # Increment inner loop counter
    cmpl $4, -8(%ebp)          # Compare inner loop counter with 4
    jl inner_loop              # If counter < 4, continue inner loop

    jmp outer_loop             # Repeat outer loop

end_sort:
    movl %ebp, %esp
    popl %ebp
    ret

_main:
    # Sort the array
    pushl $arr
    call bubble_sort_desc
    addl $4, %esp

    # Print sorted array
    pushl $outp_sorted
    pushl $arr
    call print_array
    addl $8, %esp

    xorl %eax, %eax            # Zero out %eax (set return value to 0)
    ret                        # Return from the function
