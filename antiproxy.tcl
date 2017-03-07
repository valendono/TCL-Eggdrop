
#  __ __        __                          ___                                              __    
#  _\ \\ \__    /\ \                        /\_ \                                            /\ \__ 
# /\__  _  _\  \_\ \    __  __  __    __\//\ \    ___  _____    ___ ___      __    ___\ \ ,_\ 
# \/__\ \\ \__  /'_` \  /'__`\/\ \/\ \  /'__`\\ \ \  / __`\/\ '__`\ /' __` __`\  /'__`\/' _ `\ \ \/ 
#  /\_  _  _\/\ \_\ \/\  __/\ \ \_/ |/\  __/ \_\ \_/\ \_\ \ \ \_\ \/\ \/\ \/\ \/\  __//\ \/\ \ \ \_
#  \/_/\_\\_\/\ \___,_\ \____\\ \___/ \ \____\/\____\ \____/\ \ ,__/\ \_\ \_\ \_\ \____\ \_\ \_\ \__\
#      \/_//_/  \/__,_ /\/____/ \/__/  \/____/\/____/\/___/  \ \ \/  \/_/\/_/\/_/\/____/\/_/\/_/\/__/
#                                                              \ \_\
#                                                              \/_/
#
#                        /\ \                /\ \__  __                
#  _____  _ __  ___    \_\ \  __  __    ___\ \ ,_\/\_\    ___    ___    ____ 
# /\ '__`\/\`'__\/ __`\  /'_` \/\ \/\ \  /'___\ \ \/\/\ \  / __`\ /' _ `\  /',__\
# \ \ \_\ \ \ \//\ \_\ \/\ \_\ \ \ \_\ \/\ \__/\ \ \_\ \ \/\ \_\ \/\ \/\ \/\__, `\
#  \ \ ,__/\ \_\\ \____/\ \___,_\ \____/\ \____\\ \__\\ \_\ \____/\ \_\ \_\/\____/
#  \ \ \/  \/_/ \/___/  \/__,_ /\/___/  \/____/ \/__/ \/_/\/___/  \/_/\/_/\/___/
#    \ \_\                                                              
#    \/_/                                                              
#      
# Anti proxy scan script.

# /* This is an anti proxy script written for eggdrop. It's been tested on eggdrop1.6.17 with TCL version 8.4
# *  Unlike other anti proxy scripts i've seen around.
# *  This script works just as well on a windrop as it does on a windrop
# *  I've been testing it with a few proxies myself and it clears about 5 proxies in a few seconds without a problem
# *  If it detects a floodjoin happening it will set the modes you choose
# *  (Default mir = moderated, invite only, registered only) These modes are for Quakenet though.
# *  The script will first check what modes you already have set so it won't be unsetting a mode you already had before the floodjoin
# */

# /* Author info
# *  I made this script because i was sick of all the proxies that were joining my channel and spamming it
# *  It's based off the proxycheck.tcl made by James. I rewrote the entire script but kept the basics in.
# *  This script is generally alot faster than that script. But it's still in beta form!
# *  I release this script to http://development.woosah.org
# *  and no other websites are allowed to release this without my explicit authorisation.
# *  If you have an eggdrop website with scripts and you'd like to put this script on your webpage,
# *  Send me an email at metroid at gmail.com replacing at with @
# */

# /* Installing the anti-proxy script
# *  First, put the script into your /scripts folder.
# *  Then at the end of your eggdrop.conf, Put:
# *  source scripts/anti-proxy.tcl
# *  Or if you are using the #development configuration file, you won't have to do anything.
# *  Just rehash the bot after you've done this and it should work.
# *  Read the next part about using it.
# */

# /* Using the anti-proxy script
# *  The script itself pretty much does everything automaticly once it's activated.
# *  You can activate it by typing: <trigger>proxy enable
# *  You can deactivate it by typing: <trigger>proxy disable
# *  If you want some statistics about how many people it has scanned, detected or kicked,
# *  you can use <trigger>proxy stats
# *  Just typing <trigger>proxy will tell you if the check is enabled or disabled, and possibly statistics about it.
# */

