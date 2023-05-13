#!/usr/bin/perl
# This is used to find duplicate files in a system.
use strict;
use warnings FATAL => 'all';
use File::Find;
use File::Basename;
use File::Spec;
use User::pwent;
# It uses jdupes, fdupes, and findimagedupes packages to find duplicate files, and images.
# run the 3 packages
my $USER = getpwuid($<);
system "jdupes $USER > ~/jdupes.txt";
system "findimagedupes ~/ > ~/findimagedupes.txt";
system "fdupes ~/ > ~/fdupes.txt";

# open the files