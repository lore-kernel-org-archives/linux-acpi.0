From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
Date: 23 Mar 2005 13:40:35 -0500
Message-ID: <1111603235.17317.883.camel@d845pe>
References: <41062.15.99.19.46.1111525073.squirrel@mail.atl.hp.com>
	 <1111539249.18927.17.camel@sli10-desk.sh.intel.com>
	 <1110.65.74.231.82.1111550240.squirrel@mail.cce.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110.65.74.231.82.1111550240.squirrel-TOYrGrLsdJ1xnVILBQAtiA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grzegorz Kulewski <kangur-ghbW0t/Qn0CsTnJN9+BGXg@public.gmane.org>, Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bjorn,

I like how pci_fixup_device() invokes the quirk
when we want at pci_enable_device() time w/o cluttering
the code with VIA specific hooks.

I think you've also identified an improvement by
checking acpi_irq_model -- as the PCI config space
IRQ register is defined only in PIC-mode -- so one
must assume that the quirky via HW can't depend on
us writing reserved bits for IRQs > 15.

But checking skip_ioapic_setup in the non-ACPI case
isn't quite right.  This is set for "noapic".  But
it is not set in the PIC-mode case where the kernel
supports IOAPIC but the hardware does not -- in that
case the quirk would erroneously exit.

Also, the original quirk_via_irqpic()
had a udelay(15) before the write -- I have no idea
if that was significant or not -- maybe soembody else
on the list does -- as none of us have VIA documentation...

thanks,
-Len

ps. we need to fix this on 2.4 also.




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
