echo >/dev/null # >nul & GOTO WINDOWS & rem ^




################################################################################
# Unix Main Codes                                                              #
################################################################################
repo="$(command -v $0)"
repo="${repo%%start.cmd}"
"${repo}/init/unix.sh" $@
################################################################################
# Unix Main Codes                                                              #
################################################################################
exit $?




:WINDOWS
::##############################################################################
:: Windows Main Codes                                                          #
::##############################################################################
echo Unsupported for now.
::##############################################################################
:: Windows Main Codes                                                          #
::##############################################################################
