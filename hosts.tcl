# Kalau mau chan tertentu hilangkan # dibawah ini lalu .chanset #channel +dns
#setudef flag dns

#Dibawah ini create file kalau belum ada
set hostpath [exec pwd]/host.pl

if {![file exists $hostpath]} {
        putlog "Uh oh, couldn't find 'host.pl' so I will create it for you. :-)"
# Kalau bermasalah dengan path /usr/bin/perl coba gunakan /usr/local/bin/perl tergantu perasaan masing-masing

        append out "#\!/usr/bin/perl\n"
        append out "# Automatically Generated, do not edit anything but the path above!\n"
        append out "\n"
        append out "\$host \= \`host \@ARGV 2\>/dev/null\`\;\n"
        append out "if \(\$host eq \"\"\) \{\n"
        append out "        print \"Host not found, try again.\\n\"\;\n"
        append out "\} else \{\n"
        append out "        foreach \$line \(\$host\) \{\n"
        append out "                print \"\$line\"\;\n"
        append out "        \}\n"
        append out "\}\n"
        set fd [open "$hostpath" w]
        puts $fd $out
        unset out
        close $fd
        exec chmod 755 $hostpath
}

# Command utama !dnsx domain/IP, contoh !dnsx nyit-nyit.net
bind pub - !dnsx pub_dnslookup

proc pub_dnslookup {nick uhost hand chan text} {
        global hostpath
        set host [lindex $text 0]
        if {$host == ""} {
                #putserv "PRIVMSG $chan :$nick, you should ask me something to look up first."
                return 0
        } else {
                #putserv "PRIVMSG $chan :Ok $nick, I am looking up \002$host\002 for you. :-)"
                set input [open "|$hostpath $host" r]
                while {![eof $input]} {
                        catch {[set contents [gets $input]]}
                        if {$contents == "Host not found, try again."} {
                                #putserv "PRIVMSG $chan :I'm sorry $nick, I looked for \002$host\002, but couldn't find any information on it."
                                catch {close $input}
                                putlog "<<$hand>> $nick ($chan) !dnsx $text"
                                return 0
                        } elseif {$contents != ""} {
                                if { [string match "*mail is handled*" $contents] } {
                                        return
                                } else {
                                        putserv "PRIVMSG $chan :$contents"
                                }
                        } else { }
                }
                close $input
        }
        putlog "<<$hand>> $nick ($chan) !dnsx $text"
        return 0
}

putlog "dnsx.tcl by samurai - modifikasi oleh dono 20160428 - credits to sdx"
