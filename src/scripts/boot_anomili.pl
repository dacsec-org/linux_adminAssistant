#!/usr/bin/perl
# This is to check for boot anomalies at boot time
# it uses grep and cat /proc to check for anomalies
# and prints anything from warning level up to the screen
# and to a log file

use strict;
use warnings FATAL => 'all';
# Make the new log file
my $log = "~/boot_log.txt";
# This is the file to check
my $file = "/proc/kmsg";
# This is the level to check for
my $level = "warning | error | critical | alert | emerg";
# This is the command to check for anomalies
my $cmd = "cat $file | grep -i $level" | $log;
# This is the command to print to the screen
my $cmd1 = "cat $file | grep -i $level";

system($cmd && $cmd1);
if (!system($cmd)) {
    print "There are no anomalies in the boot log\n";
} else {
    print "There are anomalies in the boot log\n";
    exit 0;
}
