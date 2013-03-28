bind pub - !alexa msg_alexa
proc msg_alexa {nick uhost hand chan text} {
  global botnick
  if {$text == "" } {putquick "PRIVMSG $chan :You have to use true command for look up whois information. Command: !alexa domain";return}

        if {[string match "*" $text]} {
  set connect [::http::geturl http://data.alexa.com/data?cli=10&url=$text]
  set files [::http::data $connect]
  ::http::cleanup $files

    set l [regexp -all -inline -- {<POPULARITY URL=".*?" TEXT="(.*?)" SOURCE=".*?"/>.*?<COUNTRY CODE="(.*?)" NAME="(.*?)" RANK="(.*?)"/>.*?</SD>} $files]

if {[llength $l] != 0} {

     foreach {black a b c d e f} $l {

         set a [string trim $a " \n"]
         set b [string trim $b " \n"]
         set c [string trim $c " \n"]
         set d [string trim $d " \n"]

         regsub -all {<.+?>} $a {} a
         regsub -all {<.+?>} $b {} b
         regsub -all {<.+?>} $c {} c
         regsub -all {<.+?>} $d {} d


	putserv "PRIVMSG $chan :\[\002$text\002\] Alexa Rank: $a - Rank in \[\002$b\002\]$c: $d" }


} else { putserv "PRIVMSG $chan :\[\002$text\002\] No Data Found or Rank more than 1 million, that sux!" }


	}
}


