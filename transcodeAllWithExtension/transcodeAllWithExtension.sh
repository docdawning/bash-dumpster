#!/bin/bash
#Had help from: https://www.cyberciti.biz/faq/bash-loop-over-file/

if [ "$#" -ne 2 ] ; then
	echo "This needs to be invoked with two parameters, ex: $0 mkv mp4"
	exit 1
fi

SRC_EXT=$1
DEST_EXT=$2
TRASH_DIR=pendingDel
mkdir -p $TRASH_DIR
for file in *.$SRC_EXT; do
	DEST_FILE=`echo $file | sed "s/.$SRC_EXT/.$DEST_EXT/"`
	echo -e "\n### TRANSCODING \"$file\" to \"$DEST_FILE\" ###"
	time ffmpeg -stats -y -v -0 -i "$file" "$DEST_FILE"
	mv "$file" $TRASH_DIR/
done

echo -e "\n\nAll done. Note that used src files are in $TRASH_DIR\n"
