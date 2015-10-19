package Abe487Tester::Controller::Tester;

use File::Temp 'tempdir';
use Mojo::Base 'Mojolicious::Controller';

# --------------------------------------------------
sub index {
    my $self = shift;
    $self->layout('default');
    $self->render();
}

# --------------------------------------------------
sub test {
    my $self      = shift;
    my $github_id = $self->param('github_id') 
                    or return $self->reply->exception("No Github ID");
    my $week      = $self->param('week')
                    or return $self->reply->exception("No week");

    my $results   = $self->run_test($github_id, $week);

    $self->layout('default');
    $self->render(
        github_id => $github_id, 
        week      => $week, 
        results   => $results,
    );
}

# --------------------------------------------------
sub run_test {
    my ($self, $github_id, $week) = @_;
    my $tmpdir = tempdir();
    say STDERR "tmpdir = '$tmpdir'";
    chdir $tmpdir;
    for my $id ($github_id, 'kyclark') {
        $self->execute(qw[git clone], "https://github.com/$id/abe487.git", $id);

        unless (-d $id) {
            return "Unable to clone '$id'";
        }
    }

    my $test_conf = "kyclark/lab/tester/${week}.conf";
    unless (-e $test_conf) {
        return "$week config ($test_conf) does not exist";
    }

    my $results = 
        `kyclark/lab/tester/tester.pl -t $test_conf -d $github_id/$week 2>&1`;

    return $results || "Unable to complete tests";
}

# --------------------------------------------------
sub execute {
    my $self = shift;
    my @args = @_ or return;

    say STDERR "executing ", join ' ', @args;
    system(@args) == 1 or return $self->reply->exception($?);
}

1;
