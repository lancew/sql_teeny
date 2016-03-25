use strict;
use warnings;
package sql_teeny;

sub interpolate {
    my %args = @_;
    die unless $args{statement} && $args{data};

    my $statement = $args{statement};
    my @binds;
    for my $field (@{$args{data}}){
        if (ref($field) eq "HASH") {
           for my $key (keys %$field) {
                $statement =~ s/%s/$key = ?/;
                push @binds, $field->{$key};
           }
        }
        else
        {
            push @binds, $field;
        }
    }

    return $statement,@binds;
}


1;
