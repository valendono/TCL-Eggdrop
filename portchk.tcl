######################################
## DCC .portchk <host/ip> <port>    ##
## PUB !port <host/ip> <port>       ##
##.chanset <channel> +portchk       ##
######################################

set portchk_setting(flag) ""
set portchk_setting(cmd_pub) "!port"
set portchk_setting(cmd_dcc) "portchk"
set portchk_setting(read) 1
set portchk_setting(onjoin) 1
set portchk_setting(ports) "21 22 23 25 53 80 81 110 113 135 137 138 139 143 443 445 1080 3128 3306 5900 6660 6661 6662 6663 6665 6666 6667 6668 6669 7000 8080 10000 31337 64501 65500 65501"
set portchk_setting(autoban_svr) 0
set portchk_setting(autoban_list) 0
set portchk_setting(global) 0
set portchk_setting(bantime) 5
set portchk_setting(onotice) 1
set portchk_setting(bold) 1
set portchk_setting(portchk:) 1

############################################################################
#   PLEASE DO NOT EDIT ANYTHING BELOW UNLESS YOU KNOW WHAT YOU ARE DOING   #
############################## Script Begin ################################

#if {![string match 1.8.* $version]} {
#	putlog "\002portchk:\002 \002CRITICAL ERROR\002 portchk.tcl requires eggdrop 1.6.x to run."
#	die "\002portchk:\002 \002CRITICAL ERROR\002 portchk.tcl requires eggdrop 1.6.x to run."
#}
bind pub $portchk_setting(flag) $portchk_setting(cmd_pub) portchk_scan_pub
bind dcc $portchk_setting(flag) $portchk_setting(cmd_dcc) portchk_scan_dcc
bind join - * portchk_onjoin_scan
setudef flag portchk

proc portchk_dopre {} {
	global portchk_setting
	if {!$portchk_setting(portchk:)} {
		return ""
	} elseif {!$portchk_setting(bold)} {
		return "portchk: "
	} else {
		return "\002portchk:\002 "
	}
}
proc portchk_onjoin_scan {nick uhost hand chan} {
	global portchk_setting
	if {($portchk_setting(onjoin)) && ($portchk_setting(ports) != "")} {
		foreach i [channel info $chan] {
			if {([string match "+portchk" $i]) && ([botisop $chan])} {
				set host [lindex [split $uhost @] 1]
				foreach p $portchk_setting(ports) {
					if {![catch {set sock [socket -async $host $p]} error]} {
						set timerid [utimer 15 [list portchk_timeout_join $sock]]
						fileevent $sock writable [list portchk_connected_join $nick $chan $sock $host $p $timerid]
					}
				}
				break
			}
		}
	}
}
proc portchk_scan_pub {nick uhost hand chan text} {
	global portchk_setting
	set host [lindex [split $text] 0]
	set port [lindex [split $text] 1]
	if {$port == ""} {
		putquick "NOTICE $nick :Usage: $portchk_setting(cmd_pub) <host> <port>"
	} else {
		if {[catch {set sock [socket -async $host $port]} error]} {
			putquick "PRIVMSG $chan :15\[portchk4!15\] Connection to $host \($port\) was refused."
		} else {
			set timerid [utimer 15 [list portchk_timeout_pub $chan $sock $host $port]]
			fileevent $sock writable [list portchk_connected_pub $chan $sock $host $port $timerid]
		}
	}
}
proc portchk_scan_dcc {hand idx text} {
	global portchk_setting
	set host [lindex [split $text] 0]
	set port [lindex [split $text] 1]
	if {$port == ""} {
		putdcc $idx "[portchk_dopre]Usage: .$portchk_setting(cmd_dcc) <host> <port>"
	} else {
		if {[catch {set sock [socket -async $host $port]} error]} {
			putdcc $idx "[portchk_dopre]Connection to $host \($port\) was refused."
		} else {
			set timerid [utimer 15 [list portchk_timeout $idx $sock $host $port]]
			fileevent $sock writable [list portchk_connected $idx $sock $host $port $timerid]
		}
	}
}
proc portchk_connected {idx sock host port timerid} {
	killutimer $timerid
	set error [fconfigure $sock -error]
	if {$error != ""} {
		close $sock
		putdcc $idx "[portchk_dopre]Connection to $host \($port\) failed. \([string totitle $error]\)"
	} else {
		fileevent $sock writable {}
		fileevent $sock readable [list portchk_read $idx $sock $host $port]
		putdcc $idx "[portchk_dopre]Connection to $host \($port\) accepted."
	}
}
proc portchk_timeout {idx sock host port} {
	close $sock
	putdcc $idx "[portchk_dopre]Connection to $host \($port\) timed out."
}
proc portchk_read {idx sock host port} {
	global portchk_setting
	if {$portchk_setting(read)} {
		if {[gets $sock read] == -1} {
			putdcc $idx "[portchk_dopre]EOF On Connection To $host \($port\). Socket Closed."
			close $sock
		} else {
			putdcc $idx "[portchk_dopre]$host \($port\) > $read"
		}
	} else {
		close $sock
	}
}
proc portchk_connected_pub {chan sock host port timerid} {
	killutimer $timerid
	set error [fconfigure $sock -error]
	if {$error != ""} {
		close $sock
		putquick "PRIVMSG $chan :15\[portchk4!15\] Connection to $host \($port\) failed. \([string totitle $error]\)"
	} else {
		fileevent $sock writable {}
		fileevent $sock readable [list portchk_read_pub $chan $sock $host $port]
		putquick "PRIVMSG $chan :15\[portchk4!15\] Connection to $host \($port\) accepted."
	}
}
proc portchk_timeout_pub {chan sock host port} {
	close $sock
	putquick "PRIVMSG $chan :15\[portchk4!15\] Connection to $host \($port\) timed out."
}
proc portchk_connected_join {nick chan sock host port timerid} {
	global portchk_setting botnick
	killutimer $timerid
	set error [fconfigure $sock -error]
	if {$error != ""} {
		close $sock
	} else {
		fileevent $sock writable {}
		fileevent $sock readable [list portchk_read_join $sock]
		if {$portchk_setting(onotice)} {
			foreach i [chanlist $chan] {
				if {([isop $i $chan]) && ($i != $botnick)} {
					putserv "NOTICE $i :Port $port was found open on $nick's host. \($host\)"
				}
			}
		}
		if {$portchk_setting(autoban_svr)} {
			putserv "MODE $chan +b *!*@$host"
			putserv "KICK $chan $nick :One of the ports open on your host is banned."
			timer $portchk_setting(bantime) [list portchk_unsvrban $chan $host]
		} elseif {$portchk_setting(autoban_list)} {
			if {$portchk_setting(global)} {
				newban *!*@$host portchk "One of the ports open on your machine is banned." $portchk_setting(bantime)
			} else {
				newchanban $chan *!*@$host portchk "One of the ports open on your machine is banned." $portchk_setting(bantime)
			}
		}
	}
}
proc portchk_timeout_join {sock} {
	close $sock
}
proc portchk_read_join {sock} {
	close $sock
}
proc portchk_read_pub {sock} {
	global portchk_setting
	if {!$portchk_setting(read)} {
		close $sock
	} elseif {[gets $sock read] == -1} {
		putquick "PRIVMSG $chan :EOF On Connection To $host \($port\). Socket Closed."
		close $sock
	}
}
proc portchk_unsvrban {chan host} {
	putserv "MODE $chan -b *!*@$host"
}

putlog "Portchk Addon TCL Modifed By MoBi ? Succesfully Loaded..."
