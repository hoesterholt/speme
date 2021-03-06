package macro;

my $y=2;

sub set_y {
  $y=shift;
}

#
# (define y 2)
#
# (define-syntax max
#     (syntax-rules ()
#       ((_ a) (let ((count 0))
#                 (set! count (+ count 1))
#                 (print count)
#                 (* y a)))
#       ((_ a ...) (+ (max a) (max ...)))))
#                  
# (max a b c d) resulteert in 
#    our $someid;if (not(defined($someid))) { $someid=max(4); }  
#		// Declaratie van de instantiatie van max.
#    $someid->(\$a,\$b,\$c,\$d);								
#		// Gebruik van de instantiatie. Het is een macro, dus aanroep op basis van references.
#		// Dus hoe te herkennen dat het een macro is? 
#		// Goede vraag. Dat moet dus ergens bekend zijn in lijstje oid.
#
#

sub max($) {
   my $n=shift;
   if ($n==1) {
      my $count=0;
      return sub { $count+=1;print $count; my $a=shift; return $y*${$a}; };
   } else {
      my $m1=max(1);
      my $m2=max($n-1);
      return sub { my $a=shift; $m1->($a)+$m2->(@_); };
   }
}


sub qr($) {
   my $n=shift;
   if ($n==2) {
     return sub { my $a=shift;my $b=shift; ${$a}=${$b};return ${$a}; };
   } else {
   	 print "NO!\n";
   }
}

#
# (define-syntax deftimes (syntax-rules () ((_ a b) (define (a x) (* x b y)))))
#
sub deftimes($) {
	my $n=shift;
	if ($n==2) {
		return sub { my $a=shift;my $b=shift;
				${$a}=sub { my $x=shift; return $x*${$b}*$y; };
		};
	} else {
		print "NO!\n";
	}
}

sub get_internal_y() {
	return $y;
}

sub deftimes2($) {
  my $ev=shift;
	$ev->("sub { my \$a=shift;my \$b=shift; return \$a*\$b*macro::get_internal_y; }"); #macro::\$y; }");
}



1;
