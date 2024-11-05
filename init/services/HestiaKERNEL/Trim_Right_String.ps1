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
. "${env:LIBS_HESTIA}\HestiaKERNEL\Trim_Right_Unicode.ps1"
. "${env:LIBS_HESTIA}\HestiaKERNEL\To_Unicode_From_String.ps1"
. "${env:LIBS_HESTIA}\HestiaKERNEL\To_String_From_Unicode.ps1"




function HestiaKERNEL-Trim-Right-String {
        param (
                [string]$___input,
                [string]$___charset
        )


        # validate input
        if (
                ($___input -eq "") -or
                ($___charset -eq "")
        ) {
                return $___input
        }


        # execute
        $___content = HestiaKERNEL-To-Unicode-From-String $___input
        if ($___content.Length -eq 0) {
                return $___input
        }

        $___chars = HestiaKERNEL-To-Unicode-From-String $___charset
        if ($___chars.Length -eq 0) {
                return $___input
        }

        $___content = HestiaKERNEL-Trim-Right-Unicode $___content $___chars
        if ($___content.Length -eq 0) {
                return $___input
        }


        # report status
        return HestiaKERNEL-To-String-From-Unicode $___content
}