package Abe487Tester;

use Mojo::Base 'Mojolicious';

sub startup {
    my $self = shift;

    $self->plugin('JSONConfig', { file => 'tester.json' });

    $self->plugin('PODRenderer');

    $self->plugin('tt_renderer');

    my $r = $self->routes;
    $r->get('/')->to('tester#index');

    $r->get('/test')->to('tester#test');
}

1;
