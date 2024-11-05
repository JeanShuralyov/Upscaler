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
. "${LIBS_HESTIA}/HestiaKERNEL/Is_Punctuation_Unicode.sh"
. "${LIBS_HESTIA}/HestiaKERNEL/To_Unicode_From_String.sh"




HestiaKERNEL_Is_Punctuation_String() {
        #___rune="$1"


        # execute
        ___unicode="$(HestiaKERNEL_To_Unicode_From_String "$1")"
        if [ "$___unicode" = "" ]; then
                printf -- "%d" $HestiaKERNEL_ERROR_DATA_INVALID
                return $HestiaKERNEL_ERROR_DATA_INVALID
        fi

        printf -- "%d" "$(HestiaKERNEL_Is_Punctuation_Unicode "${___unicode%%, *}")"
        return $?
}
