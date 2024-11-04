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
. "${LIBS_HESTIA}/HestiaKERNEL/To_Lowercase_Unicode.sh"
. "${LIBS_HESTIA}/HestiaKERNEL/To_Unicode_From_String.sh"
. "${LIBS_HESTIA}/HestiaKERNEL/To_String_From_Unicode.sh"




HestiaKERNEL_To_Lowercase_String() {
        #___input="$1"
        #___locale="$2"


        # validate input
        if [ "$1" = "" ]; then
                printf -- ""
                return $HestiaKERNEL_ERROR_DATA_EMPTY
        fi


        # execute
        ___content="$(HestiaKERNEL_To_Unicode_From_String "$1")"
        if [ "$___content" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_DATA_INVALID
        fi

        ___content="$(HestiaKERNEL_To_Lowercase_Unicode "$___content")"
        if [ "$___content" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_BAD_EXEC
        fi

        ___content="$(HestiaKERNEL_To_String_From_Unicode "$___content")"
        if [ "$___content" = "" ]; then
                printf -- "%s" "$1"
                return $HestiaKERNEL_ERROR_BAD_EXEC
        fi


        # report status
        return $HestiaKERNEL_ERROR_OK
}
