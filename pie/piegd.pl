use strict;
use warnings;
use GD::Graph::pie; #圓餅圖
use GD::Graph::Data;
use GD::Graph::colour;
use List::Util qw/max min/;
use POSIX;
my $datafile = glob "*.txt";
open (my $t,"< $datafile") or die "Cannot open $datafile to read: $!";
my @input = <$t>;
close($t);

my @x = "";
my @y1 = "";

foreach my $index (0..$#input){
$input[$index] =~ s/^\s*//g;
chomp($input[$index]);
($x[$index],$y1[$index]) = split(/\s+/,$input[$index]);
}
#my $y1max1 = ceil(max @y1);
#my $y1min1 = floor(min @y1);
#my $y2max1 = ceil(max @y2);
#my $y2min1 = floor(min @y2);
#my $xmax=sprintf("%.0f", max @x);
#my $xmin=sprintf("%.0f", min @x);

my $data = GD::Graph::Data->new([[@x],[sort { $b <=> $a}(@y1)]])
	 or die GD::Graph::Data->error;
  
my $graph = GD::Graph::pie->new(800, 800);

$graph->set( 
	start_angle 	=> 90,
	"3d" 			=> 1,
	title 			=> 'A Pie Graph',
	label 			=> 'label',
	suppress_angle	=> 5, 
	transparent 	=> 0,
	suppress_angle  => 0,
	#show_value  	=> 1,
) or die $graph->error;

#字體設定
$graph->set_title_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_label_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_value_font("c:/WINDOWS/fonts/arial.ttf",15);

$graph->plot($data) or die $graph->error;

#檔案輸出
my $file = 'pie.png';
open(my $out, '>', $file) or die "Cannot open '$file' for write: $!";
binmode $out;
print $out $graph->gd->png;
close $out;
 
