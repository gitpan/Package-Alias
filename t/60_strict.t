# -*- perl -*-
#
# Tests behavior under strict.
#

#use Test::More tests => 5;
use Test::More qw/no_plan/;

use strict;

$A::B::var = "A::B";
$D::var    = "D";

use Package::Alias C    => 'A::B',
		   'E::F' => 'D';

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
