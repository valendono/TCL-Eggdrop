
######################################################################
# Adzan By JoJo
# Modifikasi otomatis oleh dono - irc.ayochat.or.id
# Version 1.0.2
# Initial release: 20 November 2009
# Modifikasi oleh dono: 20 April 2014
# last update 08 May 2016
######################################################################
# Q: Bagaimana ganti daerah default ?
# A: Cari cetak 308 "Jakarta Pusat" "" gantilah sesuai daerah yang diinginkan
# Q: Trus apalagi yang harus di update dan supaya tcl ini jalan ?
# A: Sebut nama dono 2x lalu wajib memakai http.tcl dan set lah `multichan-nya'
######################################################################
# Update 1.0.2
# Tidak berpatokan pada server tertentu, tapi pada jam pada mesin server menjalankan eggdrop
######################################################################
######################################################################
package require http

set init-server {
        putlog "Init server dan lakukan pengecekan"
        set sedangrunning "true"
        set kodedaerah "Jakarta Pusat"
	set daerah "308"
        otomatis
}

set kodedaerah "Jakarta Pusat"
set daerah "308"

#bind pub o|m !adzanstart pub:adzan 
#enable jika diperlukan, tapi gak ah, kamu ndak perlu ini, serba otomatis
bind pub - !adzan pub:sholat
bind pub - !adzanstatus pub:adzanstatus 
bind time - "00 * * * *" sholat
set shelltime_setting(format) "%A %B %d %Y -- %H:%M:%S"
set multichan "#jakarta #indonesia #bawel"
set sedangrunning "true"
set bedawaktuserver "5" 
#artinya +5, saat ini masih tidak bisa -1 atau - lainnya


# ganti daerah yang diinginkan
proc percetakan {} { 
	global kodedaerah daerah
	cetak $daerah "$kodedaerah" ""
	}

proc otomatis {} {
	pub:pengecekan
	percetakan
}

proc sholat {mins hours days months years} { 
	pub:pengecekan
	percetakan
}


