setudef flag question 

      set bantime 1440 
      set tag "Banned:" 
      set kickreason "Possible bot" 
      set channel "#gembels" 
      
      
bind time - "42 23 * * *" coba:hidupkan 
bind time - "06 20 * * *" coba:matikan 

      
proc coba:hidupkan {} { 
channel set #gembels +question 
putserv "PRIVMSG #gembels : Anti Bot Enable" 
} 

proc coba:matikan {} { 
channel set #gembels -question 
putserv "PRIVMSG #gembels : Anti Bot Disabled" 
} 


   bind join - *             onjoin 
   bind msgm - ".answer *"    answer 




   proc onjoin {nickname hostname handle channel} { 
      global botnick timers answer 
      ## if {$nickname == $botnick} { return } 
         if {![isbotnick $nickname] && ![info exists timers($hostname)]} { 
            set num1 [rand 9] 
            set num2 [rand 9] 
            set q [expr $num1 + $num2] 

            set answer($hostname) $q 
            set timers($hostname) [timer 2 [list noanswer $hostname]] 
	    putserv "PRIVMSG dono : $timers($hostname) -  $timers"
            putserv "PRIVMSG $nickname :I have a question, please answer with: .answer <number>" 
            putserv "PRIVMSG $nickname :$num1 + $num2 = ?" 

      } 
   } 


  proc noanswer {hostname} { 
      global botnick timers answer tag kickreason
      if {[info exists timers($hostname)]} { 
         set channel $channel 
         set bantime $bantime 

         foreach user [chanlist $channel] { 
            if {[string match "$hostname" "[string trim [getchanhost $user $channel] "~"]"]} { 
               set victim [string tolower $user] 
            } 
         } 
         if {[info exists victim]} { 
            if {[botisop $channel]} { 
               ## putserv "mode $channel +b *!*[string trim $hostname "~"]" 
               putserv "kick $channel $victim :$tag $kickreason" 
               putserv "PRIVMSG $victim :You didn't answer my question !" 
            } 
            newchanban $channel *!*[string trim $hostname "~"] question "$kickreason" $bantime 
         } 
         unset timers($hostname) 
         unset answer($hostname) 
      } 
   } 

   proc answer {nickname hostname handle arguments} { 
      global botnick timers answer bantime kickreason
      if {[info exists timers($hostname)]} { 

         set channel $channel 
         set bantime $bantime 
         set correctanswer [lindex $arguments 1] 

         if {[string match $correctanswer $answer($hostname)] != 1} { 
            if {[botisop $channel]} { 
               putserv "mode $channel +b *!*[string trim $hostname "~"]" 
               putserv "kick $channel $nickname :$tag $kickreason" 
            } 
            killtimer $timers($hostname) 
            newchanban $channel *!*[string trim $hostname "~"] question "$kickreason" $bantime 
            putserv "PRIVMSG $nickname :Jawaban salah!" 
         } else { 
            killtimer $timers($hostname) 
            putserv "PRIVMSG $nickname :Jawaban benar!" 
            putquick "MODE $channel +v $nickname" 
         } 
         unset timers($hostname) 
         unset answer($hostname) 
      } 
   } 
putlog "Antibot Loaded" 
