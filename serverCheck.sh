#!/bin/bash
set -x
set -e

APP=$1


if [ -z "$APP" ]; then
  echo "Failed, as no APP name provided."
  exit -1
fi

build_status(){
                    # Maximum wait time for build to Complete is 5 mint. If not Completed Failed.
                    # polling after every 5 Seconds
                    result=$(curl -s -I $1 | grep HTTP/1.1 | awk {'print $2'})
                    echo $result
                    QUERY_TIMEOUT_SECONDS=5
                    count=0
                    while [ "${result}" != 200 ]
                    do
                        sleep $QUERY_TIMEOUT_SECONDS
                        result=$(curl -s -I $1 | grep HTTP/1.1 | awk {'print $2'})
                        count=$(( $count + 1 ))

                        if [ $count = 60 ]; then
                            echo "*** error: Could not get status code. Please check manually ***"
                            exit 1
                        fi
                    done
                }

if [[ "$APP" = "microServer1" ]]
then
   # need to wait min 35 sec. as sever restart takes time after deployment.
  sleep 35
   build_status https://api.hostserver
 elif [[ "$APP" = "microServer2" ]]
 then
     # need to wait min 12 sec. as sever restart takes time after deployment.
     sleep 12
     build_status https://www.hostserver.up.check
elif [[ "$APP" = "cashgram" ]]
then
    # need to wait min 18 sec. as sever restart takes time after deployment.
    # sleep 18
    build_status http://localhost:3000/cashgram/
else
  echo "Failed, as no script written for ${APP}."
  exit -1;
fi