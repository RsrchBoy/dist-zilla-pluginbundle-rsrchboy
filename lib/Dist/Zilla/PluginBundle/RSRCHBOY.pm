package Dist::Zilla::PluginBundle::RSRCHBOY;

# ABSTRACT: Zilla your Dists like RSRCHBOY!

use Moose;
use namespace::autoclean;

use Dist::Zilla;
with 'Dist::Zilla::Role::PluginBundle::Easy';

sub configure {
    my $self = shift @_;

    $self->add_bundle(Git => {
        allow_dirty => 'dist.ini',
        allow_dirty => 'README.pod',
        allow_dirty => 'Changes',
        tag_format  => '%v',
    });

    $self->add_plugins([ 'Git::NextVersion' =>
        #;first_version = 0.001       ; this is the default
        #;version_regexp  = ^v(.+)$   ; this is the default
        { version_regexp => '^(\d.\d+)$' },
    ]);


    $self->add_plugins(
        qw{
            NextRelease
            GatherDir
            PruneCruft
            License
            ExecDir
            ShareDir
            MakeMaker
            InstallGuide
            Manifest
            PkgVersion
            PodWeaver
            ReadmeFromPod
            AutoPrereqs

            ConsistentVersionTest
            PodCoverageTests
            PodSyntaxTests
            NoTabsTests
            EOLTests
            CompileTests
            HasVersionTests
            PortabilityTests
            ExtraTests
            MinimumPerl
            ReportVersions
            Prepender

            Authority

            MetaConfig
            MetaJSON
            MetaYAML

            TestRelease
            ConfirmRelease
            UploadToCPAN
            CheckPrereqsIndexed

            GitHub::Meta
            GitHub::Update
        },

        [ ReadmeAnyFromPod  => ReadmePodInRoot => {
            type     => 'pod',
            filename => 'README.pod',
            location => 'root',
        }],

        [ ArchiveRelease => {
            directory => 'releases',
        }],

        [ InstallRelease => {
            install_command => 'cpanm . ||:',
        }],
    );

    return;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=for Pod::Coverage configure

=head1 SYNOPIS

    # in your dist.ini...
    [@RSRCHBOY]

=head1 DESCRIPTION

This is RSRCHBOY's current L<Dist::Zilla> dist.ini config for his packages.
He's still figuring this all out, so it's probably wise to not depend on
this being too terribly consistent/sane until the version gets to 1.

=cut