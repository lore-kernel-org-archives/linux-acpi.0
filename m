From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: acpi4asus CVS updated
Date: 17 Jul 2003 12:09:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058436553.7682.39.camel@idoru.kc.de>
References: <20030716210914.GB17981@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030716210914.GB17981-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mit, 2003-07-16 um 23.09 schrieb Karol Kozimor:
> Hi,
Hi!

> I've just added support for ASUS M3700N and S1300N laptops. This includes
> display switching code, which *should* work, but the same what was with
> L3800C applies to those also: once the module is loaded, Fn+F8 cedes
> working. This is a feature of the DSDT, not a bug in the driver, the only
> way to switch displays would then be to echo an appropriate value into
> /proc/acpi/asus/disp.

Hiw is disp coded, i.e. which value activates/deactivates which "head"?
I suspect that it is binary and that bit-0 is the LCD, correct?
What are the others?
Which is the highest bit?

I ask because it should be quite easy to fix the hotkey problem by
simply adding a acpid script for it, simply counting up and flipping
back to bit-0. The hotkey event seems to be ATKD 00000061.

> The CVS is at http://sourceforge.net/projects/acpi4asus, but since the
> CVS-view doesn't currently relfect the current status of repository, I've
> made a patch to bring the kernel sources up to date (be careful, -p3 may be
> needed when patching), grab it at 
> http:/hell.org.pl/~sziwan/asus/asus_core.c-1.51-to-1.55.diff

Does not apply to the version in last ACPI patch (030619); but doesn't
matter since one can use the complete source from sf.net anyway.

Many many thanks to you and the others to make this working!

> Please test it ASAP.
> Best regards,
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
