From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Interrupt routing problem
Date: 05 Jan 2004 23:10:51 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1073362251.2419.21.camel@dhcppc4>
References: <3ACA40606221794F80A5670F0AF15F8401720C75@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C75-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Nils,

First try acpi=off to completely remove ACPI from the picture.
If the USB issues are still with you, then you know it has nothing to do
with ACPI.

If the USB issues did go away, then there is surely at least an ACPI
related issue, probably an ACPI bug.  If so, try booting with pci=noacpi
to disable ACPI interrupt routing.  without your dmesg I can't tell if
this would have any effect or not, but it may. You'll be able to tell
from a different /proc/interrupts.  But with a PIC-mode box chances are
good that everything will remain piled onto a single IRQ and this will
make no difference.

Depending on your hardware, acpi_irq_balance, perhaps with
acpi_irq_pci=... could distribute some devices off IRQ9.  However, IRQ9
is only the 5th most active entry, so this may not help.

if you were receiving ACPI events with an interrupt-level performance
issue, that could be a cause.  Check /var/log/acpid to see if ACPI
itself is getting any events.

thanks,
-Len

On Sun, 2004-01-04 at 21:17, Yu, Luming wrote:
> >strange phenomenons concerning USB with this setup, i.e. devices
> >suddenly getting disconnected and reconnected again, HUBs beeing
> >disabled altogether, ports being disabled and so on; and yes, using
> uhci
> >instead of usb-uhci does not help any.
> 
> How did you know this is caused by sharing IRQ 9? 
> 
> What is the exact failure that causes?
> 
> 
> >So my question is if I can "help" my kernel somehow to distribute the
> >IRQs in a more clever way.
> 
> You can try boot with acpi_irq_balance option.
> 
> --Luming
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id78&alloc_id371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
