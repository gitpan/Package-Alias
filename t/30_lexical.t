# -*- perl -*-
#
# Tests whether lexical values are available in aliased classes
#

use Test::More tests => 4;
#use Test::More qw/no_plan/;

use Package::Alias C    => A::B,
		   E::F => D;

package A::B; use Test::More; my $ab = "A::B";
package C;    use Test::More;
package D;    use Test::More; my $d = "D";
package E::F; use Test::More;


# Originals
package A::B;
is $ab,	"A::B",		"Original: A::B";

package D;
is $d,	"D",		"Original: D";

package C;
is $ab,	"A::B",		"Alias: C";

package E::F;
is $d,	"D",		"Alias: E::F";
