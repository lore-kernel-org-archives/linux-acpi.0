From: ezra peisach <epeisach-AW32GngNFaTp5eoAjl1PXg@public.gmane.org>
Subject: Re: DELL inspiron 8200 fails to restore console after S1/S3
Date: Mon, 12 Jan 2004 08:22:17 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401121322.IAA215926@med-xtal.bu.edu>
References: <3ACA40606221794F80A5670F0AF15F8401720CB2@PDSMSX403.ccr.corp.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <3ACA40606221794F80A5670F0AF15F8401720CB2-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
	(luming.yu@intel.com)
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Thank you for your reply.

>What is AGP.VID, I didn't find any information regarding VID in ACPI
>spec 2.0b.

AGP is clearly the onboard video device. From the dsdt, AGP is a device, and
VID a subdevice. It appears that the VID is adhering to the Appendix B of
the 2.0c specs (switching video outputs)

>From looking at the DSDT \_SB.PCI0.AGP.VID is only being notified of
lid open/close event. Which makes sense - you might want to enable the
external CRT at that time. I am currently investigating if the Dell BIOS 
requires one to enable the output display on waking. If so - the dsdt is not
doing it. (I need to check the display status bits after restore).

>I think video driver should be responsible for turnning on/off console,
>becuase they have chance to run when entering/leaving S1/S3.
I've come to the same conclusion.  I've discovered that 
the blanking is caused by the machine disabling the LCD backlight on restore.
(radeontools-1.2 figured that out). 

I need to figure out now if the vga handler (VESA) interface is doing the 
right things on power restore. There was another thread about someone
else having the backlight remain on on S1/S3 invocation - and that the driver
was disabling hsync/vsync. If everything is Kosher there - then maybe I 
need a radeon specific blanking hook to follow the vga driver.

Thanks again - I will keep everyone posted.

Ezra




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
