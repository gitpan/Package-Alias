# -*- perl -*-
#
# Tests whether Package::Alias will blow away an existing namespace.
#


use Test::More tests => 5;
#use Test::More qw/no_plan/;

package A::B;  $var = "A::B";
package C;     $var = "C";
package D;     $var = "D";

package main;

BEGIN { diag "This warning is ok:" }
use Package::Alias C    => A::B,
		   E::F => D;

# Originals
is $A::B::var,	"A::B",		"Original: A::B";
is $D::var,	"D",		"Original: D";

# Aliases
is $C::var,	"C",		"Package C retained";
is $E::F::var,	"D",		"Alias: E::F";

ok    $A::B::var
    & $C::var
    & $D::var
    & $E::F::var,		"Silence warnings by using variables once";
