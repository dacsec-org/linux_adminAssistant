#!/usr/bin/perl
# This is the installer for the application
use strict;
use warnings FATAL => 'all';
use diagnostics;
use feature 'say';
use Term::ANSIColor;
use File::Copy;
use File::Copy::Recursive qw(dir-copy);
use File::Path qw(make_path remove_tree);
use CPAN::DistnameInfo;

# check if the user is root
if ($< != 0) {
    say "You must be root to run this script.";
    exit;
}

# if this is any debian based system, we can use apt to install the tools.
# return the output of the os_detect.pl script
my $os = `perl os_detect.pl`;
# if the os is debian based, we can use apt to install the tools
if ($os =~ /debian/ || $os =~ /ubuntu/ || $os =~ /mint/ || $os =~ /kali/ || $os =~ /parrot/) {
    say "This is a debian based system. Installing the tools using apt";{
    # update, and upgrade the system first
    system "apt update" && "apt full-upgrade -y";
    }
    # install the tools
    system "apt install -y grep iproute2 iputils-ping net-tools tcpdump netstat traceroute wget curl git ls pciutils
    usbutils lshw lsscsi lsof strace ltrace htop iotop iftop nmap iperf3 iperf iperf3-doc iperf-doc iperf3-dbg iperf-dbg";
}
# if the os is redhat based, we can use yum to install the tools
if ($os =~ /redhat/) {
    say "This is a redhat based system. Installing the tools using yum";{
        # update, and upgrade the system first
        system "yum update" && "yum upgrade -y";
    }
    # install the tools
    system "yum install -y grep iproute2 iputils-ping net-tools tcpdump netstat traceroute wget curl git ls pciutils
    usbutils lshw lsscsi lsof strace ltrace htop iotop iftop nmap iperf3 iperf iperf3-doc iperf-doc iperf3-dbg iperf-dbg";
}
# if the install is successful, print a success message
if ($? == 0) {
    say "The tools have been installed successfully.";
}
# if the install is not successful, print an error message
else {
    say "The tools have not been installed successfully." + $?;
}

# if install failed, grep the logs for the error, and print it, and suggest a fix
