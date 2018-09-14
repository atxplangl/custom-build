#!/bin/bash -x
#################################################
# posts build status and number to a slack channel

cd $WORKSPACE

# generate slack payload json
cat >$SLACK_PAYLOAD << EOL
{
  "channel": "$SLACK_CHANNEL",
  "username": "$SLACK_DISPLAY_NAME",
  "text": "$SLACK_MESSAGE",
  "icon_emoji": ":jenkins:"
}
EOL

# post to slack channel
curl -X POST \
     -d @$SLACK_PAYLOAD \
        $SLACK_BASE_URL/$SLACK_SECRET

cd $WORKSPACE
