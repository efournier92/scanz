#!/bin/bash

#----------------
# Name          : photo_args.bash
# Description   : Interprets command arguments for photo mode
#----------------

source "./_src/input/user_select.bash"

read_photo_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local i=0

  while [[ "$1" != "" ]]; do
    case $1 in

      -i | --scanner )
        shift
        local scanner="$1"
        ;;

      -q | --quality )
        shift
        local quality="$1"
        ;;

      -g | --grayscale )
        local gray_color_mode="true"
        ;;

      -d | --output_dir )
        shift
        local output_dir="$1"
        ;;

      -o | --output_name )
        shift
        local output_name="$1"
        ;;

    esac
    shift
  done

  [[ -z "$scanner" ]] && local scanner=`user_select_scanner`
  [[ -z "$quality" ]] && local quality=`default_photo_quality`
  [[ -z "$output_dir" ]] && local output_dir=`default_output_dir`
  [[ -z "$output_name" ]] && local output_name=`default_file_name`
  [[ "$gray_color_mode" = "true" ]] \
    && local color_mode=`color_mode_gray` \
    || local color_mode=`color_mode_color`

  echo "$scanner" "$color_mode" "$quality" "$output_dir" "$output_name"
}

