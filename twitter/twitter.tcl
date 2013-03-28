# Birdy for eggdrop - v5.05c
# (also known as)
# Twitter, Tweets with Megahal (Egghelp version)
# Original concept and script by Warlord
# Super-Action rocket missles provided by speechles..
# This script has been modifed and update by dono
# If you like this script donate to slennox@egghelp.org

# Terms and Agreements of use
# ------
# You assume all rights, responsibility, and consequences
# which may arise from using this script. I as copyleft
# holder only assume right to title, it is the burden
# of copyleft title user to guarantee reponsible use
# of this twitter application. Failure to do so may, and
# may not result in the suspension/deletion of your
# twitter account. Using this script signifies reading
# of this, the copyright notice below, and the disclaimer
# found directly below the copyright notice... read on...
# ------
# Copyleft (C) 2010-2011 - speechles (imspeechless@gmail.com)
# v5.05c - August 29th, 2011 -
# speechles (#roms-isos@efnet) *copyleft = gnu gpl v3
# ------
# Version 4.x Disclaimer: -- IMPORTANT: PLEASE READ --
# This is merely an experimental release to support irc channel
# banter as well as the presence of the artificial intelligence
# known as megahal onto twitter. This is not to be taken
# as some sort of tool of which to spam and cause havoc for
# twitter. This is to further our reach as irc users into
# the medium which alot of users seem to be using today. But..
# using this script the format will stick to our standard irc
# look and feel. This allows irc users to reach out beyond their
# irc channels into a broader medium which may attract them a
# larger userbase. This was not designed as a tool to use to
# spam twitter. Yes, I repeated that and I may do so again
# shortly. Don't spam with this, be responsible. Now a bit about
# the config section. Make sure you've read it completely. Leaving
# the settings default leaves everything turned on. If you don't
# use megahal disable it in the script to assure it's off. If you
# have questions find the thread on egghelp and compose them
# as a post to that thread. This requires you make a username on
# that forum to do so which assures me you're not asking for
# your modifications to support some nefarious intent.
# ------
#
# REMEMBER TO MAKE THIS WORK IN YOUR CHANNEL:
# Type in partyline: ".chanset #yourchannel +twitter"
# FOR MEGAHAL TO REPLY TO USERS WITHIN YOUR CHANNELS ACCOUNT:
# Type in partyline: ".chanset #yourchannel +twittermega"
# FOR @MENTIONS TO WORK:
# Type in partyline: ".chanset #yourchannel +twittermentions
# FOE MEGAHAL TO REPLY TO @MENTIONS:
# Type in partyline: ".chanset #yourchannel +twittermentionsmega"
# FOR FRIENDS TIMELIMES TO WORK:
# Type in partyline: ".chanset #yourchannel +twitterfriends"
# FOR TRACKING SEARCH TIMELINES TO WORK:
# Type in partyline: ".chanset #yourchannel +twittertrack"
#
# 
#  I  M  P  O  R  T  A  N  T         D O  N O T  S K I P !
#
#  R  E  A  D    B  E  L  O  W    C  A  R  E  F  U  L  L  Y
#
# TO USE THIS SCRIPT YOU MUST REGISTER AN APPLICATION AT:
# http://dev.twitter.com to attain your consumer credentials.
# After getting your consumer key and secret, you will need
# to check the [my tokens] button on the right side of your
# applications page when it is showing your consumer key.
# This will take you to your single use tokens containing
# your Access_token_key and Access_token_sercet. These will now
# be used along with your username to authenticate you
# with twitter. This is known as OAuth. Your rate will now be
# 350 requests per hour for each account you add. This increases
# greately from the 150 per hour under basic authentication.
# Enjoy.
#
# OAUTH.TCL
# Portions of oauth.tcl are part of the original
# package found at the url below:
# http://github.com/horgh/twitter-tcl -> oauth.tcl
# Original credit to horgh/fedex
# Major rewrite done by speechles
# 
# -----
# --> config begins

# 1) --> GENERAL SETTINGS <--

# This is the twitter logo.
# (string)
set twitter(logo) "\[\002\00311T\002\003]"

# Set user agent.
# (string)
set twitter(agent) "Mozilla/4.75 (X11; U; Linux 2.2.17; i586; Nav)"

# Set the url base
# (string)
set twitter(url) "http://twitter.com/"

# Set the output style here:
# %chan == $chan, %nick == $nick
# no other variables can be used
# (string)
set twitter(output) "PRIVMSG %chan"

# What effect would you like added to twitter numerics?
# for example:
# effect on "\00304" is red text
# effect off "\003" turns off the color
# (strings)
set twitter(effect-on) "\002"
set twitter(effect-off) "\002"

# how many seconds should each user wait before re-issuing
# a twitter command? Set this in seconds.
# (0 off/1 on)
set twitter(throttle) 1

# If you have Trf or zlib packages detectable, this script
# will let you use gzip to speed up your twittering..
# Would you like to enable gzip auto-detection?
# (0 off/1 on)
set twitter(use_gzip) 1

# 2) --> URLS <--

# Url to issue tweets to - json is fine
# you should never need to change this.
# (string)
set twitter(tweet) "http://api.twitter.com/1/statuses/update.json"
set twitter(private_new) "http://api.twitter.com/1/direct_messages/new.json"
set twitter(follow) "http://api.twitter.com/1/friendships/create.json"
set twitter(unfollow) "http://api.twitter.com/1/friendships/destroy.json"
set twitter(followers) "http://api.twitter.com/1/statuses/followers.json"
set twitter(followers_new) "http://api.twitter.com/1/followers/ids.json"
set twitter(users_show) "http://api.twitter.com/1/users/lookup.json"
set twitter(following) "http://api.twitter.com/1/statuses/friends.json"
set twitter(following_new) "http://api.twitter.com/1/friends/ids.json"
set twitter(private_destroy) "http://api.twitter.com/1/direct_messages/destroy.json"
set twitter(tweet_destroy) "http://api.twitter.com/1/statuses/destroy/%id%.json"
set twitter(retweet) "http://api.twitter.com/1/statuses/retweet/%id%.json"
set twitter(retweets_of_me) "http://api.twitter.com/1/statuses/retweets_of_me.json"
set twitter(retweets_to_me) "http://api.twitter.com/1/statuses/retweeted_to_me.json"
set twitter(retweets_by_me) "http://api.twitter.com/1/statuses/retweeted_by_me.json"



# timelines - xml is far easier to parse...
# you should never need to change these either.
# (strings)
# deprecated -- set twitter(friends) "http://api.twitter.com/1/statuses/friends_timeline.json"
set twitter(friends) "http://api.twitter.com/1/statuses/home_timeline.json"
set twitter(public) "http://api.twitter.com/1/statuses/public_timeline.json"
set twitter(user) "http://api.twitter.com/1/statuses/user_timeline.json"
# deprecated --  set twitter(userxml) "http://www.twitter.com/statuses/user_timeline.xml"
set twitter(userxml) "http://api.twitter.com/1/statuses/user_timeline.xml" 
set twitter(home) "http://api.twitter.com/1/statuses/home_timeline.json"
set twitter(mention) "http://api.twitter.com/1/statuses/mentions.json"
# deprecated -- set twitter(mentionxml) "http://www.twitter.com/statuses/mentions.xml"
set twitter(mentionxml) "http://api.twitter.com/1/statuses/mentions.xml"
set twitter(private) "http://api.twitter.com/1/direct_messages.json"
set twitter(private_sent) "http://api.twitter.com/1/direct_messages/sent.json"
set twitter(rate) "http://api.twitter.com/1/account/rate_limit_status.json"
set twitter(search) "http://search.twitter.com/search.json"

# 3) --> ADVANCED SETTINGS <--

# Set the global tweet format here
# if no local tweet format is set in the channel acct list below
# then the global setting will be used instead.
# %nick = $nick
# %chan = $chan
# %text = user input
# %modes = (+ or @) op or voice only presently...
# (string)
set twitter(globaltweetformat) "%nick %text"

# How do you want to handle /me actions done in tweets?
# Put the trigger word that will denote this below.
# (string)
set twitter(me) "/me"

# URL/Link's are now "automatically" shortened within your tweets
# set below the length of url's that will be shortened. The best range
# for this is 12-20, but this also depends on which shortener method
# you also choose in the option below this. Experiment. If you set
# this below 12 you will experience problems.
# (integer)
set twitter(shorten) 12

# which method should be used when shortening the url?
# (0-1) will only use the one you've chosen.
# (2-3) will use them all.
# 0 --> http://is.gd
# 1 --> http://cli.gs
# 2 --> randomly select one of the two above ( 1,0,0,1,1..etc )
# 3 --> cycle through the two above ( 0,1,0,1,0,1..etc )
# 4 + > return normal url
# (integer)
set twitter(shorten_type) 0

# how should short url's be prefixed?
# 0 - http:// -- cost is 7 characters
# 1 - www. -- cost is 4 characters
# You are only allowed 140 characters on twitter. The costs shown
# above are indicators of how much of these 140 characters will
# be used for every url.
# (0-1)
set twitter(short_type) 0

# minimum flags required to issue tweets
# (string)
set twitter(flags) "vogmn|vogmn"

# what modes can people temporarily tweet with
# these are channel modes, not flags on the bot
# you can use op, voice, or both, or "".
# (list)
set twitter(channel) [list "op" "voice"]

# Do you want @mentions within tweets to always
# be arranged at the front of the tweet?
# <nick> !tweet @fred this is kewl @mike do you agree?
# is autoarranged like below before !tweeting...
# @fred @mike <nick> this is kewl do you agree?
# (0 no/1 yes)
set twitter(autoarrange) 0

# Use this to fix timestamp durations and correct
# issues synching your time to twitter's GMT time.
# Enter the seconds offset required below, to disable
# set this to 0. This is useful for Daylight savings 
# time adjustments, as well as other issues.
# Use either a Positive, or -Negative offset.
# (integer)
set twitter(fixMyDuration) "0"

# Split tweets with newlines into multi-line tweets?
# Without this set to 1, ascii art tweets will not
# show correctly.
# (0 no/1 yes)
set twitter(newline) 1

# Allow newlines in tweets? With this, you can create
# multi-line tweets on IRC by using \n to seperate
# each line.
# (0 no/1 yes)
set twitter(allow_newlines) 1

# Interval in which to check for lost or new followers?
# (time string)
set twitter(followerstimestring) [list "?0*" "?5*"]

# 4) --> ACCOUNTS SETTINGS <--

# Accts to tweet to
# "#channel|Login|Consumer_key|Consumer_secret|Access_token|Access_token_secret[|tweet-format]"
# --
# Channel name here uses lowercase, your actual
# channel case is irrevelant. But here you must
# use lowercase only
# --
# tweet-format is entirely optional and used as
# an optional local over-ride. If no tweet-format
# is given the globaltwitterformat will be used.
# --
# 	
# (list)
set twitter(accts) {
#	"#chan3|acct3|consumer_key3|consumer_secret3|access_token_key3|access_token_secret3"
}

# 5) --> PROFILE SETTINGS <--

# If you have megahal enabled, then you might want
# to set the below option to 1. With this set you
# can then use the chanset command:
# .chanset #yourchan +twittermega
# Now your bot will reply to twitter messages at
# set intervals just to keep your account active if
# users aren't posting. The bot will not post to the
# account if it was the last one to post.
# (0 off/1 on)
set twitter(megahal) 1

# If your using megahal on your twitter for reply
# tweets to your users, what timestring interval
# would you like to use? The default string of
# "?0*" will check if it can reply every
# 10 minutes, at exactly minutes ending with 0.
# (list of timestrings)
#set twitter(timestring) [list "?2*" "?4*" "?6*" "?8*" "?0*"]
set twitter(timestring) [list "*"]

# do you want the bot to putlog when it's made
# replies? a setting of 1 will post it has in
# the channel associated to your account.
# (it will only announce in the first channel  )
# (linked to your account. if multiple channels)
# (are used it won't display it's replied there)
# (this would be too spammy and floody...      )
# (0 channel/1 putlog)
set twitter(silent) 0

# This is a megahal function, if you do not use
# megahal set this to 0. do you want your bot to
# learn from twitter tweets from users?
# (0 no/1 yes)
set twitter(learn) 1

# 6) --> FRIENDS SETTINGS <--

# Do you want new timelines from friends to be relayed
# directly to IRC when they occur?
# (0 no/1 yes)
set  twitter(usefriends) 1

# max amount of timelines to show in channel for each user
# request, thisis the amount of lines you wish to see for
# every request.
# (integer, preferably less than 5 or 6 or it's spammy)
set twitter(friendmax) 4

# set the limit of new friend timelines the bot will show
# in channel when channel is set +twitterfriends
# (integer)
set twitter(friendlimit) 10

# set the time interval to check for new timelines from
# friends for each acct above? The default string of "?7*"
# will check if it can reply every 10 minutes, at
# exactly minutes ending with 7. This is so it doesn't
# collide with other timers which posts to users
# using !tweet and relay @mentions.
# (list of time strings)
#set twitter(friendstimestring) [list "?2*" "?4*" "?6*" "?8*" "?0*"]
set twitter(friendstimestring) [list "*"]

# 7) --> MENTIONS SETTINGS <--

# Do you want @mentions to be relayed directly
# to IRC when they occur?
# (0 no/1 yes)
set  twitter(usementions) 1

# if your using megahal would you like your bot
# to also reply to your @mentions?
# (0 no/1 yes)
set twitter(usemegareply) 1

# This is a megahal function, if you do not use
# megahal set this to 0. Do you want your bot to
# learn from @mentions other users send it?
# (0 no/1 yes)
set twitter(mentionlearn) 1

# set the time interval to check for new @mentions
# for each acct above? The default string of "?5*"
# will check if it can reply every 10 minutes, at
# exactly minutes ending with 5. This is so it doesn't
# collide with the timer above which posts to users
# using !tweet.
# (list of time strings)
#set twitter(mentiontimestring) [list "?1*" "?3*" "?5*" "?7*" "?9*"]
set twitter(mentiontimestring) [list "*"]

# set the limit of new @mentions to relay directly to
# channel each time cycle, if usemegareply is enabled
# your bot will also reply to these. ;)
# (integer)
set twitter(mentionlimit) 4

# do you want the bot to putlog when the accounts
# mentions are gathered and/or megahal replies?
# a setting of 0 will post these in the channel
# associated to your account.
# (it will only announce in the first channel  )
# (linked to your account. if multiple channels)
# (are used it won't display it's replied there)
# (this would be too spammy and floody...      )
# (0 channel/1 putlog)
set twitter(mentionsilent) 0

# 8) --> TRACK SETTINGS <--

# do you want to use search word tracking?
# this allows you to track search terms in real time
# into your irc channel. Think of it like being able
# to +follow search terms.
set twitter(usetracking) 1

# set the limit of new track announces you wil see
# each update cycle.
set twitter(tracklimit) 4

# set the time interval to check for new search items
# you are tracking.
set twitter(tracktimestring) [list "*"]

# 9) --> SAVE SETTINGS <--

# What filename should we save timelines and serivces
# to during rehash and using the timestring found
# below this?
# (string)
set twitter(filesave) "twitter.dat"

