#!/usr/bin/perl
use strict;
use warnings;

use strict;
my $wafermapfile = "G624741_W02";

sub read_wafermap_and_write_excel
{
	open (my $fh1, "<:crlf" , $wafermapfile . ".map" ) or die "couldn't open file, $!";
	
	open my $fh2, ">>" , $wafermapfile."_mod".".txt" or die "couldn't open file, $!";
	my $data;
	local $/ = undef;
	my $lines = <$fh1>;
	close($fh1);

	# while ( <$fh1> ) {
		# $data .= $_;
		# # if (defined $_ && length $_ > 0){
			# # $data .= $_;
			# # $_ =~ /\sF(.*)F\s/g;
			# # if (defined $1 && length $1 > 0){
				# # print $fh2 $1."\n";
			# # }
			# # my @line = split("", $_);
			
			# # count(\@line,'F');
		# # }
	# }
	#print $fh2 $lines;
	$lines =~ /\sF(.*)F\s/g;
	my $countchar=0;
	while ( $lines =~ /\sF(.*)F\s/g) {
		print $fh2 $1."\n";
		my @line = split("", $1);
		print $1."\n";
		for (my $i=0;$i <= scalar(@line);$i++){
			if(length($line[$i]) > 0){
				if($line[$i] eq 'F'){
					print $line[$i];
					$countchar++;
				}
			}
		}
		print $countchar."\n";
		
		
	}
	#$data = ~ /\sF(.*)F\s/g;
	#print $1;
}
sub count
{
	my $chartofind = $_[1];
	my @strLine = @{$_[0]};
	my $countchar=0;
	my $i=0;
	#print $chartofind."\n";
	#print @strLine,"\n";
	#print scalar(@strLine)."\n";
	#exit;
	for (my $i=0;$i <= scalar(@strLine);$i++){
		if(length($strLine[$i]) > 0){
			if($strLine[$i] eq $chartofind){
				$countchar++;
			}
		}
	}	
	print $countchar."\n";
	exit;
}


read_wafermap_and_write_excel(); # read and write to excel from wafermap
