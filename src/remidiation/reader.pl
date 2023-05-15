#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
# this script is for cleaning the ,/tmp/boot_database, and reading 1 warning at a time

my $file = '/tmp/boot_database';
# return the first line of the file
my $line = `head -n 1 $file`;
# print the first line of the file, type f if we want to fix it, 'n' if we don't, then delete the line and repeat.
#  'q' to quit
while ($line) {
    print $line;
    print "fix? (f/n/q): ";
    my $input = <STDIN>;
    chomp $input;
    # if no, ask the user if they want delete the line from the repair file
if ($input eq 'n') {
        print "delete? (y/n): ";
        $input = <STDIN>;
        chomp $input;
    } elsif ($input eq 'q') {
        exit;
    } else {

            # delete the line from the file
            `sed -i '1d' $file`;
        }
    }
    # delete the line from the file
    `sed -i '1d' $file`;
    # get the next line
    $line = `head -n 1 $file`;
}