# set the time interval to save timelines and services
# for every account. The default string of "30*" "00*" will
# save every 30 minutes. It will also be saved at
# every rehash.
# (list of time strings)
set twitter(autosavetimestring) [list "30*" "00*"]

# 10) --> DISPLAY SETTINGS <--

# Here you set up your display options for some of the
# messages which are shown most often. Feel free to
# customize these. Below are the list of acceptable
# tokens:
#
# TOKEN - FUNCTION / DESCRIPTION
# %pos% - restapi / position of timeline showing
# %len% - restapi / amount of timeline showing
# %created% - many / duration ago of tweet
# %source% - many / source of tweet
# %id% - many / timeline msg-id of tweet
# %screen% - restapi / screen name of user
# %user% - many / username of account
# %chan% - many / channel of account
# %name% - restapi / real name of user
# %trunc% - tweet / reply-to and/or truncated tweet message
# %text% - restapi / text of tweet
# %replyid% - restapi / timeline msg-id of tweet replied to
# %replyname% -  restapi / username of user replied to
# %end% - restapi / end of displayable list
# %start% - restapi / start of displayable list
# %type% - restapi / type of restapi event called
# %who% - restapi / username used in restapi event
# %url% - restapi / url given if username restapi event
# %nick% - mention / username tweeting the mention
# %reply% - mention / bot's reply to @mention tweet
# %output% - followers / list of new/lost followers
# %acct% - followers / screen name of account
# %current% - followers / number of current usernames following
#
# Some of these WILL NOT work when added incorrectly. The below are meant to be used as examples.
# Do NOT delete them, comment them so you know which %tokens% can be used in each display element.
# (strings)
set twitter(tweet-display) "Tweet created: http://twitter.com/%user%%trunc% ( %id%@%user% - %created% via %source% )"
set twitter(private-display) "Direct message created: http://twitter.com/%user%%trunc% ( %id%@%user% - %created% via %source% )"
set twitter(retweet-display) "ReTweet created: http://twitter.com/%user% ( %retweetid%@%retweetscreen% -> %id%@%user% - %created% via %source% )"
#set twitter(restapi-display) "(%pos%/%len%) %created% via %source% (%id%@%screen%) (%name%): %text%"
set twitter(restapi-display) "\002%name%\002: %text%\017 ( %id%@%screen% - %created% via %source% )"
set twitter(restapi-display-cont) "\002%name%\002: %text%"
#set twitter(restapi-display-reply) "(%pos%/%len%) %created% via %source% (%id%@%screen% to %replyid%@%replyname%) (%name%): %text%"
set twitter(restapi-display-reply) "\002%name%\002: %text%\017 ( %id%@%screen% to %replyid%@%replyname% - %created% via %source% )"
set twitter(restapi-display-reply-cont) "\002%name%\002: %text%"
#set twitter(restapi-display-title) "\[%end%-%start%\] %type% timelines (%chan%@%user%):"
set twitter(restapi-display-title) "( %end%-%start%\ ) %type% timelines ( %chan%@%user% ):"
#set twitter(restapi-display-title-user) "\[%end%-%start%\] %type% timelines (%user%) @ %url% :"
set twitter(restapi-display-title-user) "( %end%-%start% ) %type% timelines ( %user% ) %url% :"
#set twitter(mention-display) "(Megahal) @Mention: %nick%: %text% (%id%@%screen% %created%)"
set twitter(mention-display) "\002%nick%\002: %text%\017 ( %id%@%screen% - %created% via %source% )"
set twitter(mention-display-cont) "\002%nick%\002: %text%"
#set twitter(mention-display-nomega) "@Mention: %nick%: %text% (%id%@%screen% %created%)"
set twitter(mention-display-nomega) "\002%nick%\002: %text%\017 ( %id%@%screen% - %created% via %source% )"
set twitter(mention-display-nomega-cont) "\002%nick%\002: %text%"
#set twitter(mention-display-megahal) "(Megahal) %bot% replied: %reply%"
set twitter(mention-display-megahal) "\002%bot%\002 replied: %reply%"
#set twitter(search-display) "(%pos%/%len%) %created% via %source% (%id%@%screen%): %text%"
set twitter(search-display) "\002%screen%\002: %text%\017 ( %id%@%screen% - %created% via %source% )"
set twitter(search-display-cont) "\002%screen%\002: %text%"
set twitter(track-display) "\002%screen%\002: %text%\017 ( %id%@%screen% - %created% via %source% )"
set twitter(track-display-cont) "\002%screen%\002: %text%"
set twitter(follow-message) "\002%current%\002 users now following! You can too @ http://twitter.com/%acct% ! Follow us at %chan%!"
set twitter(follow-new) "\002New followers\002: %output%"
set twitter(follow-lost) "\002Lost followers\002: %output%"
# <-- script begins

# the binds, change these if you want to
bind pub - !twitter proc:twitter
bind pub - !tweet proc:tweet
bind pub - !private proc:private
bind pub - !myfriends proc:twitter:friends
bind pub - !myprofile proc:twitter:user
bind pub - !myhome proc:twitter:home
bind pub - !public proc:twitter:public
bind pub - !mymentions proc:twitter:mentions
bind pub - !mymessages proc:twitter:messages
bind pub - !myprivates proc:twitter:privates
bind pub - !tsearch proc:twitter:search
bind pub - !user proc:twitter:user2
bind pub - !rate proc:twitter:rate
bind pub - +follow [list proc:twitter:dofollow "follow"]
bind pub - -follow [list proc:twitter:dofollow "unfollow"]
bind pub - +service [list proc:twitter:service "Added"]
bind pub - -service [list proc:twitter:service "Removed"]
bind pub - !services  [list proc:twitter:service ""]
bind pub - !friends [list proc:twitter:restlist "following"]
bind pub - !followers [list proc:twitter:restlist "followers"]
bind evnt - prerehash proc:twitter:save
bind pub - +app [list proc:twitter:apps "Added"]
bind pub - -app [list proc:twitter:apps "Removed"]
bind pub - !apps  [list proc:twitter:apps ""]
bind pub - +track [list proc:twitter:track "Added"]
bind pub - -track [list proc:twitter:track "Removed"]
bind pub - !track  [list proc:twitter:track ""]
bind pub - !RTofme proc:twitter:rtome
bind pub - !RTbyme proc:twitter:rtbme
bind pub - !RTtome proc:twitter:rttme
bind pub - !RT proc:twitter:retweet

# add megahal for fun.. ;)
if {$twitter(megahal) > 0 } {
	foreach bind $twitter(timestring) {
		bind time - "$bind" proc:twitter:megahal
	}
}
# add mentions
if {$twitter(usementions) > 0 } {
	foreach bind $twitter(mentiontimestring) {
		bind time - "$bind" proc:twitter:megahal:privatereply
	}
}
# add friends
if {$twitter(usefriends) > 0 } {
	foreach bind $twitter(friendstimestring) {
		bind time - "$bind" proc:twitter:friendsauto
	}
}

# add tracking
if {$twitter(usetracking) > 0 } {
	foreach bind $twitter(tracktimestring) {
		bind time - "$bind" proc:twitter:trackauto
	}
}

# add autosave
foreach bind $twitter(autosavetimestring) {
	bind time - "$bind" proc:twitter:save
}

# add followers tracking
foreach bind $twitter(followerstimestring) {
	bind time - "$bind" proc:twitter:followers:auto
}


# Chanset command flags
setudef flag twitter
setudef flag twittermega
setudef flag twittermentions
setudef flag twittermentionsmega
setudef flag twitterfriends
setudef flag twittertrack
setudef flag twitterfollowers

# load old twitter.dat if it exists, this will load any saved timelines and services at each restart
if {[file exists $twitter(filesave)]} {
	source $twitter(filesave)
}

# check if http version 2.5 or greater is used
# if so, we can use utf-8 features, otherwise
# fall back to standard iso8859-1
if {[catch {package require http 2.5} e] != 0} {
	set twitter(noutf8) 1
	package require http
}

if {[catch {package require OAuthSingle} e] !=0} {
	die "Twitter.tcl requires the OAuthSingle package (oauth.tcl) loaded FIRST. Terminating..."
}

proc proc:private {nick uhost hand chan text} {
	proc:tweet $nick $uhost $hand $chan "-d $text"
}

proc proc:twitter:rate {nick uhost handle chan text} {
	if {![channel get $chan twitter]} { return }
	global twitter
	# does the user have temporary access to add services?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	# do they have flags required to add services?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to check rate-limits in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[set pos [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]] == -1} {
		putserv "$to :$twitter(logo) There isn't any twitter account listed for $chan."
		return
	} else {
		set tuser [lindex [split [lindex $twitter(accts) $pos] |] 1]
	}
	if {[info exists twitter(base64)]} {
		putserv "$to :$twitter(logo) Cannot find package (base64). Base64 encoding is required. Failed."
		return
	}
	if {[catch {set html [proc:twitter:oauth $twitter(rate) GET $chan ""]} error]} { putserv "$to :$twitter(logo) $error" ; return }
	if {[info exists state(charset)]} {
		set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
	} else {
		set twitter(charset) "utf-8"
	}
	set html [proc:twitter:encode $html]
	if {[string match "*error*" $html]} {
		set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
		putserv "$to :$twitter(logo) $text"
	} else {
		if {[regexp -nocase {"photos":(.*?)\}} $html - pl]} {
			regsub -nocase {"photos":.*?\}} $html - html
			regexp -nocase {"daily_limit"\:(.*?)(\}|,)} $pl - pli
			regexp -nocase {"reset_time":"(.*?)"} $pl - pt
			regexp -nocase {"remaining_hits":(.*?)($|,)} $pl - ph
			set ptis [duration [expr {[proc:twitter:duration $pt 1] - ([clock seconds] - $::twitter(fixMyDuration))}]]
		}
		regexp -nocase {"hourly_limit"\:(.*?)(\}|,)} $html - hl
		regexp -nocase {"reset_time":"(.*?)"} $html - rt
		regexp -nocase {"remaining_hits":(.*?)(\}|,)} $html - rh
		set rtis [duration [expr {[proc:twitter:duration $rt 1] - ([clock seconds] - $::twitter(fixMyDuration))}]]
		putserv "$to :$twitter(logo)Rate-Info ($chan@$tuser): Total/Hits/Remaining \002$hl/[expr {$hl-$rh}]/$rh\002. Next reset occurs in $rtis ($rt)"
 		if {[info exists pli]} { 
               putserv "$to :$twitter(logo)Rate-Photo ($chan@$tuser): Total/Hits/Remaining \002$pli/[expr {$pli-$ph}]/$ph\002. Next reset occurs in $ptis ($pt)"
            }
            putserv $text
	}
}

