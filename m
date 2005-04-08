From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Re: Fw: Re: 2.6.12-rc2-mm2
Date: Fri, 08 Apr 2005 17:50:02 -0600
Message-ID: <1113004202.12025.105.camel@eeyore>
References: <20050408092947.41175d63.akpm@osdl.org>
	 <425707A2.2050208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <425707A2.2050208-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, tom.l.nguyen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 2005-04-09 at 00:37 +0200, Michael Thonke wrote:
> but whats so different that causes some PCI-E cards to get not regonized
> or working at all?

I'm not clear on which cards are not recognized.  In the -mm dmesg
log you posted, sk98lin found a card:

    Linux version 2.6.12-rc2-mm2-md1 (root@ioGL64NX) (gcc-Version 3.4.3 20041125 (Gentoo Linux 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #2 SMP PREEMPT
    ...
    sk98lin: Network Device Driver v8.15.1.3
    (C)Copyright 1999-2005 Marvell(R).
    ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 201
    PCI: Setting latency timer of device 0000:02:00.0 to 64
    eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
          PrefPort:A  RlmtMode:Check Link State

So what do you mean by "not recognized"?  I assumed you meant that
the card just didn't work.

I noticed in some lspci output the IRQ was reported as 7, not
the 201 above.  So that also makes me suspicious of PCI-Express
IRQ routing gone bad.

Please don't trim the to/cc list; I added Tom because he knows
about PCI Express.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
