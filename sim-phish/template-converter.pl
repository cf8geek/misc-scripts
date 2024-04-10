#!/usr/bin/perl -w
use warnings;
use strict;

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# this is a pretty quick-and-dirty script, it's probably not real safe,
# and doesn't do any user-input sanitization or anything. But it WORKS.

# need cat, curl, and base64 installed. Tested on Ubuntu 22.04 LTS
# will clobber ./tmp.b64 and ./tmp.curl
# could also be:
#if ( not(defined($ARGV[1])) ) {
if ( ! defined $ARGV[1] ) {
	die "Usage: ./converter.pl input.html output.html \n";
} #else {
	our $fh_read;
	our $fh_write;
	our $fh_temp;
	our $inputPath = $ARGV[0];
	our $outputPath = $ARGV[1];
	our $tempPath = "./tmp.b64";
	our $counter = 0;
#}

# open the files to the file handles
open ($fh_read, "<", $inputPath)
	or die "Failed to open input file $!\n";
open ($fh_write, ">", $outputPath)
	or die "Failed to open output file $!\n";

while (my $x = <$fh_read>) {
	# cut off the trailing newline
	#chomp $x;

	# strip all x-sei stuff per KB4 documentation
	# https://support.knowbe4.com/hc/en-us/articles/115001904547-Social-Engineering-Indicators-SEI-Guide#html
	# Non-greedy match ., and make it match a newline:
	# https://www.oreilly.com/library/view/perl-cookbook/1565922433/ch06s16.html
	# https://www.oreilly.com/library/view/perl-cookbook/1565922433/ch06s07.html
	$x =~ s/<x-sei.*?>//sg;
	$x =~ s/<\/x-sei>//sg;

	# replace known/"cared about" KB4 Placeholders with M$ Tags
	# https://support.knowbe4.com/hc/en-us/articles/204949707-Placeholders-Guide
		# and all linked documentation on above page
	# https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/attack-simulation-training-payloads?view=o365-worldwide
	# $x =~ s///sg;
	# for some reason, neither KB4 nor M$ seem to have [[URL]] nor ${phishingUrl} publicly documented, but we know from seeing it before across multiple tenants, that this is how it works...
	# the "malicious" link
	$x =~ s/\[\[URL\]\]/\$\{phishingUrl\}/g;
	# not sure if this one exists in KB4
	#$x =~ s/\[\[\]\]/\$\{userName\}/sg;
	# user's first name
	$x =~ s/\[\[first_name\]\]/\$\{firstName\}/g;
	# user's last name
	$x =~ s/\[\[last_name\]\]/\$\{lastName\}/g;
	# this does not appear to exist in KB4
	$x =~ s/\[\[\]\]/\$\{upn\}/sg;
	# user's primary SMTP address
	$x =~ s/\[\[email\]\]/\$\{emailAddress\}/g;
#	$x =~ s/\[\[\]\]/\$\{\}/sg;
#	$x =~ s///sg;


	# strip all other KB4 placeholders; I'm being lazy and might add more later
	# but, make it obvious
	$x =~ s/\[\[.*?\]\]/##FIXME##/g;
	

	# need to convert images to base64:
	my $thematch;
	# capture:
	# FAIL: https://www.geeksforgeeks.org/perl-use-of-capturing-in-regular-expressions/
	# https://perldoc.perl.org/perlre
	#if ($x =~ m/<img.*?src="(?{$thematch=http.*?}))">/) {
	#if ($x =~ m/<img.*?src="(http.*?)".*?>/) {
	if ($x =~ m/<img.*?src="(http.*?).(jpg|png)".*?>/) {
		$thematch=$1;
		my $thefiletype = $2;
		# call system utilities to do the image conversion
		# https://stackoverflow.com/questions/799968/whats-the-difference-between-perls-backticks-system-and-exec
		system ("curl $thematch\.$2 | base64 -w 0 > ./tmp.b64");
		open ($fh_temp, "<", $tempPath)
			or die "Failed to open input file $!\n";
		my $content = <$fh_temp>;
		# replaces the URL with the base64 data; appropriately marks it as .png or .jpg
		# TODO: download file, run "file" command to find type, put that in... don't rely on extension from original source
		# syntax here:
		# https://www.geeksforgeeks.org/how-to-display-base64-images-in-html/
		$x =~ s/<img(.*?)src="(http.*?)"(.*?)>/<img$1src="data:image\/$thefiletype\;base64,$content"$3>/;
		close ($fh_temp);
	} else {
		# error handling for if it's not a .jpg or .png file
		if ($x =~ m/<img.*?src="(http.*?)".*?>/) {
			$x =~ s/<img(.*?)src="(http.*?)"(.*?)>/<img$1src="$2 ##FIXME## "$3>>/g;
		}
	}

	# output to file:
	# https://www.perltutorial.org/perl-write-to-file/
	print $fh_write $x

}

print "\n\n";
print "script complete; search for ##FIXME## to find any issues";
print "\n\n";

# cleanup
close ($fh_write);
close ($fh_read);
# just in case this one is still open
close ($fh_temp);
#EOF
