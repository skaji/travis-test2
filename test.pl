#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.1;
use IO::Socket::IP;

my $server = IO::Socket::IP->new(
    LocalHost => '::',
    LocalPort => 8334,
    Listen => 5,
    Proto => 'tcp',
    ReuseAddr => 1,
) or die "Failed to create a TCP server: $!";

say "Successfully created a TCP server on [::]:8334";

my $client = IO::Socket::IP->new(
    PeerHost => '::1',
    PeerPort => 8334,
);

if ($client) {
    say "Successfully connected the server via [::1]:8334";
} else {
    say "Failed to connect the server via [::1]:8334: $!";
}
