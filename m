From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Mon, 9 May 2005 13:26:27 +0200
Message-ID: <20050509112625.GA482@atrey.karlin.mff.cuni.cz>
References: <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de> <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de> <20050507200225.GB8212@elf.ucw.cz> <427D46DE.7010301@kernelconcepts.de> <20050509101930.GB24478@atrey.karlin.mff.cuni.cz> <427F434C.80002@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <427F434C.80002-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Hendrik =?iso-8859-2?Q?J=FCrgens?= <hjuerg-ULHALamj7Vx/+Jgy1241yg@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> [...]
> >>>>So at least for my T42p I can recommend NOT to use vbetool at all for
> >>>>suspend/resume but rather to use s3_bios!
> >>>Can you suggest a patch to Documentation/power/video.txt?
> >>I changed the file a little accordingly, a diff is attached.
> >>I think it would be a good idea to start some compatibitlity
> >>documentation, i.e. which device is known to work with which
> >>options/tricks. I appended a "compatibility matrix" to the end of the file.
> >>
> >>Tel me if you find this documentation useful or what can/should be
> >>added/changed.
> > 
> > I do not think we should list multiple ways to make it work. Thats
> > just too complicated. Just one "best" method should be listed...
> 
> OK, I removed the extra "X"'es from the table ;)

Hmm, sorry for not asking earlier. Do you think you could make it
relative to recent version of video.txt? [attached]

> > Oh and pleas make patches diff -u...
> 
> Attached ;)
> 
> Do you have another idea what might cause the still extra ~2W power
> drain I see after resume? Or any idea how to trace/find that?

You might want to try suspending with minimal drivers. If that does
not cure ~2W up, try searching for heat source after resume that was
not there before. 2W should be enough to be felt...


-- 
Boycott Kodak -- for their patent abuse against Java.

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="video.txt"


		Video issues with S3 resume
		~~~~~~~~~~~~~~~~~~~~~~~~~~~
		  2003-2005, Pavel Machek

During S3 resume, hardware needs to be reinitialized. For most
devices, this is easy, and kernel driver knows how to do
it. Unfortunately there's one exception: video card. Those are usually
initialized by BIOS, and kernel does not have enough information to
boot video card. (Kernel usually does not even contain video card
driver -- vesafb and vgacon are widely used).

This is not problem for swsusp, because during swsusp resume, BIOS is
run normally so video card is normally initialized. S3 has absolutely
no chance of working with SMP/HT. Be sure it to turn it off before
testing (swsusp should work ok, OTOH).

There are a few types of systems where video works after S3 resume:

(1) systems where video state is preserved over S3.

(2) systems where it is possible to call the video BIOS during S3
  resume. Unfortunately, it is not correct to call the video BIOS at
  that point, but it happens to work on some machines. Use
  acpi_sleep=s3_bios.

(3) systems that initialize video card into vga text mode and where
  the BIOS works well enough to be able to set video mode. Use
  acpi_sleep=s3_mode on these.

(4) on some systems s3_bios kicks video into text mode, and
  acpi_sleep=s3_bios,s3_mode is needed.

(5) radeon systems, where X can soft-boot your video card. You'll need
  a new enough X, and a plain text console (no vesafb or radeonfb). See
  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html for more information.
  Alternatively, you should use vbetool (6) instead.

(6) other radeon systems, where vbetool is enough to bring system back
  to life. It needs text console to be working. Do vbetool vbestate
  save > /tmp/delme; echo 3 > /proc/acpi/sleep; vbetool post; vbetool
  vbestate restore < /tmp/delme; setfont <whatever>, and your video
  should work.

(7) on some systems, it is possible to boot most of kernel, and then
  POSTing bios works. Ole Rohne has patch to do just that at
  http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2.

Now, if you pass acpi_sleep=something, and it does not work with your
bios, you'll get a hard crash during resume. Be careful. Also it is
safest to do your experiments with plain old VGA console. The vesafb
and radeonfb (etc) drivers have a tendency to crash the machine during
resume.

