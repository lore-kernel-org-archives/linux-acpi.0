From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: battery0 not present
Date: Sat, 20 Mar 2004 12:05:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <405C2561.30004@pca.it>
References: <40324F44.60006@pca.it> <4047395D.6000500@pca.it> <002401c401f6$8cfcd920$3a392886@bidrf227>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <002401c401f6$8cfcd920$3a392886-NmZw/y+ms+s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/04/04 15:39, Jan Philipp Giel wrote:
> The corrected DSDT still lacks some funtionality, e.g. it is not properly
> handled when the AC Adaptor is connected - KLaptop still shows "running on
> batteries", 0:00 left but the battery status is increasing.
latest DSDT from Andre Messerschmidt
	http://www.isis.de/members/~messersch/asus-m6800n.html
solved the AC status: now it's recognized correctly and 'GNOME Battery Applet'
shows correctly if I'm AC or battery and when I plug in/out the AC adapter.
=====
gismo:/home/luca# dmesg | grep ACPI
Asus Laptop ACPI Extras version 0.27
ACPI: AC Adapter [AC] (on-line)
ACPI: Processor [CPU1] (supports C1)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Thermal Zone [THRM] (58 C)
gismo:/home/luca#
=====

> So before mailing to Asus we should wait until everything is working IMO.
You're right, here the situation for ACPI support on my M6842NWH:
- - battery > works with Andre's DSDT
- - AC > works with Andre's DSDT
- - thermal > works
- - processor > still 'invalid PBLK length (7)' message, only C1 with original or
              Andre's DSDT, C1 & C2 with Bruno Ducrot's _CST patches
- - buttons > works
- - hotkeys > works with 'acpi4asus' 0.27+CVS
- - fan > module loaded, but no entries in /proc/acpi/fan/, anyway the fan starts
        automatically when required
- - with APIC I can't clearly shutdown
    http://sourceforge.net/mailarchive/forum.php?thread_id=3854100&forum_id=6102
- - 'os_wait_semaphore' problem still unsolved
- - I haven't tried yet sleep states

BTW, I upgraded to BIOS 0206A from http://fsai.fh-trier.de/~gielj/M6800N/

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAXCVhVAp7Xm10JmkRAgdrAJ4w3WBCKkLlkK6P/Y6bU8nvzRIyGgCfZlOK
X7cgRtyM56y/S1vNBL7nVQM=
=HJps
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
