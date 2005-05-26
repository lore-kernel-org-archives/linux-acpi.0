From: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Date: Thu, 26 May 2005 13:34:44 +0400
Message-ID: <20050526133444.A14184@jurassic.park.msu.ru>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de> <20050524185856.A7639@jurassic.park.msu.ru> <20050524084533.A20567@unix-os.sc.intel.com> <20050524205855.A8367@jurassic.park.msu.ru> <20050524103724.A22049@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050524103724.A22049-39QZ/XbsZ5/mO6KZMuUCQVaTQe2KTcn/@public.gmane.org>; from rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Tue, May 24, 2005 at 10:37:25AM -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 24, 2005 at 10:37:25AM -0700, Rajesh Shah wrote:
> For the transparent p2p bridge problem you mentioned, wouldn't you
> be dealing with p2p bridges, and therefore expect the pci_bus
> resource pointers to point to the corresponding pci_dev resources?

The problem is that for subtractive decode bridges we assume
full "transparency" and completely ignore standard p2p bridge
resources (i.e. windows) just using first 3 parent bus pointers
whatever they are.
This model does work in most cases, but there are potential problems
with peer-to-peer DMA behind such bridges, poor performance for MMIO
ranges outside bridge windows, prefetchable vs. non-prefetchable issues
and so on.

If we had 6 or more resource pointers in struct pci_bus, then the
appended patch would fix that.

> Or are you proposing to decouple pci_bus resource pointers from 
> pci_dev completely?

Actually no. Low-level bridge drivers (p2p, cardbus or particular
host bridge) certainly know about resource layout of the respective
device. But generic resource management code doesn't make any
assumptions about that and looks only at resource types.

> From quick code inspection, that seems to be
> not too much trouble to increase from 4 then.

No trouble at all, I guess.

Ivan.

--- linux/drivers/pci/probe.c.orig	Sat May  7 09:20:31 2005
+++ linux/drivers/pci/probe.c	Wed May 25 18:31:34 2005
@@ -239,9 +239,8 @@ void __devinit pci_read_bridge_bases(str
 
 	if (dev->transparent) {
 		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i];
-		return;
+		for(i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i - 3];
 	}
 
 	for(i=0; i<3; i++)


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