proc pub:jam {nick uhost hand chan text} {
	setwaktu
}
proc pub:sholat {nick uhost hand chan text} {
	global daerah kodedaerah 
	set daerah ""
	if {$text == ""} {
          puthelp "NOTICE $nick :Gunakan: !adzan batam"
          return 0
	 }
set namanih [string tolower $text]
switch -- $namanih {
	"ambarawa" { set daerah "1" 
	set namadaerah "Ambarawa" }
	"ambon" { set daerah "2" 
	set namadaerah "Ambon" }
	"amlapura" { set daerah "3" 
	set namadaerah "Amlapura" }
	"amuntai" { set daerah "4" 
	set namadaerah "Amuntai" }
	"argamakmur" { set daerah "5" 
	set namadaerah "Argamakmur" }
	"atambua" { set daerah "6" 
	set namadaerah "Atambua" }
	"babo" { set daerah "7" 
	set namadaerah "Babo" }
	"bagan siapiapi" { set daerah "8" 
	set namadaerah "Bagan Siapiapi" }
	"bajawa" { set daerah "9" 
	set namadaerah "Bajawa" }
	"balige" { set daerah "10" 
	set namadaerah "Balige" }
	"balikpapan" { set daerah "11" 
	set namadaerah "Balikpapan" }
	"banda aceh" { set daerah "12" 
	set namadaerah "Banda Aceh" }
	"bandarlampung" { set daerah "13" 
	set namadaerah "Bandarlampung" }
	"bandung" { set daerah "14" 
	set namadaerah "Bandung" }
	"bangkalan" { set daerah "15" 
	set namadaerah "Bangkalan" }
	"bangkinang" { set daerah "16" 
	set namadaerah "Bangkinang" }
	"bangko" { set daerah "17" 
	set namadaerah "Bangko" }
	"bangli" { set daerah "18" 
	set namadaerah "Bangli" }
	"banjar" { set daerah "19" 
	set namadaerah "Banjar" }
	"banjar baru" { set daerah "20" 
	set namadaerah "Banjar Baru" }
	"banjarmasin" { set daerah "21" 
	set namadaerah "Banjarmasin" }
	"banjarnegara" { set daerah "22" 
	set namadaerah "Banjarnegara" }
	"bantaeng" { set daerah "23" 
	set namadaerah "Bantaeng" }
	"banten" { set daerah "24" 
	set namadaerah "Banten" }
	"bantul" { set daerah "25" 
	set namadaerah "Bantul" }
	"banyuwangi" { set daerah "26" 
	set namadaerah "Banyuwangi" }
	"barabai" { set daerah "27" 
	set namadaerah "Barabai" }
	"barito" { set daerah "28" 
	set namadaerah "Barito" }
	"barru" { set daerah "29" 
	set namadaerah "Barru" }
	"batam" { set daerah "30" 
	set namadaerah "Batam" }
	"batang" { set daerah "31" 
	set namadaerah "Batang" }
	"baturaja" { set daerah "33" 
	set namadaerah "Baturaja" }
	"batusangkar" { set daerah "34" 
	set namadaerah "Batusangkar" }
	"baubau" { set daerah "35" 
	set namadaerah "Baubau" }
	"bekasi" { set daerah "36" 
	set namadaerah "Bekasi" }
	"bengkalis" { set daerah "37" 
	set namadaerah "Bengkalis" }
	"bengkulu" { set daerah "38" 
	set namadaerah "Bengkulu" }
	"benteng" { set daerah "39" 
	set namadaerah "Benteng" }
	"biak" { set daerah "40" 
	set namadaerah "Biak" }
	"bima" { set daerah "41" 
	set namadaerah "Bima" }
	"binjai" { set daerah "42" 
	set namadaerah "Binjai" }
	"bireuen" { set daerah "43" 
	set namadaerah "Bireuen" }
	"bitung" { set daerah "44" 
	set namadaerah "Bitung" }
	"blitar" { set daerah "45" 
	set namadaerah "Blitar" }
	"blora" { set daerah "46" 
	set namadaerah "Blora" }
	"bogor" { set daerah "47" 
	set namadaerah "Bogor" }
	"bojonegoro" { set daerah "48" 
	set namadaerah "Bojonegoro" }
	"bondowoso" { set daerah "49" 
	set namadaerah "Bondowoso" }
	"bontang" { set daerah "50" 
	set namadaerah "Bontang" }
	"boyolali" { set daerah "51" 
	set namadaerah "Boyolali" }
	"brebes" { set daerah "52" 
	set namadaerah "Brebes" }
	"bukit tinggi" { set daerah "53" 
	set namadaerah "Bukit Tinggi" }
	"bulukumba" { set daerah "54" 
	set namadaerah "Bulukumba" }
	"buntok" { set daerah "55" 
	set namadaerah "Buntok" }
	"cepu" { set daerah "56" 
	set namadaerah "Cepu" }
	"ciamis" { set daerah "57" 
	set namadaerah "Ciamis" }
	"cianjur" { set daerah "58" 
	set namadaerah "Cianjur" }
	"cibinong" { set daerah "59" 
	set namadaerah "Cibinong" }
	"cilacap" { set daerah "60" 
	set namadaerah "Cilacap" }
	"cilegon" { set daerah "61" 
	set namadaerah "Cilegon" }
	"cimahi" { set daerah "62" 
	set namadaerah "Cimahi" }
	"cirebon" { set daerah "63" 
	set namadaerah "Cirebon" }
	"curup" { set daerah "64" 
	set namadaerah "Curup" }
	"demak" { set daerah "65" 
	set namadaerah "Demak" }
	"denpasar" { set daerah "66" 
	set namadaerah "Denpasar" }
	"depok" { set daerah "67" 
	set namadaerah "Depok" }
	"dili" { set daerah "68" 
	set namadaerah "Dili" }
	"dompu" { set daerah "69" 
	set namadaerah "Dompu" }
	"donggala" { set daerah "70" 
	set namadaerah "Donggala" }
	"dumai" { set daerah "71" 
	set namadaerah "Dumai" }
	"ende" { set daerah "72" 
	set namadaerah "Ende" }
	"enggano" { set daerah "73" 
	set namadaerah "Enggano" }
	"enrekang" { set daerah "74" 
	set namadaerah "Enrekang" }
	"fakfak" { set daerah "75" 
	set namadaerah "Fakfak" }
	"garut" { set daerah "76" 
	set namadaerah "Garut" }
	"gianyar" { set daerah "77" 
	set namadaerah "Gianyar" }
	"gombong" { set daerah "78" 
	set namadaerah "Gombong" }
	"gorontalo" { set daerah "79" 
	set namadaerah "Gorontalo" }
	"gresik" { set daerah "80" 
	set namadaerah "Gresik" }
	"gunung sitoli" { set daerah "81" 
	set namadaerah "Gunung Sitoli" }
	"indramayu" { set daerah "82" 
	set namadaerah "Indramayu" }
	"jakarta barat" { set daerah "309" 
	set namadaerah "Jakarta Barat" }
	"jakarta selatan" { set daerah "310" 
	set namadaerah "Jakarta Selatan" }
	"jakarta timur" { set daerah "311" 
	set namadaerah "Jakarta Timur" }
	"jakarta utara" { set daerah "312" 
	set namadaerah "Jakarta Utara" }
	"jambi" { set daerah "83" 
	set namadaerah "Jambi" }
	"jayapura" { set daerah "84" 
	set namadaerah "Jayapura" }
	"jember" { set daerah "85" 
	set namadaerah "Jember" }
	"jeneponto" { set daerah "86" 
	set namadaerah "Jeneponto" }
	"jepara" { set daerah "87" 
	set namadaerah "Jepara" }
	"jombang" { set daerah "88" 
	set namadaerah "Jombang" }
	"kabanjahe" { set daerah "89" 
	set namadaerah "Kabanjahe" }
	"kalabahi" { set daerah "90" 
	set namadaerah "Kalabahi" }
	"kalianda" { set daerah "91" 
	set namadaerah "Kalianda" }
	"kandangan" { set daerah "92" 
	set namadaerah "Kandangan" }
	"karanganyar" { set daerah "93" 
	set namadaerah "Karanganyar" }
	"karawang" { set daerah "94" 
	set namadaerah "Karawang" }
	"kasungan" { set daerah "95" 
	set namadaerah "Kasungan" }
	"kayuagung" { set daerah "96" 
	set namadaerah "Kayuagung" }
	"kebumen" { set daerah "97" 
	set namadaerah "Kebumen" }
	"kediri" { set daerah "98" 
	set namadaerah "Kediri" }
	"kefamenanu" { set daerah "99" 
	set namadaerah "Kefamenanu" }
	"kendal" { set daerah "100" 
	set namadaerah "Kendal" }
	"kendari" { set daerah "101" 
	set namadaerah "Kendari" }
	"kertosono" { set daerah "102" 
	set namadaerah "Kertosono" }
	"ketapang" { set daerah "103" 
	set namadaerah "Ketapang" }
	"kisaran" { set daerah "104" 
	set namadaerah "Kisaran" }
	"klaten" { set daerah "105" 
	set namadaerah "Klaten" }
	"kolaka" { set daerah "1" 
	set namadaerah "Kolaka" }
	"kota baru pulau laut" { set daerah "107" 
	set namadaerah "Kota Baru Pulau Laut" }
	"kota bumi" { set daerah "108" 
	set namadaerah "Kota Bumi" }
	"kota jantho" { set daerah "109" 
	set namadaerah "Kota Jantho" }
	"kotamobagu" { set daerah "110" 
	set namadaerah "Kotamobagu" }
	"kuala kapuas" { set daerah "111" 
	set namadaerah "Kuala Kapuas" }
	"kuala kurun" { set daerah "112" 
	set namadaerah "Kuala Kurun" }
	"kuala pembuang" { set daerah "113" 
	set namadaerah "Kuala Pembuang" }
	"kuala tungkal" { set daerah "114" 
	set namadaerah "Kuala Tungkal" }
	"kudus" { set daerah "115" 
	set namadaerah "Kudus" }
	"kuningan" { set daerah "116" 
	set namadaerah "Kuningan" }
	"kupang" { set daerah "117" 
	set namadaerah "Kupang" }
	"kutacane" { set daerah "118" 
	set namadaerah "Kutacane" }
	"kutoarjo" { set daerah "119" 
	set namadaerah "Kutoarjo" }
	"labuhan" { set daerah "120" 
	set namadaerah "Labuhan" }
	"lahat" { set daerah "121" 
	set namadaerah "Lahat" }
	"lamongan" { set daerah "122" 
	set namadaerah "Lamongan" }
	"langsa" { set daerah "123" 
	set namadaerah "Langsa" }
	"larantuka" { set daerah "124" 
	set namadaerah "Larantuka" }
	"lawang" { set daerah "125" 
	set namadaerah "Lawang" }
	"lhoseumawe" { set daerah "126" 
	set namadaerah "Lhoseumawe" }
	"limboto" { set daerah "127" 
	set namadaerah "Limboto" }
	"lubuk basung" { set daerah "128" 
	set namadaerah "Lubuk Basung" }
	"lubuk linggau" { set daerah "129" 
	set namadaerah "Lubuk Linggau" }
	"lubuk pakam" { set daerah "130" 
	set namadaerah "Lubuk Pakam" }
	"lubuk sikaping" { set daerah "131" 
	set namadaerah "Lubuk Sikaping" }
	"lumajang" { set daerah "132" 
	set namadaerah "Lumajang" }
	"luwuk" { set daerah "133" 
	set namadaerah "Luwuk" }
	"madiun" { set daerah "134" 
	set namadaerah "Madiun" }
	"magelang" { set daerah "135" 
	set namadaerah "Magelang" }
	"magetan" { set daerah "136" 
	set namadaerah "Magetan" }
	"majalengka" { set daerah "137" 
	set namadaerah "Majalengka" }
	"majene" { set daerah "138" 
	set namadaerah "Majene" }
	"makale" { set daerah "139" 
	set namadaerah "Makale" }
	"makassar" { set daerah "140" 
	set namadaerah "Makassar" }
	"malang" { set daerah "141" 
	set namadaerah "Malang" }
	"mamuju" { set daerah "142" 
	set namadaerah "Mamuju" }
	"manna" { set daerah "143" 
	set namadaerah "Manna" }
	"manokwari" { set daerah "144" 
	set namadaerah "Manokwari" }
	"marabahan" { set daerah "145" 
	set namadaerah "Marabahan" }
	"maros" { set daerah "146" 
	set namadaerah "Maros" }
	"martapura kalsel" { set daerah "147" 
	set namadaerah "Martapura Kalsel" }
	"masohi" { set daerah "148" 
	set namadaerah "Masohi" }
	"mataram" { set daerah "149" 
	set namadaerah "Mataram" }
	"maumere" { set daerah "150" 
	set namadaerah "Maumere" }
	"medan" { set daerah "151" 
	set namadaerah "Medan" }
	"mempawah" { set daerah "152" 
	set namadaerah "Mempawah" }
	"menado" { set daerah "153" 
	set namadaerah "Menado" }
        "manado" { set daerah "153"
        set namadaerah "Manado" }
	"mentok" { set daerah "154" 
	set namadaerah "Mentok" }
	"merauke" { set daerah "155" 
	set namadaerah "Merauke" }
	"metro" { set daerah "156" 
	set namadaerah "Metro" }
	"meulaboh" { set daerah "157" 
	set namadaerah "Meulaboh" }
	"mojokerto" { set daerah "158" 
	set namadaerah "Mojokerto" }
	"muara bulian" { set daerah "159" 
	set namadaerah "Muara Bulian" }
	"muara bungo" { set daerah "160" 
	set namadaerah "Muara Bungo" }
	"muara enim" { set daerah "161" 
	set namadaerah "Muara Enim" }
	"muara teweh" { set daerah "162" 
	set namadaerah "Muara Teweh" }
	"muaro sijunjung" { set daerah "163" 
	set namadaerah "Muaro Sijunjung" }
	"muntilan" { set daerah "164" 
	set namadaerah "Muntilan" }
	"nabire" { set daerah "165" 
	set namadaerah "Nabire" }
	"negara" { set daerah "166" 
	set namadaerah "Negara" }
	"nganjuk" { set daerah "167" 
	set namadaerah "Nganjuk" }
	"ngawi" { set daerah "168" 
	set namadaerah "Ngawi" }
	"nunukan" { set daerah "169" 
	set namadaerah "Nunukan" }
	"pacitan" { set daerah "170" 
	set namadaerah "Pacitan" }
	"padang" { set daerah "171" 
	set namadaerah "Padang" }
	"padang panjang" { set daerah "172" 
	set namadaerah "Padang Panjang" }
	"padang sidempuan" { set daerah "173" 
	set namadaerah "Padang Sidempuan" }
	"pagaralam" { set daerah "174" 
	set namadaerah "Pagaralam" }
	"painan" { set daerah "175" 
	set namadaerah "Painan" }
	"palangkaraya" { set daerah "176" 
	set namadaerah "Palangkaraya" }
	"palembang" { set daerah "177" 
	set namadaerah "Palembang" }
	"palopo" { set daerah "178" 
	set namadaerah "Palopo" }
	"palu" { set daerah "179" 
	set namadaerah "Palu" }
	"pamekasan" { set daerah "180" 
	set namadaerah "Pamekasan" }
	"pandeglang" { set daerah "181" 
	set namadaerah "Pandeglang" }
	"pangka_" { set daerah "182" 
	set namadaerah "Pangka_" }
	"pangkajene sidenreng" { set daerah "183" 
	set namadaerah "Pangkajene Sidenreng" }
	"pangkalan bun" { set daerah "184" 
	set namadaerah "Pangkalan Bun" }
	"pangkalpinang" { set daerah "185" 
	set namadaerah "Pangkalpinang" }
	"panyabungan" { set daerah "186" 
	set namadaerah "Panyabungan" }
	"par_" { set daerah "187" 
	set namadaerah "Par_" }
	"parepare" { set daerah "188" 
	set namadaerah "Parepare" }
	"pariaman" { set daerah "189" 
	set namadaerah "Pariaman" }
	"pasuruan" { set daerah "190" 
	set namadaerah "Pasuruan" }
	"pati" { set daerah "191" 
	set namadaerah "Pati" }
	"payakumbuh" { set daerah "192" 
	set namadaerah "Payakumbuh" }
	"pekalongan" { set daerah "193" 
	set namadaerah "Pekalongan" }
	"pekan baru" { set daerah "194" 
	set namadaerah "Pekan Baru" }
	"pemalang" { set daerah "195" 
	set namadaerah "Pemalang" }
	"pematangsiantar" { set daerah "196" 
	set namadaerah "Pematangsiantar" }
	"pendopo" { set daerah "197" 
	set namadaerah "Pendopo" }
	"pinrang" { set daerah "198" 
	set namadaerah "Pinrang" }
	"pleihari" { set daerah "199" 
	set namadaerah "Pleihari" }
	"polewali" { set daerah "200" 
	set namadaerah "Polewali" }
	"pondok gede" { set daerah "201" 
	set namadaerah "Pondok Gede" }
	"ponorogo" { set daerah "202" 
	set namadaerah "Ponorogo" }
	"pontianak" { set daerah "203" 
	set namadaerah "Pontianak" }
	"poso" { set daerah "204" 
	set namadaerah "Poso" }
	"prabumulih" { set daerah "205" 
	set namadaerah "Prabumulih" }
	"praya" { set daerah "2" 
	set namadaerah "Praya" }
	"probolinggo" { set daerah "207" 
	set namadaerah "Probolinggo" }
	"purbalingga" { set daerah "208" 
	set namadaerah "Purbalingga" }
	"purukcahu" { set daerah "209" 
	set namadaerah "Purukcahu" }
	"purwakarta" { set daerah "210" 
	set namadaerah "Purwakarta" }
	"purwodadigrobogan" { set daerah "211" 
	set namadaerah "Purwodadigrobogan" }
	"purwokerto" { set daerah "212" 
	set namadaerah "Purwokerto" }
	"purworejo" { set daerah "213" 
	set namadaerah "Purworejo" }
	"putussibau" { set daerah "214" 
	set namadaerah "Putussibau" }
	"raha" { set daerah "215" 
	set namadaerah "Raha" }
	"rangkasbitung" { set daerah "216" 
	set namadaerah "Rangkasbitung" }
	"rantau" { set daerah "217" 
	set namadaerah "Rantau" }
	"rantauprapat" { set daerah "218" 
	set namadaerah "Rantauprapat" }
	"rantepao" { set daerah "219" 
	set namadaerah "Rantepao" }
	"rembang" { set daerah "220" 
	set namadaerah "Rembang" }
	"rengat" { set daerah "221" 
	set namadaerah "Rengat" }
	"ruteng" { set daerah "222" 
	set namadaerah "Ruteng" }
	"sabang" { set daerah "223" 
	set namadaerah "Sabang" }
	"salatiga" { set daerah "224" 
	set namadaerah "Salatiga" }
	"samarinda" { set daerah "225" 
	set namadaerah "Samarinda" }
	"sambas, kalbar" { set daerah "313" 
	set namadaerah "Sambas, Kalbar" }
	"sampang" { set daerah "226" 
	set namadaerah "Sampang" }
	"sampit" { set daerah "227" 
	set namadaerah "Sampit" }
	"sanggau" { set daerah "228" 
	set namadaerah "Sanggau" }
	"sawahlunto" { set daerah "229" 
	set namadaerah "Sawahlunto" }
	"sekayu" { set daerah "230" 
	set namadaerah "Sekayu" }
	"selong" { set daerah "231" 
	set namadaerah "Selong" }
	"semarang" { set daerah "232" 
	set namadaerah "Semarang" }
	"sengkang" { set daerah "233" 
	set namadaerah "Sengkang" }
	"serang" { set daerah "234" 
	set namadaerah "Serang" }
	"serui" { set daerah "235" 
	set namadaerah "Serui" }
	"sibolga" { set daerah "236" 
	set namadaerah "Sibolga" }
	"sidikalang" { set daerah "237" 
	set namadaerah "Sidikalang" }
	"sidoarjo" { set daerah "238" 
	set namadaerah "Sidoarjo" }
	"sigli" { set daerah "239" 
	set namadaerah "Sigli" }
	"singaparna" { set daerah "240" 
	set namadaerah "Singaparna" }
	"singaraja" { set daerah "241" 
	set namadaerah "Singaraja" }
	"singkawang" { set daerah "242" 
	set namadaerah "Singkawang" }
	"sinjai" { set daerah "243" 
	set namadaerah "Sinjai" }
	"sintang" { set daerah "244" 
	set namadaerah "Sintang" }
	"situbondo" { set daerah "245" 
	set namadaerah "Situbondo" }
	"slawi" { set daerah "246" 
	set namadaerah "Slawi" }
	"sleman" { set daerah "247" 
	set namadaerah "Sleman" }
	"soasiu" { set daerah "248" 
	set namadaerah "Soasiu" }
	"soe" { set daerah "249" 
	set namadaerah "Soe" }
	"solo" { set daerah "250" 
	set namadaerah "Solo" }
	"solok" { set daerah "251" 
	set namadaerah "Solok" }
	"soreang" { set daerah "252" 
	set namadaerah "Soreang" }
	"sorong" { set daerah "253" 
	set namadaerah "Sorong" }
	"sragen" { set daerah "254" 
	set namadaerah "Sragen" }
	"stabat" { set daerah "255" 
	set namadaerah "Stabat" }
	"subang" { set daerah "256" 
	set namadaerah "Subang" }
	"sukabumi" { set daerah "257" 
	set namadaerah "Sukabumi" }
	"sukoharjo" { set daerah "258" 
	set namadaerah "Sukoharjo" }
	"sumbawa besar" { set daerah "259" 
	set namadaerah "Sumbawa Besar" }
	"sumedang" { set daerah "260" 
	set namadaerah "Sumedang" }
	"sumenep" { set daerah "261" 
	set namadaerah "Sumenep" }
	"sungai liat" { set daerah "262" 
	set namadaerah "Sungai Liat" }
	"sungai penuh" { set daerah "263" 
	set namadaerah "Sungai Penuh" }
	"sungguminasa" { set daerah "264" 
	set namadaerah "Sungguminasa" }
	"surabaya" { set daerah "265" 
	set namadaerah "Surabaya" }
	"surakarta" { set daerah "266" 
	set namadaerah "Surakarta" }
	"tabanan" { set daerah "267" 
	set namadaerah "Tabanan" }
	"tahuna" { set daerah "268" 
	set namadaerah "Tahuna" }
	"takalar" { set daerah "269" 
	set namadaerah "Takalar" }
	"takengon" { set daerah "270" 
	set namadaerah "Takengon" }
	"tamiang layang" { set daerah "271" 
	set namadaerah "Tamiang Layang" }
	"tanah grogot" { set daerah "272" 
	set namadaerah "Tanah Grogot" }
	"tangerang" { set daerah "273" 
	set namadaerah "Tangerang" }
	"tanjung balai" { set daerah "274" 
	set namadaerah "Tanjung Balai" }
	"tanjung enim" { set daerah "275" 
	set namadaerah "Tanjung Enim" }
	"tanjung pandan" { set daerah "276" 
	set namadaerah "Tanjung Pandan" }
	"tanjung pinang" { set daerah "277" 
	set namadaerah "Tanjung Pinang" }
	"tanjung redep" { set daerah "278" 
	set namadaerah "Tanjung Redep" }
	"tanjung selor" { set daerah "279" 
	set namadaerah "Tanjung Selor" }
	"tapak tuan" { set daerah "280" 
	set namadaerah "Tapak Tuan" }
	"tarakan" { set daerah "281" 
	set namadaerah "Tarakan" }
	"tarutung" { set daerah "282" 
	set namadaerah "Tarutung" }
	"tasikmalaya" { set daerah "283" 
	set namadaerah "Tasikmalaya" }
	"tebing tinggi" { set daerah "284" 
	set namadaerah "Tebing Tinggi" }
	"tegal" { set daerah "285" 
	set namadaerah "Tegal" }
	"temanggung" { set daerah "286" 
	set namadaerah "Temanggung" }
	"tembilahan" { set daerah "287" 
	set namadaerah "Tembilahan" }
	"tenggarong" { set daerah "288" 
	set namadaerah "Tenggarong" }
	"ternate" { set daerah "289" 
	set namadaerah "Ternate" }
	"tolitoli" { set daerah "290" 
	set namadaerah "Tolitoli" }
	"tondano" { set daerah "291" 
	set namadaerah "Tondano" }
	"trenggalek" { set daerah "292" 
	set namadaerah "Trenggalek" }
	"tual" { set daerah "293" 
	set namadaerah "Tual" }
	"tuban" { set daerah "294" 
	set namadaerah "Tuban" }
	"tulung agung" { set daerah "295" 
	set namadaerah "Tulung Agung" }
	"ujung berung" { set daerah "296" 
	set namadaerah "Ujung Berung" }
	"ungaran" { set daerah "297" 
	set namadaerah "Ungaran" }
	"waikabubak" { set daerah "298" 
	set namadaerah "Waikabubak" }
	"waingapu" { set daerah "299" 
	set namadaerah "Waingapu" }
	"wamena" { set daerah "300" 
	set namadaerah "Wamena" }
	"watampone" { set daerah "301" 
	set namadaerah "Watampone" }
	"watansoppeng" { set daerah "302" 
	set namadaerah "Watansoppeng" }
	"wates" { set daerah "303" 
	set namadaerah "Wates" }
	"wonogiri" { set daerah "304" 
	set namadaerah "Wonogiri" }
	"wonosari" { set daerah "305" 
	set namadaerah "Wonosari" }
	"wonosobo" { set daerah "3" 
	set namadaerah "Wonosobo" }
	"yogyakarta" { set daerah "307" 
	set namadaerah "Yogyakarta" }
	"jakarta pusat" { set daerah "308"
	set namadaerah "Jakarta Pusat" }
        "batu" { set daerah "32"
        set namadaerah "Batu" }

	default { 
	if { $daerah == ""} { set daerah "308" } else 
		{ set daerah "$daerah"	 
		  set namadaerah "$kodedaerah" }
	}
	
	if { $daerah == ""} { set daerah "308" }
	cetak $daerah $namadaerah $chan

	}
}

