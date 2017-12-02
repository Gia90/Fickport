#!/bin/sh
# DailyRunner :)
#  Daily run a custom command at a specific time
#  without crontab, at or GNU-date coreutils

helpme() {
	
	echo "Daily Runner: run a command every day at specific time"
	echo "Usage: `basename "$0"` CMD TIME"
	echo -e "  CMD:\tThe command to run"
	echo -e "  TIME:\tThe time at wich run the command (e.g. \"3:33\")"

	exit $1
}

# Check input parameters
if [ "$#" -ne 2 ]; then
	echo "[ERROR] Illegal number of parameters"
	helpme 1
fi

# Store input parameters
cmdToRun="$1"
timeToRun="$2"

# Compute tomorrow date (YYYY-MM-DD)
tomorrow() {
	echo $(date -d @$(( $(date -d $(date +%F) +%s) + 86400 )) +%F)
}

# Sleep till the specified "date string" (see "date" man for more info)
sleepTill() {

	now=$(date +%s)
	runAt=$(date -d "$1" +%s)
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
	sleepTill "$(tomorrow) $timeToRun"
	echo "[>] Running \"$cmdToRun\" (`date`)"
	$cmdToRun
done
