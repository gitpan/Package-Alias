# -*- perl -*-

use Test::More tests => 5;
#use Test::More qw/no_plan/;

package A::B;  $var = "A::B";
package D;     $var = "D";

package main;
use Package::Alias A::B => C;
use Package::Alias D    => E::F;

# Originals
is $A::B::var,	"A::B",		"Original: A::B";
is $D::var,	"D",		"Original: D";

# Aliases
is $C::var,	"A::B",		"Alias: C";
is $E::F::var,	"D",		"Alias: E::F";

ok    $A::B::var
    & $C::var
    & $D::var
    & $E::F::var,		"Silence warnings by using variables once";
