#!/usr/bin/perl
# This is used to find duplicate files in a system.
# It uses jdupes, fdupes, and findimagedupes packages to find duplicate files, and images.
use strict;
use warnings FATAL => 'all';
use File::Find;
use File::Basename;
use File::Spec;
use User::pwent;

# run the 3 commands to find duplicate files, and images
my $USER = getpwuid($<);
system "jdupes $USER > ~/jdupes.txt";
system "findimagedupes ~/ > ~/findimagedupes.txt";
system "fdupes ~/ > ~/fdupes.txt";

# list the duplicate data(if any) in the terminal
print "jdupes\n";
system "cat ~/jdupes.txt";
print "fdupes\n";
system "cat ~/fdupes.txt";
# not sure the below is working for obvious reasons
print "findimagedupes\n";
system "cat ~/findimagedupes.txt";

# ask the user if they want to delete the duplicate files
print "Do you want to delete the duplicate files? (y/n)\n";
my $answer = <STDIN>;
chomp $answer;
if ($answer eq "y") {
    # delete the duplicate files
    print "Deleting duplicate files...\n";
    system "jdupes -rdN $USER";
    system "fdupes -rdN $USER";
    system "findimagedupes -d ~/";
    print "Done!\n";
} else {
    print "No files were deleted.\n";
}
# terminate the program, and exit
exit 0;

#This is not working yet. I am still working on it. Feel free to help me out.