#
#  Usage: !nsl <name/ip>
#         !dns <name/ip>
#         !nslookup <name/ip>
#
#  The command can be issued via msg or in public.
#


#  Set the path to "nslookup" on the bots host.
set nsl_path "/usr/bin/nslookup"


#########################################################################
#         You should not have to edit anything below this line!         #
#########################################################################


bind pub - !nsl pub_nslookup
bind msg - !nsl msg_nslookup
bind pub - !dns pub_nslookup
bind msg - !dns msg_nslookup
bind pub - !nslookup pub_nslookup
bind msg - !nslookup msg_nslookup

proc pub_nslookup {nick uhost hand chan arg} {
	global nsl_path
	set input [open "|$nsl_path $arg" r]
	while {![eof $input]} { 
		catch {set contents [gets $input]}
		if {[string first "Name:" $contents] >= 0} {
			set name [string range $contents 9 end]
			}
		if {[string first "Address:" $contents] >= 0} {
			set address [string range $contents 10 end]
			}
		}
	catch {close $input}
	if {$name != ""} {
		putserv "PRIVMSG $chan DNS Lookup: $name <-> $address"
		return 0
	} else {
		putserv "PRIVMSG $chan DNS Lookup: Unable to resolve address"
		return 0
		}
	}

proc msg_nslookup {nick uhost hand arg} {
	global nsl_path
	set input [open "|$nsl_path $arg" r]
	while {![eof $input]} { 
		catch {set contents [gets $input]}
		if {[string first "Name:" $contents] >= 0} {
			set name [string range $contents 9 end]
			}
		if {[string first "Address:" $contents] >= 0} {
			set address [string range $contents 10 end]
			}
		}
	catch {close $input}
	if {$name != ""} {
		putserv "PRIVMSG $nick DNS Lookup: $name <-> $addres"
		return 0
	} else {
		putserv "PRIVMSG $nick DNS Lookup: Unable to resolve address"
		return 0
		}
	}
	
putlog " - Stimps Little DNS Lookup Script v2.1 has Loaded!"
