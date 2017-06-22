#!/usr/bin/perl
use strict;
use warnings;

use strict;
my $wafermapfile = "G626616_W01";
use Text::CSV_XS;
use Scalar::Util qw(looks_like_number);

use Excel::Writer::XLSX;
use Spreadsheet::ParseExcel::SaveParser;

my $excel  = Excel::Writer::XLSX->new('wafermap.xlsx');
my $worksheet = $excel->add_worksheet('Wafermap');

sub read_wafermap_and_write_excel
{
	#use Text::CSV_XS;
	#use Excel::Writer::XLSX;
	#my $excel  = Excel::Writer::XLSX->new('wafermap.xlsx');
        #my $worksheet = $excel->add_worksheet('Wafermap');
	# my $excel= @_;
	# my $worksheet = $excel->add_worksheet('Wafermap');
	#my $csv = Text::CSV_XS-> new({binary => 1, eol =>"\n"});
	my $csv = Text::CSV_XS-> new({binary => 1, eol =>"\n"});
	#open my $fh1, '<', \$string;
	
	open (my $fh1, "<:crlf" , $wafermapfile . ".map" ) or die "couldn't open file, $!";
	
	#open fh1, "<" , $wafermapfile.".txt" or die "couldn't open file, $!";
	open my $fh2, ">>" , $wafermapfile."_mod".".txt" or die "couldn't open file, $!";

	my ($buf, $data, $n);
	my $lineno;
	my $colno;
	$lineno = 0;
	$colno = 0;
	#while (($n = read  fh1, $data, 1) != 0)
	
	while (my $line = <$fh1>)
	{
	   # fh2->print($data);
	   open (my $fh3,"<",\$line);
	   
	   while (($n = read  $fh3, $data, 1) != 0)
	   {
		#print $data;
		$fh2 -> print($data);
		if (looks_like_number($data))
		{	
			$worksheet->write( $lineno,$colno, "$data");
			
		}else{
			$worksheet->write_string( $lineno,$colno, $data);
		}
		#$worksheet->set_column($colno,$colno,1.3);
		format_excel_sheet($lineno,$colno,1.3);
		$colno +=1;
	   }
	   $colno = 0;
	   $lineno += 1;
	   #print $lineno, "-",$colno,".\n";
	   
	}
	close($fh1);
	close ($fh2);
	$excel->close;
	
}

sub format_excel_sheet
{
	my $rowno = shift;
	my $colno = shift;
	print $rowno,"_",$colno,"\n";
	$worksheet->set_column($colno,$colno,1.3);
		
}

# my $excel  = Excel::Writer::XLSX->new('wafermap.xlsx');
# my $worksheet = $excel->add_worksheet('Wafermap');

read_wafermap_and_write_excel(); # read and write to excel from wafermap
format_excel_sheet();

# $excel->close;
