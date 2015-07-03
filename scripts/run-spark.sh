#!/bin/sh

# build hadoop fat jar
#gradlew build

# pull down spark docker image (may want to background since it takes a minute)
#docker pull sequenceiq/spark:1.4.0

# run spark docker image, with the local build directory (`./build/libs/`) mounted under libs
# submit job to spark (example of SparkPi w/ arguments)
# note this is running on the spark cluster
docker run --name spark --rm -it -p 8088:8088 -p 8042:8042 -v "$(pwd)j/build/libs/:/libs/" sequenceiq/spark:1.4.0 bash -c \
'spark-submit
--class com.widen.tomservo.SparkPi
--master yarn-client
--driver-memory 1g
--executor-memory 1
--executor-cores 1
/libs/tomservo-1.0-hadoop.jar local[2] 100'
