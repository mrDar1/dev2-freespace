#!/bin/bash
# Code by Yuval Dar 

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
t_value=48
while getopts "rv" opt; do
    case $opt in
        r)
            is_recursive=true
            ;;
        v)
            is_verbose=true
            ;;
        t)
            t_value="$OPTARG" # Set the user-provided value
            ;;
        \?)
            echo "Invalid option: -${opt}" >&2
            exit 1
            ;;
    esac
    # remove the flags from the arguments
    shift $((OPTIND-1))
done