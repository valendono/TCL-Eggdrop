# Code below modified from original. Credit can be found within
# the twitter script itself. All credit goes to it's original authors.
# You and me, know who these are if it includes either of us.
# v1.0alpha - Twitter Oauth - single token use
# * multiple accounts
# * minimal packages required.
# * tcl8.4 friendly.
# * dict/json not required.
# * All packages required provided.
# * works like rss on crack, other rss scripts wont do twitter this can. ;)
# - original credit to horgh/fedex
# - major rewrite done by speechles
# - oauth timestamp fix by thommey

# Incorrect signature, other errors pissing you off.
# Get the inside look at every oauth transaction via query
# set your debug nick here
set oauthdebug ""

# Is your bot set to the wrong timezone and you experience
# errors such as "timestamp out of bounds" or "used nonce"
# set this setting to 1 and change the oauth_time string below.
set oauth_usetime 0

# Use this to set your timezone on your bot. Most people
# should never need to change this. For FreeBSD you most
# likely will need to alter this.
set oauth_time "%Y-%m-%d %H:%M:%S %Z"

package provide OAuthSingle 1.0

# Multiple account wrapper. Single token use. No pin required.
proc proc:twitter:oauth {url method chan query} {
	global twitter
	set found [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]
	if {$found != -1} {
		set s [split [lindex $twitter(accts) $found] |]
		set c_tok [lindex $s 2]
		set c_sec [lindex $s 3]
		set o_tok [lindex $s 4]
		set o_sec [lindex $s 5]
		if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :oauth:query_api $url $c_tok $c_sec $method $o_tok $o_sec $query" }
		if {[catch {set reply [oauth:query_api $url $c_tok $c_sec $method $o_tok $o_sec $query]} error]} { error $error }
		return $reply
	}
}

# single query use. We can proceed directly to api requests.
# query_dict is POST request to twitter as before, key:value pairing (tcl-lists)
# oauth_token, oauth_token_secret from get_access_token
proc oauth:query_api {url consumer_key consumer_secret method oauth_token oauth_token_secret query_dict} {
	set params {}
	if {[catch {set result [oauth:query_call $url $consumer_key $consumer_secret $method $params $query_dict $oauth_token $oauth_token_secret]} error]} { error $error }
	return $result
}

# build header & query, call http request and return result
# params stay in oauth header
# sign_params are only used in base string for signing (optional) - tcl-lists
proc oauth:query_call {url consumer_key consumer_secret method params {sign_params {}} {token {}} {token_secret {}}} {
	lappend oauth_raw [list oauth_consumer_key $consumer_key]
	lappend oauth_raw [list oauth_nonce [oauth:nonce]]
	lappend oauth_raw [list oauth_signature_method HMAC-SHA1]
	if {$::oauth_usetime > 0 } {
		lappend oauth_raw [list oauth_timestamp [clock scan [clock format [clock seconds] -format $::oauth_time] -gmt 1]]
	} else {
		lappend oauth_raw [list oauth_timestamp [clock seconds]]
	}
	lappend oauth_raw [list oauth_token $token]
	lappend oauth_raw [list oauth_version 1.0]

	# variable number of params
	foreach param $params {
		lappend oauth_raw [list [lindex $param 0] [lindex $param 1]]
	}
	if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :oauth_raw $oauth_raw" }
	# second oauth_raw holds data to be signed but not placed in header
	set oauth_raw_sign $oauth_raw
	foreach param $sign_params {
		lappend oauth_raw_sign [list [lindex $param 0] [lindex $param 1]]
	}
	if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :oauth_raw_sign $oauth_raw_sign" }
	set signature [oauth:signature $url $consumer_secret $method [lsort $oauth_raw_sign] $token_secret]
	if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :signature $signature" }
	set oauth_raw [linsert $oauth_raw 2 [list oauth_signature $signature]]
	if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :oauth_raw $oauth_raw" }
	set oauth_header [oauth:oauth_header [lsort $oauth_raw]]
	if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :oauth_header $oauth_header" }
	set my_query ""
	foreach param [lsort $sign_params] {
		append my_query "[lindex $param 0]=[lindex $param 1]&"
	}
	set my_query [string trimright $my_query &]
	if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :my_query $my_query" }
	return [oauth:query $url $method $oauth_header $my_query]
}

