#!/bin/bash

set -e

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

if [[ -z $host ]]; then echo 'host is required !!'; exit 1; fi;
if [[ -z $username ]]; then echo 'username is required !!'; exit 1; fi;
if [[ -z $dbname ]]; then echo 'dbname is required !!'; exit 1; fi;
if [[ -z $port ]]; then echo 'port is required !!'; exit 1; fi;
if [[ -z $password ]]; then echo 'password is required !!'; exit 1; fi;
if [[ -z $deploytype ]]; then echo 'deploytype is required !!'; exit 1; fi;
#deploytype 1=developement
#deploytype 2=update existing db
#deploytype 3=init new db

#-----------------------------------file import-----------------------------------
source ./common.sh
#-----------------------------------file import-----------------------------------

#-----------------------------------variables-----------------------------------
schemas=$(echo "${schemas}" | sed 's/ //g;s/,/\\|/g')
if [[ -z $schemas ]]; then schemas=".*"; else schemas="\(${schemas}\)" ; fi;

dbname=$(echo "${dbname}" | sed 's/ //g;s/,/ /g')

#-----------------------------------variables-----------------------------------

export PGPASSWORD=$password
for db in $dbname; 
do
	echo "$(date)----------------WORKING ON ${db}----------------"
#-----------------------------------db specific variables-----------------------------------
	filename="finalquery_${db}_${currdt}.sql"
	backupfilepath="$HOME/dbbackup/${db}/${currdt}/"
#-----------------------------------db specific variables-----------------------------------
	if [[ $deploytype != 3 ]];
	then
		currentversion=`psql -h $host -U $username -d $db -p $port -AXqtc "${versionquery}" -v ON_ERROR_STOP=1`	
	else
		currentversion="0.0.0"
	fi
	
	! [[ $currentversion =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] && echo "incorrect version string format ${currentversion}" && exit 1;
	
	echo "$(date)----------------MERGING FILES----------------"

	: > $filename

	echo "BEGIN;" >> $filename
	echo "SET statement_timeout = 0;" >> $filename
	echo "SET lock_timeout = 0;" >> $filename
	echo "SET idle_in_transaction_session_timeout = 0;" >> $filename
	echo "SET client_encoding = 'UTF8';" >> $filename
	echo "SET standard_conforming_strings = on;" >> $filename
	echo "SELECT pg_catalog.set_config('search_path', '', false);" >> $filename
	echo "SET check_function_bodies = false;" >> $filename
	echo "SET xmloption = content;" >> $filename
	echo "SET client_min_messages = warning;" >> $filename
	echo "SET row_security = off;" >> $filename
	echo "SET default_tablespace = '';" >> $filename
	echo "SET default_table_access_method = heap;" >> $filename	

	for type in $typeorder;
	do		
		if [[ $deploytype == 1 ]];
		then
			if [[ -z $types || $types == *"$type"* ]]; then find */ -type f -regex "${schemas}\/${type}\/.*\.sql$"  -exec awk -v currentversion="${currentversion}" '/--BEGIN_VERSION/{split($0,a,"=");sub("[ \t\n\r]", "", a[2]);if (length(a[2]) > 0){if (a[2] == currentversion) {p=1} else {p=0}}};p;/--END_VERSION/{p=0};' >> $filename {} + ; fi;		
		else
			if [[ -z $types || $types == *"$type"* ]]; then find */ -type f -regex "${schemas}\/${type}\/.*\.sql$"  -exec awk -v currentversion="${currentversion}" '/--BEGIN_VERSION/{split($0,a,"=");sub("[ \t\n\r]", "", a[2]);if (length(a[2]) > 0){if (a[2] > currentversion) {p=1} else {p=0}}};p;/--END_VERSION/{p=0};' >> $filename {} + ; fi;				
		fi;
	done

	printf "\nCOMMIT;" >> $filename

	echo "$(date)----------------FILES MERGED----------------"

	echo "$(date)----------------COPYING ${filename} TO ${backupfilepath}----------------"
	mkdir -p $backupfilepath
	cp $filename $backupfilepath

	echo "$(date)----------------COPIED ${filename} TO ${backupfilepath}----------------"

	echo "$(date)----------------EXECUTING SQL SCRIPT----------------"

	echo "$(date)----------------BACKING UP DATABASE ${db} to ${backupfilepath}----------------"
	mkdir -p $backupfilepath	
	pg_dump -f "${backupfilepath}${db}.dump" -h $host -p $port -U $username -F c -b $db		
	echo "$(date)----------------DATABASE ${db} BACKED UP----------------"

	echo "$(date)----------------EXECUTING THE SCRIPT ON ${db}----------------"	
	psql -q -h $host -U $username -d $db -p $port -f $filename -v ON_ERROR_STOP=1
	echo "$(date)----------------SCRIPT EXECUTED ON ${db}----------------"
done

