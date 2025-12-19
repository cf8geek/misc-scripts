#!/bin/bash
if [ -z "$1" ]; then
	echo "need year, but didn't get it. bye."
	exit;
fi
mkdir $year
mkdir $year/01-January
mkdir $year/02-February
mkdir $year/03-March
mkdir $year/04-April
mkdir $year/05-May
mkdir $year/06-June
mkdir $year/07-July
mkdir $year/08-August
mkdir $year/09-September
mkdir $year/10-October
mkdir $year/11-November
mkdir $year/12-December
mv "Screenshot From $year-01-*.png" ./$year/01-January/
mv "Screenshot From $year-02-*.png" ./$year/02-February/
mv "Screenshot From $year-03-*.png" ./$year/03-March/
mv "Screenshot From $year-04-*.png" ./$year/04-April/
mv "Screenshot From $year-05-*.png" ./$year/05-May/
mv "Screenshot From $year-06-*.png" ./$year/06-June/
mv "Screenshot From $year-07-*.png" ./$year/07-July/
mv "Screenshot From $year-08-*.png" ./$year/08-August/
mv "Screenshot From $year-09-*.png" ./$year/09-September/
mv "Screenshot From $year-10-*.png" ./$year/10-October/
mv "Screenshot From $year-11-*.png" ./$year/11-November/
mv "Screenshot From $year-12-*.png" ./$year/12-December/
exit