proc proc:twitter:dofollow {type nick uhost handle chan text} {
	if {![channel get $chan twitter]} { return }
	global twitter
	# does the user have temporary access to add services?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	set type [string tolower $type]
	# do they have flags required to add services?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to use $type in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[set pos [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]] == -1} {
		putserv "$to :$twitter(logo) There isn't any twitter account listed for $chan."
		return
	} else {
		set tuser [lindex [split [lindex $twitter(accts) $pos] |] 1]
		set tpass [lindex [split [lindex $twitter(accts) $pos] |] 2]
	}
	if {[string length $type] && ![string length $text]} {
		putserv "$to :$twitter(logo) You must specify an @username you want to $type for $chan."
		return
	}
	if {[info exists twitter(base64)]} {
		putserv "$to :$twitter(logo) Cannot find package (base64). Base64 encoding is required. Failed."
		return
	}
	set other "screen_name=[string trim [string map {" " "_"} $text]]"
	#set q [list [list "screen_name" "[string trim [string map {" " "_"} $text]]"]]
	set q [list [list "screen_name" "[oauth:uri_escape [string trim $text]]"]]
	if {[catch {set html [proc:twitter:oauth $twitter($type) POST $chan $q]} error]} { putserv "$to :$twitter(logo) $error" ; return }
	#catch {set http [::http::geturl "$twitter($type)" -query "screen_name=[string trim [string map {" " "_"} $text]]" -headers [list "Authorization" "Basic $auth"] -timeout 10000]} error

	if {[info exists state(charset)]} {
		set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
	} else {
		set twitter(charset) "utf-8"
	}
	set html [proc:twitter:encode $html]
	if {[string match "*error*" $html]} {
		set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
		putserv "$to :$twitter(logo) $text"
	} else {
		regexp -nocase {"name"\:"(.*?)"} $html - n
		regexp -nocase {"screen_name"\:"(.*?)"} $html - a
		if {[regexp -nocase {"friends_count"\:(.*?)\,"} $html - s]} { set s "$s Friends" } { set s "" }
		if {[regexp -nocase {"followers_count"\:(.*?)\,"} $html - f]} { set f "\; $f Followers" } { set f "" }
		putserv "$to :$twitter(logo) Successful [string totitle $type]: \[[proc:twitter:descdecode [proc:twitter:descdecode $n]]@$a\] \($s$f) @ http://twitter.com/$a"
	}
}

proc proc:twitter:duration {date {value 0}} {
      if {![string equal "2" $value]} {
		if {[catch { set newdate [join [lrange [lreplace [split $date] 4 4] 1 end]] } me]} { return $date }
	} else {
		if {[catch { set newdate [join [lrange [lreplace [split $date] 5 5] 1 end]] } me]} { return $date }
	}
	if {$value ==1} { return [clock scan "$newdate" -gmt 1] }
	set ago [duration [expr {[clock seconds] - [clock scan "$newdate" -gmt 1] - $::twitter(fixMyDuration)}]]
	set ago [string map {" years " "y, " " year " "y, " " weeks" "w, " " week" "w, " " days" "d, " " day" "d, " " hours" "h, " " hour" "h, " " minutes" "m, " " minute" "m, " " seconds" "s, " " second" "s,"} $ago]
	return "[string trim $ago ", "] ago"
}

proc proc:twitter:followers:auto {args} {
	global twitter
	foreach entry $::twitter(accts) {
		set part [split $entry |]
		set chan [lindex $part 0]
		set tuser [lindex $part 1]
		if {![channel get $chan twitter] || ![channel get $chan twitterfollowers]} { continue }
		set to [string map [list "%chan" $chan] $::twitter(output)]
		if {![info exists ::twitter($tuser,followers)]} {
			set ::twitter($tuser,followers) [list]
		}
		if {[info exists acs]} {
			if {[lsearch -exact $acs [string tolower $tuser]] != -1} { continue }
		}
		lappend acs [string tolower $tuser]
		set q ""
		if {[catch {set html [proc:twitter:oauth $::twitter(followers) GET $chan $q]} error]} { putlog "$::twitter(logo) $error" ; return }
		if {[info exists state(charset)]} {
			set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
		} else {
			set twitter(charset) "utf-8"
		}
		set html [proc:twitter:encode $html] ; set newf [list] ; set lostf [list] ; set current [list]
		if {[string match "*\"error*" $html]} {
			set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
			putserv "$to :$::twitter(logo) $text"
		} else {
			set thelist [regexp -all -inline {"screen_name"\:"(.*?)"} $html]
			foreach {j s} $thelist {
				lappend current $s
			}
			foreach entry $current {
				if {[lsearch -exact $::twitter($tuser,followers) $entry] == -1} { lappend newf $entry }
			}	
			foreach entry $::twitter($tuser,followers) {
				if {[lsearch -exact $current $entry] == -1} { lappend lostf $entry }
			}
			if {[llength $newf]} {
				set out [list]
				foreach entry $newf {
					lappend out $entry
					if {[llength $out] > 19} {
						set out [string map [list %output% "[join $out ", "]"] $twitter(follow-new)]
						putserv "$to :$out"
			 			set out [list]
					}
				}
				set out [string map [list %output% "[join $out ", "]"] $twitter(follow-new)]
				if {[llength $out]} { putserv "$to :$out" }
			}
			if {[llength $lostf]} {
				set out [list]
				foreach entry $lostf {
					lappend out $entry
					if {[llength $out] > 19} {
						set out [string map [list %output% "[join $out ", "]"] $twitter(follow-lost)]
						putserv "$to :$out"
						set out [list]
					}
				}
				if {[llength $out]} {
					set out [string map [list %output% "[join $out ", "]"] $twitter(follow-lost)]
					putserv "$to :$out"
				}
			}
			set follow [string map [list %chan% $chan %acct% $tuser %current% [llength $current]] $twitter(follow-message)]
			if {[llength $lostf] || [llength $newf]} { putserv "$to :$follow" }
			set ::twitter($tuser,followers) $current
		}
	}
}
	
proc proc:twitter:restlist {type nick uhost handle chan text {auto 0}} {
	if {![channel get $chan twitter]} { return }
	global twitter
	# does the user have temporary access to add services?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	set type [string tolower $type]
	# do they have flags required to add services?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to use $type in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[set pos [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]] == -1} {
		putserv "$to :$twitter(logo) There isn't any twitter account listed for $chan."
		return
	} else {
		set tuser [lindex [split [lindex $twitter(accts) $pos] |] 1]
		set tpass [lindex [split [lindex $twitter(accts) $pos] |] 2]
	}
	if {[info exists twitter(base64)]} {
		putserv "$to :$twitter(logo) Cannot find package (base64). Base64 encoding is required. Failed."
		return
	}
	set q ""
	if {[catch {set html [proc:twitter:oauth $twitter($type) GET $chan $q]} error]} { putserv "$to :$twitter(logo) $error" ; return }
	#catch {set http [::http::geturl "$twitter($type)" -headers [list "Authorization" "Basic $auth"] -timeout 10000]} error

	if {[info exists state(charset)]} {
		set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
	} else {
		set twitter(charset) "utf-8"
	}
	set html [proc:twitter:encode $html]
	if {[string match "*\"error*" $html]} {
		set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
		putserv "$to :$twitter(logo) $text"
	} else {
		set thelist [regexp -all -inline {"screen_name"\:"(.*?)"} $html]
		set count 0
		foreach {j s} $thelist {
			lappend out $s
			if {[llength $out] > 19} {
				putserv "$to :$twitter(logo) \[$chan@$tuser\] ($type): [join $out ", "]"
				set out [list]
			}
		}
		if {[llength $out]} { putserv "$to :$twitter(logo) \[$chan@$tuser\] ($type): [join $out ", "]" }
	}
}

proc proc:twitter:trackauto {args} {
	foreach entry $::twitter(accts) {
		set part [split $entry |]
		set chan [lindex $part 0]
		set tuser [lindex $part 1]
		if {![channel get $chan twitter] || ![channel get $chan twittertrack]} { continue }
		if {![info exists ::twitter($tuser,lastidt)]} {
			set ::twitter($tuser,lastidt) 0
		}
		if {[info exists acs]} {
			if {[lsearch -exact $acs [string tolower $tuser]] != -1} { continue }
		}
		lappend acs [string tolower $tuser]
		if {![info exists ::twitter(track,$tuser)] || ![string length [set text [join $::twitter(track,$tuser) " "]]]} { continue }
		proc:twitter:search $::botnick [getchanhost $::botnick] $::botnick  $chan "$text 1-$::twitter(tracklimit)"
	}
}

proc proc:twitter:track {type nick uhost handle chan text} {
	if {![channel get $chan twitter] || ![channel get $chan twittertrack]} { return }
	global twitter
	# does the user have temporary access to add services?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	# do they have flags required to add services?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to modify tracking in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[set pos [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]] == -1} {
		putserv "$to :$twitter(logo) There isn't any twitter account listed for $chan."
		return
	} else {
		set tuser [lindex [split [lindex $twitter(accts) $pos] |] 1]
	}
	if {[string length $type] && ![string length [set nicks [split $text]]]} {
		putserv "$to :$twitter(logo) You must specify the tracking terms you want $type for $chan."
		return
	}
	if {![string length $type]} {
		if {[info exists twitter(track,$tuser)]} {
			if {[llength $twitter(track,$tuser)]} {
				set count 0
				while {$count < [llength $twitter(track,$tuser)]} {
					putserv "$to :$twitter(logo) Trackings for ($chan@$tuser): [join [lrange $twitter(track,$tuser) $count [expr {$count + 9}]] " "]"
					incr count 10
				}
			} else {
				putserv "$to :$twitter(logo) There are no trackings created for ($chan@$tuser)."
			}
		} else {
			putserv "$to :$twitter(logo) There are no trackings created for ($chan@$tuser)."
		}
	} else {
		foreach entry $nicks {
			if {[string equal $type "Added"]} {
				#if {[info exists twitter(track,$tuser)]} {
				#	if {[set pos [lsearch -exact [split [string tolower [join $twitter(track,$tuser)]]] [string tolower $entry]]] != -1 && ![string equal "OR" $entry]} {
				#		lappend unmod $entry
				#	} else {
				#		lappend twitter(track,$tuser) $entry
				#		lappend modserv $entry
				#	}
				#} else {
					lappend twitter(track,$tuser) $entry
					lappend modserv $entry
				#}
			} else {
				if {[info exists twitter(track,$tuser)]} {
					if {[string equal $entry "*"] && [info exists twitter(track,$tuser)]} {
						set modserv $twitter(track,$tuser)
						unset twitter(track,$tuser)
					} elseif {[info exists twitter(track,$tuser)] && [set pos [lsearch -exact [split [string tolower [join $twitter(track,$tuser)]]] [string tolower $entry]]] != -1} {
						lappend modserv [lindex $twitter(track,$tuser) $pos]
						set twitter(track,$tuser) [lreplace $twitter(track,$tuser) $pos $pos]
					} else {
						lappend unmod $entry
					}
				} else {
					lappend unmod $entry
				}
			}
		}
		if {[info exists modserv]} {
			set count 0
			while {$count < [llength $modserv]} {
				putserv "$to :$twitter(logo) Tracking Modified for ($chan@$tuser) ($type): [join [lrange $modserv $count [expr {$count + 9}]] " "]"
				incr count 10
			}
		}
		if {[info exists unmod]} {
			if {[string equal $type "Added"]} {
				set count 0
				while {$count < [llength $unmod]} {
					putserv "$to :$twitter(logo) Duplicate Tracking given for ($chan@$tuser) (Already exists): [join [lrange $unmod $count [expr {$count + 9}]] " "]"
					incr count 10
				}
			} else {
				set count 0
				while {$count < [llength $unmod]} {
					putserv "$to :$twitter(logo) Tracking does not exist for ($chan@$tuser) (Cannot be removed): [join [lrange $unmod $count [expr {$count + 9}]] " "]"
					incr count 10
				}
			}
		}
		if {[info exists modserv]} { proc:twitter:trackauto 0 }
	}
}

proc proc:twitter:apps {type nick uhost handle chan text} {
	if {![channel get $chan twitter]} { return }
	global twitter
	# does the user have temporary access to add services?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	# do they have flags required to add services?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to modify any applications in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[set pos [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]] == -1} {
		putserv "$to :$twitter(logo) There isn't any twitter account listed for $chan."
		return
	} else {
		set tuser [lindex [split [lindex $twitter(accts) $pos] |] 1]
	}
	if {[string length $type] && ![string length [set nicks [split $text]]]} {
		putserv "$to :$twitter(logo) You must specify an application (or a list of applications) you want $type for $chan."
		return
	}
	if {![string length $type]} {
		if {[info exists twitter(apps,$tuser)]} {
			if {[llength $twitter(apps,$tuser)]} {
				set count 0
				while {$count < [llength $twitter(apps,$tuser)]} {
					putserv "$to :$twitter(logo) Applications for ($chan@$tuser): [join [lrange $twitter(apps,$tuser) $count [expr {$count + 9}]] ", "]"
					incr count 10
				}
			} else {
				putserv "$to :$twitter(logo) There are no applications created for ($chan@$tuser)."
			}
		} else {
			putserv "$to :$twitter(logo) There are no applications created for ($chan@$tuser)."
		}
	} else {
		foreach entry $nicks {
			if {[string equal [string index $entry 0] "@"]} {
				set entry [string range $entry 1 end]
			}
			if {[string equal $type "Added"]} {
				if {[info exists twitter(apps,$tuser)]} {
					if {[set pos [lsearch -exact [split [string tolower [join $twitter(apps,$tuser)]]] [string tolower $entry]]] != -1} {
						lappend unmod $entry
					} else {
						lappend twitter(apps,$tuser) $entry
						lappend modserv $entry
					}
				} else {
					lappend twitter(apps,$tuser) $entry
					lappend modserv $entry
				}
			} else {
				if {[info exists twitter(apps,$tuser)]} {
					if {[string equal $entry "*"] && [info exists twitter(apps,$tuser)]} {
						set modserv $twitter(apps,$tuser)
						unset twitter(apps,$tuser)
					} elseif {[info exists twitter(apps,$tuser)] && [set pos [lsearch -exact [split [string tolower [join $twitter(apps,$tuser)]]] [string tolower $entry]]] != -1} {
						lappend modserv [lindex $twitter(apps,$tuser) $pos]
						set twitter(apps,$tuser) [lreplace $twitter(apps,$tuser) $pos $pos]
					} else {
						lappend unmod $entry
					}
				} else {
					lappend unmod $entry
				}
			}
		}
		if {[info exists modserv]} {
			set count 0
			while {$count < [llength $modserv]} {
				putserv "$to :$twitter(logo) Applications Modified for ($chan@$tuser) ($type): [join [lrange $modserv $count [expr {$count + 9}]] ", "]"
				incr count 10
			}
		}
		if {[info exists unmod]} {
			if {[string equal $type "Added"]} {
				set count 0
				while {$count < [llength $unmod]} {
					putserv "$to :$twitter(logo) Duplicate Application given for ($chan@$tuser) (Already exists): [join [lrange $unmod $count [expr {$count + 9}]] ", "]"
					incr count 10
				}
			} else {
				set count 0
				while {$count < [llength $unmod]} {
					putserv "$to :$twitter(logo) Application does not exist for ($chan@$tuser) (Cannot be removed): [join [lrange $unmod $count [expr {$count + 9}]] ", "]"
					incr count 10
				}
			}
		}
	}
}

proc proc:twitter:service {type nick uhost handle chan text} {
	if {![channel get $chan twitter]} { return }
	global twitter
	# does the user have temporary access to add services?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	# do they have flags required to add services?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to modify any bot services in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[set pos [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]] == -1} {
		putserv "$to :$twitter(logo) There isn't any twitter account listed for $chan."
		return
	} else {
		set tuser [lindex [split [lindex $twitter(accts) $pos] |] 1]
	}
	if {[string length $type] && ![string length [set nicks [split $text]]]} {
		putserv "$to :$twitter(logo) You must specify an @username (or a list of @username's) for the service bots you want $type for $chan."
		return
	}
	if {![string length $type]} {
		if {[info exists twitter(services,$tuser)]} {
			if {[llength $twitter(services,$tuser)]} {
				set count 0
				while {$count < [llength $twitter(services,$tuser)]} {
					putserv "$to :$twitter(logo) Services for ($chan@$tuser): [join [lrange $twitter(services,$tuser) $count [expr {$count + 9}]] ", "]"
					incr count 10
				}
			} else {
				putserv "$to :$twitter(logo) There are no services created for ($chan@$tuser)."
			}
		} else {
			putserv "$to :$twitter(logo) There are no services created for ($chan@$tuser)."
		}
	} else {
		foreach entry $nicks {
			if {[string equal [string index $entry 0] "@"]} {
				set entry [string range $entry 1 end]
			}
			if {[string equal $type "Added"]} {
				if {[info exists twitter(services,$tuser)]} {
					if {[set pos [lsearch -exact [split [string tolower [join $twitter(services,$tuser)]]] [string tolower $entry]]] != -1} {
						lappend unmod $entry
					} else {
						lappend twitter(services,$tuser) $entry
						lappend modserv $entry
					}
				} else {
					lappend twitter(services,$tuser) $entry
					lappend modserv $entry
				}
			} else {
				if {[info exists twitter(services,$tuser)]} {
					if {[string equal $entry "*"] && [info exists twitter(services,$tuser)]} {
						set modserv $twitter(services,$tuser)
						unset twitter(services,$tuser)
					} elseif {[info exists twitter(services,$tuser)] && [set pos [lsearch -exact [split [string tolower [join $twitter(services,$tuser)]]] [string tolower $entry]]] != -1} {
						lappend modserv [lindex $twitter(services,$tuser) $pos]
						set twitter(services,$tuser) [lreplace $twitter(services,$tuser) $pos $pos]
					} else {
						lappend unmod $entry
					}
				} else {
					lappend unmod $entry
				}
			}
		}
		if {[info exists modserv]} {
			set count 0
			while {$count < [llength $modserv]} {
				putserv "$to :$twitter(logo) Services Modified for ($chan@$tuser) ($type): [join [lrange $modserv $count [expr {$count + 9}]] ", "]"
				incr count 10
			}
		}
		if {[info exists unmod]} {
			if {[string equal $type "Added"]} {
				set count 0
				while {$count < [llength $unmod]} {
					putserv "$to :$twitter(logo) Duplicate service given for ($chan@$tuser) (Already exists): [join [lrange $unmod $count [expr {$count + 9}]] ", "]"
					incr count 10
				}
			} else {
				set count 0
				while {$count < [llength $unmod]} {
					putserv "$to :$twitter(logo) Service does not exist for ($chan@$tuser) (Cannot be removed): [join [lrange $unmod $count [expr {$count + 9}]] ", "]"
					incr count 10
				}
			}
		}
	}
}

# save timelines and services
proc proc:twitter:save {args} {
	global twitter
	set doneit [list]
	set id [open $twitter(filesave) w]
	foreach entry $twitter(accts) {
		set acct [lindex [split $entry |] 1]
		if {[lsearch -exact $doneit $acct] == -1} {
			lappend doneit $acct
			if {[info exists twitter($acct,lastid)]} { puts $id "set twitter($acct,lastid) \"$twitter($acct,lastid)\"" }
			if {[info exists twitter($acct,lastidt)]} { puts $id "set twitter($acct,lastidt) \"$twitter($acct,lastidt)\"" }
			if {[info exists twitter($acct,lastidf)]} { puts $id "set twitter($acct,lastidf) \"$twitter($acct,lastidf)\"" }
			set a "" ; set b "" ; set c "" ; set d ""
			if {[info exists twitter(services,$acct)]} {
				foreach n $twitter(services,$acct) {
					append a " [list $n]"
				}
				puts $id "set twitter(services,$acct) [list [string trim $a]]"
			}
			if {[info exists twitter(apps,$acct)]} {
				foreach n $twitter(apps,$acct) {
					append b " [list $n]"
				}
				puts $id "set twitter(apps,$acct) [list [string trim $b]]"
			}
			if {[info exists twitter(track,$acct)]} {
				foreach n $twitter(track,$acct) {
					append c " [list $n]"
				}
				puts $id "set twitter(track,$acct) [list [string trim $c]]"
			}
			if {[info exists twitter($acct,followers)]} {
				foreach n $twitter($acct,followers) {
					append d " [list $n]"
				}
				puts $id "set twitter($acct,followers) [list [string trim $d]]"
			}
		}
	}
	flush $id
	close $id
}

# This allows gzip
# if gzip requested, Trf or zlib required.
if {$twitter(use_gzip) > 0} {
	if {([lsearch [info commands] zlib] == -1) && ([catch {package require zlib} error] !=0)} {
		if {([catch {package require Trf} error] == 0) || ([lsearch [info commands] zip] != -1)} {
			putlog "$twitter(logo) Found Trf package! Gzip enabled."
			set twitter(trf) 1
			set twitter(hdr) "Accept-Encoding gzip,deflate"
		} else {
			putlog "$twitter(logo) Unable to find zlib or trf package! Gzip disabled."
			set twitter(nogzip) 1
			set twitter(hdr) ""
		}
	} else {
		putlog "$twitter(logo) Found zlib package! Gzip enabled."
		set twitter(hdr) "Accept-Encoding gzip,deflate"
	}
} else {
	set twitter(nozlib) 1
	set twitter(hdr) ""
}

# base64 encoding, for our login:password AUTH session
if {[catch {package require base64} e] !=0} {
	set twitter(base64) 0
}

# Gzip inflate
proc proc:twitter:gzipinflate {html metas} {
	if {$::twitter(use_gzip) > 0} {
		if {![info exists ::twitter(nogzip)]} {
			foreach {name value} $metas {
				if {[regexp -nocase ^Content-Encoding$ $name]} {
					if {[string equal -nocase "gzip" $value]} {
						if {![info exists ::twitter(trf)]} {
							set html [zlib inflate [string range $html 10 [expr { [string length $html] - 8 } ]]]
						} else {
							set html [zip -mode decompress -nowrap 1 [string range $html 10 [expr { [string length $html] - 8 } ]]]
						}
						break
					}
				}
			}
		}
	}
	return $html
}

# other users timelines
proc proc:twitter:user2 {nick uhost hand chan text} {
	set splits [split $text]
	set who [join [lrange $splits 0 end-1]]
	set val [lindex $splits end]
	if {![regexp -- {^(?:\d+|all)\-(?:\d+|all)$} $val] && ![regexp -- {^(?:\d+|all)$} $val]} {
		if {[string length $who]} { append who " $val" } else { append who $val }
		set val ""
	}
	proc:twitter:restapi $nick $uhost $hand $chan $val "otheruser $who"
}

# other users timelines
proc proc:twitter:search {nick uhost hand chan text} {
	set splits [split $text]
	set who [join [lrange $splits 0 end-1]]
	set val [lindex $splits end]
	if {![regexp -- {^(?:\d+|all)\-(?:\d+|all)$} $val] && ![regexp -- {^(?:\d+|all)$} $val]} {
		if {[string length $who]} { append who " $val" } else { append who $val }
		set val ""
	}
	if {$::twitter(allow_newlines) > 0} { set who [string map [list \\n \n] $who] }
	proc:twitter:restapi $nick $uhost $hand $chan $val "search $who"
}
# public timelines
proc proc:twitter:public {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "public"
}

# mention timelines
proc proc:twitter:mentions {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "mention"
}

# user timeslines
proc proc:twitter:user {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "user"
}

# home timeslines
proc proc:twitter:home {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "home"
}

# friends timelines
proc proc:twitter:friends {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "friends"
}

# direct message timelines
proc proc:twitter:messages {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "private"
}

# sent direct messages timelines
proc proc:twitter:privates {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "private_sent"
}

# retweets-of-me
proc proc:twitter:rtome {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "retweets_of_me"
}

# retweets-by-me
proc proc:twitter:rtbme {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "retweets_by_me"
}

# retweets-to-me
proc proc:twitter:rttme {nick uhost hand chan text} {
	proc:twitter:restapi $nick $uhost $hand $chan $text "retweets_to_me"
}

# display new timelines from any friends automatically
proc proc:twitter:friendsauto {args} {
	foreach entry $::twitter(accts) {
		set part [split $entry |]
		set chan [lindex $part 0]
		if {![channel get $chan twitterfriends]} { continue }
		set tuser [lindex $part 1]
		if {![info exists ::twitter($tuser,lastidf)]} {
			set ::twitter($tuser,lastidf) 0
		}
		if {[info exists acs]} {
			if {[lsearch -exact $acs [string tolower $tuser]] != -1} { continue }
		}
		lappend acs [string tolower $tuser]
		proc:twitter:restapi $::botnick [getchanhost $::botnick] $::botnick  $chan "1-$::twitter(friendlimit)" "friends"
	}
}

# megahal replies to any of your accounts mentions
proc proc:twitter:megahal:privatereply {m h d mo y} {
	global twitter
	if {[info exists twitter(base64)]} { return }
	foreach entry $twitter(accts) {
		set html ""
		set part [split $entry |]
		set chan [lindex $part 0]
		if {![channel get $chan twitter]} { continue }
		if {![channel get $chan twittermentions]} { continue }
		set tuser [lindex $part 1]
		if {![info exists ::twitter($tuser,lastid)]} {
			set ::twitter($tuser,lastid) 0
		}
		set tpass [lindex $part 2]
		if {[info exists acs]} {
			if {[lsearch -exact $acs [string tolower $tuser]] != -1} { continue }
		}
		lappend acs [string tolower $tuser]
		set q [list [list include_rts 1]]
		if {[catch {set html [proc:twitter:oauth $twitter(mention) GET $chan $q]} error]} { putlog "$twitter(logo) $error" ; continue }
		if {[info exists state(charset)]} {
			set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
		} else {
			set twitter(charset) "utf-8"
		}
		set html [proc:twitter:encode $html]
		regsub -all "\t|\n|\r|\v" $html " " html

		set postdata [proc:twitter:jsondecode:restapi $html]

		if {![info exists postdata] || ![llength $postdata]} {
			continue
		}
		for {set j $twitter(mentionlimit) } {$j >= 1} {incr j -1} {
			set post [lindex $postdata [expr {$j - 1}]]
			if {[info exists skip]} { unset skip }
			if {[info exists sp]} { unset sp }
			if {![llength $post]} { continue }
			foreach {c id text so id2 nick s i rn} $post {}
			if {$id <= $twitter($tuser,lastid)} { continue }
			if {$twitter(newline) > 0} {
				set text [join [split [proc:twitter:descdecode [proc:twitter:descdecode $text]] "\r\t\v\a"] " "]
			} else {
				set text [join [split [proc:twitter:descdecode [proc:twitter:descdecode $text]] "\r\t\v\n\a"] " "]
			} 
			if {$twitter(usemegareply) > 0 && [channel get $chan twittermentionsmega]} {
				if {[string equal -nocase $s $tuser]} { continue }
				# tcl8.4 friendly, nocase lsearch
				if {[info exists twitter(services,$tuser)]} {
					foreach service $twitter(services,$tuser) {
						if {[string equal -nocase [string map {"_" " "} $service] [string map {"_" " "} $s]]} {
							set skip 0
							break
						}
					}
				}
				if {[info exists twitter(apps,$tuser)]} {
					foreach service $twitter(apps,$tuser) {
						if {[string equal -nocase [string map {"_" " "} $service] [string map {"_" " "} $so]]} {
							set skip 1
							break
						}
					}
				}
				if {![info exists skip] && ![string match "RT *" $text]} {
					set reply [string range "RT [string map {" " "_"} "@$s"] <$::botnick> [getreply $text]" 0 139]
					if {$twitter(mentionlearn) > 0} { learn $text }
					set q [list [list "status" "[oauth:uri_escape $reply]"] [list "in_reply_to_status_id" "$id"]]
					if {[catch {set html [proc:twitter:oauth $twitter(tweet) POST $chan $q]} error]} { putlog "$twitter(logo) $error" ; return }
					if {[info exists state(charset)]} {
						set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
					} else {
						set twitter(charset) "utf-8"
					}
					set html [proc:twitter:encode $html]
					if {[string match "*\"error\"*" $html]} {
						set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
						putlog "$twitter(logo) (Megahal) Reply tweet to $nick failed. $text"
					} else {
						set tu [string map [list %bot% "$::botnick" %reply% "$reply"] $twitter(mention-display-megahal)]
						foreach line [split $text "\n"] {
							if {![info exists sp]} {
								set tt [string map [list %created% "$c" %id% "$id" %screen% "$s" %nick% "[proc:twitter:descdecode [proc:twitter:descdecode $nick]]" %text% "$line" %source% "[proc:twitter:descdecode [proc:twitter:descdecode $so]]"] $twitter(mention-display)]
							} else {
								set tt [string map [list %created% "$c" %id% "$id" %screen% "$s" %nick% "[proc:twitter:descdecode [proc:twitter:descdecode $nick]]" %text% "$line"] $twitter(mention-display-cont)]
							}
							if {$twitter(mentionsilent) > 0} {
								putlog "$tt" ; set sp 0
							} else {
								set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
								putserv "$to :$tt" ; set sp 0
							}
						}
						if {$twitter(mentionsilent) > 0 } {
							putlog "$tu"
						} else {
							set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
							putserv "$to :$tu"
						}
					}
				} else {
					if {[info exists twitter(apps,$tuser)]} {
						foreach service $twitter(apps,$tuser) {
							if {[string equal -nocase [string map {"_" " "} $service] [string map {"_" " "} $so]]} {
								set skip 1
								break
							}
						}
					}
					if {![info exists skip] || $skip < 1} {
						foreach line [split $text "\n"] {
							if {![info exists sp]} {
								set tt [string map [list %created% "$c" %id% "$id" %screen% "$s" %nick% "[proc:twitter:descdecode [proc:twitter:descdecode $nick]]" %text% "$line" %source% "[proc:twitter:descdecode [proc:twitter:descdecode $so]]"] $twitter(mention-display-nomega)]
							} else {
								set tt [string map [list %created% "$c" %id% "$id" %screen% "$s" %nick% "[proc:twitter:descdecode [proc:twitter:descdecode $nick]]" %text% "$line"] $twitter(mention-display-nomega-cont)]
							}
							if {$twitter(mentionsilent) > 0} {
								putlog "$tt" ; set sp 0
							} else {
								set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
								putserv "$to :$tt" ; set sp 0
							}
						}
					}
				}
			} else {
				if {[info exists twitter(apps,$tuser)]} {
					foreach service $twitter(apps,$tuser) {
						if {[string equal -nocase [string map {"_" " "} $service] [string map {"_" " "} $so]]} {
							set skip 0
							break
						}
					}
				}
				if {![info exists skip]} {
					foreach line [split $text "\n"] {
						if {![info exists sp]} {
							set tt [string map [list %created% "$c" %id% "$id" %screen% "$s" %nick% "[proc:twitter:descdecode [proc:twitter:descdecode $nick]]" %text% "$line" %source% "[proc:twitter:descdecode [proc:twitter:descdecode $so]]"] $twitter(mention-display-nomega)]
						} else {
							set tt [string map [list %created% "$c" %id% "$id" %screen% "$s" %nick% "[proc:twitter:descdecode [proc:twitter:descdecode $nick]]" %text% "$line"] $twitter(mention-display-nomega-cont)]
						}
						if {$twitter(mentionsilent) > 0} {
							putlog "$tt" ; set sp 0
						} else {
							set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
							putserv "$to :$tt" ; set sp 0
						}
					}
				}
			}
		}
		if {[info exists postdata]} { 
			if {[lindex [lindex $postdata 0] 1] > $twitter($tuser,lastid)} { set twitter($tuser,lastid) [lindex [lindex $postdata 0] 1] }
		}
	}
}

# megahal replies to users (or you) when tweets are made in your profile.. ;D
proc proc:twitter:megahal {m h d mo y} {
	global twitter
	set s ""
	if {[info exists twitter(base64)]} { return }
	foreach entry $twitter(accts) {
		set part [split $entry |]
		set chan [lindex $part 0]
		set tuser [lindex $part 1]
		if {![channel get $chan twitter]} { continue }
		if {![channel get $chan twittermega]} { continue }
		set mc 1
		if {[info exists acs]} {
			if {[lsearch -exact $acs [string tolower $tuser]] != -1} { continue }
		}
		lappend acs [string tolower $tuser]
		set q ""
		if {[catch {set html [proc:twitter:oauth $twitter(userxml) GET $chan $q]} error]} { putlog "$twitter(logo) $error" ; continue }
		if {[info exists state(charset)]} {
			set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
		} else {
			set twitter(charset) "utf-8"
		}
		set text ""
		set html [proc:twitter:encode $html]
	      regsub -all "\t|\n|\r|\v" $html " " html
		regexp {<id>(.*?)</id>.*?<text>(.*?)</text>} $html - id text
		set text [join [split [proc:twitter:descdecode [proc:twitter:descdecode $text]] "\n\r\t\v"] " "]
		if {[string match "@*" $text] || [string match "RT *" $text] || ![string length $text]} { continue }
		if {[string first "<" $text] == 0} {
			if {[regexp -- {^<(.*?)>(.*?)$} $text - nick rest]} {
				if {[isbotnick $nick] || [regexp {^\s+@} $rest] || [regexp {^\s+RT\s} $rest]} { continue }
				set text "$rest"	
			} else { set nick "an unknown somebody" }
		} elseif {[string equal "\*" [lindex [split $text] 0]]} {
			set nick [lindex [split $text] 1]
			set text [join [lrange [split $text] 2 end]] 
		} else { set nick "an unknown somebody" }
		set reply [string range "<$::botnick> [getreply $text]" 0 139]
		if {$twitter(learn) > 0} { learn $text }
		set q [list [list "status" "[oauth:uri_escape $reply]"] [list "in_reply_to_status_id" "$id"]]
		set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
		if {[catch {set html [proc:twitter:oauth $twitter(tweet) POST $chan $q]} error]} { putlog "$twitter(logo) $error" ; return }
		if {[info exists state(charset)]} {
			set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
		} else {
			set twitter(charset) "utf-8"
		}
		set html [proc:twitter:encode $html]
		if {[string match "*\"error*" $html]} {
			set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
			putlog "$twitter(logo) (Megahal) reply to ${nick}'s tweet failed. $text"
		} else {
			regexp -nocase {"created_at"\:.*?"created_at"\:"(.*?)"} $html - text
			regexp -nocase {"source"\:"(.*?)","} $html - s
			regsub -nocase {\{.*?\}} $html "" html
			regexp -nocase {"id"\:(.*?)\,"} $html - id
			regsub -all -- {<.*?>} $s "" s
			if {$twitter(silent) > 0} {
				putlog "$twitter(logo) (Megahal) $::botnick replied to ${nick}'s tweet."
			} else {
 				if {[string equal -nocase [string index $nick end] s]} { set suffix {'} } else { set suffix {'s} }
				if {[string equal -nocase [string index $::botnick end] s]} { set bs {'} } else { set bs {'s} }
				putserv "$to :$twitter(logo) (Megahal) $::botnick${bs} reply to ${nick}${suffix} tweet: $reply"
			}
		}
	}
	if {[info exists mc]} {
		if {[info exists acs]} {
			putlog "$twitter(logo) (Megahal) $::botnick replied to ([join $acs ", "]) accounts."
		} else {
			putlog "$twitter(logo) Megahal replied to no accounts."
		}
	}
}

proc proc:twitter:restapi {nick uhost hand chan text type} {
	global twitter
	if {![channel get $chan twitter]} { return }
	# string map in replacements for output
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	if {![isbotnick $nick] && [proc:twitter:throttled $uhost,$chan,$type $twitter(throttle)]} {
		putserv "$to :$twitter(logo) Throttled.. Your going too fast and making my head spin!"
		return 0
	}
	if {[info exists twitter(base64)]} {
		if {[isbotnick $nick]} {
			putlog "$twitter(logo) Cannot find package (base64). Base64 encoding is required. Failed."
		} else {
			putserv "$to :$twitter(logo) Cannot find package (base64). Base64 encoding is required. Failed."
		}
		return
	}
	set found [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]
	if {$found != -1} {
		set tuser [lindex [split [lindex $twitter(accts) $found] |] 1]
		set tpass [lindex [split [lindex $twitter(accts) $found] |] 2]
		set tformat [join [lrange [split [lindex $twitter(accts) $found] |] 6 end]]
	} else {
		putserv "$to :$twitter(logo) Cannot find an account for $chan. Failed."
		return
	}
      if {[string match "retweet*" $type]} {
		set other ""
		set q [list [list count 100]]
	} elseif {[string match "otheruser*" $type]} {
		if {![string length [string trim [set who [string map {" " "_"} [join [lrange [split $type] 1 end]]]]]]} { set who "$tuser" }
		set other "?[http::formatQuery screen_name $who]"
		set q [list [list "screen_name" "$who"] [list include_rts 1]]
		set type "user"
		if {![isbotnick $nick]} { lappend q "[list count 200]" }
	} elseif {![string match "search*" $type]} {
		set other ""
		set q [list [list include_rts 1]]
		if {![isbotnick $nick]} { lappend q "[list count 200]" }
	} else {
		if {![string length [string trim [set who [join [lrange [split $type] 1 end]]]]]} { set who "$tuser" }
		set other ""
		set q [list [list q [oauth:uri_escape  $who]]]
		if {![isbotnick $nick]} { lappend q "[list rpp 100]" }
		set type "search"
	}
	if {![info exists twitter(noutf8)]} {
		set http [::http::config -useragent $twitter(agent) -urlencoding "utf-8"]
		if {[catch {set html [proc:twitter:oauth $twitter($type) GET $chan $q]} error]} {
			if {![isbotnick $nick] || ([string equal "search" $type] && [string match "*\(40?\)*" $error])} {
				putserv "$to :$twitter(logo) $error"
			} else {
				putlog "$twitter(logo) $error"
			}
			return
		}
		#catch {set http [::http::geturl "$twitter($type)$other" -headers [list "Authorization" "Basic $auth" "Accept-Encoding" "gzip,deflate"] -timeout 10000]} error
	} else {
		set http [::http::config -useragent $twitter(agent)]
		if {[catch {set html [proc:twitter:oauth $twitter($type) GET $chan $q]} error]} {
			if {![isbotnick $nick] || ([string equal "search" $type] && [string match "*\(40?\)*" $error])} {
				putserv "$to :$twitter(logo) $error"
			} else {
				putlog "$twitter(logo) $error"
			}
			return
		}
		#catch {set http [::http::geturl "$twitter($type)$other" -headers [list "Authorization" "Basic $auth"] -timeout 10000]} error
	}
	if {[info exists state(charset)]} {
		set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
	} else {
		set twitter(charset) "utf-8"
	}
	set html [proc:twitter:encode "[proc:twitter:gzipinflate "$html" $twitter(charset)]"]
      if {![isbotnick $nick]} {
		if {[string match "*\"error*" $html] && ![string match "*created_at*" $html]} {
			set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
			putserv "$to :$twitter(logo) $text"
			return
		}
		set fm $twitter(friendmax)
	} else {
		if {[string match "*\"error*" $html] && ![string match "*created_at*" $html]} {
			set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
			putlog "$twitter(logo) $text"
			return
		}
		set fm $twitter(friendlimit)
	}
	regsub -all "\t|\n|\r|\v" $html " " html
	if {[string match -nocase "privat*" $type]} {
		set friendslist [proc:twitter:jsondecode:private $html]
	} elseif {![string equal -nocase "search" $type]} {
		set friendslist [proc:twitter:jsondecode:restapi $html]
	} else {
		set friendslist [proc:twitter:jsondecode:search $html]
	}
	set len [llength $friendslist]
	if {![regexp -- {^((?:[0-9]{1,3}|all))-((?:[0-9]{1,3}|all))$} $text - st en]} {
		if {[regexp -- {^((?:[0-9]{1,3}|all))$} $text]} {
			if {![string equal "all" $text]} {
				set st $text ; set en [expr {$st + $fm-1}]
			} else {
				set st 1 ; set en $fm
			}
		}
	} else {
		if {[string equal "all" $st]} {
			set st 1
		}
		if {[string match "all" $en]} {
			set en [expr {$st + $fm}]
		}
		if {[expr {($en - $st) > ($fm -1)}]} {
			set en [expr {$st + $fm - 1}]
		}
		if {$en < $st} { set junk $en ; set en $st ; set st $junk }
		if {[expr {($en - $st) > ($fm -1)}]} {
			set st [expr {$en - ($fm -1)}]
		}
	}
	if {![string length [string trim $text]]} {
		set st 1 ; set en $fm
	}
	if {![info exists st]} { set st 1 }
	if {![info exists en]} { set en [expr {$st + $fm -1}] }
	if {$en > $len} {set en $len}
	if {$st < 1} { set st 1 }
	if {![isbotnick $nick]} {
		if {![llength $friendslist]} {
			if {![string length $other]} {
				if {![string equal -nocase "search" $type]} {
					putserv "$to :$twitter(logo) There is nothing to display for [string totitle [string map {"_" " "} $type]] with ($chan@$tuser). :("
				} else {
					putserv "$to :$twitter(logo) There is nothing to display for [string totitle [string map {"_" " "} $type]] when using \"$who\". :("
				}
			} else {
				putserv "$to :$twitter(logo) There is nothing to display for [string totitle [string map {"_" " "} $type]] with ([lindex [split $other =] 1]). ;/"
			}
			return
		} elseif {$st > $len} {
			if {![string length $other]} {
				if {![string equal -nocase "search" $type]} {
				 	putserv "$to :$twitter(logo) You cannot start at $st. There are only $len entries in the [string totitle [string map {"_" " "} $type]] list for ($chan@$tuser). ;/"
				} else {
					putserv "$to :$twitter(logo) You cannot start at $st. There are only $len entries in the [string totitle [string map {"_" " "} $type]] list when using \"$who\". ;/"
				}
			} else {
				putserv "$to :$twitter(logo) You cannot start at $st. There are only $len entries in the [string totitle [string map {"_" " "} $type]] list for ([lindex [split $other =] 1]). ;/"
			}
			return
		}
	}
	if {![isbotnick $nick]} {
		if {![string length $other]} {
			set tt [string map [list %end% "$en" %start% "$st" %type% "[string totitle [string map {"_" " "} $type]]" %chan% $chan %user% "$tuser"] $twitter(restapi-display-title)]
			putserv "$to :$tt"
		} else {
			if {[string equal -nocase $who $tuser]} { set who "$chan@$tuser" }
			set tt [string map [list %end% "$en" %start% "$st" %type% "[string totitle [string map {"_" " "} $type]]" %chan% $chan %user% "$who" %url% "http://twitter.com/[lindex [split $other =] 1]"] $twitter(restapi-display-title-user)]
			putserv "$to :$tt"
		}
	}
      if {[string length $len] == 1} { set xlen "0$len" } else { set xlen $len }
	for {set x $en} {$x >= $st} {incr x -1} {
		set line [lindex $friendslist [expr {$x - 1}]]
		if {[string length $x] == 1} { set xx "0$x" } else { set xx $x }
		if {[info exists pure]} { unset pure }
		if {[info exists sp]} { unset sp }
		if {[info exists skip]} { unset skip }
		foreach {create id text source id2 name screen replyid replyname} $line {}
		if {[isbotnick $nick] && [string equal -nocase $type "friends"] && [string match *@$tuser* $text]} { continue }
		if {$twitter(newline) > 0} {
			set text [join [split [proc:twitter:descdecode [proc:twitter:descdecode $text]] "\r\t\v\a"] " "]
		} else {
			set text [join [split [proc:twitter:descdecode [proc:twitter:descdecode $text]] "\r\t\v\n\a"] " "]
		} 
		foreach line [split $text "\n"] {
			if {[info exists twitter(apps,$tuser)]} {
				foreach service $twitter(apps,$tuser) {
					if {[string equal -nocase [string map {"_" " "} $service] [string map {"_" " "} $source]]} {
						set skip 1
						break
					}
				}
			}
			if {![string length $replyid]} {
				if {![string equal -nocase "search" $type]} {
					if {![info exists sp]} {
						set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %name% "[proc:twitter:descdecode [proc:twitter:descdecode $name]]" %text% "$line"] $twitter(restapi-display)]
					} else {
						set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %name% "[proc:twitter:descdecode [proc:twitter:descdecode $name]]" %text% "$line"] $twitter(restapi-display-cont)]
					}
				} else {
					if {![info exists sp]} {
						if {![isbotnick $nick]} {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(search-display)]
						} else {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(track-display)]
						}
					} else {
						if {![isbotnick $nick]} {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(search-display-cont)]
						} else {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(track-display-cont)]
						}
					}
				}
				if {![isbotnick $nick]} {
					if {![info exists skip]} {
						putserv "$to :$tt" ; set sp 0
					}
				} else {
					if {[string equal -nocase "friends" $type]} {
						if {($twitter($tuser,lastidf) < $id && ![string equal -nocase $screen $tuser]) || ($twitter($tuser,lastidf) == $id && [info exists sp] && ![string equal -nocase $screen $tuser])} {
							if {![info exists skip]} {
								putserv "$to :$tt" ; set sp 0
							}
							if {![info exists pure]} {
								set twitter($tuser,lastidf) $id
								set pure 0
							}
						}
					} else {
						if {($twitter($tuser,lastidt) < $id && ![string equal -nocase $screen $tuser]) || ($twitter($tuser,lastidt) == $id && [info exists sp] && ![string equal -nocase $screen $tuser])} {
							if {![info exists skip]} {
								putserv "$to :$tt" ; set sp 0
							}
							if {![info exists pure]} {
								set twitter($tuser,lastidt) $id
								set pure 0
							}
						}
					}
				}
			} else {
				if {![string equal -nocase "search" $type]} {
					if {![info exists sp]} {
						set tt [string map [list %replyid% "$replyid" %replyname% "$replyname" %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %name% "[proc:twitter:descdecode [proc:twitter:descdecode $name]]" %text% "$line"] $twitter(restapi-display-reply)]
					} else {
						set tt [string map [list %replyid% "$replyid" %replyname% "$replyname" %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %name% "[proc:twitter:descdecode [proc:twitter:descdecode $name]]" %text% "$line"] $twitter(restapi-display-reply-cont)]
					}
				} else {
					if {![info exists sp]} {
						if {![isbotnick $nick]} {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(search-display)]
						} else {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(track-display)]
						}
					} else {
						if {![isbotnick $nick]} {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(search-display-cont)]
						} else {
							set tt [string map [list %pos% "$xx" %len% "$xlen" %created% "$create" %source% "$source" %id% "$id" %screen% "$screen" %text% "$line"] $twitter(track-display-cont)]
						}
					}
				}
				if {![isbotnick $nick]} {
					putserv "$to :$tt" ; set sp 0
				} else {
					if {[string equal -nocase "friends" $type]} {
						if {($twitter($tuser,lastidf) < $id && ![string equal -nocase $screen $tuser]) || ($twitter($tuser,lastidf) == $id && [info exists sp] && ![string equal -nocase $screen $tuser])} {
							if {![info exists skip]} {
								putserv "$to :$tt" ; set sp 0
							}
							if {![info exists pure]} {
								set twitter($tuser,lastidf) $id
								set pure 0
							}
						}
					} else {
						if {($twitter($tuser,lastidt) < $id && ![string equal -nocase $screen $tuser]) || ($twitter($tuser,lastidt) == $id && [info exists sp] && ![string equal -nocase $screen $tuser])} {
							if {![info exists skip]} {
								putserv "$to :$tt" ; set sp 0
							}
							if {![info exists pure]} {
								set twitter($tuser,lastidt) $id
								set pure 0
							}
						}
					}
				}
			}
		}
	}
	#if {[isbotnick $nick] && [string length [set value [lindex [lindex $friendslist 0] 1]]]} {
	#	if { $value > $twitter($tuser,lastidf)} { set twitter($tuser,lastidf) $value }
	#}
}

