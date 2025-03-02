# original code
for file in "${files[@]}";do
    file_type=$(file -b "$file")
    file_name="$(basename "$2")"
    if [[ "$file_name" == fc-* ]] && find "$file" -type f -mmin +"$new_timeout" | grep -q .; then
        echo "Deleting "$file"!"
        rm "$file"
    elif [[ "$file_type" == "*Zip*" || "$file_type" == "*gzip*" || "$file_type" == "*bzip2*" ||
            "$file_type" == "*compress*" ]]; then
        if [[ $file == fc-* ]]; then
            echo "Moving to the next file"
        else
            mv "$file_name" "./fc-$file_name"
            echo "$file_name is already compress"
        fi






# my fix:
#function that recive file and return its extension. find extension with "find -b" command.
# case zip, gunzip, bzip2, compress
function get_extension(){
    file_type=$(file -b "$1")
    case "$file_type" in
        *Zip*) echo "zip";;
        *gzip*) echo "gz";;
        *bzip2*) echo "bz2";;
        *compress*) echo "Z";;
        *) echo "none";;
    esac
}

for file in "${files[@]}";do
    file_type=$(file -b "$file")
    file_name="${file##*/}"
    # ${file##*/} removes everything before the last /, leaving only the file name.
    local new_name="${file_name}"
    right_extension=$(get_extension "$file")

    if [[ "$file_name" == fc-* ]] && find "$file" -type f -mmin +"$new_timeout" | grep -q .; then
        echo "Deleting "$file"!"
        rm "$file"
    elif [[ "$file_type" == "*Zip*" || "$file_type" == "*gzip*" || "$file_type" == "*bzip2*" ||
            "$file_type" == "*compress*" ]]; then
        if [[ $file == fc-* ]]; then
            echo "Moving to the next file"
        else
            mv "$file_name" "./fc-${file_name}.right_extension"
            echo "$new_name is already compress"
        fi