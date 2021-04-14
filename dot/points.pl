use strict;
use warnings;
use GD::Graph::points;	#點狀圖
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
my @y2 = "";

foreach my $index (0..$#input){
$input[$index] =~ s/^\s*//g;
chomp($input[$index]);
($x[$index],$y1[$index],$y2[$index]) = split(/\s+/,$input[$index]);
}

my $data = GD::Graph::Data->new([[@x],[@y1],[@y2]])or die GD::Graph::Data->error;
my $y1max1 = ceil(max @y1)+1;##顯示上比較好看  也可刪除+1
my $y1min1 = floor(min @y1);
#my $y2max1 = ceil(max @y2);
#my $y2min1 = floor(min @y2);
#my $xmax=sprintf("%.0f", max @x);
#my $xmin=sprintf("%.0f", min @x); 
my $y=@y1-1;   
my $graph = GD::Graph::points->new(1920, 1080);

$graph->set( 
	x_label => 'X Label',
	y_label => 'Y label',
	title => 'A Points Graph',
	x_label_position	=> 1/2,		
	y_max_value => $y1max1,
	y_tick_number => $y,
	y_label_skip => 2, 
	legend_placement => 'RT',
	long_ticks => 1,
	marker_size => 15,
	markers => [ 1, 5 ],
	show_values=>1,
	values_space=>10,
	transparent => 0,
) or die $graph->error;

#圖例設定
$graph->set(legend_placement => 'RT'); 
$graph->set(legend_marker_width => 20); 
$graph->set(legend_marker_height => 12);
$graph->set_legend('A', 'B','C');
$graph->set(legend_spacing=>20); 

#字體設定
$graph->set_title_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_x_label_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_y_label_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_x_axis_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_y_axis_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_values_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_legend_font("c:/WINDOWS/fonts/arial.ttf",20); 

$graph->plot($data) or die $graph->error;

#檔案輸出
my $file = 'points.png';
open(my $out, '>', $file) or die "Cannot open '$file' for write: $!";
binmode $out;
print $out $graph->gd->png;
close $out;
 
