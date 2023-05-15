#!/usr/bin/perl
# This is to check for boot anomalies at startup time prints anything from warning level up to the screen
# and to a log file(/tmp/boot_database) hopefully for future ai learning
# and better performance of the host machine
use strict;
use warnings FATAL => 'all';
use diagnostics;
# use colors for the output
use Term::ANSIColor;
# use the system command
use feature qw(say);
# All commands in this script must bu run as root
if ($> != 0) {
    print "be root to run this script.. OR DIE!\n";
    exit 1;
}
# print the header for the script
print color('bold blue');
print "This is the boot anomaly checker\n";
# first we need to create the file for the next process
system("touch /tmp/boot_database");
=begin
now we need to append the output of the command to check for boot anomalies to the file,
with some pretty colors for levels of severity(warnings=red, errors=yellow, critical=yellow, fail=bold dark red,
exit=blue, date=green)
wheel do this in steps
=cut
my $output = system("journalctl -b | grep -Ei 'warn|error|crit|fail' |
 perl -pe 's/(warn.*)/\\e[1;33m\$1\\e[0m/gi;
  s/(error.*)/\\e[1;31m\$1\\e[0m/gi;
  s/(crit.*)/\\e[1;31m\$1\\e[0m/gi;
   s/(fail.*)/\\e[1;31m\$1\\e[0m/gi;
   s/(exit.*)/\\e[1;34m\$1\\e[0m/gi;
    s/(\\d{4}-\\d{2}-\\d{2})/\\e[1;32m\$1\\e[0m/gi'");
    # now we cut everything before and including "parrot" from each line, and append it to the file
    system("echo $output | >> /tmp/boot_database");
# now with the data we need in a file, we need to continue to the remediation script