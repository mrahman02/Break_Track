#!/bin/bash

#This script was written to practice options with scripts.
#It tracks break time.
#User can specify two options, break length and refresh duration.

#Process supplied options. Set default as needed.
while getopts "hs:b:" arg; 
do

	case $arg in
		h)
			echo "Usage:"
            echo "-h for this help message"
            echo "-b n; specify breaktime in minutes"            
            echo "-s n; specify how often \(in seconds\) you want to get notified"            
            exit 0
			;;
		s)
			refresh_duration=$OPTARG            
			#echo "You will be notified after $refresh_duration seconds."
			;;
        b)
            COUNTER=$OPTARG
            #echo "your break $COUNTER minutes"
            ;;
	esac

done

[ -z $COUNTER ] && COUNTER=1
[ -z $refresh_duration ] && refresh_duration=1
COUNTER=$(( $COUNTER * 60 ))

#Function to reuse.
decrement(){

    COUNTER=$(( COUNTER + (-1 * $refresh_duration) ))
    sleep $refresh_duration
}

#Time left
while [ $COUNTER -gt 0 ]
do
    echo "You still have $COUNTER seconds left"
    decrement
done

[ $COUNTER = 0 ] && echo "Time is up" && decrement

#Time passed.
[ $COUNTER = "-1" ] && echo "Your now are one second late" && decrement

while true
do
    echo "You now are ${COUNTER#-} seconds late"
    decrement
done
