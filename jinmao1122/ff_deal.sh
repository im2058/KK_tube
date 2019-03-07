#!/bin/bash
file=$1
dir=$2
vname=`echo $file | awk -F "/" '{print $NF}'`
ffprobe -show_format -report $file
vinf=`grep und ffprobe-* | grep "Video" | sed "s/\s\{2,\}//g" | cut -dy -f 2 | cut -d[ -f 1 | sed "s/.*\,\(.*\)/\1/g"`
format=`echo "toutiao $vinf" | sed "s/\s//g" `
rm -rf ffprobe-*
echo $format
case $format in
	toutiao640x480)
	#	echo -e $format $file >> format.log
	#ffmpeg -i $file -vf "delogo=x=665:y=24:w=161:h=49,delogo=x=237:y=239:w=381:h=120:enable='between(t,2.2,3.78)'" -c:a copy ./nologo/$vname
	#something is wrong for this format
	ffmpeg -i $file -vf "delogo=x=490:y=24:w=132:h=40,delogo=x=190:y=239:w=290:h=120:enable='between(t,2.2,3.78)'" -c:a copy ./nologo/$vname
		;;
	toutiao854x480)
	#	echo -e $format $file >> format.log
	ffmpeg -i $file -vf "delogo=x=663:y=24:w=166:h=45,delogo=x=236:y=182:w=393:h=115:enable='between(t,2.2,3.78)'" -c:a copy ./nologo/$vname
		;;
	toutiao640x360)
	#	echo -e $format $file >> format.log
	ffmpeg -i $file -vf "delogo=x=499:y=17:w=126:h=38" -c:a copy ./nologo/$vname
		;;
	*)
		echo -e $format $file >>  format.log
		;;
esac
