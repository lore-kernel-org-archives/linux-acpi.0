From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: "irq 11: nobody cared" after S3
Date: Tue, 3 Aug 2004 16:29:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408031629.19466.stefandoesinger@gmx.at>
References: <200408011850.25991.stefandoesinger@gmx.at> <410DC163.1090109@optonline.net>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <410DC163.1090109-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
> > I use 2.6.8-rc2 + acpi-20040715 and the system works fine after S3 as
> > long no driver uses IRQ11. But if I have ipw2100 loaded before I suspend
> > or load it afterwards, irq11 and irq10 are disabled.

> > The problem occurs when ipw2100(or ndiswrapper) is loaded before I
> > suspend(see dmesg.loadbefore) or if I load it after resume(see
> > dmesg.loadlater. In both cases IRQ11 and IRQ10 are disabled. IRQ10 works
> > nicely as long IRQ11 is not used. The IRQ crash occues eighter when PIT
> > is resumed or when ipw2100 registers the irq line.
>
> Does kernel command line "acpi=noirq" help?

Yes it does. Sorry for not mentioning this. I used pci=noacpi the last few 
weeks. This makes the wireless card use IRQ 10
It doesn't work very well thought, the IRQ10 and IRQ5 are unstable and the 
wireless and the sound block each other(Both IRQ 10), as well as USB and 
ethernet(IRQ 5). Additionally, DRI is unstable after resume.

I modified my DSDT to use IRQ 10 for LNKE, and that makes my system work 
perfectly. Is this a workaround or can I consider this a solution. The 
problem is, that half my hardware uses irq10 while the irqs 4,6,7,11,14 and 
15 are unused.
Shall I upload my modified dsdt? I think so.

Stefan


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
