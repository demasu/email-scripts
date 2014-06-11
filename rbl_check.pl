#!/usr/bin/perl

use strict;
use warnings;

# These two aren't core, so you need to get them installed before this will work.
use Carp qw( croak );

# Way more lists out there, but I'll add them later.
my %list = (
    'sbl-xbl.spamhaus.org'        => 'http://www.spamhaus.org',
    'pbl.spamhaus.org'            => 'http://www.spamhaus.org',
    'bl.spamcop.net'              => 'http://www.spamcop.net',
    'dsn.rfc-ignorant.org'        => 'http://www.rfc-ignorant.org',
    'postmaster.rfc-ignorant.org' => 'http://www.rfc.ignorant.org',
    'abuse.rfc-ignorant.org'      => 'http://www.rfc.ignorant.org',
    'whois.rfc-ignorant.org'      => 'http://www.rfc.ignorant.org',
    'ipwhois.rfc-ignorant.org'    => 'http://www.rfc.ignorant.org',
    'bogusmx.rfc-ignorant.org'    => 'http://www.rfc.ignorant.org',
    'dnsbl.sorbs.net'             => 'http://www.sorbs.net',
    'badconf.rhsbl.sorbs.net'     => 'http://www.sorbs.net',
    'nomail.rhsbl.sorbs.net'      => 'http://www.sorbs.net',
    'cbl.abuseat.org'             => 'http://www.abuseat.org/support',
    'relays.visi.com'             => 'http://www.visi.com',
    'list.dsbl.org'               => 'http://www.dsbl.org',
    'opm.blitzed.org'             => 'http://www.blitzed.org',
    'zen.spamhaus.org'            => 'http://www.spamhaus.org',
    'combined.njabl.org'          => 'http://www.njabl.org/',
);

# Grab the IPv4 address from user
print "Give me an IPv4 Address, please: ";
chomp( my $ip = <STDIN>);

if ( $ip !~ /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ ) {
	croak "$ip is not a valid IP address!";
}

foreach my $line (keys %list) {
    my $host = "$ip.$line";
    my $ret = qx/dig +short $host/;

	if ( $ret ) {
		print "List: $line - $ip is listed\n";
	}
	else {
		print "List: $line - Nope\n";
	}
}
