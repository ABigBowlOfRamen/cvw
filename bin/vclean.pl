#!/usr/bin/perl -w

# vclean.pl
# David_Harris@hmc.edu 7 December 2023
# Identifies unused signals in Verilog files
#   verilator should do this, but it also reports partially used signals

use strict;

for (my $i=0; $i<=$#ARGV; $i++) {
    my $fname = $ARGV[$i];
    &clean($fname);
}

sub clean {
    my $fname = shift;

#    printf ("Cleaning $fname\n");
    open(FILE, $fname) || die("Can't read $fname");
#    my $incomment = 0;
    my @allsigs;
    while (<FILE>) {
        if (/typedef/) { } # skip typedefs
        elsif (/logic (.*)/) { # found signal declarations
            my $siglist = $1;
            $siglist =~ s/\/\/.*//; # trim off everything after //
#            print ("Logic: $siglist\n");
            $siglist =~ s/\[[^\]]*\]//g; # trim off everything in brackets
            $siglist =~ s/\s//g; # trim off white space
#            print ("Logic Trimmed: $siglist\n");
            my @sigs = split(/[,;)]/, $siglist);
#            print ("Logic parsed: @sigs\n");
            push(@allsigs, @sigs);
        }
    }
#    print("Signals: @allsigs\n");
    foreach my $sig (@allsigs) {
#        print("Searching for $sig\n");
        my $hits = `grep -c $sig $fname`;
#        print("  Signal $sig appears $hits times\n");
        if ($hits < 2) {
            printf("$sig not used in $fname\n");
        }
    }
}