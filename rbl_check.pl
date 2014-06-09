#!/usr/bin/perl

use strict;
use warnings;

use Net::DNS;
use Data::Validate::IP ('is_ipv4');

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
my $v = Data::Validate::IP->new();

die "not an IPv4 ip" unless ($v->is_ipv4($ip));

foreach my $line (keys %list) {
    my $host = "$ip.$line";
    my $res = Net::DNS::Resolver->new;
    my $query = $res->search("$host");

    if($query) {
        foreach my $rr ($query->answer) {
            next unless $rr->type eq "A";
        }
        print "List: $line - $ARGV[0] is listed\n";
    } else {
        print "List: $line - Nope\n";
    }
}
