From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
Date: 23 Nov 2004 01:09:09 -0500
Message-ID: <1101190148.19999.394.camel@d845pe>
References: <41990138.7080008@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41990138.7080008-D1TkPCJej5s@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stas Sergeev <stsp-D1TkPCJej5s@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *9

This is a common BIOS bug.  It advertises that LNK1 is presently set
to IRQ9, but tells us that IRQ9 is actually illegal for that link;
so Linus has to choose a legal one. (no, we can't just leave it there,
as that breaks other systems).  But apparently we choose poorly.

> Probing IDE interface ide1...
> hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15

IDE probes out and grabs its hard-coded IRQ15.

> ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 15
> PCI: setting IRQ 15 as level-triggered
> ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 15 (level, low) -> IRQ 15
> uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)

Here we assign LNK1 to IRQ15 for the benefit of USB,
which, of course, kills your IDE on IRQ 15.  This
is a Linux bug -- but one I thought we fixed some time back.

> hdc: lost interrupt

----------
I'm surprised that you're just seeing this now in 2.6.10.
Did 2.6.9 work correctly?  If so, can you send me the
2.6.9 dmesg?

Any difference with CONFIG_PNP=n?

thanks,
-Len





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
