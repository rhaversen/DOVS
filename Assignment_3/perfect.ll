; ModuleID = 'number_perfect_module'
declare void @print_perfect(i64)

define void @number_perfect(i32 %n) {
entry:
    ; Allocate space for variables 'i', 'temp', and 'j'
    %i = alloca i32, align 4
    %temp = alloca i32, align 4
    %j = alloca i32, align 4

    ; Initialize 'i' to 1
    store i32 1, i32* %i
    br label %while_cond

while_cond: ; Loop condition for 'while (i <= n)'
    %i_val = load i32, i32* %i
    %cmp_i_n = icmp sle i32 %i_val, %n
    br i1 %cmp_i_n, label %while_body, label %while_end

while_body:
    ; Initialize 'temp' to 0 and 'j' to 1
    store i32 0, i32* %temp
    store i32 1, i32* %j
    br label %for_cond

for_cond: ; Loop condition for 'for (j = 1; j < i; j = j + 1)'
    %j_val = load i32, i32* %j
    %i_val_2 = load i32, i32* %i
    %cmp_j_i = icmp slt i32 %j_val, %i_val_2
    br i1 %cmp_j_i, label %for_body, label %for_end

for_body:
    ; Compute 'd = i % j'
    %i_val_3 = load i32, i32* %i
    %j_val_2 = load i32, i32* %j
    %d = srem i32 %i_val_3, %j_val_2

    ; Check if 'd == 0'
    %d_is_zero = icmp eq i32 %d, 0

    ; Compute 'add_val = (d == 0) ? j : 0'
    %add_val = select i1 %d_is_zero, i32 %j_val_2, i32 0

    ; Update 'temp = temp + add_val'
    %temp_val = load i32, i32* %temp
    %temp_new = add i32 %temp_val, %add_val
    store i32 %temp_new, i32* %temp

    ; Increment 'j = j + 1'
    %j_inc = add i32 %j_val_2, 1
    store i32 %j_inc, i32* %j

    ; Loop back to 'for_cond'
    br label %for_cond

for_end:
    ; Check if 'temp == i'
    %temp_val_2 = load i32, i32* %temp
    %i_val_4 = load i32, i32* %i
    %cmp_temp_i = icmp eq i32 %temp_val_2, %i_val_4
    br i1 %cmp_temp_i, label %if_then, label %if_end

if_then:
    ; Extend 'i' to i64 and call 'print_perfect'
    %i64_val = sext i32 %i_val_4 to i64
    call void @print_perfect(i64 %i64_val)
    br label %if_end

if_end:
    ; Increment 'i = i + 1'
    %i_val_5 = load i32, i32* %i
    %i_inc = add i32 %i_val_5, 1
    store i32 %i_inc, i32* %i

    ; Loop back to 'while_cond'
    br label %while_cond

while_end:
    ret void
}
