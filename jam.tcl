##################################
### ShellTime.tcl              ###
### Version 1.6                ###
### Edited By wonk_santai      ###
##################################

set shelltime_setting(flag) "-|-"
set shelltime_setting(cmd) "time"

########################################################
# Set the pub command for viewing the shell time here. #
########################################################

set shelltime_setting(pubcmd) "!jam"

#######################################################################
# Set the clock format here. See below for a list of format settings. #
# ------------------------------------------------------------------- #
#                                                                     #
# %% - Insert a %.                                                    #
# %a - Abbreviated weekday name (Mon, Tue, etc.).                     #
# %A - Full weekday name (Monday, Tuesday, etc.).                     #
# %b - Abbreviated month name (Jan, Feb, etc.).                       #
# %B - Full month name.                                               #
# %c - Locale specific date and time.                                 #
# %d - Day of month (01 - 31).                                        #
# %H - Hour in 24-hour format (00 - 23).                              #
# %I - Hour in 12-hour format (00 - 12).                              #
# %j - Day of year (001 - 366).                                       #
# %m - Month number (01 - 12).                                        #
# %M - Minute (00 - 59).                                              #
# %p - AM/PM indicator.                                               #
# %S - Seconds (00 - 59).                                             #
# %U - Week of year (00 - 52), Sunday is the first day of the week.   #
# %w - Weekday number (Sunday = 0).                                   #
# %W - Week of year (00 - 52), Monday is the first day of the week.   #
# %x - Locale specific date format.                                   #
# %X - Locale specific time format.                                   #
# %y - Year without century (00 - 99).                                #
# %Y - Year with century (e.g. 1990)                                  #
# %Z - Time zone name.                                                #
# Supported on some systems only:                                     #
# %D - Date as %m/%d/%y.                                              #
# %e - Day of month (1 - 31), no leading zeros.                       #
# %h - Abbreviated month name.                                        #
# %n - Insert a newline.                                              #
# %r - Time as %I:%M:%S %p.                                           #
# %R - Time as %H:%M.                                                 #
# %t - Insert a tab.                                                  #
# %T - Time as %H:%M:%S.                                              #
#######################################################################

set shelltime_setting(format) "%I:%M:%S %p %A, %d %B %Y"

###################################
# Enable use of bold in DCC chat? #
###################################

set shelltime_setting(bold) 1

#############################################
# Prefix "SHELLTIME:" in DCC chat messages? #
#############################################

set shelltime_setting(SHELLTIME:) 1

####################
# Code begins here #
####################

if {$numversion < 1060800} { putlog "\002SHELLTIME:\002 \002WARNING:\002 This script is intended to run on eggdrop 1.6.8 or later." }
if {[info tclversion] < 8.2} { putlog "\002SHELLTIME:\002 \002WARNING:\002 This script is intended to run on Tcl Version 8.2 or later." }

bind dcc $shelltime_setting(flag) $shelltime_setting(cmd) shelltime_dcc
bind pub $shelltime_setting(flag) $shelltime_setting(pubcmd) shelltime_pub

proc shelltime_dopre {} {
	global shelltime_setting
	if {!$shelltime_setting(SHELLTIME:)} { return "" }
	if {!$shelltime_setting(bold)} { return "SHELLTIME: " }
	return "\002SHELLTIME:\002 "
}
proc shelltime_dcc {hand idx text} {
	global shelltime_setting
	putdcc $idx "[shelltime_dopre][clock format [clock seconds] -format $shelltime_setting(format)]"
}
proc shelltime_pub {nick uhost hand chan text} {
	global shelltime_setting
	puthelp "PRIVMSG $chan :[clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)]"
}
putlog "\002SHELLTIME:\002 ShellTime.tcl 1.6 by wonk_santai is loaded."
