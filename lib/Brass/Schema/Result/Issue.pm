use utf8;
package Brass::Schema::Result::Issue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Brass::Schema::Result::Issue

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<issue>

=cut

__PACKAGE__->table("issue");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 type

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 author

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 owner

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 approver

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 reference

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 project

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 security

  data_type: 'smallint'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "type",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "author",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "owner",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "approver",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "reference",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "project",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "security",
  { data_type => "smallint", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 approver

Type: belongs_to

Related object: L<Brass::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "approver",
  "Brass::Schema::Result::User",
  { id => "approver" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 author

Type: belongs_to

Related object: L<Brass::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "author",
  "Brass::Schema::Result::User",
  { id => "author" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 comments

Type: has_many

Related object: L<Brass::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "Brass::Schema::Result::Comment",
  { "foreign.issue" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 issue_priorities

Type: has_many

Related object: L<Brass::Schema::Result::IssuePriority>

=cut

__PACKAGE__->has_many(
  "issue_priorities",
  "Brass::Schema::Result::IssuePriority",
  { "foreign.issue" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 issue_statuses

Type: has_many

Related object: L<Brass::Schema::Result::IssueStatus>

=cut

__PACKAGE__->has_many(
  "issue_statuses",
  "Brass::Schema::Result::IssueStatus",
  { "foreign.issue" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 owner

Type: belongs_to

Related object: L<Brass::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "owner",
  "Brass::Schema::Result::User",
  { id => "owner" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 project

Type: belongs_to

Related object: L<Brass::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "Brass::Schema::Result::Project",
  { id => "project" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 type

Type: belongs_to

Related object: L<Brass::Schema::Result::Type>

=cut

__PACKAGE__->belongs_to(
  "type",
  "Brass::Schema::Result::Type",
  { id => "type" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-08-28 16:40:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cxYD4AmlP9wBhcEbuSEHzQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
