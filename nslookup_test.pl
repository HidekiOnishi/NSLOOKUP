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
#       update by: onishi@Midc 19/12/2011
#       usage    :./nslookup_test.pl <FileName>
#
######################################################
use strict;
use warnings;
use Net::Nslookup;

if(@ARGV == 0){
        print "Domain File Not Found.\n";
        print "Usage: nslookup_test.pl <FileName>\n";
        exit -1;
}

##Initialize section.
open(IN,"< $ARGV[0]");
open(OUT,"> $ARGV[0]_nslookup.txt");
my $count = 0;
my $domain_count = 0;
my $error_count = 0;
my $success_count = 0;

while(<IN>){
	chomp $_;

	my $address;

	my @address = nslookup(domain => $_,type => "A"); 
	print OUT "===========================================\n";
	print OUT "[";
	if( nslookup( domain => $_, type => "A" ) ){
		print OUT $_."] Nslookup OK.\n";
		$success_count++;
	}else{
		print OUT $_."] Nslookup NG.\n";
		$error_count++;
	}

	if( @address ){
		foreach $address (@address){
			print OUT "A record is ".$address."\n";
		}
	}else{
		print OUT "A record is empty.\n";
	}
	print OUT "===========================================\n";
	$domain_count++;

}

print OUT "Number of domains:".$domain_count."\n";
print OUT "Number of success:".$success_count."\n";
print OUT "Number of error  :".$error_count."\n";

close(IN);
close(OUT);

print "\n";
print "            -------------";

$count = length($ARGV[0]);
while($count > 0){
        print "-";
        $count--;
}

print "---------------\n";
print "(*´ω｀*)< please check $ARGV[0]_nslookup.txt! |\n";
print "            -------------";

$count = length($ARGV[0]);
while($count > 0){
        print "-";
        $count--;
}

print "---------------\n";
print "\n";
exit 0;

