## Operaciones ariméticas con variables de coma flotante ##

awk "BEGIN {print $ul_mean+(2*$ul_st); exit}"

uthr=$(awk "BEGIN {print $ul_mean+(2*$ul_st); exit}")


awk '{ $1 = $2 + $3 / $4; print }' inventory-shipped

The arithmetic operators in awk are:

x + y
    Addition. 

x - y
    Subtraction. 

- x
    Negation. 

+ x
    Unary plus. No real effect on the expression. 

x * y
    Multiplication. 

x / y
    Division. Since all numbers in awk are double-precision floating point, the result is not rounded to an integer: 3 / 4 has the value 0.75. 

x % y
    Remainder. The quotient is rounded toward zero to an integer, multiplied by y and this result is subtracted from x. This operation is sometimes known as "trunc-mod." The following relation always holds:

    b * int(a / b) + (a % b) == a

    One possibly undesirable effect of this definition of remainder is that x % y is negative if x is negative. Thus,

    -17 % 8 = -1

    In other awk implementations, the signedness of the remainder may be machine dependent. 

x ^ y

x ** y
    
Exponentiation: x raised to the y power. 2 ^ 3 has the value 8. The character sequence `**' is equivalent to `^'. (The POSIX standard only specifies the use of `^' for exponentiation.) 