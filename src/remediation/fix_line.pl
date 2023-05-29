#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

=begin
 fix_line.pl works with the '$line' of <reader.pl> tool to search local man pages, or the nets for the
 selected lines(issues) the admin wants to query, or fix.
 which then returns multiple 'possible' options in an interactive way.
 confirm the line the admin has selected from the reader.pl script to ensure that it is in fact the line they want to
 query or fix

=cut
print "Please confirm the line(issue) you want to query or fix: \n----- "yes" or "no" -----\n";
my $confirm = <STDIN>;
chomp $confirm;
$confirm = lc $confirm;
if ($confirm eq "yes") {
    print "Please enter the line(issue) you want to query or fix: \n";
    my $line = <STDIN>;
    chomp $line;
    print "You have selected line(issue): $line\n" +
        "Please wait while we search for possible solutions to your issue\n";
    #for 'hits' found that have at least 3 matching 'keys' of the '$line'


    # if no then return to the reader.pl script
} elsif ($confirm eq "no") {
    print "Please return to the reader.pl script to select the line(issue) you want to query or fix\n";
} else {
    print "Please enter a valid response: \n----- "yes" or "no" -----\n";
}

