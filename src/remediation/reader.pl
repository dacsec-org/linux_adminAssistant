#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

=begin
 this script is for cleaning the ,/tmp/boot_database,
 and reading 1 warning at a time for the admin to decide
 if they want to fix it or not.
 after there working properly, this and the fix_line.pl
 script will be combined into one script.

=cut
# file to read
my $file = '/tmp/boot_database.txt';

# return the first line of the file
my $line = `head -n 1 $file`;

=begin
 print the first line of the file.
 type 'f' if we want to fix it,
 'n' if we don't, delete the line
 if we want, and repeat.
 'q' to quit

=cut
while ($line) {
    print $line;
    print "\nfix? (f/n/q): ";
    my $input = <STDIN>;
    chomp $input;

# if no, ask the admin if they want delete the line from the repair file
if ($input eq 'n') {
        print "\ndelete? (y/n): ";
        # get the input
        $input = <STDIN>;
        # if yes, delete the line from the file
        if ($input eq 'y') {
            `sed -i '1d' $file`;

        }
        chomp $input;
    } elsif ($input eq 'q') {
        exit;
# if the the admin wants to fix a warning(line), send that warning to the
# fix_line.pl script as the '$line' variable
    } elsif ($input eq 'f') {

        my $fix = `./fix_line.pl $line`;
        if ($fix eq 'y') {
            `sed -i '1d' $file`;
        }
    } else {
    # delete the line from the file
    `sed -i '1d' $file`;
        }
    }

