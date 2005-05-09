From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Mon, 09 May 2005 13:02:36 +0200
Message-ID: <427F434C.80002@kernelconcepts.de>
References: <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de> <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de> <20050507200225.GB8212@elf.ucw.cz> <427D46DE.7010301@kernelconcepts.de> <20050509101930.GB24478@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090106090805070204020001"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050509101930.GB24478-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, =?ISO-8859-1?Q?Hendri?= =?ISO-8859-1?Q?k_J=FCrgens?= <hjuerg-ULHALamj7Vx/+Jgy1241yg@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090106090805070204020001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
> Hi!
Hi!

[...]
>>>>So at least for my T42p I can recommend NOT to use vbetool at all for
>>>>suspend/resume but rather to use s3_bios!
>>>Can you suggest a patch to Documentation/power/video.txt?
>>I changed the file a little accordingly, a diff is attached.
>>I think it would be a good idea to start some compatibitlity
>>documentation, i.e. which device is known to work with which
>>options/tricks. I appended a "compatibility matrix" to the end of the file.
>>
>>Tel me if you find this documentation useful or what can/should be
>>added/changed.
> 
> I do not think we should list multiple ways to make it work. Thats
> just too complicated. Just one "best" method should be listed...

OK, I removed the extra "X"'es from the table ;)

> Oh and pleas make patches diff -u...

Attached ;)

Do you have another idea what might cause the still extra ~2W power
drain I see after resume? Or any idea how to trace/find that?

> 								Pavel
Kind regards
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCf0NLJXeIURG1qHgRAjAqAJsExKqTJEz5+gq9sEmEhda82MzOxACeJGFa
sRRiYWOBp90nUtUEOLF6/gw=
=FAlU
-----END PGP SIGNATURE-----

--------------090106090805070204020001
Content-Type: text/x-patch;
 name="video.txt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="video.txt.diff"

--- linux-2.6.11.8/Documentation/power/video.txt-o	2005-05-08 00:48:38.000000000 +0200
+++ linux-2.6.11.8/Documentation/power/video.txt	2005-05-09 13:00:19.000000000 +0200
@@ -36,8 +36,49 @@
 Now, if you pass acpi_sleep=something, and it does not work with your
 bios, you'll get hard crash during resume. Be carefull.
 
-You may have system where none of above works. At that point you
+You may have a system where none of above works. At that point you
 either invent another ugly hack that works, or write proper driver for
 your video card (good luck getting docs :-(). Maybe suspending from X
 (proper X, knowing your hardware, not XF68_FBcon) might have better
 chance of working.
+
+
+Other well known solutions to get your video back on resume using vbetool.
+Vbetool can execude the real-mode video BIOS extension and use standard
+video BIOS calls to alter the hardware state of your video hardware. There
+are two ways to get video to resume:
+
+* save your current video setting before going to suspend and restore it on
+  resume, like
+	vbetool save > /tmp/.vbe-settings
+	[go to sleep]
+	vbetool restore < /tmp/.vbe-settings
+  On many systems this will bring back your complete video hardware,
+  including backlight on notebook TFTs. This is known to work with many ATI
+  radeon systems and Intel Centrino.
+
+* manually execute the video post method if you BIOS does not do it for you,
+  again vbetool can do this
+	vbetool post
+  This can on some systems already be enough to get your video back.
+
+Warning: The above should only be tested in a safe environment like a single
+user shell since it may be necessary to cold-reset your machine, your
+machine might not resume correctly or simply crash hard.
+
+
+Compatibility matrix for S3 resume:
+
+Machine		s3_bios s3_mode vbe-save vbe-post recommended
+-------------------------------------------------------------
+HP Omnibook xe3s
+  Athlon           -       -       -        -        no special action required
+IBM T42p           X                                 s3_bios, vbe methods result in CPU bus master activity madness
+Toshiba 4030cdt            X                         s3_mode
+Toshiba Satellite
+  P10-554          X       X                         s3_bios,s3_mode
+
+
+X = working
+? = unknown
+- = not action required

--------------090106090805070204020001--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
