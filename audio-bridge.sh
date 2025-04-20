#!/usr/bin/env bash
# This is free and unencumbered software released into the public domain.

cmd_name="audio-bridge.sh"

function CreateSource {
    if [[ -z "$1" ]]; then
        local dev_name="audio-bridge"
    else
        local dev_name="$1"
    fi

    pactl load-module module-null-sink \
        media.class=Audio/Source/Virtual sink_name="$dev_name" \
        channel_map=front-left,front-right
}

case "$1" in
create)
    CreateSource "$2" || exit $?
    echo "use this command to delete devices:"
    echo "pactl unload-module <ID>"
    ;;
help | --help | -h | *)
    echo "Usage: ${cmd_name} [--help | -h] <action> [<args>]"
    echo "action:"
    echo -e "    create [<dev_name>]\tCreate a bridge devices via pactl(default name is 'audio-bridge')"
    echo -e "    help(default)\tShow this help message, compatible --help and -h"
    ;;
esac
