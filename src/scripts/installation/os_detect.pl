#!/usr/bin/perl
# This script's sole purpose is for Operating system detection for the purpose of installing the correct packages
# for the correct OS.
# run perl os_detect.pl from its directory to see the output(you may have to use sudo)
use strict;
use warnings;
use warnings FATAL => 'all';

my $os = `uname -s`;
chomp($os);
if ($os eq "Linux") {
    my $distro = `lsb_release -si`;
    chomp($distro);
    if ($distro eq "Ubuntu") {
        print "Ubuntu\n";
    } elsif ($distro eq "Debian") {
        print "Debian\n";
    } elsif ($distro eq "Fedora") {
        print "Fedora\n";
    } elsif ($distro eq "RedHatEnterpriseServer") {
        print "RedHat\n";
    } elsif ($distro eq "Parrot") {
        print "Parrot\n";
    } elsif ($distro eq "Kali") {
        print "Kali\n";
    } elsif ($distro eq "CentOS") {
        print "CentOS\n";
    } else {
        print "Unknown Linux Distro\n
YOU SHALL DIE NOW!!!\n";
    }

} elsif ($os eq "Darwin") {
    print "MacOS\n";
    } else {
    print "Unknown OS\n
YOU SHALL DIE NOW!!!\n";
}
