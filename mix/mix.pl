use strict;
use warnings;
use GD::Graph::mixed; #混和 效果有限
use GD::Graph::Data;
use GD::Graph::colour;
use List::Util qw/max min/;
use POSIX;

my $datafile = glob "*.txt"; #讀取任何 TXT檔
open (my $t,"< $datafile") or die "Cannot open $datafile to read: $!";
my @input = <$t>;
close($t);

my @x = "";
my @y1 = "";
my @y2 = "";
my @y3 = "";
my @y4 = "";
my @y5 = "";
my @y6 = "";

foreach my $index (0..$#input){
$input[$index] =~ s/^\s*//g;
chomp($input[$index]);
($x[$index],$y1[$index],$y2[$index],$y3[$index],$y4[$index],$y5[$index],$y6[$index]) = split(/\s+/,$input[$index]);
}

my $data = GD::Graph::Data->new([[@x],[@y1],[@y2],[@y3],[@y4],[@y5],[@y6]]) or die GD::Graph::Data->error;
my $y1max1 = ceil(max @y1);
my $y1min1 = floor(min @y1);
my $y2max1 = ceil(max @y2);
my $y2min1 = floor(min @y2);
my $y3max1 = ceil(max @y3);
my $y3min1 = floor(min @y3);
my $y4max1 = ceil(max @y4);
my $y4min1 = floor(min @y4);
my $y5max1 = ceil(max @y5);
my $y5min1 = floor(min @y5);
my $y6max1 = ceil(max @y6);
my $y6min1 = floor(min @y6);
#my $xmax=sprintf("%.0f", max @x);
#my $xmin=sprintf("%.0f", min @x);
my $graph = GD::Graph::mixed->new(1920, 1080);
my$ymax= $y3max1+1; 
my$ymin= $y2min1-1;
print $ymin;
$graph->set( 
	types => ['lines', 'bars', undef, 'area', 'linespoints', 'bars',],
    default_type => 'points',

	x_label         => 'X Label',
    y_label         => 'Y label',
    title           => 'A Mixed Type Graph',
    y_max_value     => $ymax,
    y_min_value    => $ymin,
    y_tick_number   => 3,
    y_label_skip    => 1,
    x_plot_values   => 1,
    y_plot_values   => 1,
    long_ticks      => 1,
    x_ticks         => 0,
    legend_marker_width => 24,
    line_width      => 3,
    marker_size     => 12,
    bar_spacing     => 8,
    transparent     => 0,
) or die $graph->error;

#字體設定
$graph->set_x_label_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_y_label_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_x_axis_font("c:/WINDOWS/fonts/arial.ttf",15 );
$graph->set_y_axis_font("c:/WINDOWS/fonts/arial.ttf",15);

$graph->plot($data) or die $graph->error;

#檔案輸出
my $file = 'mixed.png';
open(my $out, '>', $file) or die "Cannot open '$file' for write: $!";
binmode $out;
print $out $graph->gd->png;
close $out;
 
