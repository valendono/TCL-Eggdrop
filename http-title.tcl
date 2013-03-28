# http-title.tcl --
#
#     This script will display the page title of a web link pasted in a channel.
#     To enable, use: .chanset #channel +http-title
# 
# Copyright (c) 2010, Rickard Utgren <rutgren@gmail.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# RCS: $Id$
#
# v0.1 by Pixelz (rutgren@gmail.com), April 29, 2010

# I'm holding release of this script until eggdrop 1.6.20 is released, because
# of the planned utf-8 support and fix for fileevents in 1.6.20. The script has
# only been tested with a beta version of the utf-8 patch, not with the other
# utf-8 patch that's floating around, but I suspect that both will work. If it
# doesn't, too bad. Wait for 1.6.20, or use Tcldrop instead, where everything
# works perfectly!

# This script is still UNRELEASED, don't complain about things listed in
# FixMe/ToDo. If you find a problem with something that's supposed to work, and
# isn't listed below, then please contact me.

# FixMe:
# 22:20:52 <@Pixelz> http://www.screenjunkies.com/tvphotos/18-awesome-david-caruso-memes
# 22:20:53 <Sunflight> [21:20] Tcl error [::http-title::pubm]: invalid command name "zlib"
#
# ToDo:
# - support gzip (it's not enough to just load the package, duh)
# - cleanup cleanup cleanup
# - fix FixMe's
# - Rewrite to use "::http::geturl -command"
# - Hold release until eggdrop properly supports UTF-8

# - Add a manual charset override that's exposed to users (separate from the .tld defaults we set)
# - Add support for reading meta description, perhaps with a list where you can set which sites to do that for
# - Add url-shortening (is.gd?, u.nu?)

package require Tcl 8.5
package require eggdrop 1.6.20
package require http 2.5
package require htmlparse 1.1.3

namespace eval ::http-title {
	setudef flag {http-title}
	encoding system {utf-8}
	variable ::http::defaultCharset
	variable haveTls
	variable haveGzip
	
	# These packages aren't hard requirements, so we check for the here instead of polluting the global namespace.
	# Check for the TLS package
	if {![catch {package require tls}]} {
		::http::register https 443 [list ::tls::socket -require 0 -request 1]
		set haveTls 1
		putlog {http-title: TLS OpenSSL extension found, HTTPS available.}
	} else {
		set haveTls 0
		putlog {http-title: TLS OpenSSL extension not found, HTTPS unavailable.}
	}
	
	# Check for zlib or Trf
	if {([lsearch -exact [info commands] zlib] != -1) || (![catch {package require zlib}])} {
		# we have zlib
		set haveGzip 1
		putlog {http-title: zlib found, gzip compression availible.}
	} elseif {([lsearch -exact [info commands] zip] != -1) || (![catch {package require Trf}])} {
		# we have Trf
		set haveGzip 2
		putlog {http-title: Trf found, gzip compression availible.}
	} else {
		set haveGzip 0
		putlog {http-title: zlib or Trf not found, gzip compression unavailable.}
	}
}

# IDNA implementation by Alexey Shchepin
# http://svn.xmpp.ru/repos/tkabber/trunk/tkabber/idna.tcl
proc ::http-title::domain_toascii {domain} {
	set domain [string tolower $domain]
	set parts [split $domain "\u002E\u3002\uFF0E\uFF61"]
	set res {}
	foreach p $parts {
		set r [toascii $p]
		lappend res $r
	}
	return [join $res .]
}

proc ::http-title::toascii {name} {
	# TODO: Steps 2, 3 and 5 from RFC3490

	if {![string is ascii $name]} {
		set name [punycode_encode $name]
		set name "xn--$name"
	}
	return $name
}