proc proc:twitter:xmldecode:restapi {html} {
	set friendslist [list] ; set m [list]
	# while data exists, keep going...
	while {[regexp -nocase -- {<status>(.*?)</status>} $html - snip]} {
		# ugly regexp parsing... it works, bite me :P
		regsub -nocase -- {<status>.*?</status>} $html "" html
		regexp -nocase -- {<created_at>(.*?)</created_at>.*?<id>(.*?)</id>.*?<text>(.*?)</text>.*?<source>(.*?)</source>} $snip - c id t so
		if {![regexp -nocase -- {<in_reply_to_status_id>(.*?)</in_reply_to_status_id>.*?<in_reply_to_screen_name>(.*?)</in_reply_to_screen_name>} $snip - rid rn]} {
			set rid "" ; set rn ""
		}
		regexp -nocase -- {<id>(.*?)</id>.*?<name>(.*?)</name>.*?<screen_name>(.*?)</screen_name>} $snip - i n s
		regsub -all -- {<.*?>} [proc:twitter:descdecode [proc:twitter:descdecode $so]] "" so
		# sometimes xml returns a duplicate result this will stop that
		# using msg-id's to track each item.
		if {[lsearch -exact $m $i] == -1 } {
			lappend friendslist [list "[proc:twitter:duration $c]" "$id" "$t" "$so" "$i" "$n" "$s" "$rid" "$rn"]
			lappend m $i
		}
	}
	return $friendslist
}

