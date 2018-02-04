#!/usr/bin/env bash
set -u
set -e
set -o noclobber

JDBC_DRIVER_DIR=/root
JDBC_DRIVER_PATH=${JDBC_DRIVER_PATH:-$(echo ${JDBC_DRIVER_DIR}/*.jar| sed "s/ /:/g")}

DATABASE_TYPE=${DATABASE_TYPE:-pgsql}

DB_HOST=${DB_HOST:-localhost}
DB_NAME=${DB_NAME:-postgres}
DB_USER=${DB_USER:-postgres}
DB_PASS=${DB_PASS:-}

[ ! -d "/output/${DB_NAME}" ] && mkdir -p "/output/${DB_NAME}"

# See official document: http://schemaspy.readthedocs.io/
# [-t databaseType]
# Type of database (e.g. ora, db2, etc.). Use -dbhelp for a list of built-in types. Defaults to ora.
# [-db dbName]
# Name of database to connect to
# [-u user]
# Valid database user id with read access. A user id is required unless -sso is specified.
# [-s schema]
# Database schema. This is optional if it’s the same as user or isn’t supported by your database. Use -noschema if your database thinks it supports schemas but doesn’t (e.g. older versions of Informix).
# [-p password]
# Password associated with that user. Defaults to no password.
# [-o outputDirectory]
# Directory to write the generated HTML/graphs to
# [-dp pathToDrivers]
# Looks for drivers here before looking in driverPath in [databaseType].properties. The drivers are usually contained in .jar or .zip files and are typically provided by your database vendor.
# [-hq] or [-lq]
# Generate higher or lower-quality diagrams. Various installations of Graphviz (depending on OS and/or version) will default to generat /ing either higher or lower quality images. That is, some might not have the “lower quality” libraries and others might not have the “higher quality” libraries. Higher quality output takes longer to generate and results in significantly larger image files (which take longer to download / display), but the resultant Entity Relationship diagrams generally look better.
# [-host host]
# host of database.

java \
    -jar      "/root/schemaspy-6.0.0-rc2.jar" \
    -t        "${DATABASE_TYPE}" \
    -db       "${DB_NAME}" \
    -u        "${DB_USER}" \
    -s        "public" \
    -p        "${DB_PASS}" \
    -o        "/output/${DB_NAME}" \
    -dp       "${JDBC_DRIVER_PATH}" \
    -hq \
    -host     "${DB_HOST}" \
    ;

