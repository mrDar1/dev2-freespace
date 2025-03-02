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
###################

########### Helpers ###########
# print format for -v flag
print_if_verbose() {
    if [ "$is_verbose" = true ]; then
        echo -e "${BOLD}$*${RESET_COLOR}"
    fi
}
##########END HELPERS##########



# if no arguments enter - exit
if [ $# -lt 1 ]; then
    echo "Usage: $0 [-r] [-v] [-t ###] file [files...]"
    exit 1
fi

# Handle flags:
# add command flags and exit if invalid flag entered
is_verbose=false
is_recursive=false
t_flag_value=48 # default value
while getopts "rv" opt; do
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

echo "is_recursive: $is_recursive"
echo "is_verbose: $is_verbose"
echo "t_flag_value: $t_flag_value"
echo "Remaining arguments: $@"