# do http request with oauth header
proc oauth:query {url method oauth_header {query {}}} {
      #putserv "privmsg speechles :$url - $method - $oauth_header - $query"
	set header [list Authorization [concat "OAuth" $oauth_header]]
	::http::config -useragent "Mozilla/5.0 (Linux; U; Eggdrop) Birdy/20110610"
	if {[string equal -nocase "POST" $method] && [string length $query]} {
		catch { set token [http::geturl $url -headers $header -query $query -timeout 5000] } error
	} else {
		if {[string length $query]} {
			catch { set token [http::geturl $url?$query -headers $header -timeout 5000] } error
		} else {
			catch { set token [http::geturl $url -headers $header -timeout 5000] } error
		}
	}
	if {[string match -nocase "::http::*" $error]} {
		if {[string equal -nocase [set status [http::status $token]] "reset"]} {
			http::cleanup $token
			error "OAuth failed: Connection reset..."
		}
		if {![string length [set ncode [http::ncode $token]]]} { set ncode "???" }
		if {[string match "5*" $ncode]} {
			error "OAuth fail whale: Wait a bit, or find a Japanese fishing vessel. HARPOON! (code: $ncode)"
		}
		set data [http::data $token]
		http::cleanup $token
		if {$ncode != 200} {
			set erta [list] ; # if {[string match *\\n* $data]} { set data "[lindex [split [string map [list \\n \n] $data] "\n"] 0]\}" }
			set junk [split [string map -nocase [list \" ""] [join $data]] ,]
			foreach name $junk {
				lappend erta [string map [list ":" ": " "\\" ""] [string totitle $name]]
			}
			if {[llength $erta]} { 
				error "OAuth failed: ($ncode) [join [lsort -dictionary $erta] {; }] ( $status )"
			} else {
				error "OAuth failed: ($ncode) Unknown problem... No reason given...( $status )"
			}
		}
	} else {
		error "OAuth failed: (???) [join [split $error "\n"] {; }] ( internal error )"
	}
	return $data
}

# take a tcl-list of params and create as follows:
# create string as: key="value",...,key2="value2"
proc oauth:oauth_header {params} {
	set header {}
	foreach param $params {
		lappend header [oauth:uri_escape [lindex $param 0]]=\"[oauth:uri_escape [lindex $param 1]]\"
	}
	return [join $header ","]
}

# take tcl-list of params and create as follows
# sort params by key
# create string as key=value&key2=value2...
# TODO: if key matches, sort by value
proc oauth:params_signature {params} {
	foreach item [lsort $params] {
		lappend lis [lindex $item 0]=[lindex $item 1]
	}
	
	return [join ${lis} "&"]
}

# build signature as in section 9 of oauth spec
# token_secret may be empty
proc oauth:signature {url consumer_secret method params {token_secret {}}} {
	# We want base URL for signing (remove ?params=...)
	if {[string length $params]} { set url [lindex [split $url "?"] 0] }
	set base_string [oauth:uri_escape ${method}]&[oauth:uri_escape ${url}]&[oauth:uri_escape [oauth:params_signature $params]]
	if {[string length $::oauthdebug]} { putserv "privmsg $::oauthdebug :base-string $base_string" }
	set key [oauth:uri_escape $consumer_secret]&[oauth:uri_escape $token_secret]
	set signature [sha1::hmac -bin -key $key $base_string]
	return [base64::encode $signature]
}

proc oauth:nonce {} {
	set nonce [clock clicks][rand 10000]
	return [sha1::sha1 $nonce]
}

# wrapper around http::formatQuery which uppercases octet characters
proc oauth:uri_escape {str} {
	set str [http::formatQuery $str]
	# uppercase all %hex where hex=2 octets
	set str [regsub -all -- {%(\w{2})} $str {%[string toupper \1]}]
	return [subst $str]
}