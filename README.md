# What is this?
This docker image purpose is to create ER diagram automaticaly based on currently database schema with schemaspy for postgres9.5.

# How to run

docker run --rm -it -e DB_HOST=<YOUR_DB_HOST> -v /path/to/output:/output cimadai/schemaspy

The default value is following.

| KEY | VALUE |
| --- | --- |
| DB_HOST | localhost |
| DB_NAME | postgres |
| DB_USER | postgres |
| DB_PASS | (empty) |

## If you want to overwrite these parameter

docker run --rm -it -e DB_HOST=<YOUR_DB_HOST> -e DB_NAME=<YOUR_DB_NAME> -e DB_USER=<YOUR_DB_USER> -e DB_PASS=<YOUR_DB_PASS> -v /path/to/output:/output cimadai/schemaspy

This script referred to the following URL.

https://qiita.com/genzouw/items/23cd0119715403e6e110

# Display output schema.

Open output index.html in browser.

`open ./output/<DB_NAME>/index.html`


