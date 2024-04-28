#!bin/bash
input_dir=${1:="input"}
output_dir=${2:="output"}

if [ ! -d $output_dir ]
then
 mkdir $output_dir
fi

first_depth_files=$(find $input_dir -depth 1 -type f)

echo "файлы 1-го уровня вложенности $input_dir:"
echo "$first_depth_files\n"


first_depth_dirs=$(find $input_dir -depth 1 -type d)

echo "папки 1-го уровня вложенности в $input_dir:"
echo "$first_depth_dirs\n"


all_files=$(find $input_dir -type f)

echo "все файлы в папке $input_dir"
echo "$all_files\n"


count_repeated=1

function get_new_file_name {
 file_name=$1
 file_name_without_extention=${file_name%.*}
 extention=${file_name#$file_name_without_extention}
 new_file_name="${file_name_without_extention}${count_repeated}${extention}"

 echo $new_file_name
}

function create_deep_copy {
 file_name=$1
 new_file_name=$(get_new_file_name $file_name)

 mv $file_name $new_file_name
 cp $new_file_name $output_dir
 mv $new_file_name $file_name
}


for file_name in $all_files
do
 last_file_name=$(basename $file_name)

 if [[ -e $output_dir/$last_file_name ]]
 then
  create_deep_copy $file_name
  ((count_repeated+=1))
 else
  cp $file_name $output_dir
 fi
done