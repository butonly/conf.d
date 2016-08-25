

HOST=
PORT=27047
USERNAME=
PASSWORD=
DATABASE=
COLLECTION=

DUMP_DIR=/var/mongodb/dump
LOGFILE=/var/mongodb/dump/data_backup.log

DATE=`date '+%Y%m%d-%H%M'`
DIRNAME=dump-${DATE}
ARCHIVE=${DIRNAME}.tgz
OUT=${DUMP_DIR}/${DIRNAME}
DAYS=3

OPTIONS="--oplog --verbose --objcheck --drop --stopOnError \
    --host=${HOST} --port=${PORT} \
    --username=${USERNAME} --password=${PASSWORD} \
    --authenticationDatabase= --authenticationMechanism= \
    --db=${DATABASE} --collection=${COLLECTION} \
    --query=  \
    --out=${OUT}"

mongorestore --host=${HOST} --port


mongorestore --port=27017 DUMP_DIR