namespace eval proxy {
 variable version "0.75"
 variable author  "metroid - #development on irc.quakenet.org"

 variable trigger "?"


 # The sources we dns to find out if a user is a proxy
 variable source { "dnsbl.dronebl.org" "rbl.efnetrbl.org" "rbl.efnet.org" "dnsbl.tornevall.org" }


 setudef flag antiproxy

 setudef str  antijoins
 setudef str  antidetected
 setudef str  antikicked

 # /* Settings! */
 variable flood "2:15" ;# 4 proxies that join in 8 seconds and the channel gets closed
 variable close "30"  ;# This is in seconds! It will keep the channel closed for 30 seconds
 variable modes "mir"  ;# the modes it will set when the channel gets flooded.
 # /* End of settings */


 # /* Don't edit anything below these lines. If you break it, don't expect me to fix it for you. */
 bind JOIN -|- *                  [namespace current]::checkuser
 bind PUB  m|n ${trigger}proxy    [namespace current]::toggle

 variable proxy
 array set proxy ""
}

proc proxy::toggle {nickname hostname handle channel arguments} {
 set command [lindex [split $arguments] 0]
 switch -exact -- [string tolower $command] {
  enable {
  if {![channel get $channel antiproxy]} {
    channel set $channel +antiproxy
    putquick "NOTICE $nickname :Done. Anti-Proxy was enabled."
  } else {
    putquick "NOTICE $nickname :Error: Anti-Proxy is already enabled."
  }
  }
  disable {
  if {[channel get $channel antiproxy]} {
    channel set $channel -antiproxy
    putquick "NOTICE $nickname :Done. Anti-Proxy was disabled."
  } else {
    putquick "NOTICE $nickname :Error: Anti-Proxy is already disabled."
  }
  }
  stats {
  if {([channel get $channel antijoins] != "") || ([channel get $channel antidetected] != "") || ([channel get $channel antikicked] != "")} {
    putquick "NOTICE $nickname :Stats for $channel: [statistics $channel]"
  } else {
    putquick "NOTICE $nickname :No statistics available for $channel."
  }
  }
  default {
  if {[channel get $channel antiproxy]} {
    putquick "NOTICE $nickname :Anti-Proxy is currently enabled for $channel. Statistic: [statistics $channel]"
  } else {
    putquick "NOTICE $nickname :Anti-Proxy is currently disabled for $channel."
  }
  }
 }
}


