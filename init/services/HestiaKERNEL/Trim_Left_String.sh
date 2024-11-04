#!/bin/sh
# Copyright 2024 (Holloway) Chew, Kean Ho <hello@hollowaykeanho.com>
#
#
# Licensed under (Holloway) Chew, Kean Ho’s Liberal License (the "License").
# You must comply with the license to use the content. Get the License at:
#
#                 https://doi.org/10.5281/zenodo.13770769
#
# You MUST ensure any interaction with the content STRICTLY COMPLIES with
# the permissions and limitations set forth in the license.
. "${LIBS_HESTIA}/HestiaKERNEL/Error_Codes.sh"
. "${LIBS_HESTIA}/HestiaKERNEL/Trim_Left_Unicode.sh"
. "${LIBS_HESTIA}/HestiaKERNEL/To_Unicode_From_String.sh"
. "${LIBS_HESTIA}/HestiaKERNEL/To_String_From_Unicode.sh"




HestiaKERNEL_Trim_Left_String() {
        #___content="$1"
        #___charset="$2"


        # validate input
        if [ "$1" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_ENTITY_EMPTY
        fi

        if [ "$2" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        ___content="$(HestiaKERNEL_To_Unicode_From_String "$1")"
        if [ "$___content" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_DATA_INVALID
        fi

        ___chars="$(HestiaKERNEL_To_Unicode_From_String "$2")"
        if [ "$___chars" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_DATA_INVALID
        fi

        ___content="$(HestiaKERNEL_Trim_Left_Unicode "$___content" "$___chars")"
        if [ "$___content" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_BAD_EXEC
        fi

        ___content="$(HestiaKERNEL_To_String_From_Unicode "$___content")"
        if [ "$___content" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_BAD_EXEC
        fi
        printf -- "%s" "$___content"


        # report status
        return $HestiaKERNEL_ERROR_OK
}