proc ::http-title::punycode_encode {input} {
	set base 36
	set tmin 1
	set tmax 26
	set skew 38
	set damp 700
	set initial_bias 72
	set initial_n 0x80
	
	set n $initial_n
	set delta 0
	set out 0
	set bias $initial_bias
	set output ""
	set input_length [string length $input]
	set nonbasic {}
	
	for {set j 0} {$j < $input_length} {incr j} {
		set c [string index $input $j]
		if {[string is ascii $c]} {
			append output $c
		} else {
			lappend nonbasic $c
		}
	}

	set nonbasic [lsort -unique $nonbasic]
	
	set h [set b [string length $output]];
	
	if {$b > 0} {
		append output -
	}
	
	while {$h < $input_length} {
		set m [scan [string index $nonbasic 0] %c]
		set nonbasic [lrange $nonbasic 1 end]
	
		incr delta [expr {($m - $n) * ($h + 1)}]
		set n $m
	
		for {set j 0} {$j < $input_length} {incr j} {
			set c [scan [string index $input $j] %c]
	
			if {$c < $n} {
				incr delta
			} elseif {$c == $n} {
				for {set q $delta; set k $base} {1} {incr k $base} {
					set t [expr {$k <= $bias ? $tmin :
						 $k >= $bias + $tmax ? $tmax : $k - $bias}]
					if {$q < $t} break;
					append output \
					[punycode_encode_digit \
						[expr {$t + ($q - $t) % ($base - $t)}]]
					set q [expr {($q - $t) / ($base - $t)}]
				}
		
				append output [punycode_encode_digit $q]
				set bias [punycode_adapt \
						  $delta [expr {$h + 1}] [expr {$h == $b}]]
				set delta 0
				incr h
			}
		}
		
		incr delta
		incr n
	}

	return $output;
}

proc ::http-title::punycode_adapt {delta numpoints firsttime} {
	set base 36
	set tmin 1
	set tmax 26
	set skew 38
	set damp 700
	
	set delta [expr {$firsttime ? $delta / $damp : $delta >> 1}]
	incr delta [expr {$delta / $numpoints}]
	
	for {set k 0} {$delta > (($base - $tmin) * $tmax) / 2}  {incr k $base} {
		set delta [expr {$delta / ($base - $tmin)}];
	}
	
	return [expr {$k + ($base - $tmin + 1) * $delta / ($delta + $skew)}]
}

proc ::http-title::punycode_encode_digit {d} {
	return [format %c [expr {$d + 22 + 75 * ($d < 26)}]]
}

## end of IDNA procs

proc ::http-title::fixCharset {charset} {
	set lcharset [string tolower $charset]
	switch -glob -nocase -- $charset {
		{utf-8} - {utf8} {
			set retval {utf-8}
		}
		{iso-*} {
			set retval [string map -nocase {{iso-} {iso}} $lcharset]
		}
		{windows-*} {
			set retval [string map -nocase {{windows-} {cp}} $lcharset]
		}
		{shift_jis*} {
			set retval [string map -nocase {{shift_jis} {shiftjis}} $lcharset]
		}
		{euc-*} {
			set retval $lcharset
		}
		default {
			set retval $charset
		}
	}
	if {[lsearch -exact [encoding names] $retval] == -1} {
		putlog "http-title.tcl error: unhandled charset \"$retval\". PLEASE REPORT THIS BUG!"
		return 1
	} else {
		return $retval
	}
}

