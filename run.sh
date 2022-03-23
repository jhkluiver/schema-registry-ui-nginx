#!/bin/sh

DEFAULT_URL="/api/schema-registry"
ALLOW_GLOBAL="${ALLOW_GLOBAL:-false}"
ALLOW_TRANSITIVE="${ALLOW_TRANSITIVE:-false}"
ALLOW_DELETION="${ALLOW_DELETION:-false}"
READONLY_MODE="${READONLY_MODE:-false}"
SCHEMA_URL="${SCHEMA_URL:-$DEFAULT_URL}"

    echo "Landoop Schema Registry UI running on NGINX"
	echo "-------------------------------------------"
    echo "Landoop Schema Registry UI ${SCHEMA_REGISTRY_UI_VERSION}"
    echo "Visit <https://github.com/Landoop/schema-registry-ui/tree/master/docker>"
    echo "to find more about how you can configure this container."
    echo


    if echo "$ALLOW_TRANSITIVE" | egrep -sq "true|TRUE|y|Y|yes|YES|1"; then
        TRANSITIVE_SETTING=",allowTransitiveCompatibilities: true"
        echo "Enabling transitive compatibility modes support."
    fi

    if echo "$ALLOW_GLOBAL" | egrep -sq "true|TRUE|y|Y|yes|YES|1"; then
        GLOBAL_SETTING=",allowGlobalConfigChanges: true"
        echo "Enabling global compatibility level change support."
    fi

    if echo "$ALLOW_DELETION" | egrep -sq "true|TRUE|y|Y|yes|YES|1"; then
        DELETION_SETTING=",allowSchemaDeletion: true"
        echo "Enabling schema deletion support."
    fi

    if echo "$READONLY_MODE" | egrep -sq "true|TRUE|y|Y|yes|YES|1"; then
        READONLY_SETTING=",readonlyMode: true"
        echo "Enabling readonly mode."
    fi



    if [ -z "$SCHEMAREGISTRY_URL" ]; then
        echo "Schema Registry URL was not set via SCHEMAREGISTRY_URL environment variable."
		exit 1
    else
	    sed -i "s|SCHEMAREGISTRY_URL|$SCHEMAREGISTRY_URL|g" /etc/nginx/conf.d/default.conf
        echo "Setting Schema Registry URL to $SCHEMAREGISTRY_URL."
	fi	
        cat <<EOF >/tmp/env.js
var clusters = [
   {
     NAME: "default",
     SCHEMA_REGISTRY: "$SCHEMA_URL"
     $GLOBAL_SETTING
     $TRANSITIVE_SETTING
     $DELETION_SETTING
     $READONLY_SETTING
   }
]
EOF
    

/docker-entrypoint.sh nginx &
sleep infinity


