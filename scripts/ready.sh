#!/usr/bin/env sh

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c '\dt' -q --csv | grep -c 'table'
