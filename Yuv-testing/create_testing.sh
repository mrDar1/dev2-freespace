#!/bin/bash
# create 10 zip files the first 5 newer than 48 hours and the last 5 older than 48 hours
# create 5 more reguar files 3 newer than 48 hours and 2 older than 48 hours

# helper function to update timestamp
update_time_stamp() {
    i=$1
    if [ $i -le 3 ]; then
        echo $(date +"%Y%m%d%H%M")  # No change
    elif [ $i -le 5 ]; then
        echo $(date -d "-1 days" +"%Y%m%d%H%M")
    elif [ $i -le 7 ]; then
        echo $(date -d "-3 days" +"%Y%m%d%H%M")
    elif [ $i -le 10 ]; then
        echo $(date -d "-4 days" +"%Y%m%d%H%M")
    elif [ $i -le 13 ]; then
        echo $(date -d "-1 days" +"%Y%m%d%H%M")
    else
        echo $(date -d "-3 days" +"%Y%m%d%H%M")    
    fi
}

# current date and time
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# loop to create 10 zip files and set timestamps decreasing to current day, 1 day ago, 3 days ago, 4 days ago
for i in {1..10}
do
    filename="file${i}"
    touch "$filename"

    echo "yuval testing file number $i" > "$filename"

    zip_name="fc-${filename}.zip"
    zip "$zip_name" "$filename"
    rm "$filename"

    timestamp=$(update_time_stamp "$i")
    # update time stamp
    touch -t "$timestamp" "$zip_name"

done

# create 5 files, 3 newer than 48 hours and 2 older than 48 hours
for i in {11..15}
do
    filename="file${i}"
    touch "$filename"

    echo "yuval testing file number $i" > "$filename"

    timestamp=$(update_time_stamp "$i")
    # set file timestamp to the updated one
    touch -t "$timestamp" "$filename"
done
