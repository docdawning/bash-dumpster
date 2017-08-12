#!/bin/bash
# Read the readme for my dissertation about this..

# Usage is to just give the block device you want to run fsck against.
# Be freakin thoughtful here, I'm not making this overly fool-proof.
# There's no warranty either, so like, enjoy.

# Also, if you give a second argument, it should be the webhook URL for a slack/mattermost server
# To send reports to.

FSCK_TARGET=$1
LOOP_ON_FSCK_RETURN_CODE=9

function fsckIt {
	e2fsck -y $FSCK_TARGET 
	FSCK_RESULT=$?
}

function log {
	echo -e "\n$1"
	echo -e `date "+%Y%m%d%H%M"`": $1" >> $0.log
}

# Parameters are:
#	$1 <-- Message
#	$2 <-- Webhooks URL
function matterMost {
	curl -i -X POST -d "payload={\"text\": \"$1\"}" $2
}

### EXEC BEGINS BELOW ###

if [ ! -b "$FSCK_TARGET" ] ; then
	log "\nYou want me to fsck against \"$FSCK_TARGET\"? Well, it's not a block device. So. No."
	exit -1
else
	log "\nGood, \"$FSCK_TARGET\" IS a block device, so like, this could work"
fi

log "Starting `date`" > $0.log

fsckIt
while [ $FSCK_RESULT -eq 9 ] ; do
	log "Return code of $LOOP_ON_FSCK_RETURN_CODE observed, running again "
	fsckIt
done 

# IF there's a second arg, use it as a Slack/MatterMost webhook url
if [ "$#" -gt 1 ] ; then
	matterMost "$0 at `cat /etc/hostname` is done." $2
else
	log "I'd have sent a Slack/MatterMost message about this, but you didn't give a second parameter"
fi

log "That's it. Resto. The End. I hope you found some data."

