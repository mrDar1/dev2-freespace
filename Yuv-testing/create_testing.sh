#!/bin/bash

# will create 10 files with timestamps decreasing by 10 hours each.
# so need to keep the first 4 and erase the follow 6.

# Get the current date and time
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# Loop to create 10 files and set timestamps decreasing by 10 hours
for i in {1..10}
do
    filename="file${i}"
    touch "$filename"

    # calculate timestamp: decrease by (i-1) * 10 hours
    timestamp=$(date -d "$current_time -$(( (i-1) * 10 )) hours" +"%Y%m%d%H%M")
    echo "yuval testing file number $i" > "$filename"
    echo "fake time stamp is: ${timestamp}" > "$filename"

    zip_name="fc-${filename}.zip"
    zip "$zip_name" "$filename"
    rm "$filename"

    # set file timestamp to the updated one
    touch -t "$timestamp" "$zip_name"

    # echo "Created $filename with timestamp: $(date -d "$current_time -$(( (i-1) * 10 )) hours" +"%Y-%m-%d %H:%M:%S")"
done

# echo "10 files created with timestamps decreasing by 10 hours each."


# create file 5 files with names: file11, file12, file13, file14, file15
# for i in {11..15}
# do
#     filename="file$i"
#     touch "$filename"
#     echo "yuval testing file number $i" > "$filename"

#     # calculate timestamp: decrease by (i-1) * 10 hours
#     timestamp=$(date -d "$current_time -$(( (i-1) * 10 )) hours" +"%Y%m%d%H%M")

#     # set file timestamp to the updated one
#     touch -t "$timestamp" "$filename"

#     # echo "Created $filename with timestamp: $(date -d "$current_time -$(( (i-1) * 10 )) hours" +"%Y-%m-%d %H:%M:%S")"
# done