proc proc:twitter:jsondecode:restapi {html} {
	# can't render these on IRC anyways.
	# newlines, carriage return, vertical tab, tab
	# at the end of each set, create a newline to split with
	regsub -all "\t|\n|\r|\v" $html " " html
	set html [string map [list "\},\{" "\n"] $html]
	set friendslist [list] ; set row 0
	# iterate through each entry
	foreach entry [split $html "\n"] {
            #if {[regexp -nocase {"entities"\:(.*?)]\}\,} $entry - entities]} {
            #   regsub -nocase {"entities"\:(.*?)]\}\,} $entry "" entry
            #} else { set entities "" }
		# ugly regexp parsing, but hey.. it works, bite me :P
		if {[regexp -- {"in_reply_to_screen_name"\:(.*?)(,|$)} $entry - rn]} {
			set rn [string trim $rn "\"\}"]
		} else { set rn "kaboom" }
            if {[info exists n1]} { unset n1 }
		if {[regexp -- {"id_str"\:"(.*?)".*?"id_str"\:"(.*?)".*?"id_str"\:"(.*?)".*?"id_str"\:"(.*?)"} $entry - id id2 id3 id4]} {
			set srt [lsort -decreasing -dictionary [list $id $id2 $id3 $id4]]
			set id [lindex $srt 0] ; set id2 [lindex $srt 1]
		} elseif {[regexp -- {"id_str"\:"(.*?)".*?"id_str"\:"(.*?)".*?"id_str"\:"(.*?)"} $entry - id id2 id3]} {
			set srt [lsort -decreasing -dictionary [list $id $id2 $id3]]
			set id [lindex $srt 0] ; set id2 [lindex $srt 1]
		} else {
			if {![regexp -- {"id_str"\:"(.*?)".*?"id_str"\:"(.*?)"} $entry - id id2]} {
				if {![regexp -- {"id_str"\:"(.*?)"} $entry - id]} { set id "" }
            	} else {
				if {$id2 > $id} { set id $id2 }
			}
		}
		if {[regexp -- {"text"\:(.*?)(?:"\}|",").*?"text"\:(.*?)(?:"\}|",")} $entry - t t1]} {
			set t [string trim [string map {"\\\"" "\""} [string range $t 1 end]]]
                  if {[string match "http\:*" [lindex [split $t] end]]} {
                    if {[string equal [string index $t end] "\""]} { set t [string range $t 0 end-1] }
                  }
			set t1 [string trim [string map {"\\\"" "\""} [string range $t1 1 end]]]
                  if {[string match "http\:*" [lindex [split $t1] end]]} {
                    if {[string equal [string index $t1 end] "\""]} { set t1 [string range $t1 0 end-1] }
                  }
			if {[string match "RT *" $t1]} { set t2 $t1 ; set t1 $t ; set t $t2 }
		} elseif {[regexp -- {"text"\:(.*?)(?:"\}|","|"$)} $entry - t]} {
			set t [string map {"\\\"" "\""} [string range $t 1 end]]
                  if {[string match "http:*" [lindex [split $t] end]]} {
                    if {[string equal [string index $t end] "\""]} { set t [string range $t 0 end-1] }
                  }
		} else { set t "deleted" }
            #if {[regexp -nocase {"urls"\:(.*?)\]\,} $entities - urlscrub]} {
            #   set urlscrub [string range $urlscrub 2 end]
            #   if {[string length $urlscrub]} {
		#	set urls [regexp -nocase -all -inline {"expanded_url"\:"(.*?)".*?"indices"\:\[(.*?),(.*?)$} $urlscrub]
		#      if {[llength $urls]} {
		#	   #putserv "privmsg speechles :urls $urls"
		#	   foreach {- url ust uen} $urls {
            #            if {$ust > 0 && $uen > 0 } { set t "[string range $t 0 [expr {$ust-1}]] [string map {\\ ""} ${url}][string range $t $uen end]" }
            #         }
		#	}
		#   }
            #}
 
		if {![regexp -- {"created_at"\:"(.*?)".*?"created_at"\:"(.*?)".*?"created_at"\:"(.*?)".*?"created_at"\:"(.*?)"} $entry - c c1 c2 c3]} {
			if {![regexp -- {"created_at"\:"(.*?)".*?"created_at"\:"(.*?)"} $entry - c c1]} {
				set c ""
			} elseif {[proc:twitter:duration $c 1] < [proc:twitter:duration $c1 1]} {
				set c $c1
			}
		} else {
			set z [list $c $c1 $c2 $c3]
			set z1 [lsort -decreasing [list [list [proc:twitter:duration $c 1] 0] [list [proc:twitter:duration $c1 1] 1] [list [proc:twitter:duration $c2 1] 2] [list [proc:twitter:duration $c3 1] 3]]]
			set c [lindex $z [lindex [lindex $z1 0] 1]]
			set c1 [lindex $z [lindex [lindex $z1 1] 1]]
			if {[string equal $c [proc:twitter:duration [lindex $z 1] 1]]} { set bkw 0 }
		}
		if {[info exists z]} { unset z }
		if {[regexp -- {"source"\:(.*?)(?:,|\{|$)} $entry - so]} {
			set so [string trim $so "\"\}\]" ]
		} else { set so "" }
		if {![regexp -- {"in_reply_to_status_id"\:(.*?),} $entry - rid]} { set rid "" }
		if {[string match -nocase "null*" $rid]} { set rid "" }
		if {[string match -nocase "null*" $rn]} { set rn "" }
		if {![regexp -nocase {"screen_name"\:"(.*?)".*?"screen_name"\:"(.*?)"} $entry - s s1]} {
			regexp -nocase {"screen_name"\:"(.*?)"} $entry - s
		}
		if {[regexp -nocase -- {"retweeted_status".*?"name"\:"(.*?)"} $entry - nc]} {
			set z ""
			regexp -nocase -- {"retweet_count"\:(.*?),} $entry - z
			set z [string trim $z "\"\}" ]
			if {$z == 0 || ![string length z] } { set z "" } { set z "($z)" }
			set rt "RT "
			set ck [join [lrange [split $t] 0 1]]
			set r1 [join [lrange [split $t] 2 end]]
			if {[info exists t1] && [string length $t1]} {
				if {[string length $r1] != [string length $t1]} {
					set t "$ck $t1"
				}
			}
		} else {
			set rt ""
		}
		if {[regexp -nocase {"name"\:"(.*?)".*?"name"\:"(.*?)"} $entry - n n1]} {
			if {[info exists nc] && ![string equal $n $nc] && ![info exists bkw]} {
				set n2 $n1 ; set n1 $n ; set n $n2 ; set s $s1
			}
			if {![info exists z]} { set z "" } elseif {![string length $rt] && ![string length $rid]} {
				set n2 $n1 ; set n1 $n ; set n $n2 
			}
			set n "$n1 ($rt$n$z)"
            } else {
			regexp -nocase {"name"\:"(.*?)"} $entry - n
		}
		regsub -all -- {<.*?>} [proc:twitter:descdecode [proc:twitter:descdecode $so]] "" so
		# append data to friendslist
		if {[info exists n]} { lappend friendslist [list "[proc:twitter:duration $c]" "$id" "[string map [list \\ \\\\ ] $t]" "$so" "$id" "$n" "$s" "$rid" "$rn"] }
	}
	return $friendslist
}

