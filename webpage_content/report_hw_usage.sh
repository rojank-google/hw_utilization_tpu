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

#TARGET_DIR=$end_date'_to_'$start_date

function z1_handle_dir {
# make directories for this period
TARGET_DIR='Z1_'$end_date'_to_'$start_date
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
}

function z2_handle_dir {
# make directories for this period
TARGET_DIR='Z2_'$end_date'_to_'$start_date
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
}


# FIRST z1, run CCA, CCD, CCH
cd z1
z1_handle_dir
# call xeGenReport for z1
xeGenReport -host cca-emu ccd-emu cch-emu -period $end_date $start_date -passKey cadencepxp
cd ..

# SECOND z2, run CCL
cd z2
z2_handle_dir
# call xeGenReport for z2
xeGenReport -host ccl-emu -period $end_date $start_date -passKey cadencepxp
cd ..

# THIRD z3, run Z3 machines
#cd z3


# update index.html of webpage
source /home/rojank/hw_utilization_tpu/config_index.sh
source /home/rojank/hw_utilization_tpu/clean_index.sh


# push contents to GitHub website
cd /home/rojank/hw_utilization_tpu
git status
git add .
git commit -m "automatic update for $TARGET_DIR from report_hw_usage.sh"
git push origin main

echo PUSHED UPDATE TO GITHUB SITE
