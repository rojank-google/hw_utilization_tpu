#!/bin/sh

# source tools
source /home/rojank/hw_utilization_tpu/WXE23_ISR4.sh >& /dev/null 

# create directories for monthly, quarterly, bi-weekly
month=$(date +%-m)
year=$(date +%Y)
echo "Running report for the last 3 months:"

start_date=$year.$month

target_month=$(( (month - 3 + 12) % 12 ))    # 3 months ago


echo $start_date
if [[ month < 3 ]]; then
	end_date=$(( (year - 1))).$(( target_month  ))
else
	end_date=$(( (year))).$(( target_month ))
fi

echo $end_date

TARGET_DIR=$end_date'_to_'$start_date

# make directories for this period
if [ -d "$TARGET_DIR" ]; then
	echo "Dir already exists, cd into it"
	cd "$TARGET_DIR"
else
	echo "Making new dir"
	mkdir "$TARGET_DIR"
	# check if mkdir was successful before cd
	if [ $? -eq 0 ]; then
		cd "$TARGET_DIR"
	else
		echo "Error: Could not create directory "$TARGET_DIR". Exiting."
		exit 1
	fi
fi

echo "Current working directory: $(pwd)"

# run xeGenReport for the last 3 months for CCA, CCD, CCH (Z1)





# push contents to GitHub website

