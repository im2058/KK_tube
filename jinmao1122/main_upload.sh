#!/bin/bash
n=1
basedir=`pwd`
videodir='/root/all_video/download/xigua.txt'
date
#for video in `ls -rtl $videodir | sed 's/\s\s/ /g' | cut -d' ' -f 9-`
for video in `ls $videodir`
do
	echo $video
	enname=`python3 traslate/tr360.py $video | sed 's/.Mp4//g'`
	#enname='api'
	echo  $enname 
	echo -e " $video + $enname " >> translog
#	mv ${videodir}/$video ./nologo/org_$n.mp4
#	ffmpeg -i ${videodir}/$video -vf "delogo=x=663:y=24:w=166:h=49,delogo=x=231:y=180:w=391:h=117:enable='between(t,2.2,3.78)'" -c:a copy ./nologo/$video
	bash ./ff_deal.sh ${videodir}/$video ppp
	n=`expr $n + 1`
	mv ${videodir}/$video ./donedir
#	sleep 5
#	ffmpeg -i $file -vf "delogo=x=665:y=24:w=161:h=49,delogo=x=237:y=239:w=381:h=120:enable='between(t,2.2,3.78)'" -c:a copy ./nologo/$vname
done

cd $basedir
for vload in `ls ./nologo | grep -i "mp4"`
do
	echo $vload
	en_title=`grep "$vload" translog | cut -d'+' -f 2 | sed s/\[Mm\]\[Pp\]4//g `
#	en_title=`echo ${en_titl1e:0:10}`
	desc=`grep "$vload" translog | sed s/\[Mm\]\[Pp\]4//g | sed s/+//g`
	echo $desc
	youtube-upload  --title="${en_title:0:98}" --description="${desc}" --default-language="zh" --default-audio-language="zh" --privacy="public" ./nologo/$vload
	randoms=`expr $(($RANDOM%7+4)) \* 60 + $(($RANDOM%7+3))`
	mv ./nologo/$vload ./tmp
	echo $randoms
	sleep $randoms
done

