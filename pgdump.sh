export PGPASSWORD='Rel!@blE@1279#'

username=rsoftnetmanager
dbname=BMSPG
host=192.168.2.212
port=16897
# type="tables"
# type="sequences"
# type="views"
# type="triggers"
# type="procedures"
# type="functions"
type="data"

# query="Select string_agg(table_schema || '.' || table_name, ' ')
# 		From information_schema.tables
# 		Where table_type='BASE TABLE' and table_name not ilike 'pg_%'
# 		AND table_name not ilike '%_shadow' and table_name not in ('connprodlinkisprimary', 'jold', 'iserror', 'store_id')
# 		AND table_name not like '%temp%'
# 		AND table_schema <> 'information_schema'
# 		"

# query="
# select string_agg(sequence_schema || '.' || sequence_name, ' ')
# from information_schema.sequences
# "

# query="
# select string_agg(table_schema || '.' || table_name, ' ') from information_schema.views where table_schema not in ('information_schema', 'pg_catalog')
# and table_name <> 'pg_stat_statements'
# "

# query="
# select string_agg(trigger_schema || '.' || trigger_name, ' ')
# from information_schema.triggers;
# "

# query="SELECT
# string_agg(routine_schema || '.' || routine_name, ' ')
# FROM
#     information_schema.routines
# WHERE
#     routine_type = 'PROCEDURE' ;
# "

# query="SELECT string_agg(routine_schema || '.' || routine_name, ' ')
# FROM
#     information_schema.routines
# WHERE
#     routine_type = 'FUNCTION' AND routine_schema <> 'pg_catalog'
# and routine_name not ilike 'dblink%' and routine_name not ilike '%pg_%'
# and routine_name <> 'fnliquibasechainset'
# ;"

query="Select string_agg(table_schema || '.' || table_name, ' ')
From information_schema.tables
Where table_type='BASE TABLE' and table_name not ilike 'pg_%'
		 AND table_name not ilike '%_shadow' and table_name not in ('connprodlinkisprimary', 'jold', 'iserror', 'store_id')
		 AND table_name not like '%temp%'
		 AND table_schema <> 'information_schema'
        AND table_name in ('ipgstatus', 'ipgstatuslink', 'istatus', 'ipaymode', 'ipaymentgateway');
	"

objects=$(psql -h $host -p $port -U $username -d $dbname -t -c "$query")

# tables, views & sequnces can be filtered using -t flag.

echo $objects

for obj in $objects;
do
# pg_dump -s -t "$obj" -p $port -h $host -U $username -d $dbname -O | sed -e '/^--/d' -e '/^SET/d' -e '/^SELECT pg_catalog/d' -e '/^$/d' > ./${obj%%.*}/$type/$obj.sql;

pg_dump -a -t "$obj" -p $port -h $host -U $username -d $dbname --column-inserts | sed -e '/^--/d' -e '/^SET/d' -e '/^SELECT pg_catalog/d' -e '/^$/d' > ./${obj%%.*}/$type/$obj.sql;

# objquery="
# select pg_get_triggerdef(oid) || ';'
# from pg_trigger
# where tgname = '${obj##*.}';
# ";

# objquery="
# SELECT pg_get_functiondef(f.oid) || ';'
# FROM pg_catalog.pg_proc f
# INNER JOIN pg_catalog.pg_namespace n ON (f.pronamespace = n.oid)
# WHERE n.nspname = '${obj%%.*}' and proname = '${obj##*.}'
# ;"

# objquery="SELECT pg_get_functiondef(f.oid) || ';'
# FROM pg_catalog.pg_proc f
# INNER JOIN pg_catalog.pg_namespace n ON (f.pronamespace = n.oid)
# WHERE n.nspname = '${obj%%.*}' and proname = '${obj##*.}';"

# psql -h $host -U $username -d $dbname -At -c "$objquery" -o ./${obj%%.*}/$type/$obj.sql;
done;

