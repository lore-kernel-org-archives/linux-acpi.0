From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch for 0.54
 (version 3)
Date: Wed, 08 Sep 2004 12:41:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <413EE1EA.2070307@pca.it>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403>
Reply-To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ipw2100-devel <ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Herman Sheremetyev <mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 09/08/04 07:38, Zhu, Yi wrote:
> Here comes the 3rd version of the suspend-resume patch.
it works perfectly on my ASUS M6N, 2.6.8.1 with no patch and S4: I can
suspend/resume directly from X (Debian XFree86-4.3.0.dfsg.1-7 & GNOME
2.7.92). All is working correctly, not only the ipw2100 driver but all
the other drivers, too. I mean, actually I loaded a lot of different
modules (see below), I just did 'echo 4 > /proc/acpi/sleep' different
times (this is the 3rd in sequence).
=====
luca@gismo:~$ lsmod
Module                  Size  Used by
ipw2100                98164  0
ieee80211              18564  1 ipw2100
ieee80211_crypt         6020  1 ieee80211
ds                     20744  4
lp                     10536  0
thermal                18576  0
fan                     5644  0
button                  8472  0
battery                12428  0
ac                      6668  0
asus_acpi              11544  0
rfcomm                 39324  0
l2cap                  26116  5 rfcomm
bluetooth              49668  4 rfcomm,l2cap
firmware_class         10496  1 ipw2100
ohci1394               36356  0
ieee1394              110772  1 ohci1394
yenta_socket           21888  0
pcmcia_core            72008  2 ds,yenta_socket
bcm5700               140844  0
snd_intel8x0m          21064  4
snd_intel8x0           36360  4
snd_ac97_codec         73348  2 snd_intel8x0m,snd_intel8x0
snd_pcm_oss            55080  0
snd_mixer_oss          20352  5 snd_pcm_oss
snd_pcm                98824  3 snd_intel8x0m,snd_intel8x0,snd_pcm_oss
snd_timer              26244  1 snd_pcm
snd_page_alloc         12040  3 snd_intel8x0m,snd_intel8x0,snd_pcm
snd_mpu401_uart         8448  1 snd_intel8x0
snd_rawmidi            25508  1 snd_mpu401_uart
snd_seq_device          8712  1 snd_rawmidi
snd                    58980  18
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              10592  5 snd
ehci_hcd               43652  0
uhci_hcd               33804  0
intel_agp              22944  1
agpgart                34984  1 intel_agp
parport_pc             23616  1
parport                26944  2 lp,parport_pc
pcspkr                  3944  0
joydev                 10176  0
evdev                   9856  1
xfs                   518008  0
ufs                    70660  0
udf                    90628  0
romfs                   9092  0
ntfs                   98516  0
jfs                   177608  0
hfsplus                60420  0
hfs                    47620  0
cramfs                 42996  0
zlib_inflate           22784  1 cramfs
cdfs                   28200  0
speedstep_centrino      8148  0
processor              25776  2 thermal,speedstep_centrino
fbcon                  31748  72
font                    8576  1 fbcon
radeonfb               63016  1
cfbcopyarea             4096  1 radeonfb
cfbimgblt               3328  1 radeonfb
cfbfillrect             3968  1 radeonfb
luca@gismo:~$
=====

There's only one minor problem: sometimes during the suspend process the
laptop doesn't shut down, the screen remains black and I have to
manually press 4-sec the power button. Then resuming is always ok. But
this is a minor issue ;-)

BTW it's about 40min from the latest resume and the ipw2100 is working
perfectly: 75kB/s downloading a Debian CD images with BitTorrent.

S3 doesn't work neither without the ipw2100: I get a resume suddenly
after the suspend process is finished and without errors.

> Thank you for all your testing effort!
You're welcome :-)

Thx, bye,
Gismo / Luca

PS
- - ACPI folks: I cced to let you know this improvement in the M6N
suspend/resume process

- - Herman: I searched in http://mrhammy2.ath.cx:81/forum/index.php, but
it seems that S4 is never mentioned in the last days, so I cced you :-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBPuHpVAp7Xm10JmkRAj/PAJ905mm9l62rwUR53GZ95sDujRsbjwCfYSEt
+vJPnfh/5ewDZ4IpXo6KF98=
=iIhf
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