proc proc:twitter:jsondecode:search {html} {
	# can't render these on IRC anyways.
	# newlines, carriage return, vertical tab, tab
	# at the end of each set, create a newline to split with
	regsub -all "(?:\t|\n|\r|\v)" $html " " html
	set html [string map [list "\},\{" "\n"] $html]
	set friendslist [list]
	# iterate through each entry
	foreach entry [split $html "\n"] {
		# ugly regexp parsing, but hey.. it works, bite me :P
		if {[regexp -- {"in_reply_to_screen_name"\:(.*?),} $entry - rn]} {
			set rn [string trim $rn "\"" ]
		} else { set rn "" }
		if {![regexp -- {"id"\:(.*?),} $entry - id]} { set id "" }
		if {[regexp -- {"text"\:(.*?)(,\"|$)} $entry - t]} {
			set t [string map {"\\\"" "\""} [string range $t 1 end-1]]
		} else { set t "" }
		if {![regexp -- {"created_at"\:"(.*?)"} $entry - c]} { set c "" }
		if {[regexp -- {"source"\:(.*?)(?:,|\{|$)} $entry - so]} {
			regsub -all -- {<.*?>} [proc:twitter:descdecode $so] "" so
			set so [string trim $so "\"\}\]" ]
		} else { set so "" }
		if {![regexp -- {"in_reply_to_status_id"\:(.*?),} $entry - rid]} { set rid "" }
		if {[string match -nocase "null*" $rid]} { set rid "" ; set rn "" }
		if {[string match -nocase "null*" $rn]} { set rn "" ; set rid "" }
		regexp -nocase {"from_user"\:"(.*?)"} $entry - s
		set n ""
		regsub -all -- {<.*?>} [proc:twitter:descdecode [proc:twitter:descdecode $so]] "" so
		# append data to friendslist
		if {[info exists s]} { lappend friendslist [list "[proc:twitter:duration $c 2]" "$id" "[string map [list \\ \\\\ ] $t]" "$so" "$id" "$n" "$s" "$rid" "$rn"] }
	}
	return $friendslist
}

proc proc:twitter:jsondecode:private {html} {
	# can't render these on IRC anyways.
	# newlines, carriage return, vertical tab, tab
	# at the end of each set, create a newline to split with
	regsub -all "\t|\n|\r|\v" $html " " html
	set html [string map [list "\},\{" "\n"] $html]
	set friendslist [list]
	# iterate through each entry
	foreach entry [split $html "\n"] {
		# ugly regexp parsing, but hey.. it works, bite me :P
		if {[regexp -- {"in_reply_to_screen_name"\:(.*?),} $entry - rn]} {
			set rn [string trim $rn "\"" ]
		} else { set rn "" }
		#if {![regexp -- {"id"\:(.*?),.*?"id"\:(.*?),} $entry - id2 id]} { set id "" } { if {$id2 > $id} { set id $id2 } }
            if {![regexp -- {"id_str"\:"(.*?)".*?"id_str"\:"(.*?)".*?"id_str"\:"(.*?)"} $entry - id id2 id3]} {
			if {![regexp -- {"id_str"\:"(.*?)"} $entry - id]} { set id "" }
            } else {
			if {$id < $id3} {
				set id $id3
                  	if {$id3 < $id2} {
					set id $id2
				}
			}
		}
		if {[regexp -- {"text"\:(.*?)(,\"|$)} $entry - t]} {
			set t [string map {"\\\"" "\""} [string range $t 1 end-1]]
		} else { set t "" }
		if {![regexp -- {"created_at"\:"(.*?)".*?"created_at"\:"(.*?)".*?"created_at"\:"(.*?)"} $entry - c c1 c2]} { set c "" }
		if {[info exists c1] && [info exists c] && [info exists c2]} {
			if {[proc:twitter:duration $c 1] < [proc:twitter:duration $c1 1] || [proc:twitter:duration $c 1] < [proc:twitter:duration $c2 1]} {
				set c $c2
				if {[proc:twitter:duration $c 1] < [proc:twitter:duration $c1 1]} {
					set c $c1
				}
			}
		}
		if {![regexp -- {"in_reply_to_status_id"\:(.*?),} $entry - rid]} { set rid "" }
		if {[string equal -nocase "null" $rid]} { set rid "" }
		if {[string equal -nocase "null" $rn]} { set rn "" }
		if {[regexp -nocase {"name"\:"(.*?)".*?"name"\:"(.*?)"} $entry - n n1]} { 
			set n "$n1 ($n)"
            } else {
			regexp -nocase {"name"\:"(.*?)"} $entry - n
		}
		regexp -nocase {"sender_screen_name"\:"(.*?)"} $entry - s
		# append data to friendslist
		if {[info exists n]} { lappend friendslist [list "[proc:twitter:duration $c]" "$id" "[string map [list \\ \\\\ ] $t]" "DM" "$id" "$n" "$s" "$rid" "$rn"] }
	}
	return $friendslist
}
         
proc proc:twitter:effect {text} {
	return "$::twitter(effect-on)${text}$::twitter(effect-off)"
}

# Throttle Proc - Thanks to user
# see this post: http://forum.egghelp.org/viewtopic.php?t=9009&start=3
proc proc:twitter:throttled {id seconds} {
	global twitterthrottle
	if {[info exists twitterthrottle($id)]&&$twitterthrottle($id)>[clock seconds]} {
		set id 1
	} {
		set twitterthrottle($id) [expr {[clock seconds]+$seconds}]
		set id 0
	}
}
# delete expired entries every 10 minutes
bind time - ?0* proc:twitter:throttledCleanup
proc proc:twitter:throttledCleanup args {
	global twitterthrottle
	set now [clock seconds]
	foreach {id time} [array get twitterthrottle] {
		if {$time<=$now} {unset twitterthrottle($id)}
	}
}

proc proc:twitter:encode {text} {
	global twitter
	if {[lsearch -exact [encoding names] $twitter(charset)] != -1} {
		set text [encoding convertto $twitter(charset) $text]
	}
	return $text
}

proc proc:twitter:descdecode {text {char "utf-8"} } {
	# code below is neccessary to prevent numerous html markups
	# from appearing in the output (ie, &quot;, &#5671;, etc)
	# stolen (borrowed is a better term) from tcllib's htmlparse ;)
	# works unpatched utf-8 or not, unlike htmlparse::mapEscapes
	# which will only work properly patched....
	set escapes {
		&nbsp; \xa0 &iexcl; \xa1 &cent; \xa2 &pound; \xa3 &curren; \xa4
		&yen; \xa5 &brvbar; \xa6 &sect; \xa7 &uml; \xa8 &copy; \xa9
		&ordf; \xaa &laquo; \xab &not; \xac &shy; \xad &reg; \xae
		&macr; \xaf &deg; \xb0 &plusmn; \xb1 &sup2; \xb2 &sup3; \xb3
		&acute; \xb4 &micro; \xb5 &para; \xb6 &middot; \xb7 &cedil; \xb8
		&sup1; \xb9 &ordm; \xba &raquo; \xbb &frac14; \xbc &frac12; \xbd
		&frac34; \xbe &iquest; \xbf &Agrave; \xc0 &Aacute; \xc1 &Acirc; \xc2
		&Atilde; \xc3 &Auml; \xc4 &Aring; \xc5 &AElig; \xc6 &Ccedil; \xc7
		&Egrave; \xc8 &Eacute; \xc9 &Ecirc; \xca &Euml; \xcb &Igrave; \xcc
		&Iacute; \xcd &Icirc; \xce &Iuml; \xcf &ETH; \xd0 &Ntilde; \xd1
		&Ograve; \xd2 &Oacute; \xd3 &Ocirc; \xd4 &Otilde; \xd5 &Ouml; \xd6
		&times; \xd7 &Oslash; \xd8 &Ugrave; \xd9 &Uacute; \xda &Ucirc; \xdb
		&Uuml; \xdc &Yacute; \xdd &THORN; \xde &szlig; \xdf &agrave; \xe0
		&aacute; \xe1 &acirc; \xe2 &atilde; \xe3 &auml; \xe4 &aring; \xe5
		&aelig; \xe6 &ccedil; \xe7 &egrave; \xe8 &eacute; \xe9 &ecirc; \xea
		&euml; \xeb &igrave; \xec &iacute; \xed &icirc; \xee &iuml; \xef
		&eth; \xf0 &ntilde; \xf1 &ograve; \xf2 &oacute; \xf3 &ocirc; \xf4
		&otilde; \xf5 &ouml; \xf6 &divide; \xf7 &oslash; \xf8 &ugrave; \xf9
		&uacute; \xfa &ucirc; \xfb &uuml; \xfc &yacute; \xfd &thorn; \xfe
		&yuml; \xff &fnof; \u192 &Alpha; \u391 &Beta; \u392 &Gamma; \u393 &Delta; \u394
		&Epsilon; \u395 &Zeta; \u396 &Eta; \u397 &Theta; \u398 &Iota; \u399
		&Kappa; \u39A &Lambda; \u39B &Mu; \u39C &Nu; \u39D &Xi; \u39E
		&Omicron; \u39F &Pi; \u3A0 &Rho; \u3A1 &Sigma; \u3A3 &Tau; \u3A4
		&Upsilon; \u3A5 &Phi; \u3A6 &Chi; \u3A7 &Psi; \u3A8 &Omega; \u3A9
		&alpha; \u3B1 &beta; \u3B2 &gamma; \u3B3 &delta; \u3B4 &epsilon; \u3B5
		&zeta; \u3B6 &eta; \u3B7 &theta; \u3B8 &iota; \u3B9 &kappa; \u3BA
		&lambda; \u3BB &mu; \u3BC &nu; \u3BD &xi; \u3BE &omicron; \u3BF
		&pi; \u3C0 &rho; \u3C1 &sigmaf; \u3C2 &sigma; \u3C3 &tau; \u3C4
		&upsilon; \u3C5 &phi; \u3C6 &chi; \u3C7 &psi; \u3C8 &omega; \u3C9
		&thetasym; \u3D1 &upsih; \u3D2 &piv; \u3D6 &bull; \u2022
		&hellip; \u2026 &prime; \u2032 &Prime; \u2033 &oline; \u203E
		&frasl; \u2044 &weierp; \u2118 &image; \u2111 &real; \u211C
		&trade; \u2122 &alefsym; \u2135 &larr; \u2190 &uarr; \u2191
		&rarr; \u2192 &darr; \u2193 &harr; \u2194 &crarr; \u21B5
		&lArr; \u21D0 &uArr; \u21D1 &rArr; \u21D2 &dArr; \u21D3 &hArr; \u21D4
		&forall; \u2200 &part; \u2202 &exist; \u2203 &empty; \u2205
		&nabla; \u2207 &isin; \u2208 &notin; \u2209 &ni; \u220B &prod; \u220F
		&sum; \u2211 &minus; \u2212 &lowast; \u2217 &radic; \u221A
		&prop; \u221D &infin; \u221E &ang; \u2220 &and; \u2227 &or; \u2228
		&cap; \u2229 &cup; \u222A &int; \u222B &there4; \u2234 &sim; \u223C
		&cong; \u2245 &asymp; \u2248 &ne; \u2260 &equiv; \u2261 &le; \u2264
		&ge; \u2265 &sub; \u2282 &sup; \u2283 &nsub; \u2284 &sube; \u2286
		&supe; \u2287 &oplus; \u2295 &otimes; \u2297 &perp; \u22A5
		&sdot; \u22C5 &lceil; \u2308 &rceil; \u2309 &lfloor; \u230A
		&rfloor; \u230B &lang; \u2329 &rang; \u232A &loz; \u25CA
		&spades; \u2660 &clubs; \u2663 &hearts; \u2665 &diams; \u2666
		&quot; \x22 &amp; \x26 &lt; \x3C &gt; \x3E O&Elig; \u152 &oelig; \u153
		&Scaron; \u160 &scaron; \u161 &Yuml; \u178 &circ; \u2C6
		&tilde; \u2DC &ensp; \u2002 &emsp; \u2003 &thinsp; \u2009
		&zwnj; \u200C &zwj; \u200D &lrm; \u200E &rlm; \u200F &ndash; \u2013
		&mdash; \u2014 &lsquo; \u2018 &rsquo; \u2019 &sbquo; \u201A
		&ldquo; \u201C &rdquo; \u201D &bdquo; \u201E &dagger; \u2020
		&Dagger; \u2021 &permil; \u2030 &lsaquo; \u2039 &rsaquo; \u203A
		&euro; \u20AC &apos; \u0027 &lrm; "" &rlm; "" &#8236; "" &#8237; ""
		&#8238; "" &#8212; \u2014
	};
      #set text [string map [list "\]" "\\\]" "\[" "\\\[" "\$" "\\\$"] [string map $escapes $text]]
      if {![string equal $char [encoding system]]} { set text [encoding convertfrom $char $text] }
      set text [string map [list "\]" "\\\]" "\[" "\\\[" "\$" "\\\$"] [string map $escapes $text]]
	regsub -all -- {&#([[:digit:]]{1,5});} $text {[format %c [string trimleft "\1" "0"]]} text
	regsub -all -- {&#x([[:xdigit:]]{1,4});} $text {[format %c [scan "\1" %x]]} text
	catch { set text "[subst "$text"]" }
	if {![string equal $char [encoding system]]} { set text [encoding convertto $char $text] }
	return "$text"
}

proc proc:tweet:modes {nick chan} {
	set modes ""
	if {[isvoice $nick $chan]} { append modes "+" }
	if {[ishalfop $nick $chan]} { append modes "%" }
	if {[isop $nick $chan]} { append modes "@" }
	return $modes
}

proc proc:twitter:retweet {nick uhand handle chan input} {
	global twitter
	if {![channel get $chan twitter]} { return }
	# string map in replacements for output
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	if {[proc:twitter:throttled $uhand,$chan,tweet $twitter(throttle)]} {
		putserv "$to :$twitter(logo) Throttled.. Your going too fast and making my head spin!"
		return 0
	}
	if {[info exists twitter(base64)]} {
		putserv "$to :$twitter(logo) Cannot find package (base64). Base64 encoding is needed to retweet. Failed."
		return
	}
	# temporary tweeter?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	# a flagged bot known tweeter?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to retweet in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[info exists twitter(noutf8)]} {
		set http [::http::config -useragent $twitter(agent)]
	} else {
		set http [::http::config -useragent $twitter(agent) -urlencoding "utf-8"]
	}
	set found [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]
	if {$found != -1} {
		set tuser [lindex [split [lindex $twitter(accts) $found] |] 1]
		set tformat [join [lrange [split [lindex $twitter(accts) $found] |] 6 end]]
	} else {
		putserv "$to :$twitter(logo) Cannot find an account to retweet for $chan. Failed."
		return
	}
	if {![regexp -- {^([0-9]+)$} [lindex [split $input] 0] - replyid]} {
		putserv "$to :$twitter(logo) You must supply an numerical ID that you wish to retweet! \"$input\" means nothing, that's what you got.. ;/"
		return 0
	}
	set rt [string map [list "%id%" "$replyid"] $twitter(retweet)]
	putserv "privmsg speechles :rt $rt"
	set q [list [list id $replyid]]
	if {[catch {set html [proc:twitter:oauth $rt POST $chan $q]} error]} { putserv "$to :$twitter(logo) $error" ; return }
	if {[info exists state(charset)]} {
		set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
	} else {
		set twitter(charset) "utf-8"
	}
	set html [proc:twitter:encode $html]
	if {[string match "*\"error*" $html]} {
		set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
		putserv "$to :$twitter(logo) $text"
	} else {
		if {![regexp -- {"created_at"\:"(.*?)".*?"created_at"\:"(.*?)"} $html - c c1]} { set c "" }
		if {[info exists c1] && [info exists c]} {
			if {[proc:twitter:duration $c 1] < [proc:twitter:duration $c1 1]} { set chek $c1 } { set chek $c }
		} elseif {[info exists c1] && ![info exists c]} {
			set chek $c1
		} else {
			set chek $c
		}
		if {[regexp -- {"source"\:(.*?)(?:,|\{|$)} $html - s]} {
			regsub -all -- {<.*?>} [proc:twitter:descdecode $s] "" s
			set s [string trim $s "\"\}" ]
		} else { set s "" }
		regexp -nocase {"screen_name"\:"(.*?)"} $html - sn
		#regsub -nocase {\{.*?\}} $html "" html
		regexp -- {"id_str"\:"(.*?)".*?"id_str"\:"(.*?)".*?"id_str"\:"(.*?)".*?"id_str"\:"(.*?)"} $html - id id2 id3 id4
		set srt [lsort -decreasing -dictionary [list $id $id2 $id3 $id4]]
		set id3 [lindex $srt 0] ; set id [lindex $srt 1]
		set tt [string map [list %created% "[proc:twitter:duration [string trim $chek]]" %source% "[string trim $s]" %id% "$id3" %user% "$tuser" %chan% "$chan" %retweetid% "$id" %retweetscreen% "$sn"] $twitter(retweet-display)]
		putserv "$to :$twitter(logo) $tt"
	}
}


proc proc:tweet {nick uhand handle chan input} {
	global twitter
	if {![channel get $chan twitter]} { return }
	# string map in replacements for output
	set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
	if {[proc:twitter:throttled $uhand,$chan,tweet $twitter(throttle)]} {
		putserv "$to :$twitter(logo) Throttled.. Your going too fast and making my head spin!"
		return 0
	}
	if {[info exists twitter(base64)]} {
		putserv "$to :$twitter(logo) Cannot find package (base64). Base64 encoding is needed to tweet. Failed."
		return
	}
	# temporary tweeter?
	if {[llength $twitter(channel)]} {
		foreach mask $twitter(channel) {
			if {[is$mask $nick $chan]} {
				set allow 1
			}
		}
	}
	# a flagged bot known tweeter?
	if {![matchattr $handle $twitter(flags) $chan] && ![info exists allow]} {
		putserv "$to :$twitter(logo) You are not able to tweet in $chan. You must have ($twitter(flags) flags), or be ([join $twitter(channel)]) in $chan. Both of which you aren't. :P"
		return
	}
	if {[info exists twitter(noutf8)]} {
		set http [::http::config -useragent $twitter(agent)]
	} else {
		set http [::http::config -useragent $twitter(agent) -urlencoding "utf-8"]
	}
	set found [lsearch -glob $twitter(accts) "[string tolower $chan]|*"]
	if {$found != -1} {
		set tuser [lindex [split [lindex $twitter(accts) $found] |] 1]
		set tformat [join [lrange [split [lindex $twitter(accts) $found] |] 6 end]]
	} else {
		putserv "$to :$twitter(logo) Cannot find an account to tweet for $chan. Failed."
		return
	}
      if {[string equal -nocase "-d " [string range $input 0 2]]} {
		set dm 0
		set input [string range $input 3 end]
		if {[regexp -- {^@(.*?)$} [lindex [split $input] 0] - sn]} {
			set input "[join [lrange [split $input] 1 end]]"
		} else {
			putserv "$to :$twitter(logo) A direct message must start with the @username to message."
			return 0
		}
	}
	if {[regexp -- {^([0-9]+)@(.*?)$} [lindex [split $input] 0] - replyid rep]} {
		set input "[join [lrange [split $input] 1 end]]"
		set ret "@$rep "
	} elseif {[string index [lindex [split $input] 0] 0] == "@"} {
		set ret "[lindex [split $input] 0] "
		set input "[join [lrange [split $input] 1 end]]"
	} else { set ret "" }
	if {[string equal -nocase "$twitter(me)" [lindex [split $input] 0]]} { 
		set act 0
		set input [join [lrange [split $input] 1 end]]
	} { set act 1 }
	set ment "" ; set newtext ""
	foreach word [split $input] {
		if {[regexp {^www\.} $word] && ([string length $word] > [expr {$twitter(shorten) + 7}])} {
			set data [proc:twitter:twittiny $word $twitter(shorten_type)]
			if {$twitter(short_type) == 1} { set data "www.[string range $data 7 end]" }
                  append newtext "$data "
		} elseif {[regexp {^http\:} $word] && ([string length $word] > $twitter(shorten) )} {
			set data [proc:twitter:twittiny $word $twitter(shorten_type)]
			if {$twitter(short_type) == 1} { set data "www.[string range $data 7 end]" }
                  append newtext "$data "
		} elseif {$twitter(autoarrange) > 0 } {
			if {[string index $word 0] == "@"} {
				append ment "$word "
			} else {
				append newtext "$word "
			}
		} else { append newtext "$word " }
	}
	set input [string trimright $newtext " "]
	if {$twitter(allow_newlines) > 0} { set input [string map [list \\n \n] $input] ; set ncount [regexp -all {\n} $input] } { set ncount 0 }
	if {$act} {
		if {[string length $tformat]} {
			set tweetform "$ret$ment[string map [list %nick "" %chan $chan %text "$input" "%modes" "[proc:tweet:modes $nick $chan]"] $tformat]"
		} else {
			set tweetform "$ret$ment[string map [list %nick "" %chan $chan %text "$input" "%modes" "[proc:tweet:modes $nick $chan]"] $twitter(globaltweetformat)]"
		}
	} else {
		if {[string length $tformat]} {
			set tweetform "$ret$ment[string map [list %nick "* $nick" %chan $chan %text "$input" "%modes" "[proc:tweet:modes $nick $chan]"] $tformat]"
		} else {
			set tweetform "$ret$ment[string map [list %nick "* $nick" %chan $chan %text "$input" "%modes" "[proc:tweet:modes $nick $chan]"] $twitter(globaltweetformat)]"
		}
	}	
	if {[string length $tweetform] > [expr {140 - $ncount}]} {
		set cut " \[truncated] (...[string range [string map [list \n " "] $tweetform] [expr {120 - $ncount}] [expr {139 - $ncount}]]>|<[string range [string map [list \n " "] $tweetform] [expr {140 - $ncount}] [expr {160 - $ncount}]]...)"
		set tweetform [string range $tweetform 0 [expr {139 - $ncount}]]
	} { set cut "" }
	if {[info exists replyid]} {
		append cut " \(reply to $replyid@$rep\)"
		set other "status=[http::formatQuery $tweetform]&in_reply_to_status_id=$replyid"
		set q [list [list "status" "[oauth:uri_escape $tweetform]"] [list "in_reply_to_status_id" "$replyid"]]
		if {[catch {set html [proc:twitter:oauth $twitter(tweet) POST $chan $q]} error]} { putserv "$to :$twitter(logo) $error" ; return }
		#catch {set http [::http::geturl "$twitter(tweet)" -query "status=[oauth:uri_escape $tweetform]&in_reply_to_status_id=$replyid" -headers [list "Authorization" "Basic $auth"] -timeout 10000]} error
	} else {
		if {![info exists dm]} {
			set q [list [list "status" "[oauth:uri_escape $tweetform]"]]
			if {[catch {set html [proc:twitter:oauth $twitter(tweet) POST $chan $q]} error]} { putserv "$to :$twitter(logo) $error" ; return }
		} else {
			set q [list [list screen_name $sn] [list "text" "[oauth:uri_escape $tweetform]"]]
			if {[catch {set html [proc:twitter:oauth $twitter(private_new) POST $chan $q]} error]} { putserv "$to :$twitter(logo) $error" ; return }
		}
	}
	if {[info exists state(charset)]} {
		set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
	} else {
		set twitter(charset) "utf-8"
	}
	set html [proc:twitter:encode $html]
	if {[string match "*\"error*" $html]} {
		set text [string range "[join [lrange [split $html \"] 5 end]]" 0 end-1]
		putserv "$to :$twitter(logo) $text"
	} else {
		if {![regexp -- {"created_at"\:"(.*?)".*?"created_at"\:"(.*?)"} $html - c c1]} { set c "" }
		if {[info exists c1] && [info exists c]} {
			if {[proc:twitter:duration $c 1] < [proc:twitter:duration $c1 1]} { set chek $c1 } { set chek $c }
		} elseif {[info exists c1] && ![info exists c]} {
			set chek $c1
		} else {
			set chek $c
		}
		if {![info exists dm]} {
			if {[regexp -- {"source"\:(.*?)(?:,|\{|$)} $html - s]} {
				regsub -all -- {<.*?>} [proc:twitter:descdecode $s] "" s
				set s [string trim $s "\"\}" ]
			} else { set s "" }
		} else {
			set s "DM"
		}
		#regsub -nocase {\{.*?\}} $html "" html
		if {![info exists dm]} {
			regexp -nocase {"id_str"\:"(.*?)".*?"id_str"\:"(.*?)"} $html - id id2
			if {[info exists id] && [info exists id2]} {
				if {$id < $id2} { set id $id2 }
			} elseif {[info exists id2] && ![info exists id]} {
				set id $id2
			} elseif {![info exists id2] && ![info exists id]} {
     	             set id ""
			}
		} else {
			if {![regexp -- {"id_str"\:"(.*?)".*?"id_str"\:"(.*?)".*?"id_str"\:"(.*?)"} $html - id id2 id3]} {
				if {![regexp -- {"id_str"\:"(.*?)"} $html - id]} { set id "" }
            	} else {
				if {$id < $id3} {
					set id $id3
					if {$id3 < $id2} {
						set id $id2
					}
				}
			}
		}
		if {![info exists dm]} {
			set tt [string map [list %created% "[proc:twitter:duration [string trim $chek]]" %source% "[string trim $s]" %id% "$id" %user% "$tuser" %chan% "$chan" %trunc% "$cut"] $twitter(tweet-display)]
		} else {
			set tt [string map [list %created% "[proc:twitter:duration [string trim $chek]]" %source% "[string trim $s]" %id% "$id" %user% "$tuser" %chan% "$chan" %trunc% "$cut"] $twitter(private-display)]
		}
		putserv "$to :$twitter(logo) $tt"
		#putserv "$to :$twitter(logo) Tweet created: [proc:twitter:duration [string trim $chek]] via [string trim $s] \($id@$tuser\) \($chan\) @ http://twitter.com/$tuser$cut"
	}
}

proc proc:twitter:twittiny {url type} {
	set ua "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5"
	set http [::http::config -useragent $ua -urlencoding "utf-8"]
	switch -- $type {
		2 { set type [rand 2] }
		3 { if {![info exists ::twitterCount]} {
				set ::twitterCount 0
				set type 0
			} else {
				set type [expr {[incr ::twitterCount] % 2}]
			}
		}
	}

	switch -- $type {
		0 { set query "http://is.gd/api.php?[http::formatQuery longurl $url]" }
		1 { set query "http://cli.gs/api/v1/cligs/create?[http::formatQuery url $url]&title=&key=&appid=webby" }
	}
	set token [http::geturl $query -timeout 10000]
	upvar #0 $token state
	if {![string match "* *" $state(body)]} { return [string map {"\n" ""} $state(body)] }
	return $url
}

proc proc:twitter {nick uhand handle chan input} {
	if {[channel get $chan twitter]} {
		global twitter
		# string map in replacements for output
		set to [string map [list "%chan" $chan "%nick" $nick] $twitter(output)]
		if {[proc:twitter:throttled $uhand,$chan,twitter $twitter(throttle)]} {
			putserv "$to :$twitter(logo) Throttled.. Your going too fast and making my head spin!"
			return 0
		}
		if {![llength [split $input]]} {
			putserv "$to :$twitter(logo) Please be more specific I need a user name example: !twitter username"
		} else {
			# proper support for utf-8; twitter uses utf-8
			# *requires http 2.5+
			if {[info exists twitter(noutf8)]} {
				set http [::http::config -useragent $twitter(agent)]
			} else {
				set http [::http::config -useragent $twitter(agent) -urlencoding "utf-8"]
			}
			# fancy url constructor; utf-8 safe; special character safe
			# *uses http packages format query
			foreach word [split $input] { lappend query [http::formatQuery $word] }
			# error catching, this also captures our url into the variable u
			if {![info exists twitter(noutf8)]} {
				catch { set http [::http::geturl "[set orig [set u "$twitter(url)[join $query "_"]"]]" -timeout 10000]} error
			} else {
				catch { set http [::http::geturl "[set orig [set u "$twitter(url)[join $query "_"]"]]" -headers $twitter(hdr) -timeout 10000]} error
			}
			# error condition 1, socket error or other general error
			if {![string match -nocase "::http::*" $error]} {
				putserv "$to :$twitter(logo) [string totitle [string map {"\n" " | "} $error]] \( $u \)"
				return 0
			}
			# error condition 2, http error
			if {![string equal -nocase [::http::status $http] "ok"]} {
				putserv "$to :$twitter(logo) [string totitle [::http::status $http]] \( $u \)"
				return 0
			}
			upvar #0 $http state
			set query $u ; set r 0
			set redir [::http::ncode $http]
			# REDIRECT LOOP OF JOY! YAY! GO GO SUPER ACTION REDIRECT MISSLE >>>===> *POW*
			while {[string match "*${redir}*" "303|302|301" ]} {
				foreach {name value} $state(meta) {
					if {[regexp -nocase ^location$ $name]} {
						if {![string match "http*" $value]} {
							# fix our locations if needed
							if {![string match "/" [string index $value 0]]} {
								set value "[join [lrange [split $query "/"] 0 2] "/"]/$value"
							} else {
								set value "[join [lrange [split $query "/"] 0 2] "/"]$value"
							}
						}
						catch {set http [::http::geturl "[string map {" " "%20"} $value]" -headers "Referer $query" -timeout 10000]} error
						# error condition 1, socket error or other general error
						if {![string match -nocase "::http::*" $error]} {
							putserv "$to :$twitter(logo) [string totitle [string map {"\n" " | "} $error]] \( $value \)"
							return 0
						}
						# error condition 2, http error
						if {![string equal -nocase [::http::status $http] "ok"]} {
							putserv "$to :$twitter(logo) [string totitle [::http::status $http]] \( $value \)"
							return 0
						}
						upvar #0 $http state
						set redir [::http::ncode $http]
						set u [set query [string map {" " "%20"} $value]]
						if {[incr r] > 10} { putserv "$to :$twitter(logo) redirect error (>10 too deep) \( $u \)" ; return }
					}
				}
			}
			# error condition 3, 40* error
			if {[string match -nocase "40*" [::http::ncode $http]]} {
				putserv "$to :$twitter(logo) \[[::http::ncode $http]\] Sorry, that page doesn't exist! \( $u \)"
				return 0
			}
			# charset info to render our html
#			set twitter(charset) [string map -nocase {"UTF-" "utf-" "iso-" "iso" "windows-" "cp" "shift_jis" "shiftjis"} $state(charset)]
			# get data.
			set html [proc:twitter:encode "[proc:twitter:gzipinflate "[::http::data $http]" $state(meta)]"]
			# cleanup http array
			::http::cleanup $http
			regsub -all "\n" $html " " html
			# scrape output
#			set regionalized [regexp -- {<html lang="(.*?)"} $html "" reglang]
			if {[regexp -nocase -- { <h1 class="fullname">(.*?)</h1>} $html - name]} {
				set nametag "Name"
				regsub -all -nocase -- {<i.*?class="verified.*?title="(.*?)profile"></i>} $name "\\1" name
				set name [string trim $name]
			} else {
				if {[regexp -nocase -- {<ul class="about vcard.*?author">.*?<span class="label">(.*?)</span></li>.*?<span class="label">(.*?)</span></li>} $html - stats locale]} {
					regsub -all -- {<.*?>} $stats "" stats
					set nametag [string trim [lindex [split $stats] 0]]
					set name [string trim [join [lrange [split $stats] 1 end]]]
					regsub -all -- {<.*?>} $locale "" locale
					set locationtag [string trim [lindex [split $locale] 0]]
					set location [proc:twitter:descdecode [proc:twitter:descdecode [string trim [join [lrange [split $$locale] 1 end]]]]]
				}
			}
			if {![info exists location]} {
				if {[regexp -nocase -- {<span class="location">(.*?)</span>} $html - location]} {
					set location [proc:twitter:descdecode [proc:twitter:descdecode [string trim $location]]]
					set locationtag "Location"
				}
			}
			if {[regexp -nocase -- {data-element-term="following_stats" data-nav='following'>.*?<strong>(.*?)</strong>.*?Following} $html - following]} {set following [string trim $following]}
			if {[regexp -nocase -- {data-element-term="follower_stats" data-nav='followers'>.*?<strong>(.*?)</strong>.*?Followers} $html - followers]} {set followers [string trim $followers]}
			if {[regexp -nocase -- {data-element-term="tweet_stats" data-nav='profile'>.*?<strong>(.*?)</strong>.*?Tweet} $html - totaltweets]} {set totaltweets [string trim $totaltweets]}
			if {[regexp -nocase -- {data-screen-name=".*?" data-user-id="(.*?)">} $html - id]} {set id [string trim $id]}
#			if {[regexp -nocase -- {class="tweet-timestamp js-permalink" title="(.*?)" ><span class="_timestamp.*?data-time="(.*?)".*?data-long-form="true">(.*?)</span></a>} $html - tweettime tweetplace tweetreply]} {
#				set tweettime [string trim $tweettime]
#				regsub -all -- {<.*?>} $tweetplace "" tweetplace
#				set tweetplace [string trim $tweetplace]
#				regsub -all -- {<.*?>} $tweetreply "" tweetreply
#				set tweetreply [string trim $tweetreply]
#				set tweetplace [string trim [append tweetplace " $tweetreply"]]
#			}
			if {[regexp -nocase -- {<p class="bio ">(.*?)</p>} $html - bio]} { 
                                regsub -all -nocase -- {<a.*?title="(.*?)"><s>#</s><b>.*?</b></a>} $bio "\\1" bio
                                regsub -all -nocase -- {<a.*?rel="nofollow">(.*?)</a>} $bio "\\1" bio
                                regsub -all -nocase -- {<s>@</s><b>(.*?)</b>} $bio "@\\1" bio
			set bio [string trim $bio] 
			}
			if {[regexp -nocase -- {<p class="js-tweet-text">(.*?)</p>} $html - ltweet]} {
				# scrub html elements out
				regsub -all -nocase -- {<a.*?href="/search.*?<s>#</s><b>(.*?)</b>.*?</a>} $ltweet "#\\1" ltweet
                                regsub -all -nocase -- {<a.*?href="/.*?atreply.*?<s>@</s><b>(.*?)</b>.*?</a>} $ltweet "@\\1" ltweet
                                regsub -all -nocase -- {<a.*?href.*?target="_blank".*?data-expanded-url="(.*?)" title=".*?</span>.*?</a>} $ltweet "\\1" ltweet
				set ltweet [string trim $ltweet]
#				regsub -all -nocase -- {<a target="_blank" class="twitter.*?href="(.*?)".*?>(.*?)</a>} $ltweet "( \\1 )" ltweet
#                                regsub -all -nocase -- {<a class="twitter-.*?href=".*?" ><s>@</s><b>(.*?)</b></a>} $ltweet "@\\1" ltweet
			}
			set extra ""
			if {[info exists name] && [info exists nametag]} { append extra "$nametag: [proc:twitter:effect $name]; " }
			if {[info exists location] && [info exists locationtag]} { append extra "$locationtag: [proc:twitter:effect $location]; " }

			# check if a variable we scraped exists
                      if {[info exists following]} {
                               # protected tweets?
                               if {[regexp -- {s account is protected.</h2>>} $html]} {
                                       # yes
                                       putserv "$to :$twitter(logo) ${extra}Following: [proc:twitter:effect $following]; Followers: [proc:twitter:effect $followers]; Total Tweets: [proc:twitter:effect "Tweets Protected"]."
                                       if {[info exists bio]} {
                                               putserv "$to :$twitter(logo) [proc:twitter:descdecode [proc:twitter:descdecode $bio]]"
                                       }
                                       putserv "$to :$twitter(logo) Maap sob, twitter nya di protected sob.."
                               } else {
                                       # no
                	                putserv "$to :$twitter(logo) ${extra}Following: [proc:twitter:effect $following]; Followers: [proc:twitter:effect $followers]; Total Tweets: [proc:twitter:effect $totaltweets]."
                                       if {[info exists bio]} {
                                               putserv "$to :$twitter(logo) [proc:twitter:descdecode [proc:twitter:descdecode $bio]]"
                                       }
#                                        putserv "$to :$twitter(logo) Commands lain: http://www.kaskus.xxx/twit.txt"

#putserv "$to :$twitter(logo) !tweet untuk tweet, contoh: !tweet dono ganteng"
#putserv "$to :$twitter(logo) !user untuk melihat time line, contoh: !user sakitjiwa 1-1"
#putserv "$to :$twitter(logo) !twitter untuk melihat info sederhana profil user, contoh: !twitter sakitjiwa"

                                       # a last tweet?
                                       if {[info exists ltweet]} {
                                               # yes
		   putserv "$to :$twitter(logo) \[$id\] [proc:twitter:descdecode [proc:twitter:descdecode $ltweet]]"
#                   putserv "$to :$twitter(logo) Last Tweet: \[$id\] \($tweettime $tweetplace\) [proc:twitter:descdecode [proc:twitter:descdecode $ltweet]]"
                                       } else {
                                               # no
                                               putserv "$to :$twitter(logo) Maap sob, twitter nya di protected sob.. atau ndak pernah ngetweet sob.."
                                       }
                               }

                               # locked
                      } elseif {[regexp -nocase -- {<body class=".*?" id="locked">} $html]} {
                               if {![regexp -nocase -- {<h1>(.*?)</h1>} $html - reply]} { set reply "Account is locked, cannot parse a reply though.. O_o;?" }
                               putserv "$to :$twitter(logo) $reply \( $orig -> $u \)"
                               # suspended
                       } elseif {[regexp -nocase -- {<body class=".*?" id="suspended">} $html]} {
                               if {![regexp -nocase -- {<h2>.*?<p>(.*?)</p>} $html - reply]} { set reply "Account is suspended, cannot parse a reply though.. O_o;?" }
                               putserv "$to :$twitter(logo) $reply \( $orig -> $u \)"
                       } else {
                               # if not, give a funny message, bascially the regexp's above are
                               # broken and need maintenance when this message appears.
                               putserv "$to :$twitter(logo) Houston, we have a problem. Oxygen level is low. Atmospheric pressure is dropping."
                       }

		}
	}
}

putlog "Twitter, Tweets with Megahal v5.05a (Idea and original script by Warlord, Edited by dono) Loaded.."

# eof

