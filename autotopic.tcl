# oleh dono 20150115 irc.ayochat.or.id
bind cron - {* * * * *} cron:week

proc cron:week {min hour day month weekday} {
        global shelltime_setting
        if {![botisop #minangcrew]} {return 0}
        if {[string trimleft $min 0] == 59 && [string trimleft $hour 0] == 23} {
  switch [string trimleft $weekday 0]  {
    "1" { puthelp "TOPIC #minangcrew : \00308,01 6 hari lagi - Auto Update Topic Testing - [clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)] \003" }
    "2" { puthelp "TOPIC #minangcrew : \00309,01 5 hari lagi - Auto Update Topic Testing - [clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)] \003" }
    "3" { puthelp "TOPIC #minangcrew : \00311,01 4 hari lagi - Auto Update Topic Testing - [clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)] \003" }
    "4" { puthelp "TOPIC #minangcrew : \00313,01 3 hari lagi - Auto Update Topic Testing - [clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)] \003" }
    "5" { puthelp "TOPIC #minangcrew : \00304,01 2 hari lagi - Auto Update Topic Testing - [clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)] \003" }
    "6" { puthelp "TOPIC #minangcrew : \00300,01 1 hari lagi - Auto Update Topic Testing - [clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)] \003" }
    "7" {
    putserv "PRIVMSG #minangcrew :Score akan di reset dalam 1 menit"
    puthelp "TOPIC #minangcrew : \00301,08 Hari Minggu - Auto Update Topic Testing - [clock format [clock seconds] -timezone :Asia/Jakarta -format $shelltime_setting(format)]"
        }

    }
  }
}

#NB: Aktifkan jam.tcl untuk mendapatkan shelltime_setting
# 1 = Senin ... 7 = Minggu