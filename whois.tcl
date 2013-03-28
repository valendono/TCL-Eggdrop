####################################################
#### Who is Versi 1.1 by dono
### +Update host +Whois Automation With IP Info
##################################################
bind pub - !whois msg_whois
proc msg_whois {nick uhost hand chan text} {
  global botnick
  if {$text == ""} { putquick "PRIVMSG $chan :You have to use true command for look up whois information. Command: <!whois domain>"; return }

        package require tls
        ::http::register https 443 ::tls::socket

	if {[string match "*.id" $text]} { 
  set connect [::http::geturl https://tools.whois.com.au/whois/$text] 
  set files [::http::data $connect]
  ::http::cleanup $files
    set l [regexp -all -inline -- {Creation Date:(.*?)T.*?Expiration Date:(.*?)T.*?Sponsoring Registrar:(.*?)Status:.*?Registrant ID:(.*?)Admin Contact.*?Name Server:(.*?)Access to WHOIS} $files]
     foreach {black a b c d e} $l {

         set a [string trim $a " \n"]
         set b [string trim $b " \n"]
         set c [string trim $c " \n"]
         set d [string trim $d " \n"]
         set e [string trim $e " \n"]

         regsub -all {<.+?>} $a {} a
         regsub -all {<.+?>} $b {} b
         regsub -all {<.+?>} $c {} c
         regsub -all {<.+?>} $d {} d
         regsub -all {<.+?>} $e {} e

	if {[info exists a]} { putserv "PRIVMSG $chan :\[\002$text\002\] Created: $a - Exp: $b - Registrar: $c - Registrant: $d - DNS: $e"

  set connect2 [::http::geturl https://tools.whois.com.au/dig/$text]
  set files2 [::http::data $connect2]
  ::http::cleanup $files2
    set l2 [regexp  -all -inline -- {<td headers="th-ip-1">(.*?)</td>} $files2]
     foreach {blue z } $l2 {
         set a [string trim $z " \n"]
         regsub -all {<.+?>} $z {} z
        if {[info exists z]} {

  set connect3 [::http::geturl http://whatismyipaddress.com/ip/$z]
  set files3 [::http::data $connect3]
  ::http::cleanup $files3
    regexp -- {ISP:</th><td>(.*?)</td></tr><tr><th>Organization} $files3 - isp
    regexp -- {Country:</th><td>(.*?) <img src=} $files3 - country
    regexp -- {Hostname:</th><td>(.*?)</td></tr>} $files3 - hostname
    regexp -- {State/Region:</th><td>(.*?)</td></tr>} $files3 - state
    regexp -- {City:</th><td>(.*?)</td></tr>} $files3 - city
if {[info exists country]} { puthelp "privmsg $chan :\[\002$text\002\] IP: $z - ISP: $isp - Hostname: $hostname - Country: $country" } 
if {[info exists state]} { puthelp "privmsg $chan :\[\002$text\002\] State: $state - City: $city"}
                }
          }


# tutup info exists f
			} 
# tutup foreach
		}
# tutup string match "*.id"

	} elseif {[string match "*.org" $text]} {
  set connect [::http::geturl https://tools.whois.com.au/whois/$text]
  set files [::http::data $connect]
  ::http::cleanup $files
    set l [regexp -all -inline -- {Created On:(.*?)UTC.*?Last Updated On:(.*?)UTC.*?Expiration Date:(.*?)Sponsoring Registrar:(.*?)Status:.*?Registrant Street1:(.*?)Registrant Street2:.*?Registrant City:(.*?)Registrant State/Province:(.*?)Registrant Postal Code:(.*?)Registrant Country:(.*?)Registrant Phone:.*?Registrant Email:(.*?)Admin ID} $files]
     foreach {black a b c d e f g h i j} $l {

         set a [string trim $a " \n"]
         set b [string trim $b " \n"]
         set c [string trim $c " \n"]
         set d [string trim $d " \n"]
         set e [string trim $e " \n"]
         set f [string trim $f " \n"]
         set g [string trim $g " \n"]
         set h [string trim $h " \n"]
         set i [string trim $i " \n"]
         set j [string trim $j " \n"]

         regsub -all {<.+?>} $a {} a
         regsub -all {<.+?>} $b {} b
         regsub -all {<.+?>} $c {} c
         regsub -all {<.+?>} $d {} d
         regsub -all {<.+?>} $e {} e
         regsub -all {<.+?>} $f {} f
         regsub -all {<.+?>} $g {} g
         regsub -all {<.+?>} $h {} h
         regsub -all {<.+?>} $i {} i
         regsub -all {<.+?>} $j {} j


        if {[info exists a]} { putserv "PRIVMSG $chan :\[\002$text\002\] Created: $a - Update: $b - Exp: $c - Registrar: $d - Email: $j"

  set connect2 [::http::geturl https://tools.whois.com.au/dig/$text]
  set files2 [::http::data $connect2]
  ::http::cleanup $files2
    set l2 [regexp  -all -inline -- {<td headers="th-ip-1">(.*?)</td>} $files2]
     foreach {blue z } $l2 {
         set a [string trim $z " \n"]
         regsub -all {<.+?>} $z {} z
        if {[info exists z]} {

  set connect3 [::http::geturl http://whatismyipaddress.com/ip/$z]
  set files3 [::http::data $connect3]
  ::http::cleanup $files3
    regexp -- {ISP:</th><td>(.*?)</td></tr><tr><th>Organization} $files3 - isp
    regexp -- {Country:</th><td>(.*?) <img src=} $files3 - country
    regexp -- {Hostname:</th><td>(.*?)</td></tr>} $files3 - hostname
    regexp -- {State/Region:</th><td>(.*?)</td></tr>} $files3 - state
    regexp -- {City:</th><td>(.*?)</td></tr>} $files3 - city
if {[info exists country]} { puthelp "privmsg $chan :\[\002$text\002\] IP: $z - ISP: $isp - Hostname: $hostname - Country: $country" }

if {[info exists state]} { puthelp "privmsg $chan :\[\002$text\002\] State: $state - City: $city"}
                }
          }


# tutup info exists f
                        }
# tutup foreach
#                }
# tutup string match "*.org"

	} else {

  set connect [::http::geturl https://tools.whois.com.au/whois/$text] 
  set files [::http::data $connect]
  ::http::cleanup $files
    set l [regexp  -all -inline -- {Domain Name:(.*?)Registrar:(.*?)Whois Server:.*?Updated Date:(.*?)Creation Date:(.*?)Expiration Date:(.*?)&gt;&gt;&gt;} $files] 
     foreach {red a b c d e } $l {

         set a [string trim $a " \n"]
         set b [string trim $b " \n"]
         set c [string trim $c " \n"]
         set d [string trim $d " \n"]
         set e [string trim $e " \n"]

         regsub -all {<.+?>} $a {} a
         regsub -all {<.+?>} $b {} b
         regsub -all {<.+?>} $c {} c
         regsub -all {<.+?>} $d {} d
         regsub -all {<.+?>} $e {} e
if {[info exists b]} { putserv "PRIVMSG $chan : \[\002$text\002\] Registrar: $b - Updated Date: $c - Creation Date: $d - Expiration Date: $e" } 	


  set connect2 [::http::geturl https://tools.whois.com.au/dig/$text]
  set files2 [::http::data $connect2]
  ::http::cleanup $files2
    set l2 [regexp  -all -inline -- {<td headers="th-ip-1">(.*?)</td>} $files2]
     foreach {blue z } $l2 {
         set a [string trim $z " \n"]
         regsub -all {<.+?>} $z {} z
        if {[info exists z]} {
  set connect3 [::http::geturl http://whatismyipaddress.com/ip/$z]
  set files3 [::http::data $connect3]
  ::http::cleanup $files3
    regexp -- {ISP:</th><td>(.*?)</td></tr><tr><th>Organization} $files3 - isp
    regexp -- {Country:</th><td>(.*?) <img src=} $files3 - country
    regexp -- {Hostname:</th><td>(.*?)</td></tr>} $files3 - hostname
    regexp -- {State/Region:</th><td>(.*?)</td></tr>} $files3 - state
    regexp -- {City:</th><td>(.*?)</td></tr>} $files3 - city
if {[info exists country]} { puthelp "privmsg $chan : \[\002$text\002\] IP: $z - ISP: $isp - Hostname: $hostname - Country: $country" }
if {[info exists state]} { puthelp "privmsg $chan : \[\002$text\002\] State: $state - City: $city" }
 	}
    }
  }
 }
}





#bind pub - !ip msg_ipwhois
#proc msg_ipwhois {nick uhost hand chan text} {
#  global botnick
#  if {$text == "" } {putquick "PRIVMSG $chan :You have to use true command for look up whois information. Command: !ip ipnumber";return}

#        if {[string match "*" $text]} {
#  set connect [::http::geturl http://whatismyipaddress.com/ip/$text]
#  set files [::http::data $connect]
#  ::http::cleanup $files
#    regexp -- {ISP:</th><td>(.*?)</td></tr><tr><th>Organization} $files - isp
#    regexp -- {Country:</th><td>(.*?) <img src=} $files - country
#    regexp -- {Hostname:</th><td>(.*?)</td></tr>} $files - hostname
#    regexp -- {State/Region:</th><td>(.*?)</td></tr>} $files - state
#    regexp -- {City:</th><td>(.*?)</td></tr>} $files - city
#if {[info exists country]} {
#        puthelp "privmsg $chan :IP: $text - ISP: $isp - Hostname: $hostname - Country: $country"
#if {[info exists state]} {
#        puthelp "privmsg $chan :State: $state - City: $city"
#}

 #} else {  puthelp "privmsg $chan :Invalid address or IP not found" }

#	}
#}



set whoisinfo(port) 43
set whoisinfo(ripe) "whois.ripe.net"
set whoisinfo(arin) "whois.arin.net"
set whoisinfo(apnic) "whois.apnic.net"
set whoisinfo(lacnic) "whois.lacnic.net"
set whoisinfo(afrinic) "whois.afrinic.net"

bind pub - !ip pub_whoisinfo
bind pub - .ip pub_whoisinfo

proc whoisinfo_setarray {} {
	global query
	set query(netname) "(none)"
	set query(country) "(none)"
	set query(orgname) "(none)"
	set query(orgid) "(none)"
	set query(range) "(none)"
}

proc whoisinfo_display { chan } {
	global query
	putlog "Firstline: $query(firstline)"
	putquick "PRIVMSG $chan :Range : $query(range) - NetName : $query(netname) - Organization : $query(orgname) - Country : $query(country)"
}

proc pub_whoisinfo {nick uhost handle chan search} {
	global whoisinfo
	global query
	whoisinfo_setarray 
	if {[whoisinfo_whois $whoisinfo(arin) $search]==1} {
		if {[string compare [string toupper $query(orgid)] "RIPE"]==0} {
			if {[whoisinfo_whois $whoisinfo(ripe) $search]==1} {
				whoisinfo_display $chan
			}
		 } elseif {[string compare [string toupper $query(orgid)] "APNIC"]==0} {
			if {[whoisinfo_whois $whoisinfo(apnic) $search]==1} {
				whoisinfo_display $chan
			}
		 } elseif {[string compare [string toupper $query(orgid)] "LACNIC"]==0} {
			if {[whoisinfo_whois $whoisinfo(lacnic) $search]==1} {
				whoisinfo_display $chan
				}
		 } elseif {[string compare [string toupper $query(orgid)] "AFRINIC"]==0} {
			if {[whoisinfo_whois $whoisinfo(afrinic) $search]==1} {
				whoisinfo_display $chan
				}
		 } else {
			whoisinfo_display $chan
		}
	} else {
		if { [info exist query(firstline)] } {
			puthelp "PRIVMSG $chan :$query(firstline)"
		} else {
			puthelp "PRIVMSG $chan :Error!"
		}
	}
}

proc whoisinfo_whois {server search} {
	global whoisinfo
	global query
	set desccount 0
	set firstline 0
	set reply 0
	putlog "Whois: $server:$whoisinfo(port) -> $search"
	if {[catch {set sock [socket -async $server $whoisinfo(port)]} sockerr]} {
      	puthelp "PRIVMSG $chan :Error: $sockerr. Try again later."
      	close $sock
		return 0
    	}
	puts $sock $search
	flush $sock
	while {[gets $sock whoisline]>=0} {
		putlog "Whois: $whoisline"
		if {[string index $whoisline 0]!="#" && [string index $whoisline 0]!="%" && $firstline==0} {
			if {[string trim $whoisline]!=""} {
				set query(firstline) [string trim $whoisline]
				set firstline 1
			}
		}
		if {[regexp -nocase {netname:(.*)} $whoisline all item]} {
			set query(netname) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {owner-c:(.*)} $whoisline all item]} {
			set query(netname) [string trim $item]
			set reply 1 
		} elseif {[regexp -nocase {country:(.*)} $whoisline all item]} {
			set query(country) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {descr:(.*)} $whoisline all item] && $desccount==0} {
			set query(orgname) [string trim $item]
			set desccount 1
			set reply 1
		} elseif {[regexp -nocase {orgname:(.*)} $whoisline all item]} {
			set query(orgname) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {owner:(.*)} $whoisline all item]} {
			set query(orgname) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {orgid:(.*)} $whoisline all item]} {
			set query(orgid) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {inetnum:(.*)} $whoisline all item]} {
			set query(range) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {netrange:(.*)} $whoisline all item]} {
			set query(range) [string trim $item]
			set reply 1
		}
	}
	close $sock
	return $reply
}


bind pub - !check msg_domain
proc msg_domain {nick uhost hand chan text} {
  global botnick
  if {$text == "" } {putquick "PRIVMSG $chan :You have to use true command for look up whois information. Command: !check domain";return}

        if {[string match "*" $text]} {
  set connect [::http::geturl http://www.isup.me/$text]
  set isup [::http::data $connect]
  ::http::cleanup $isup
    regexp -- {class="domain">.*?</a></span> (.*?)
<p><a href.*?</a></p>} $isup - hasil
	if {[info exists hasil]} { puthelp "privmsg $chan :$nick, web server na $text $hasil" } else {  puthelp "privmsg $chan :Kayaknya down br0 ?" }

        }
}


bind pub - !help msg_help
proc msg_help {nick uhost hand chan text} {
  global botnick
  if {$text == "" } {putquick "PRIVMSG $nick :!help twitter";return}

	puthelp "privmsg $nick : Silahkan baca full commandnya di http://www.kaskus.xxx/twit.txt"

}


putlog "whois.tcl v1.1 by dono Loaded..."
