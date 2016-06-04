#!/bin/bash

USER=root                                        #数据库用户名
PASSWORD=x35d4f8we132cf8e1s62d13x5d4f8e3sd1d65sd #数据库用户密码
DATABASE='weibo_service'                         #数据库名称

BACKUP_DIR=/var/mysql/backup/${DATABASE}        #备份文件存储路径
LOGFILE=/var/mysql/backup/data_backup.log       #日记文件路径

DATE=`date '+%Y%m%d-%H%M'`
DUMPFILE=${DATE}.sql
ARCHIVE=${DATE}.sql.tgz
DAYS=3

OPTIONS="-u${USER} -p${PASSWORD} ${DATABASE}" 

if [ ! -d ${BACKUP_DIR} ] ;
then
    # mkdir -p "${BACKUP_DIR}"
    mkdir -p "${BACKUP_DIR}/${DATABASE}"
fi

echo " " >> ${LOGFILE}
echo " " >> ${LOGFILE}
echo "———————————————–———————————————–———————————————–———————————————–" >> ${LOGFILE}
echo "BACKUP FOR ${DATABASE} DATE:" $(date +"%y-%m-%d %H:%M:")          >> ${LOGFILE}

cd ${BACKUP_DIR}

mysqldump ${OPTIONS} > ${DUMPFILE}

if [[ $? == 0 ]]; then
    # tar czvf ${ARCHIVE} ${DUMPFILE} >> ${LOGFILE} 2>&1
    tar czvf ${ARCHIVE} ${DUMPFILE}
    rm -f ${DUMPFILE}
    echo "[${ARCHIVE}] Backup Successful!" >> ${LOGFILE}
else
    echo "Database Backup Fail!" >> ${LOGFILE}
    #备份失败后向网站管理者发送邮件提醒，需要mailutils或者类似终端下发送邮件工具的支持
    #mail -s "Database:${DATABASE} Daily Backup Fail" ${WEBMASTER}
fi

# 删除超过10天的备份文件
find ${BACKUP_DIR} -mtime +${DAYS} -name "*.*" -exec rm -rf {} \;

echo "[${ARCHIVE}] Backup Done!" >> ${LOGFILE}
echo "———————————————–———————————————–———————————————–———————————————–" >> ${LOGFILE}

