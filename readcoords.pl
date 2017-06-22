use strict;
use warnings;

# This script will extract xy coordinates into a file from a wafermap. 

my $ifile  = "wafermap.txt"; # wafermap file 
my $ofile = "temp.txt"; # output file 
my @chars;
my $i;
my $x_initial; # start x for the wafermap
my $y_initial; # start y for the wafermap
my $lineno;
my $x;
my $y;
$x_initial=1; # here you input start x 
$y_initial=1; # here you input start y

open my $myfile, $ifile or die "couldn't open $ifile: $!";
open my $myofile,  '>', $ofile;
$lineno = 0;
#print "x y bin\n";
print $myofile "x y bin\n";
while (my $line = <$myfile>){
	
	@chars = split("", $line);
	$line =~ s/\s+$//; #trim right side of string
	my $noofelements = $#chars;
	#print "..$noofelements\n";
	
	for ($i=0; $i <= $noofelements; $i++) {
		if($chars[$i] =~ /\w/){
			$x = $i+$x_initial;
			$y = $lineno+$y_initial;
			#print "$x $y $chars[$i]\n"; #print to output screen
			print $myofile "$x $y $chars[$i]\n"; # print to output file;
		}
	}
	$lineno++;
	

}
close $myfile;
close $myofile;

