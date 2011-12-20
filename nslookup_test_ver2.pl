#!/usr/bin/perl
######################################################
#
#               NSLOOKUP TEST Script
#
#                 nslookup_test.pl
#
#                DENET.CO.,LTD
#
#       auther   : onishi@Midc 19/12/2011
#       update by: onishi@Midc 20/12/2011
#       usage    : ./nslookup_test.pl
#                : perl nslookup_test.pl
#
######################################################
use strict;
use warnings;

##Initialize section.
my $dir = "/var/named/chroot/var/namedb";
my $count = 0;
my $success_count = 0;
my $error_count = 0;

open(OUT,"> nslookup_test.txt");

use Net::Nslookup;
use File::Find;

find( \&get_domain_name, $dir );

sub get_domain_name{
        if( $_ =~ /^db./ ){
                if( $_ =~ /_remove/ ){
                }elsif( $_ =~ /_20[0-9][0-9]/ ){
                }elsif( $_ =~ /[A-Z]/ ){
                }elsif( $_ =~ /.jp.[a-z,0-9]/ ){
                }else{
                        $_ =~ s/^db.//g;
                        print OUT "[";
                        if( nslookup( domain => $_, type => "A" ) ){
                                print OUT $_."] Nslookup OK.\n";
                                $success_count++;
                        }else{
                                print OUT $_."] Nslookup NG.\n";
                                $error_count++;
                         }
                }
        }
        $count++;
}

print OUT "\n";
print OUT "Number of zone-files:".$count."\n";
print OUT "Number of success:".$success_count."\n";
print OUT "Number of error:".$error_count."\n";

close(OUT);

exit 0;
