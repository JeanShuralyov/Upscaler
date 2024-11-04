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
. "${env:LIBS_HESTIA}\HestiaKERNEL\To_Lowercase_Unicode.ps1"
. "${env:LIBS_HESTIA}\HestiaKERNEL\To_Unicode_From_String.ps1"
. "${env:LIBS_HESTIA}\HestiaKERNEL\To_String_From_Unicode.ps1"




function HestiaKERNEL-To-Lowercase-String {
        param (
                [string]$___input,
                [string]$___locale
        )


        # validate input
        if ($___input -eq "") {
                return ""
        }


        # execute
        $___content = HestiaKERNEL-To-Unicode-From-String $___input
        if ($___content.Length -eq 0) {
                return $___input
        }

        $___content = HestiaKERNEL-To-Lowercase-Unicode $___content
        if ($___content.Length -eq 0) {
                return $___input
        }


        # report status
        return HestiaKERNEL-To-String-From-Unicode $___content
}
