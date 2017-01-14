B#!/bin/sh

x=5
y=10
z=$(( x + y )) #15
pow=$(( y ** x )) #10^5

<<EOF
we can use numerical calculation operator 
var = $(( v1 op v2 )) op:= +,-,*,/,%,**
** means power
++v1,v1++,v1--,--v1
EOF

echo "x = $x"
echo "y = $y"
echo "x + y = $x + $y = $z"
echo "10^2 = $pow"
