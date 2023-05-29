#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use diagnostics;

# use colors for the output
use Term::ANSIColor;

# use the system command
use feature qw(say);

# to use the normal $USER variable
my $USER = $ENV{USER};

=begin
 This is to check for journalctl anomalies at startup time, prints anything from warning level up to the screen
 and to a log file(/tmp/boot_database) hopefully for future ai learning
 and better performance of the host machine
=cut

# Only the first command in this script must bu run as root
if ( $> != 0 ) {
    print "be root to run this script.. OR DIE!\n";

    # ask user to enter sudo password
    system("sudo -v");

    # check if user entered the correct password
    if ( $? != 0 ) {
        print "You entered the wrong password, exiting...\n";
        exit 1;
    }

    # check if user is root
    if ( $> != 0 ) {
        print "You are not root, exiting...\n";
        exit 1;
    }
}

# print the header for the script
print color('bold blue');
print "This is the boot anomaly checker\n\n";

# # first we need to create the file for the next process
# system("touch /tmp/boot_database.txt");

=begin
 now we need to append the output of the command to next process
 with some pretty colors for levels of severity(warnings=red, errors=yellow,
 critical=yellow, fail=bold dark red, exit=blue, date=green)
 we do this in steps
    1. get the output of the command
=cut

my $output = system(
    "journalctl -b | grep -Ei 'warn|error|crit|fail' |
 perl -pe 's/(warn.*)/\\e[1;33m\$1\\e[0m/gi;
  s/(error.*)/\\e[1;31m\$1\\e[0m/gi;
  s/(crit.*)/\\e[1;31m\$1\\e[0m/gi;
   s/(fail.*)/\\e[1;31m\$1\\e[0m/gi;
   s/(exit.*)/\\e[1;34m\$1\\e[0m/gi;
    s/(\\d{4}-\\d{2}-\\d{2})/\\e[1;32m\$1\\e[0m/gi'"
) or die "failed to run command: $!\n";

=begin
 this part of th script is for printing the '$output' of the above command,
 1 '$line' at a time for the admin to decide if they want to fix it or not.

=cut

# 2. return the the output of the above command 1 line at a time
my $line = `head -n 1 $output`;

# 3. print the first line of the '$output' to the screen
print $line;

# 4. ask the admin if they want to fix the line
print "\nfix? (f/n/q): ";

# 5. get the input from the admin
my $input = <STDIN>;

# 6. remove the newline from the input
chomp $input;

# 7. if the admin doesn't want to fix the line, send it to /dev/null
if ( $input eq 'n' ) {
    `sed -i '1d' $output`;
    chomp $input;

    # go to the next line
    $line = `head -n 1 $output`;

# 8. if the admin wants to fix the line, open a subshell as $USER to do a webearch of the error
}
elsif ( $input eq 'f' ) {

    # ask if we want a local, web, or both search of the error
    print "local, web, or both? (l/w/b): ";

    # get the input from the admin
    $input = <STDIN>;

    # remove the newline from the input
    chomp $input;

    # if we want a local search of the error keep the same root shell
    if ( $input eq 'l' ) {

        # search for the error locally
        my $input = `grep -r $line /var/log`;
        chomp $input;

        # if we want a web search of the error
        # open new shell as $USER and search for the error on the web
    }
    elsif ( $input eq 'w' ) {

        # search for the error on the web
        my $input = `su -c "firefox 'https://duckduckgo.com/?q=$line'" $USER`;
        chomp $input;

        # if we want a local and web search of the error
        # open new shell as $USER and search for the error on the web
    }
    # were getting rid of this option for now due to sub shell issues
    # elsif ( $input eq 'b' ) {

    #     # search for the error locally
    #     my $input = `grep -r $line /var/log`;
    #     chomp $input;

    #     # search for the error on the web
    #     my $input = `su -c "firefox 'https://duckduckgo.com/?q=$line'" $USER`;
    #     chomp $input;
    # }

    # go to the next line
    $line = `head -n 1 $output`;

    # 8. if the admin wants to quit, exit the script
}
elsif ( $input eq 'q' ) {
    exit;

# 9. if the admin enters anything else, print an error message, tell them what they entered, and tell them to try again
# and print the options again
}
else {
    print "You entered '$input', that is not a valid option, try again\n";
    print "fix? (f/n/q): ";
    $input = <STDIN>;
    chomp $input;
}

# end of script
print color('reset');
exit 0;