proc proxy::checkuser {nickname hostname handle channel} {
 checkstats $channel
 if {[channel get $channel antiproxy] && [botisop $channel] && ![string match *users.quakenet.org* $hostname] && ![matchattr $handle m|m $channel] && ![isbotnick $nickname]} {
  channel set $channel antijoins "[expr [channel get $channel antijoins] + 1]"
  regexp {.*\@(.*)} $hostname -> hostname
  if [regexp {[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$} $hostname] {
  [namespace current]::check $hostname $hostname 1 $nickname $hostname $channel 
  } else {
  dnslookup $hostname [namespace current]::check $nickname $hostname $channel
  }
 }
}

proc proxy::check  {ip hostname status nickname originalhost channel } {
  variable source
  if {$status} {
    regexp {([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})} $ip -> part1 part2 part3 part4
    set newip "$part4.$part3.$part2.$part1"
 
    foreach proxylist $source {
      dnslookup "$newip.$proxylist" [namespace current]::check2 $nickname $ip $originalhost $hostname $channel $proxylist
    }
  } else {
    putlog "AntiProxy: Couldn't dns resolve $originalhost."
  }
}

proc proxy::check2 {ip hostname status nickname oip realhost originalhost channel rbl } {
  variable proxy
  variable bantime
  variable close
  if {[info exists proxy($channel,$nickname)]} { return 0 }
  set closemode [modes $channel]
  if {$status} {
    set proxy($channel,$nickname) 1
    utimer 10 [list unset [namespace current]::proxy($channel,$nickname)]
    channel set $channel antidetected "[expr [channel get $channel antidetected] + 1]"
    if {[floodjoin $channel]} {
    putquick "MODE $channel +b$closemode $realhost" -next
    set ::close($channel) 1
    utimer $close [list [namespace current]::open "$channel" "$closemode"]
    }
    pushmode $channel +b $realhost
    if [regexp {[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}$} $originalhost] {
    putquick "KICK $channel $nickname :\<$oip\> is in the DNSBL \[Open Proxy\] \(ID: [expr [channel get $channel antikicked] + 1]\)"
    } else {
    putquick "KICK $channel $nickname :\<$oip\> \[$originalhost\] is in the DNSBL \[Open Proxy\] \(ID: [expr [channel get $channel antikicked] + 1]\)"
    }
    channel set $channel antikicked "[expr [channel get $channel antikicked] + 1]"
    utimer 3 [list flushmode $channel]
  }
}
  
proc proxy::open {channel modes} {
 if {[info exists ::close($channel)]} {
  putserv "MODE $channel -$modes"
  unset ::close($channel)
 } else {
  return 0
 }
}

proc proxy::modes {channel} {
 variable modes
 set end ""
 set chanmode [lindex [getchanmode $channel] 0]
 foreach mode [split $modes ""] {
  if {![string match *$mode* $chanmode]} {
  append end $mode
  }
 }
 return "[join $end]"
}

proc proxy::unsetflood {channel} {
 if {[info exists ::flood($channel)]} {
  unset ::flood($channel)
 }
}

proc proxy::statistics {channel} {
 set joins    [channel get $channel antijoins]
 set detected [channel get $channel antidetected]
 set kicked  [channel get $channel antikicked]
 if {$joins == "" || $joins == "0"} {
  return "Statistic Unavailable"
 } elseif {$detected == "" || $detected == "0"} {
  return "Statistic Unavailable"
 } elseif {$kicked == "" || $kicked == "0"} {
  return "Statistic Unavailable"
 } else {
  return "Scanned: $joins, Detected: $detected, Kicked: $kicked  \[[format %.2f [expr ($kicked * 100.0) / $joins]]%\]"
 }
}

proc proxy::checkstats {channel} {
# /* This is set to 1 to prevent the bot from crashing. (for some people this appears to be a problem) */
 if {[channel get $channel antijoins] == ""} { channel set $channel antijoins "1" }
 if {[channel get $channel antidetected] == ""} { channel set $channel antidetected "1" }
 if {[channel get $channel antikicked] == ""} { channel set $channel antikicked "1" }
}

proc proxy::floodjoin {channel} {
 variable flood
 set split [split $flood :]
 set user [lindex $split 0]
 set seconds [lindex $split 1]
 if {![info exists ::flood($channel)]} {
  set ::flood($channel) 1
 } else {
  incr ::flood($channel)
 }
  if {$::flood($channel) >= $user} {
  set ::flood($channel) 0
  return 1
  } else {
    utimer $seconds [list [namespace current]::unsetflood $channel]
  }
  return 0
}

proc proxy::credits {} {
  variable file [lindex [split [info script] "/"] end];
  variable version;
  variable owner "metroid (#development)";
  variable modified [clock format [file mtime [info script]] -format "%Y/%m/%d %H:%M:%S"];
  set channels 0; set total 0; set end ""
  foreach chan [channels] {;
  checkstats $chan
  incr total
  if {[channel get $chan antiproxy]} { incr channels ; lappend end $chan }
  };
 putlog "$file v$version by $owner - Last modified: $modified"
 putlog "$file active on $channels/$total ([format %.2f [expr ($channels.0 * 100.0) / $total.0]]%) channels: [join $end ", "]"
 putlog "$file was successfully loaded!"
}

proxy::credits

# // Copyright: This script was made by metroid (#development). This means, YOU DIDNT MAKE IT! I DID! :p
# // Don't break my copyright because it's lame and i'll sue you ass if you do. Have fun!