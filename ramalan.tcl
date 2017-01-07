bind pub - !ramalan msg_bintang
proc msg_bintang {nick uhost hand chan text} {
  global botnick
  set time_setting "%Y/%m/%d"
  set tanggalharini [clock format [clock seconds] -format $time_setting]
  set text [string tolower $text]
  if {$text == "" } {putquick "PRIVMSG $chan :You have to use true command for look up whois information. Command: !bintang domain";return}
        #putserv "PRIVMSG $chan :Debug Format Tanggal: $tanggalharini "

        if {[string match "*" $text]} {
  set connect [::http::geturl http://www.vemale.com/zodiak/$text/$tanggalharini/]
  set files [::http::data $connect]
  ::http::cleanup $files

    set l [regexp -all -inline -- {<span itemprop="summary">(.*?)</p></span>                </p><p style="display:block; margin: 5px 0px 0px 0px !important; height: 0px !important">&nbsp;</p>.*?<p>Single: (.*?).</p>
<p>Couple: (.*?)</p>                </p><p style="display:block; margin: 5px 0px 0px 0px !important; height: 0px !important">&nbsp;</p>.*?<strong class="title-body">Karier &amp; Keuangan</strong>(.*?)<span itemprop='reviewer'>By Woman of KapanLagi.com</span>} $files]

if {[llength $l] != 0} {

     foreach {black a b c d} $l {

         set a [string trim $a " \n"]
         set b [string trim $b " \n"]
         set c [string trim $c " \n"]
         set d [string trim $d " \n"]

         regsub -all {\.} $a {} a
         regsub -all {&nbsp;} $b {} b
         regsub -all {&nbsp;} $c {} c
         regsub -all {&nbsp;} $d {} d
         regsub -all {<.+?>} $d {} d

         regsub -all {\.} $b {} b
         regsub -all {\.} $c {} c

        putserv "PRIVMSG $chan :\[Ramalan Bintang [string toupper $text] $tanggalharini\] : $a - \002CINTA\002 \037Jomblo\037: $b \& \037Couples\037: $c - \002KEUANGAN\002: $d" }

} else { putserv "PRIVMSG $chan :\[\002[string toupper $text]\002\] Kami tidak menemukan horoskop kamu! Pilihannya adalah: aries taurus gemini cancer leo virgo libra scorpio sagittarius capricorn aquarius pisces" }


        }
}

putlog "\00313[string range [info script] 0 end]\00313 \002loaded...\002"
