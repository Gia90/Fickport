#!/bin/sh
# DailyRunner :)
#  Daily run a custom command at a specific time

cmdToRun="$1"
timeToRun="$2"

# TODO: add input args check

# TODO: add help

# Sleep till the specified "date string" (see "date" man for more info)
sleepTill() {

	now=$(date +%s)
	runAt=$(date -d "$1" +%s)
	#runAt=$(date -d "00:49" +%s)
	secsToWait=$(($runAt - $now))

	if [ "$secsToWait" -lt 0 ]; then
		echo "[!sleepTill] The specified date ($1) is in the past! ($runAt < $now)"
		return 1
	fi
	
	echo "[>sleepTill]: sleeping till \"$1\" ($secsToWait seconds) ..."
	sleep $secsToWait
	return 0
}

echo
echo "[>] Starting daily runner for \"$cmdToRun\" at \"$timeToRun\" (`date`)"

# If it's earlier than timeToRun, run it also today
if sleepTill "$timeToRun"; then
	echo "[>] Running \"$cmdToRun\" also in the initial day (`date`)"
	$cmdToRun
fi


# and then run it every day (tomorrow at the same timeToRun time)
while :
do
	sleepTill "tomorrow $timeToRun"
	echo "[>] Running \"$cmdToRun\" (`date`)"
	$cmdToRun
done