proc ::http-title::pubm {nick uhost hand chan text {url {}} {referer {}} {cookies {}} {redirects {}}} {
	if {[channel get $chan {http-title}] && ([string match -nocase "*http://*" [set stext [stripcodes bcruag $text]]] || [string match -nocase "*https://*" $stext] || [string match -nocase "*www.*" $stext]) && [regexp -nocase -- {(?:^|\s)(https?://[^\s\\$]+|www.[^\s\\$]+)} $stext - url]} {
		# set nick suffix
		if {[string equal -nocase [string index $nick end] s]} { set suffix {'} } else { set suffix {'s} }
		if {![string match -nocase "http://*" $url] && ![string match -nocase "https://*" $url]} { set url "http://${url}" }
		# fix urls like http://domain.tld?foo
		regsub -nocase -- {(^https?://[^/?]+)(\?)} $url {\1/?} url
		# split the domain from the url
		regexp -nocase -- {(https?://)([^/]+)(.*)} $url - pre domain post
		# detect urls like http://-www.google.com, which will be seen as a flag by [socket]
		if {[string index $domain 0] eq {-}} { return }
		# handle internationalized domain names
		set url ${pre}[domain_toascii $domain]${post}
		# first, do a HTTP HEAD request, to get an idea of what we're dealing with
		if {[set wget [wget $url 1]] eq {}} {
			return
		} else {
			array set state $wget
		}
		# Grab the content-type
		foreach {name value} $state(meta) {
			if {[string equal -nocase {content-type} $name]} {
				set content-type [regsub -- {^([^\;]+)(\;.*)?} $value {\1}]
			}
		}
		# bail out if we couldn't get the content-type
		if {![info exists content-type]} {
			return
		}
		# if content-type isn't html, we stop here
		if {${content-type} ne {text/html}} {
			array set meta $state(meta)
			if {[info exists meta(Content-Length)]} {
				#putserv "PRIVMSG $chan :${nick}${suffix} URL title: N/A ( ${content-type}\; $meta(Content-Length) bytes )"
				return
			} else {
				putserv "PRIVMSG $chan :${nick}${suffix} URL title: N/A ( ${content-type}\; unknown size )"
			}
			return
		}
		
		# now we do the real HTTP request to get the actual data.
		if {[set wget [wget $url 0]] eq {}} {
			return
		} else {
			array set state $wget
		}
		if {$state(status) eq {ok}} {
			set data $state(body)
			# grab the charset from the HTTP headers
			if {[info exists state(charset)]} {
				if {[set headerEnc [fixCharset $state(charset)]] eq {1}} { return }
			#} elseif {[info exists ::http::defaultCharset] && $::http::defaultCharset ne {}} {
			#	set defaultHeaderEnc 1
			#	if {[set headerEnc [fixCharset $::http::defaultCharset]] eq {1}} { return }
			#} else {
			#	set defaultHeaderEnc 1
			#	set headerEnc {iso8859-1}
			}
			# grab the charset from the HTML <meta> tags
			if {[regexp -nocase -- {<meta [^>]*?charset="?([a-zA-Z0-9\-_]+)[^>]*>} $data - metaEnc]} {
				if {[set metaEnc [fixCharset $metaEnc]] eq {1}} { return }
				if {![string equal -nocase $headerEnc $metaEnc]} {
					# HTTP header charset & meta charset doesn't match, assume that meta is correct
					set data [encoding convertfrom [string tolower $metaEnc] $data]
				}
			}
			# No charset detected, or it defaulted to iso8859-1. Set some defaults based on TLD
			# FixMe: set ::http::defaultCharset to this instead, before ::http::geturl
			# FixMe: doesn't work if a site is redirecting to a tld we're overriding here, ie tinyurl redirecting to a broken .ru site
			if {($headerEnc eq {iso8859-1}) && ![info exists metaEnc] && [regexp -nocase -- {^https?://[^/?]+\.([^/?]+)(?:$|[/?]).*$} $url - tld]} {
				switch -exact -nocase -- $tld {
					{ru} { set data [encoding convertfrom {koi8-r} $data] }
					default {  }
				}
			}
			foreach {name value} $state(meta) {
				if {[string equal -nocase {content-type} $name]} {
					set content-type [regsub -- {^([^\;]+)(\;.*)?} $value {\1}]
				}
			}
			if {[regexp -nocase -- {<title>([^<]+)</title>} $data - title]} {
				# some sites like to put excessive whitespace in the middle of the title, so we get rid of it here.
				set title [join [regexp -inline -all -- {\S+} [::htmlparse::mapEscapes $title]]]
				# truncate titles that are too long
				if {[string length $title] > 350} {
					set title "[string range $title 0 350]..."
				}
				putserv "PRIVMSG $chan :${nick}${suffix} URL title: $title ( ${content-type}\; [string bytelength $data] bytes )"
			} else {
				putserv "PRIVMSG $chan :${nick}${suffix} URL title: N/A ( ${content-type}\; [string bytelength $data] bytes )"
			}
		}
	}
}

# recursive wget with cookies and referer
# mostly written by speechles
# made to actually work by me
proc ::http-title::wget {url validate {refer ""} {cookies ""} {re 0}} {
	http::config -urlencoding {utf-8}
	# if we have cookies, let's use em ;)
	if {![string length $cookies]} {
		catch {set token [http::geturl $url -validate $validate -timeout 3000]} error
	} else {
		catch {set token [::http::geturl $url -validate $validate -headers [list "Referer" "$refer" "Cookie" "[string trim [join $cookies {;}] {;}]" ] -timeout 3000]} error
	}
	# error condition 1, invalid socket or other general error
	if {![string match -nocase "::http::*" $error]} {
		putlog "Error: [string totitle [string map [list "\n" " | "] $error]] \( $url \)"
		return
	}
	# error condition 2, http error
	if {![string equal -nocase [::http::status $token] "ok"]} {
		putlog "Http error: [string totitle [::http::status $token]] \( $url \)"
		http::cleanup $token
		return
	}
	upvar #0 $token state
	# iterate through the meta array to grab cookies
	foreach {name value} $state(meta) {
		# do we have cookies?                                                           
		if {[regexp -nocase ^Set-Cookie$ $name]} {
			# yes, add them to cookie list                                                       
			lappend ourCookies [lindex [split $value {;}] 0]
		}
	}
	if {![info exists ourCookies]} {
		# if no cookies this iteration remember cookies from last
		if {[string length $cookies]} {
			set ourCookies $cookies
		} else {
			# we have no cookies at all
			set ourCookies {}
		}
	}
	# recursive redirect support, 300's
	# the full gambit of browser support, hopefully ... ;)
	if {[string match "*[http::ncode $token]*" "303|302|301" ]} {
		foreach {name value} $state(meta) {
			if {[regexp -nocase ^location$ $name]} {
				if {![string match "http*" $value]} {
					# fix our locations if needed
					if {![string match "/" [string index $value 0]]} {
						set value "[join [lrange [split $url {/}] 0 2] "/"]/$value"
					} else {
						set value "[join [lrange [split $url {/}] 0 2] "/"]$value"
					}
				}
				# catch redirect to self's. There is one rule:
				# A url can redirect to itself a few times to attempt to
				# gain proper cookies, or referers. This is hard-coded at 2.
				# We catch the 3rd time and poison our recursion with it.
				# This will stop the madness ;)
				# FixMe: I'm not so sure that this even works. The poison var should obviously be passed with the recursion
				if {[string match [string map {" " "%20"} $value] $url]} {
					if {![info exists poison]} {
						set poison 1
					} else {
						incr poison
						if {$poison > 2} {
							putlog "HTTP Error: Redirect error self to self \(3rd instance poisoned\) \( $url \)"
							return
						}
					}
				}
				# poison any nested recursion over 10 traversals deep. no
				# legitimate site needs to do this. EVER!
				if {[incr re] > 10} {
					putlog "HTTP Error: Redirect error (>10 too deep) \( $url \)"
					return
				}
				# recursive redirect by passing cookies and referer
				# this is what makes it now work! :)
				return [wget [string map {" " "%20"} $value] $validate $url $ourCookies $re]
			}
		}
	}
	# waaay down here, we finally check the ncode for 400 or 500 codes
	if {[string match 4* [http::ncode $token]] || [string match 5* [http::ncode $token]]} {
		putlog "Http resource is not evailable: [http::ncode $token] \( $url \)"
		return
	}
	# return the state array
	set retval [array get state]
	http::cleanup $token
	return $retval
}

namespace eval ::http-title {
	bind pubm - "*" ::http-title::pubm
	putlog "Loaded http-title.tcl v0.1 by Pixelz"
}
