#!/bin/bash
# Code by Yuval Dar 

# set -x

##### Const #######
readonly ASCII="text/plain"
readonly BZIP2="application/x-bzip2"
readonly COMPRESS="application/x-compress"
readonly GZIP="application/gzip"
readonly ZIP="application/zip"
readonly DIRECTORY="inode/directory"
readonly PURPLE_BACKGROUND="\e[45m"
readonly RESET_COLOR="\e[0m"
readonly BOLD="\e[1;37m"
readonly NAMING_FORMAT="fc-*"
###################

########### Helpers ###########
# print format for -v flag
print_if_verbose() {
    if [ "$is_verbose" = true ]; then
        echo -e "${BOLD}$*${RESET_COLOR}"
    fi
}
##########END HELPERS##########



# edge case: if no arguments enter - exit
if [ $# -lt 1 ]; then
    echo "Usage: $0 [-r] [-v] [-t ###] file [files...]"
    exit 1
fi

# Handle flags:
# add command flags and exit if invalid flag entered
is_verbose=false
is_recursive=false
t_flag_value=48 # default value
while getopts "rvt:" opt; do
    case $opt in
        r)
            is_recursive=true
            ;;
        v)
            is_verbose=true
            ;;
        t)
            # make sure argument is a number
            if [[ ! "$OPTARG" =~ ^[0-9]+$ ]]; then
                echo "Error: -t flag requires a numeric argument."
                exit 1
            fi
            t_flag_value="$OPTARG" # Set the user-provided value
            ;;
        \?)
            echo "Invalid option: -${opt}" >&2
            exit 1
            ;;
    esac
done
# remove the flags from the arguments
shift $((OPTIND-1))

#debug:
echo "is_recursive: $is_recursive"
echo "is_verbose: $is_verbose"
echo "t_flag_value: $t_flag_value"
echo "Remaining arguments: $@"


# traverse all files and check the compression type with "file" command:
# case 1: if ASCII zip it and rename to fc-<filename> and delete the original
# case 2: if directory - check if recursive flag is on and if so, call function again
# case 3: if file_name=="fc-*" - check if time stamp is older than t_flag_value and delete if so
# case 4: if unknowntype - count it
freespace_command() {
    local files_list=("$@")
    local inside_files=()

    for cur_file in "${files_list[@]}"; do
        file_type=$(file --mime-type -b "${cur_file}") 

        case $file_type in
        # case 1: ASCII
        $ASCII)
            print_if_verbose "zip ASCII file: ${cur_file}"
            zip -qq "${cur_file}.zip" "${cur_file}"
            mv "${cur_file}.zip" "fc-${cur_file}.zip"
            rm "${cur_file}"
            ;;
        # case 1: directory
        $DIRECTORY)
            print_if_verbose "Enter Directory: ${cur_file}"

            if [ "$is_recursive" = true ]; then
                pushd $cur_file > /dev/null 2>&1
                inside_files=(*)
                freespace_command "${inside_files[@]}"
                popd > /dev/null 2>&1
            fi
            ;;
        $NAMING_FORMAT)
            print_if_verbose "this file at right name format: ${cur_file}"
            # get the time stamp of the file
            file_time=$(stat -c %Y "${cur_file}")
            # get the current time
            current_time=$(date +%s)
            # calculate the difference
            time_diff=$((current_time - file_time))

            echo file_time: $file_time
            echo current_time: $current_time
            echo "time_diff: $time_diff"
            
            # # check if the time difference is greater than the t_flag_value
            # if [ $time_diff -gt $t_flag_value ]; then
            #     print_if_verbose "delete file: ${cur_file}"
            #     rm "${cur_file}"
            # fi
            # ;;
        *)
            print_if_verbose "cant freespace: ${cur_file} do not support: ${file_type} " >&2
            ((count_unkown_types++))
        esac
    done
}








count_unkown_types=0
freespace_command "$@"