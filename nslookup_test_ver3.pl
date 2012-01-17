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
#       update by: onishi@Midc 17/1/2012
#       usage    : ./nslookup_test.pl
#                : perl nslookup_test.pl
#
######################################################
use strict;
use warnings;

my $dir = "/var/named/chroot/var/namedb";
my $count = 0;
my $success_count = 0;
my $error_count = 0;

if( !-d $dir){
        die("error:$!");
}

open(OUT,"> nslookup_test.txt");

use Net::Nslookup;
use File::Find;

find( \&get_domain_name, $dir );

sub get_domain_name{
        if($File::Find::dir !~ /old/){
                if( ($_ =~ /^bootfile./) && ($_ !~ /_20[0-9][0-9]/) && ($_ !~ /matsuo/) ){
##                       print $File::Find::name,"\n";##DEBUG CODE
                         open(IN,"< $File::Find::name");
                         while(<IN>){
                                 if( ($_ =~ /^zone/) && ($_ !~ /in-addr.arpa/ ) ){
                                         $_ =~ s/^zone "//g;
                                         $_ =~ s/" {//g;
                                         $_ =~ s/"{//g;
                                         chomp $_;
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
                        close(IN);
                        $count++
                }
        }
}

print OUT "\n";
print OUT "Number of bootfiles:".$count."\n";
print OUT "Number of success:".$success_count."\n";
print OUT "Number of error:".$error_count."\n";

close(OUT);

exit 0; 