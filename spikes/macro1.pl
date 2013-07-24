use macro;

my $c=macro::deftimes2(sub { print @_,"\n";return eval shift; });
print "c=",$c,"\n";
print eval "sub { return \"a\"; }","\n";
print eval $c,"\n";
print eval "sub { my \$a=shift;return \$a*\$a; }","\n";
print eval "sub { my \$a=shift;my \$b=shift; return \$a*\$b; }","\n";
my $g=eval "sub { my \$a=shift;my \$b=shift; return \$a*\$b*macro::\$y; }";
print "g=",$g,"\n";

macro::set_y(5);
print "y=",macro::get_internal_y,"\n";
print "y=5,c(2,3)=",$c->(2,3),"\n";
macro::set_y(44);
print "y=44,c(2,3)=",$c->(2,3),"\n";

my $f_max_inst=macro::max(3);
my $f=sub {
   my $a=shift;my $b=shift;my $c=shift;
   return $f_max_inst->($a,$b,$c);
};

my $f_max_inst2=macro::max(8);

print $f->(\2,\3,\4),"-",2*2+2*3+2*4,"\n";
macro::set_y(10);
print $f->(2,3,4),"-",10*2+10*3+10*4,"\n";
print $f->(2,3,4),"-",10*2+10*3+10*4,"\n";
macro::set_y(5);
print $f->(2,3,4),"\n";
macro::set_y(3.14);
print $f->(2,3,4),"\n";
print $f_max_inst2->(1,2,3,4,5,6,7,8),"\n";
print $f_max_inst2->(1,2,3,4,5,6,7,8),"\n";

my $r=100;
macro::set_y(10);
print $f_max_inst->(\$r,\$r,\$r),"\n";

my $tr=macro::qr(2);
print $tr,"\n";
$tr->(\$r,\3);
print $r,"\n";

eval { $tr->(\5,\3); };
print $@;
$tr->(\$r,\"hi there!");
print $r,"\n";

my $t8;
macro::deftimes(2)->(\$t8,\8);
print "(t8 10)=",$t8->(10),"\n";
macro::set_y(9);
print "(t8 10)=",$t8->(10),"\n";



