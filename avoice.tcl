############################## _\|/_ ###############################
##
## autovoice on pubmsg script v1.2
## by aerosoul@IRCNet (soul@gmx.net)
##
## this script will give voice to users who say something on the
## channel and devoice them after idle time.
##
## people will have a overlook of who idles and who is active on your
## channels (especially for chans with bot-only ops)
##
## - add voice on pubmsg for #channel :
##   .chanset #channel +av.pubmsg
##   remove with .chanset #channel -av.pubmsg
## - add devoice after idle time for #channel :
##   .chanset #channel +av.devoice
## - optionally set devoice time in the bots partyline :
##   .chanset #channel av.dtime 30 (in minutes)
##
## there is a little delay before voicing, so there won't be
## modefloods.
##
## tell me bugs and suggestions @ IRCNet #playaz or soul@gmx.net
## (no, I don't write a version for older eggys, sorry.)
## if you want to send me ganja, please leave a msg ;)
##
## v1.2 28. may 2001:   - added option to set devoice time @ partyline
##                      - fixed some stuff / cleaned up
##                      - removed responding to stupid "thank you, bot"
##                        scripts
##                      - the script now also voices @'s. makes more
##                        sense =)
##
############################## _\|/_ ###############################

# set the channels for this script in partyline (see above)

# default: devoice after 23 mins
# optionally you can set this in the bots partyline
set av_dtime 30

# users with flag +g or +2 or bots won't be devoiced
set av_nodevoiceflag "2gb"

# users with flag +1 won't be voiced
# set to "1b" if you don't want bots to be voiced, too
set av_novoiceflag "1"

# log devoicing to partyline ? (0/1)
set av_partylog 0

# delay before autovoicing, in seconds (will be randomized)
set av_delay 120

# also give voice to ops? (0/1)
set av_opvoice 0

# also give voice to half ops? (0/1)
set av_halfopvoice 0
############################## _\|/_ ###############################

# # # # # # # # # # don't edit below this line # # # # # # # # # # #
# # # # # # # # if you don't know what you're doing  # # # # # # # #

if {$numversion < "1050000"} {
 putlog "you need eggdrop version >1.5 for autovoice on pubmsg script to work"
 return 0
}

setudef flag av.pubmsg
setudef flag av.devoice
setudef int av.dtime

proc av_main {nik uhost hand chan text} {
 global av_delay av_novoiceflag

 set delay [expr 1 + [rand $av_delay]]

 if {![string match *av_devoice* [timers]]} {timer [expr 3 + [rand 5]] av_devoice}
 set chan [string tolower $chan]
 if {[av_fcheck $chan] == 0} {return 0}
 if {[matchattr $hand $av_novoiceflag] || [matchattr $hand |$av_novoiceflag $chan]} {
        return 0
 }
 if {![isvoice $nik $chan]} {
        utimer $delay [split "av_doit $chan $nik"]
 }
}

proc av_doit {vchan vnick} {
global av_opvoice av_halfopvoice
 if {![isvoice $vnick $vchan]} {
  if {($av_opvoice == 0) && [isop $vnick $vchan] && ($av_halfopvoice == 0) && [ishalfop $vnick $vchan]} { return 0 }
  pushmode $vchan +v $vnick
 }
}

proc av_devoice {} {
global av_dtime av_nodevoiceflag av_partylog
if {![string match *av_devoice* [timers]]} {timer [expr 1 + [rand 3]] av_devoice}
 foreach chan [channels] {
  set dtime $av_dtime
  if {[av_cdtime $chan] != 0} {
   set dtime [av_cdtime $chan]
  }
  set av_deoplist ""
  if {[av_dcheck $chan] == 1} {
   foreach user [chanlist $chan] {
    set hand [nick2hand $user]
    if {[matchattr $hand $av_nodevoiceflag] || [matchattr $hand |$av_nodevoiceflag $chan]} {
        continue
    }
    if {([getchanidle $user $chan] > $dtime) && [isvoice $user $chan]} {
        pushmode $chan -v $user
        set av_deoplist "$av_deoplist $user"
    }
   }
   if {$av_partylog == 1} {
    set count 0
    foreach u $av_deoplist {
        set count [expr $count + 1]
    }
    if {($count != 0)} {
     putlog "-\[ av.pubmsg \]- devoicing $count users in $chan: $av_deoplist"
    }
   }
  }
 }
}

proc av_cdtime {chan} {
 foreach info [string tolower [channel info $chan]] {
  if {[lindex $info 0] == "av.dtime"} {
   return [lindex $info 1]
  }
 }
}

proc av_fcheck {chan} {
 foreach info [channel info $chan] {
  if {[string tolower [string range $info 1 e]] == "av.pubmsg"} {
   if {[string index $info 0] == "-"} {
    return 0
   } else {
    return 1
   }
  }
 }
 return 0
}

proc av_dcheck {chan} {
 foreach info [channel info $chan] {
  if {[string tolower [string range $info 1 e]] == "av.devoice"} {
   if {[string index $info 0] == "-"} {
    return 0
   } else {
    return 1
   }
  }
 }
 return 0
}

set autovoice_chans ""

foreach chan [channels] {
 if {[av_fcheck $chan] == 1} {
        set autovoice_chans "$autovoice_chans $chan"
 }
}

if {![string match *av_devoice* [timers]]} {timer [expr 3 + [rand 5]] av_devoice}

bind pubm - * av_main

############################## _\|/_ ###############################

putlog "-\[ voice on pubmsg script v1.2 by aerosoul active on: $autovoice_chans \]-"

############################ legalize! #############################