You may have a system where none of above works. At that point you
either invent another ugly hack that works, or write proper driver for
your video card (good luck getting docs :-(). Maybe suspending from X
(proper X, knowing your hardware, not XF68_FBcon) might have better
chance of working.

Table of known working systems:

Model                           hack (or "how to do it")
------------------------------------------------------------------------------
Acer Aspire 1406LC		ole's late BIOS init (7), turn off DRI
Acer TM 242FX			vbetool (6)
Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6)
Acer TM 4052LCi		        s3_bios (2)
Acer TM 636Lci			s3_bios vga=normal (2)
Acer TM 650 (Radeon M7)		vga=normal plus boot-radeon (5) gets text console back
Acer TM 660			??? (*)
Acer TM 800			vga=normal, X patches, see webpage (5) or vbetool (6)
Acer TM 803			vga=normal, X patches, see webpage (5) or vbetool (6)
Acer TM 803LCi			vga=normal, vbetool (6)
Arima W730a			vbetool needed (6)
Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
Asus L3350M (SiS 740)           (6)
Asus L3800C (Radeon M7)		s3_bios (2) (S1 also works OK)
Asus M6887Ne			vga=normal, s3_bios (2), use radeon driver instead of fglrx in x.org
Athlon64 desktop prototype	s3_bios (2)
Compal CL-50			??? (*)
Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
Compaq Evo N620c		vga=normal, s3_bios (2)
Dell 600m, ATI R250 Lf		none (1), but needs xorg-x11-6.8.1.902-1
Dell D600, ATI RV250            vga=normal and X, or try vbestate (6)
Dell Inspiron 4000		??? (*)
Dell Inspiron 500m		??? (*)
Dell Inspiron 600m		??? (*)
Dell Inspiron 8200		??? (*)
Dell Inspiron 8500		??? (*)
Dell Inspiron 8600		??? (*)
eMachines athlon64 machines	vbetool needed (6) (someone please get me model #s)
HP NC6000			s3_bios, may not use radeonfb (2); or vbetool (6)
HP NX7000			??? (*)
HP Pavilion ZD7000		vbetool post needed, need open-source nv driver for X
HP Omnibook XE3	athlon version	none (1)
HP Omnibook XE3GC		none (1), video is S3 Savage/IX-MV
IBM TP T20, model 2647-44G	none (1), video is S3 Inc. 86C270-294 Savage/IX-MV, vesafb gets "interesting" but X work.
IBM TP A31 / Type 2652-M5G      s3_mode (3) [works ok with BIOS 1.04 2002-08-23, but not at all with BIOS 1.11 2004-11-05 :-(]
IBM TP R32 / Type 2658-MMG      none (1)
IBM TP R40 2722B3G		??? (*)
IBM TP R50p / Type 1832-22U     s3_bios (2)
IBM TP R51			none (1)
IBM TP T30	236681A		??? (*)
IBM TP T40 / Type 2373-MU4      none (1)
IBM TP T40p			none (1)
IBM TP R40p			s3_bios (2)
IBM TP T41p			s3_bios (2), switch to X after resume
IBM TP T42			s3_bios (2)
IBM ThinkPad T42p (2373-GTG)	s3_bios (2)
IBM TP X20			??? (*)
IBM TP X30			s3_bios (2)
IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
IBM Thinkpad X40 Type 2371-7JG  s3_bios,s3_mode (4)
Medion MD4220			??? (*)
Samsung P35			vbetool needed (6)
Sharp PC-AR10 (ATI rage)	none (1)
Sony Vaio PCG-F403		??? (*)
Sony Vaio PCG-N505SN		??? (*)
Sony Vaio vgn-s260		X or boot-radeon can init it (5)
Toshiba Libretto L5		none (1)
Toshiba Satellite 4030CDT	s3_mode (3)
Toshiba Satellite 4080XCDT      s3_mode (3)
Toshiba Satellite 4090XCDT      ??? (*)
Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
Uniwill 244IIO			??? (*)


(*) from http://www.ubuntulinux.org/wiki/HoaryPMResults, not sure
    which options to use. If you know, please tell me.

(***) To be tested with a newer kernel.

(****) Not with SMP kernel, UP only.

VBEtool details
~~~~~~~~~~~~~~~
(with thanks to Carl-Daniel Hailfinger)

First, boot into X and run the following script ONCE:
#!/bin/bash
statedir=/root/s3/state
mkdir -p $statedir
chvt 2
sleep 1
vbetool vbestate save >$statedir/vbe


To suspend and resume properly, call the following script as root:
#!/bin/bash
statedir=/root/s3/state
curcons=`fgconsole`
fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
cat /dev/vcsa >$statedir/vcsa
sync
echo 3 >/proc/acpi/sleep
sync
vbetool post
vbetool vbestate restore <$statedir/vbe
cat $statedir/vcsa >/dev/vcsa
rckbd restart
chvt $[curcons%6+1]
chvt $curcons


Unless you change your graphics card or other hardware configuration,
the state once saved will be OK for every resume afterwards.
NOTE: The "rckbd restart" command may be different for your
distribution. Simply replace it with the command you would use to
set the fonts on screen.

--wRRV7LY7NUeQGEoC--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
