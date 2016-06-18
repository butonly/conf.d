#!/bin/bash

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

if [ ! -d ${DUMP_DIR} ];
then
    mkdir -p "${DUMP_DIR}/${DATABASE}"
fi

mkdir -p "${OUT}"

echo " " >> ${LOGFILE}
echo " " >> ${LOGFILE}
echo "———————————————–———————————————–———————————————–———————————————–" >> ${LOGFILE}
echo "BACKUP FOR ${DATABASE} DATE:" $(date +"%y-%m-%d %H:%M:")          >> ${LOGFILE}

cd ${DUMP_DIR}

OPTIONS="--oplog --verbose \
    --host=${HOST} --port=${PORT} \
    --username=${USERNAME} --password=${PASSWORD} \
    --authenticationDatabase= \
    --db=${DATABASE} --collection=${COLLECTION} \
    --query=  \
    --out=${OUT}"

mongodump ${OPTIONS} >> ${LOGFILE}

if [[ $? == 0 ]]; then
    tar -czvf ${ARCHIVE} ${DIRNAME}
    rm -rf ${OUT}
    echo "[${ARCHIVE}] Backup Successful!" >> ${LOGFILE}
else
    echo "Database Backup Fail!" >> ${LOGFILE}
    #备份失败后向网站管理者发送邮件提醒，需要mailutils或者类似终端下发送邮件工具的支持
    #mail -s "Database:${DATABASE} Daily Backup Fail" ${WEBMASTER}
fi

# 删除超过10天的备份文件
find ${DUMP_DIR} -mtime +${DAYS} -name "*.*" -exec rm -rf {} \;

echo "[${ARCHIVE}] Backup Done!" >> ${LOGFILE}
echo "———————————————–———————————————–———————————————–———————————————–" >> ${LOGFILE}

