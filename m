From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 22:01:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408202201.54083.stefandoesinger@gmx.at>
References: <88056F38E9E48644A0F562A38C64FB6002A934AC@scsmsx403.amr.corp.intel.com> <41265443.9050800@optonline.net>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41265443.9050800-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
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
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> Something else to watch out for on ICH2 and similar chipsets is that, as
> long as the IRQ router is steering a PCI link onto a certain IRQ, LPC
> ISA device are blocked from triggering that IRQ via the SERIRQ protocol.
> But if we move the all the PCI links elsewhere, the SERIRQ is no longer
> blocked, and if some ISA LPC device is holding a high level, which
> normally wouldn't trigger IRQ's under ISA, then the IRQ line will get
> disabled because the PIC is probably set to level-trigger because it was
> PCI at one point. I've seen this happen with IRQ 12 when the BIOS
> decided there was no PS/2 mouse present so it could re-use the IRQ. The
> real cause is that the i850 has  a register that allows IRQ1 and IRQ12
> to be disabled on the LPC bus, and this register isn't restored on
> resume. This probably doesn't apply to IRQ11 on Stefan's system, though...
If I re-programm the IRQ to something else than IRQ10, the device doesn't 
resume too. So it's not only a problem of IRQ 11.

> Maybe it's time to look at the suspend/resume callbacks on the ipw2100
> driver, anyway.
The ipw2100 driver calls pci_disable_device in it's suspend handler. But I 
think the ipw2100 maintainers need help with suspend/resume because James 
Ketrenos can't test it on his own system.

I'll change another devices IRQ line to test if it's only an ipw2100 issue.

Stefan


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
