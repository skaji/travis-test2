#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.1;
use IO::Socket::IP;

my $server = IO::Socket::IP->new(
    Listen => 5,
    Proto => 'tcp',
) or die "Failed to create a TCP server, $!";

my $host = $server->sockhost;
my $port = $server->sockport;

say "Successfully created a TCP server on $host:$port";

my $client = IO::Socket::IP->new(
    PeerHost => $host,
    PeerPort => $port,
);

if ($client) {
    say "Successfully connected the server via $host:$port";
} else {
    say "Failed to connect the server via $host:$port, $!";
}
