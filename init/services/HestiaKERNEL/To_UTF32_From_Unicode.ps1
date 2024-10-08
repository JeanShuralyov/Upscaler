# Copyright 2024 (Holloway) Chew, Kean Ho <hello@hollowaykeanho.com>
#
#
# BSD 3-Clause License
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
