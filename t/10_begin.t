# -*- perl -*-

use Test::More tests => 9;
#use Test::More qw/no_plan/;

package A;     $var = "A";
package C;     $var = "C";
package K;     $var = "K";
package M;     $var = "M";

package main;

use Package::Alias A => B;
use Package::Alias C => D;
use Package::Alias K => L,
		   M => N;

# Originals
is $A::var,	"A",		"Original: A";
is $C::var,	"C",		"Original: C";
is $K::var,	"K",		"Original: K";
is $M::var,	"M",		"Original: M";

# Aliases
is $B::var,	"A",		"Alias: B";
is $D::var,	"C",		"Alias: D";

# More than one package aliased in one call
is $L::var,	"K",		"Alias: L";
is $N::var,	"M",		"Alias: N";

ok    $A::var
    & $B::var
    & $C::var
    & $D::var
    & $K::var
    & $L::var
    & $M::var
    & $N::var,			"Silence warnings by using variables once";
