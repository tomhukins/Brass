=pod
Brass
Copyright (C) 2015 Ctrl O Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=cut

package Brass::Config::Servers;

use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has schema => (
    is       => 'ro',
    required => 1,
);

has all => (
    is => 'lazy',
);

sub _build_all
{   my $self = shift;
    my $server_rs = $self->schema->resultset('Server')->search({},{
        join     => 'domain',
        prefetch => 'sites',
        order_by => ['domain.name', 'me.name'],
    });
    $server_rs->result_class('Brass::Config::Server');
    my @all = $server_rs->all;
    \@all;
}

has _index => (
    is => 'lazy',
);

sub _build__index
{   my $self = shift;
    my @all = $self->all;
    my %index = map { $_->id => $_ } @all;
    \%index;
}

sub server
{   my ($self, $id) = @_;
    my $index = $self->_index;
    $index->{$id};
}

1;

