echo $CHANNEL
echo $START_TIME
docker run -it \
    -v "$(pwd)"/output:/output \
    yyoshiki41/radigo rec -id=$CHANNEL -s=$START_TIME
