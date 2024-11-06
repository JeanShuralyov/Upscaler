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
. "${env:LIBS_HESTIA}\HestiaKERNEL\Unicode\Is_Unicode.ps1"




function HestiaKERNEL-Trim-Left-Unicode {
        param (
                [uint32[]]$___content_unicode,
                [uint32[]]$___charset_unicode
        )


        # validate input
        if (
                ($(HestiaKERNEL-Is-Unicode $___content_unicode) -ne ${env:HestiaKERNEL_ERROR_OK}) -or
                ($(HestiaKERNEL-Is-Unicode $___charset_unicode) -ne ${env:HestiaKERNEL_ERROR_OK})
        ) {
                return $___content_unicode
        }


        # execute
        [System.Collections.Generic.List[uint32]]$___converted = @()
        $___is_scanning = 0
        :scan_unicode for ($i = 0; $i -le $___content_unicode.Length - 1; $i++) {
                # get current character
                $___current = $___content_unicode[$i]


                # it's already mismatched so prefix the remaining values
                if ($___is_scanning -ne 0) {
                        $null = $___converted.Add($___current)
                        continue scan_unicode
                }


                # scan character from given charset
                foreach ($___char in $___charset_unicode) {
                        if ($___current -eq $___char) {
                                continue scan_unicode # exit early from O(m^2) timing ASAP
                        }
                }


                # It's an mismatched
                $___is_scanning = 1
                $null = $___converted.Add($___current)
        }


        # report status
        return [uint32[]]$___converted
}