proc cetak {daerah namadaerah chan} {
global multichan waktusubuh waktudzuhur waktuashar waktumaghrib waktuisya waktutweet
  set connect [::http::geturl http://sholat.gq/adzan/daily.php?id=$daerah]
  set files [::http::data $connect]

    set l [regexp -all -inline -- {.*?<tr class="table_light" align="center"><td><b>.*?</b></td><td>.*?</td><td>(.*?)</td><td>.*?</td><td>.*?</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td><td>(.*?)</td></tr>.*?<tr class="table_block_title"><td colspan="9"><b>&nbsp;:: Parameter</b></td></tr>.*?<tr class="table_block_content"><td align="right" colspan="2">Arah :</td><td colspan="5">(.*?) \&deg\; ke Mekah</td></tr>.*?<tr class="table_block_content"><td align="right" colspan="2">Jarak :</td><td colspan="5">(.*?) km ke Mekah</td></tr>} $files]

if {[llength $l] != 0} {

     foreach {black a b c d e f g} $l {

         set a [string trim $a " \n"]
         set b [string trim $b " \n"]
         set c [string trim $c " \n"]
         set d [string trim $d " \n"]
     	 set e [string trim $e " \n"]
         set f [string trim $f " \n"]
         set g [string trim $g " \n"]

         regsub -all {<.+?>} $a {} a
         regsub -all {<.+?>} $b {} b
         regsub -all {<.+?>} $c {} c
         regsub -all {<.+?>} $d {} d
         regsub -all {<.+?>} $e {} e
         regsub -all {<.+?>} $f {} f
         regsub -all {<.+?>} $g {} g

	if {[llength $chan] != 0} {
	setwaktu
	puthelp "PRIVMSG $chan :\[\002Adzan $namadaerah, $waktutweet\002\] Subuh: $a - Dzuhur: $b - Ashar: $c - Maghrib: $d - Isya: $e - Arah $f derajat \& jarak $g KM ke Mekah" 

	set daerah ""
	set namadaerah ""

	} else { putlog "loading dan copy dari web ..." }

        set waktusubuh "$a:00"
        set waktudzuhur "$b:00"
	set waktuashar "$c:00"
	set waktumaghrib "$d:00"
	set waktuisya "$e:00"

		}
	}

}


set jam "00:00:xx"
set jamclean "00:00:00"
set waktu "xx xx xx"
set parent ""
set jamcocok "00:00:00"
set cektiap 1
set sedangrunning "true"
set adzanrange "false"



#######################################################################
# Set the clock format here. See below for a list of format settings. #
# ------------------------------------------------------------------- #
#                                                                     #
# %% - Insert a %.                                                    #
# %a - Abbreviated weekday name (Mon, Tue, etc.).                     #
# %A - Full weekday name (Monday, Tuesday, etc.).                     #
# %b - Abbreviated month name (Jan, Feb, etc.).                       #
# %B - Full month name.                                               #
# %c - Locale specific date and time.                                 #
# %d - Day of month (01 - 31).                                        #
# %H - Hour in 24-hour format (00 - 23).                              #
# %I - Hour in 12-hour format (00 - 12).                              #
# %j - Day of year (001 - 366).                                       #
# %m - Month number (01 - 12).                                        #
# %M - Minute (00 - 59).                                              #
# %p - AM/PM indicator.                                               #
# %S - Seconds (00 - 59).                                             #
# %U - Week of year (00 - 52), Sunday is the first day of the week.   #
# %w - Weekday number (Sunday = 0).                                   #
# %W - Week of year (00 - 52), Monday is the first day of the week.   #
# %x - Locale specific date format.                                   #
# %X - Locale specific time format.                                   #
# %y - Year without century (00 - 99).                                #
# %Y - Year with century (e.g. 1990)                                  #
# %Z - Time zone name.                                                #
# Supported on some systems only:                                     #
# %D - Date as %m/%d/%y.                                              #
# %e - Day of month (1 - 31), no leading zeros.                       #
# %h - Abbreviated month name.                                        #
# %n - Insert a newline.                                              #
# %r - Time as %I:%M:%S %p.                                           #
# %R - Time as %H:%M.                                                 #
# %t - Insert a tab.                                                  #
# %T - Time as %H:%M:%S.                                              #
#######################################################################

#bind pub - !startadzan shelljam_pub


#proc shelljam_pub {nick uhost hand chan text} {
#	global kodedaerah daerah
#	putlog "Init server dan lakukan pengecekan"
#	cetak 308 "Jakarta Puisat" ""
#	set sedangrunning "true"
#	pub:pengecekan
#	otomatis
#}


#set jam, jamclean, waktu
proc setwaktu { } {
global botnick waktu jam jamclean waktutweet shelltime_setting bedawaktuserver
set arguments [clock format [clock seconds] -format $shelltime_setting(format)]
 set day [lindex [split $arguments] 0]

 if {$day == "Monday"} { set hari "Senin" }
 if {$day == "Tuesday"} { set hari "Selasa" }
 if {$day == "Wednesday"} { set hari "Rabu" }
 if {$day == "Thursday"} { set hari "Kamis" }
 if {$day == "Friday"} { set hari "Jum'at" }
 if {$day == "Saturday"} { set hari "Sabtu" }
 if {$day == "Sunday"} { set hari "Minggu" }
 set tanggal [lindex [split $arguments] 2]
 set month [lindex [split $arguments] 1]
 if {$month == "January"} { set bulan "Januari" }
 if {$month == "February"} { set bulan "Februari" }
 if {$month == "March"} { set bulan "Maret" }
 if {$month == "April"} { set bulan "April" }
 if {$month == "May"} { set bulan "Mei" }
 if {$month == "June"} { set bulan "Juni" }
 if {$month == "July"} { set bulan "Juli" }
 if {$month == "August"} { set bulan "Agustus" }
 if {$month == "September"} { set bulan "September" }
 if {$month == "October"} { set bulan "Oktober" }
 if {$month == "November"} { set bulan "November" }
 if {$month == "December"} { set bulan "Desember" }
 set tahun [lindex [split $arguments] 3]
 set jam [lindex [split $arguments] 5]
 set temp11 [lindex [split $jam :] 0]
 set temp2 [lindex [split $jam :] 1]
 set temp1 [expr $temp11+$bedawaktuserver]
 set jamclean "$temp1:$temp2:00"
  
 set waktu "$hari, $tanggal $bulan $tahun $jam WIB"
 set waktutweet "$tanggal $bulan $tahun"

}

proc iscocok { text } {
global jamclean

if { $jamclean == $text } {
return 1
} else {
return 0
}

}

proc pub:waktureply { } {
global multichan parent
setwaktu
#$arguments

if { $parent == "showadzan" } {
	pub:adzanstatus
}

}

proc pub:pengecekan {} {
global sedangrunning cektiap waktusubuh waktudzuhur waktuashar waktumaghrib waktuisya multichan

#puthelp "PRIVMSG #gembels :isya: $waktuisya sedanrunning: $sedangrunning"
if {[llength $waktusubuh] == 0} { percetakan }

if { $sedangrunning == "true" } {
#konekserver
setwaktu

if { [iscocok $waktusubuh] } {
	pub:showadzan "Subuh" $waktusubuh
	} 
	
if { [iscocok $waktudzuhur] } {
	pub:showadzan "Dzuhur" $waktudzuhur
	}

if { [iscocok $waktuashar] } {
	pub:showadzan "Ashar" $waktuashar
	}

if { [iscocok $waktumaghrib] } {
	pub:showadzan "Maghrib" $waktumaghrib
	}

if { [iscocok $waktuisya] } {
	pub:showadzan "Isya" $waktuisya
	}

timer [expr $cektiap] pub:pengecekan
		
	}
}



proc pub:showadzan { text jamnya } {
global multichan adzanrange kodedaerah daerah waktusubuh waktudzuhur waktuashar waktumaghrib waktuisya
	
if { $adzanrange == "false" } {
        foreach channel $multichan {
#		puthelp "PRIVMSG $channel : Allahu akbar.. Allahu akbar.. Hayya' Alash Shalaah..."
		puthelp "PRIVMSG $channel :Waktu tepat menunjukan pukul $jamnya WIB, waktunya utk melaksanakan ibadah sholat $text untuk daerah $kodedaerah dan sekitar nya"
                puthelp "PRIVMSG $channel :Jadwal Adzan $kodedaerah Hari ini: Subuh: $waktusubuh - Dzuhur: $waktudzuhur - Ashar: $waktuashar - Maghrib : $waktumaghrib - Isya: $waktuisya"
#		putquick "NOTICE $channel :$jamnya WIB - Sholat $text untuk $kodedaerah dan sekitarnya"
        }

set adzanrange "true"
timer 2 turnoff:adzanrange
#tweetadzan "Adzan $text $jamnya WIB untuk daerah $kodedaerah dan sekitar nya"
return 0
}

}

proc turnoff:adzanrange {} {
global adzanrange
set adzanrange "false"
}





proc pub:adzanstatus {} {
global multichan waktusubuh waktudzuhur waktuashar waktumaghrib waktuisya waktu parent
set parent "adzanstatus"
        foreach channel $multichan {
	        puthelp "PRIVMSG $channel :Adzan: ON"
        }

}





putlog "Adzan Time By JoJo - Modifikasi otomatis oleh dono - irc.ayochat.or.id"

