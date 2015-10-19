use inc::Module::Install;

name           'Abe487Tester';
abstract       'ABE487 Tester';
author         'Ken Youens-Clark <kyclark@email.arizone.edu>';
version        '0.01';
license        'GPL';

requires 'namespace::autoclean';
requires 'common::sense';
requires 'Mojolicious::Plugin::JSONConfig' => '';
requires 'Mojolicious::Plugin::TtRenderer' => '1.50';
requires 'Moose'                           => '2.1005';
requires 'Template'                        => '2.25';
requires 'Template::Plugin::Comma'         => '0.04';
requires 'YAML'                            => '';
requires 'MooseX::MarkAsMethods'           => '';
requires 'MooseX::NonMoose'                => '';
requires 'Captcha::reCAPTCHA'              => '';

test_requires 'Test::More'                 => '0.98';

WriteAll;
