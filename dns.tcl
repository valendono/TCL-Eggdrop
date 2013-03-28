set dnshost(cmdchar) "!"


#-----------------please don't CHANGE ANY OF THE FOLLOWING LINES----------------------
bind pub - [string trim $dnshost(cmdchar)]dns dns:res
bind pub n|n [string trim $dnshost(cmdchar)]amsg pub:amsg
bind pub - [string trim $dnshost(cmdchar)]User@host pub:host
bind pub - [string trim $dnshost(cmdchar)]version pub:ver
bind pub - [string trim $dnshost(cmdchar)]dnsnick dns:nick
bind raw * 311 raw:host
bind raw * 401 raw:fail

set dns_chan ""
set dns_host ""
set dns_nick ""
set dns_bynick ""

proc pub:host {nick uhost hand chan arg} {
global dns_chan
set dns_chan "$chan"
putserv "WHOIS [lindex $arg 0]"
}

proc raw:host {from signal arg} {
global dns_chan dns_nick dns_host dns_bynick
set dns_nick "[lindex $arg 1]"
set dns_host "*!*[lindex $arg 2]@[lindex $arg 3]"
foreach dns_say $dns_chan { puthelp "PRIVMSG $dns_say :15\[host4!15\] \037\002$dns_nick\017 -> \037\002$dns_host\017 ." }
if {$dns_bynick == "dono"} {
                set hostip [split [lindex $arg 3] ]
                dnslookup $hostip resolve_rep $dns_chan $hostip
                set dns_bynick "dono"
}
}

proc raw:fail {from signal arg} {
global dns_chan
set arg "[lindex $arg 1]"
foreach dns_say $dns_chan { puthelp "PRIVMSG $dns_say :15nick4! \037\002$arg\017: No such nick." }
}

proc pub:ver {nick uhost hand chan text} {
#putserv "PRIVMSG $chan : Dns Resolver 3.1 by Headup"
}

proc dns:res {nick uhost hand chan text} {
 if {$text == ""} {
            puthelp "privmsg $chan :Syntax: [string trim $dnshost(cmdchar)]dns <host or ip>"
        } else {
                set hostip [split $text]
                dnslookup $hostip resolve_rep $chan $hostip
        }
}

proc dns:nick {nick uhost hand chan arg} {
global dns_chan dns_bynick dnshost
 if {$arg == ""} {
 puthelp "privmsg $chan :Syntax: [string trim $dnshost(cmdchar)]dnsnick <nick>"
        } else {
set dns_chan "$chan"
set dns_bynick "dono"
putserv "WHOIS [lindex $arg 0]"
        }
}

proc resolve_rep {ip host status chan hostip} {
        if {!$status} {

 puthelp "privmsg $chan  :15\[!dNs415\]  $hostip not resolve" 

        } elseif {[regexp -nocase -- $ip $hostip]} {
                puthelp "privmsg $chan  :15\[dNs4!15\] Resolved $ip to $host"
        } else {
#                puthelp "privmsg $chan  :15\[dNs4!15\] Resolved $host to $ip"

  set connect3 [::http::geturl http://whatismyipaddress.com/ip/$ip]
  set files3 [::http::data $connect3]
  ::http::cleanup $files3
    regexp -- {ISP:</th><td>(.*?)</td></tr><tr><th>Organization} $files3 - isp
    regexp -- {Country:</th><td>(.*?) <img src=} $files3 - country
    regexp -- {Hostname:</th><td>(.*?)</td></tr>} $files3 - hostname
    regexp -- {State/Region:</th><td>(.*?)</td></tr>} $files3 - state
    regexp -- {City:</th><td>(.*?)</td></tr>} $files3 - city
if {[info exists country]} { puthelp "privmsg $chan :\[\002$host\002\] IP: $ip - ISP: $isp - Hostname: $hostname - Country: $country" }
if {[info exists state]} { puthelp "privmsg $chan :\[\002$host\002\] State: $state - City: $city"}


        }
}

putlog "Dns Resolver 3.1 by Headup Loaded"

