#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use IO::Socket::IP;

my %case = (
    "set LocalAddr => :: for IO::Socket::IP" => { LocalAddr => '::' },
    "do not set LocalAddr for IO::Socket::IP" => {},
);

for my $case (sort keys %case) {
    say "---> Case: $case";
    my $server = IO::Socket::IP->new(
        %{$case{$case}},
        LocalPort => 8445,
        Listen => 5,
        Proto => 'tcp',
    );
    if (!$server) {
        say "Failed to create a TCP server, $!";
        next;
    }

    my $host = $server->sockhost;
    my $port = $server->sockport;
    say "Successfully created a TCP server on $host:$port";

    $host = '127.0.0.1' if $host eq '0.0.0.0';
    $host = '::1'       if $host eq '::';
    my $client = IO::Socket::IP->new(
        PeerHost => $host,
        PeerPort => $port,
    );

    if ($client) {
        say "Successfully connected the server via $host:$port";
        close $client;
    } else {
        say "Failed to connect the server via $host:$port, $!";
    }
    close $server;
}
