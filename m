From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: acpi4asus CVS updated
Date: Thu, 17 Jul 2003 18:55:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030717165520.GA296@hell.org.pl>
References: <20030716210914.GB17981@hell.org.pl> <1058436553.7682.39.camel@idoru.kc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1058436553.7682.39.camel-65LrUGLyukAb1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Nils Faerber:
> Hiw is disp coded, i.e. which value activates/deactivates which "head"?
> I suspect that it is binary and that bit-0 is the LCD, correct?
> What are the others?
> Which is the highest bit?

This in covered both in the README, and in the comments. Anyway, bit 0 is
LCD, 1 is CRT and 2 is TV-Out (the latter two may be swapped, I can't
remember that now, please consult either the README or the sources).

> I ask because it should be quite easy to fix the hotkey problem by
> simply adding a acpid script for it, simply counting up and flipping
> back to bit-0. The hotkey event seems to be ATKD 00000061.

Just pass the notification value NAND 0x60. The hotkey event is the desired
value OR'ed 0x60, FYI. The AML code does the necessary switching and
display detection, thus it only works when the other displays are actually
connected.

> Does not apply to the version in last ACPI patch (030619); but doesn't
> matter since one can use the complete source from sf.net anyway.

Just copying the asus_core.c onto asus_acpi.c should be enough. The patch
comes from cvs rdiff, and I didn't have time to test it. BTW: the M3N
prefix should really have the dot at the end, as Julien noted. The updated
patch on my site reflects this.

> Many many thanks to you and the others to make this working!

Actually, if you refer to the display switching, it has been working and
has been present in the code for at least a month or so. At least for L3C
and the like, for others, there are some problems that Julien tried to deal
with, unsuccessfully so far.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
