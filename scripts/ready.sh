#!/usr/bin/env sh

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c 'SELECT 1' -q --csv
