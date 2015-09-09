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

package Brass::Issues;

use Brass::Issue;
use Moo;
use MooX::Types::MooseLike::Base qw(:all);

has schema => (
    is       => 'ro',
    required => 1,
);

has users => (
    is       => 'ro',
    required => 1,
);

has all => (
    is => 'lazy',
);

has filtering => (
    is      => 'rw',
    isa     => HashRef,
    lazy    => 1,
    default => sub { {} },
    coerce  => sub {
        my $in = shift;
        my $return = {};
        $return->{'me.security'} = $in->{security} eq 'yes' ? 1 : 0
            if $in->{security};
        $return->{'me.project'} = $in->{project}
            if $in->{project};
        $return->{'issue_statuses.status'} = $in->{status}
            if $in->{status};
        $return->{'me.type'} = $in->{type}
            if $in->{type};
        $return->{'-or'} = {
            owner    => $in->{user_id},
            author   => $in->{user_id},
            approver => $in->{user_id},
        } if $in->{user_id};
        $return->{'user_projects.user'} = $in->{project_user_id}
            if $in->{project_user_id};
        $return;
    },
);

sub _build_all
{   my $self = shift;
    my $search = $self->filtering;
    $search->{'issuestatus_later.datetime'} = undef;
    my $issues_rs = $self->schema->resultset('Issue')->search(
        $search
    ,{
        prefetch => [
            {
                project => 'user_projects',
            },
            {
                issue_statuses => 'issuestatus_later'
            }
        ],
        order_by => 'me.title',
    });
    $issues_rs->result_class('Brass::Issue');
    my @all = $issues_rs->all;
    $_->users($self->users) foreach @all;
    \@all;
}

1;

