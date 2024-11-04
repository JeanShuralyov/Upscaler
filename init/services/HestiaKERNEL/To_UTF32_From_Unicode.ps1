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
. "${env:LIBS_HESTIA}\HestiaKERNEL\Error_Codes.ps1"
. "${env:LIBS_HESTIA}\HestiaKERNEL\Endian.ps1"
. "${env:LIBS_HESTIA}\HestiaKERNEL\Is_Unicode.ps1"
. "${env:LIBS_HESTIA}\HestiaKERNEL\Unicode.ps1"




function HestiaKERNEL-To-UTF32-From-Unicode {
        param (
                [uint32[]]$___unicode,
                [string]$___bom,
                [string]$___endian
        )


        # validate input
        if ($(HestiaKERNEL-Is-Unicode $___unicode) -ne ${env:hestiaKERNEL_ERROR_OK}) {
                return [byte[]]@()
        }


        # execute
        [System.Collections.Generic.List[byte]]$___converted = @()
        if ($___bom -eq ${env:HestiaKERNEL_UTF_BOM}) {
                switch ($___endian) {
                ${env:HestiaKERNEL_ENDIAN_LITTLE} {
                        # UTF32LE BOM - 0xFF, 0xFE, 0x00, 0x00
                        $null = $___converted.Add(0xFF)
                        $null = $___converted.Add(0xFE)
                        $null = $___converted.Add(0x00)
                        $null = $___converted.Add(0x00)
                } default {
                        # UTF32BE BOM (default) - 0x00, 0x00, 0xFE, 0xFF
                        $null = $___converted.Add(0x00)
                        $null = $___converted.Add(0x00)
                        $null = $___converted.Add(0xFE)
                        $null = $___converted.Add(0xFF)
                }}
        }

        foreach ($___char in $___unicode) {
                # convert to UTF-32 bytes list
                ## 0x00000 - 0x10000 - 0x10FFFF (surrogate pair region)
                switch ($___endian) {
                ${env:HestiaKERNEL_ENDIAN_LITTLE} {
                        $___register = $___char -band 0xFF
                        $null = $___converted.Add($___register)

                        $___register = $___char -band 0xFF00
                        $___register = $___register -shr 8
                        $null = $___converted.Add($___register)

                        ___register=$(($___char -band 0xFF0000))
                        ___register=$(($___register -shr 16))
                        $null = $___converted.Add($___register)

                        ___register=$(($___char -band 0xFF000000))
                        ___register=$(($___register -shr 24))
                        $null = $___converted.Add($___register)
                } default {
                        ___register=$(($___char -band 0xFF000000))
                        ___register=$(($___register -shr 24))
                        $null = $___converted.Add($___register)

                        ___register=$(($___char -band 0xFF0000))
                        ___register=$(($___register -shr 16))
                        $null = $___converted.Add($___register)

                        ___register=$(($___char -band 0xFF00))
                        ___register=$(($___register -shr 8))
                        $null = $___converted.Add($___register)

                        ___register=$(($___register -band 0xFF))
                        $null = $___converted.Add($___register)
                }}
        }


        # report status
        return [byte[]]$___converted
}
