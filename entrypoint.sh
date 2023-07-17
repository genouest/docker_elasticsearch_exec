#!/bin/bash

function run_scripts () {
	SCRIPTS_DIR="/scripts/$1.d"
	SCRIPT_FILES_PATTERN="^${SCRIPTS_DIR}/[0-9][0-9][a-zA-Z0-9_-]+$"
	SCRIPTS=$(find "$SCRIPTS_DIR" -type f -uid 0 -executable -regex "$SCRIPT_FILES_PATTERN" | sort)
	if [ -n "$SCRIPTS" ] ; then
		echo "=>> $1-scripts:"
	    for script in $SCRIPTS ; do
	        echo "=> $script"
			. "$script"
	    done
	fi
}

function wait_es(){
  timeout --foreground -s TERM 30s bash -c \
       'while [[ "$(curl -s -o /dev/null -m 3 -L -w ''%{http_code}'' localhost:9200)" != "200" ]];\
       do echo "Waiting for Elasticsearch" && sleep 2;\
       done'
  OUTPUT="$?"
  if [[ "${OUTPUT}" == 0 ]]; then
        echo "Elasticsearch running"
        return
  else
        echo "Error: Elasticsearch not running after 30s"
        if [ -f "/tmp/es.log" ]; then
          echo "Printing logs"
          cat /tmp/es.log
        fi
        exit "${OUTPUT}"
  fi
}

run_scripts pre-launch

# Default to launching ES if no parameters passed
if [ $# -eq 0 ]; then
	su $ES_USER -c '/usr/local/bin/docker-entrypoint.sh eswrapper $ES_ARGS'
else
	su $ES_USER -c '/usr/local/bin/docker-entrypoint.sh eswrapper $ES_ARGS > /tmp/es.log 2>&1 &'
	wait_es
	exec "$@"
fi
