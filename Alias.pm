# -*- perl -*-
#
# Package::Alias - Alias one namespace into another
#
# $Id: Alias.pm,v 1.5 2003/07/16 19:50:12 jkeroes Exp $

package Package::Alias;
use strict qw/vars subs/;
use vars   qw/$VERSION $DEBUG/;

$VERSION     = '0.02';
$DEBUG       = 0;

#------------------------------------------------------------
# Class Methods
#------------------------------------------------------------

sub alias {
    my $class_or_self = shift;
    my %args  = @_;

    while ( my ( $old, $new ) = each %args ) {

	# Ensure trailing "::" is present.
        $old .= '::' unless  $old =~ /::$/;
        $new .= '::' unless  $new =~ /::$/;

	# Insert a '\' before each "::".
	$old =~ s/ (?<! \\ ) :: /\\::/gx;
	$new =~ s/ (?<! \\ ) :: /\\::/gx;

	my $eval = qq(*{"$new"} = \\*{"$old"});

	print STDERR __PACKAGE__ . ": aliasing '$old' => '$new' with $eval\n"
	    if $DEBUG;

	eval $eval;
    }
}

*import = \&alias;

1;

__END__

#------------------------------
# Docs
#------------------------------

=head1 NAME

Package::Alias - alias one namespace into another

=head1 SYNOPSIS

  use Package::Alias
      main => 'Foo::Bar',
      Package::Name::Simply::Too::Long::To::Use => 'Pkg';

=head1 DESCRIPTION

This module aliases one package name to another. After running the
SYNOPSIS code, @INC and @Foo::Bar::INC reference the same memory.
$Package::Name::Simply::Too::Long::To::Use::var and $Pkg::var do
as well.

Chip Salzenberg says that it's not technically feasible to perform
runtime namespace aliasing.  At compile time, Perl grabs pointers to
functions and global vars.  Those pointers aren't updated if we alias
the namespace at runtime. 

=head1 AUTHOR

Joshua Keroes <skunkworks@eli.net>

=head1 BUGS

alias() should return success or failure but I don't know what to check. Help?

=head1 SEE ALSO

L<Devel::Symdump>

=cut
