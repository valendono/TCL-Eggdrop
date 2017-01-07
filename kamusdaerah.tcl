bind pub - !a msg_bahasa

proc msg_bahasa {nick uhost hand chan text} {
  global botnick
  set time_setting "%Y/%m/%d"
  set tanggalharini [clock format [clock seconds] -format $time_setting]
  set text [string tolower $text]
  if {$text == "" } {putserv "NOTICE $nick :Command: !a bahasa kata - Bahasanya: Padang, Aceh, Bali, Banjar, Bugis, Jawa, Lampung, Makassar, Palembang, Pontianak, Sunda";return}
  set bahasa [lindex $text 0]
  set artikan [lindex $text 1]

  if {$bahasa == "" || $artikan == "" } {putserv "NOTICE $nick :Command: !a bahasa kata - Bahasanya: Padang, Aceh, Bali, Banjar, Bugis, Jawa, Lampung, Makassar, Palembang, Pontianak, Sunda";return}

set bahasa [string tolower $bahasa]
switch $bahasa {
        padang { set bhs2 k }
        aceh { set bhs2 o }
        bali { set bhs2 g }
        banjar { set bhs2 h }
        bugis { set bhs2 r }
        jawa { set bhs2 i }
        lampung { set bhs2 s }
        makassar { set bhs2 j }
        palembang { set bhs2 l }
        pontianak { set bhs2 n }
        sunda { set bhs2 m}
        default { set bhs2 k }
}

if {$bhs2 == ""} { return }

###putserv "PRIVMSG $chan : $bahasa -- $artikan -- $bhs2"

  if {[string match "*" $text]} {
  set connect [::http::geturl http://www.kamusdaerah.com/?bhs=a&bhs2=$bhs2&q=$artikan]
  set files [::http::data $connect]
  ::http::cleanup $files

    set l [regexp -all -inline -- {<div class='arti'>Artinya: </div>(.*?)<div class='bahasa'>(.*?)</div>} $files]

if {[llength $l] != 0} {
     set m 0
     foreach {black a b} $l {
         incr m
         set a [string trim $a " \n"]
         set b [string trim $b " \n"]

         regsub -all {<.+?>} $a {} a
         regsub -all {<.+?>} $b {} b


        striphtml $a
        striphtml $b
        set kumpulin "$m. $a "
        append muncrat $kumpulin
        }
       putserv "PRIVMSG $chan : Translate $artikan dalam bahasa [string toupper $bahasa]: $muncrat"

} else { putserv "NOTICE $nick :\[\002[string toupper $bahasa]\002\] Kami tidak menemukan bahasa lainnya" }


        }
}


proc striphtml { text } {

     # filter out scripts, stylesheets, tags, and most escaped characters
     set text [regsub -all -nocase {<script[^>]*?>.*?</script>} $text " "]
     set text [regsub -all -nocase {<style[^>]*?>.*?</style>} $text " "]
     set text [regsub -all -nocase {<[\/\!]*?[^<>]*?>} $text " "]
     set text [regsub -all -nocase {([\r\n])[\s]+} $text "\\1"]
     set text [regsub -all -nocase {%&(quot|#34);} $text "\""]
     set text [regsub -all -nocase {&(amp|#38);} $text "&"]
     set text [regsub -all -nocase {&(lt|#60);} $text "<"]
     set text [regsub -all -nocase {&(gt|#62);} $text ">"]
     set text [regsub -all -nocase {&(nbsp|#160);} $text " "]
     set text [regsub -all -nocase {&(iexcl|#161);} $text "\xa1"]
     set text [regsub -all -nocase {&(cent|#162);} $text "\xa2"]
     set text [regsub -all -nocase {&(pound|#163);} $text "\xa3"]
     set text [regsub -all -nocase {&(copy|#169);} $text "\xa9"]

     # and last, catch arbitrary sequences
     set text [string map {[ \\[ ] \\] $ \\$ \\ \\\\} $text]
     set text [regsub -all -nocase {&#(\d+);} $text {[format c \1]}]
     set text [subst $text]

     return $text

}

putlog "\00303[string range [info script] 0 end]\00303 \002loaded...\002"
