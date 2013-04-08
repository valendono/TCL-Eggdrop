01) Go to http://twitter.com and login to your account 
02) After your logged in, visit this url: http://dev.twitter.com/apps/new 
03) Fill out the form. Choose CLIENT and READ/WRITE/DIRECT MESSAGE Access. The rest you can choose anything. Submit the form. 
04) Copy your Consumer_key and Consumer_secret into a text editor. 
05) Click the [my access token] button on the right. 
06) Copy your Access Token (oauth_token) and your Access Token Secret (oauth_token_secret) into the same text editor 
07) Extract the entire contents of twitter.zip into your scripts/ folder. 
08) open twitter.tcl and find the twitter(accts) section 
09) add your accts copying them from the text editor (this helps alleviate any typos) and make sure you follow the ordering set below. 
"#chan|acct|consumer_key|consumer_secret|access_token_key|access_token_secret" 
10) save twitter.tcl 
11) open eggdrop.conf 
12) edit eggdrop.conf adding the following scripts in the order below: 
If you have tcl-lib installed omit sourcing sha1 and base64 
source scripts/sha1.tcl 
source scripts/base64.tcl 
source scripts/oauth.tcl 
source scripts/twitter.tcl 
13) save eggdrop.conf 
14) .rehash, .restart, or start your bot 
15) log into partyline and issue the following commands. 
.chanset #yourchan +twitter 
.chanset #yourchan +twitterfriends 
.chanset #yourchan +twittermentions 
.chanset #yourchan +twittertrack 
.chanset #yourchan +twitterfollowers 
if you have megahal on your bot, you can also enable that 
.chanset #yourchan +twittermega 
.chanset #yourchan +twittermentionsmega 
16) try to check your status, type !user in #yourchan 
17) try to check your friends, type !friends in #yourchan 
18) try to follow someone, type +follow username 
19) try to track some search terms, type +track this that 
20) try to tweet, type !tweet some stuff here