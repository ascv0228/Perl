use strict;
use warnings;
use GD::Graph::bars; #長條圖
use GD::Graph::Data;
use GD::Graph::colour;
use List::Util qw/max min/;
use POSIX;

### the following GD plot parameters

my $input_datafile = 'sin000_300.txt'; # your input data file for plotting
my $output_file = 'sin_bar_300.png'; # your output file for plotting
my $plotTitle = 'sin bar chart';
my $x_labelName = 'x position';
my $y1_labelName = 'sin value';
my $y1_legend = 'sin profile';


open (my $t,"< $input_datafile") or die "Cannot open $input_datafile to read: $!";
my @input = <$t>;
close($t);
my @x = "";
my @y1 = "";

foreach my $index (0..$#input){
$input[$index] =~ s/^\s*//g;
chomp($input[$index]);
($x[$index],$y1[$index]) = split(/\s+/,$input[$index]);
}

my $data = GD::Graph::Data->new([[@x],[@y1]])
 or die GD::Graph::Data->error;
my $y1max1 = ceil(max @y1);
my $y1min1 = floor(min @y1);
my $xmax= ceil(max @x);
my $xmin= floor(min @x);
 
my $graph = GD::Graph::bars->new(1920, 1080);

$graph->set( 
	overwrite       	=> 1,
    x_label         	=> $x_labelName,
    y1_label        	=> $y1_labelName,
    title           	=> $plotTitle,
	legend_placement 	=> 'RT',
	x_label_position    => 1/2,					
	transparent 		=> 0,
	dclrs 				=> ['lgreen', 'lred', 'lblue', 'lpurple'],
	l_margin        	=> 2,
	b_margin        	=> 2,
	r_margin        	=> 2,
	t_margin        	=> 2,	
	x_label_skip		=> 1,
	#x_tick_number   	=> 180,
	x_min_value			=> $xmin,
	x_max_value			=> $xmax,					
    y1_min_value		=> $y1min1,
	y1_max_value     	=> $y1max1,	
	#bar_width			=> .5,
	#bar_spacing			=> .1, 
	#shadow_depth		=> 10, 
) or die $graph->error;

#圖例設定
$graph->set(legend_marker_width => 20); 		
$graph->set(legend_marker_height => 12);		
$graph->set_legend($y1_legend);	
$graph->set(legend_spacing=>20); 				

#字體設定
$graph->set_x_label_font("c:/WINDOWS/fonts/arial.ttf",15);	
$graph->set_y_label_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_x_axis_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_y_axis_font("c:/WINDOWS/fonts/arial.ttf",15);
$graph->set_title_font("c:/WINDOWS/fonts/arial.ttf",20); 
$graph->set_legend_font("c:/WINDOWS/fonts/arial.ttf",20);
 
$graph->plot($data) or die $graph->error;
 
#output our plot
unlink "$output_file";
open(my $out, '>', "$output_file") or die "Cannot open $output_file for write: $!";
binmode $out;
print $out $graph->gd->png;
close $out;
 
