#!/bin/bash
set -e

if [ -z "$INPUT_DESTINATION_PATH" ]; then
	DESTINATION_PATH="./languages"
else
	DESTINATION_PATH=$INPUT_DESTINATION_PATH
fi

if [ -z "$INPUT_SLUG" ]; then
	SLUG=${GITHUB_REPOSITORY#*/}
else
	SLUG=$INPUT_SLUG
fi

if [ -z "$INPUT_TEXT_DOMAIN" ]; then
	TEXT_DOMAIN=$SLUG
else
	TEXT_DOMAIN=$INPUT_TEXT_DOMAIN
fi

if [ -z "$PAT_TOKEN" ]; then
	TOKEN=$GITHUB_TOKEN
else
	TOKEN=$PAT_TOKEN
fi

POT_PATH="$DESTINATION_PATH/$TEXT_DOMAIN.pot"

if [ ! -d "$DESTINATION_PATH" ]; then
	mkdir -p $DESTINATION_PATH
fi

echo "DESTINATION_PATH: $DESTINATION_PATH"
echo "SLUG : $SLUG"
echo "TEXT_DOMAIN: $TEXT_DOMAIN"

echo "Generating POT file..."
wp i18n make-pot . "$POT_PATH" --domain="$TEXT_DOMAIN" --slug="$SLUG" --allow-root --color
