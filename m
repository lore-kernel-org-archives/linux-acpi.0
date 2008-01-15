From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: sata_nv does not function in kernel > 2.6.20.21... possible ACPI or PCI involvement?
Date: Mon, 14 Jan 2008 17:02:26 -0700
Message-ID: <200801141702.26914.bjorn.helgaas@hp.com>
References: <20080112205939.GA5291@mhcomputing.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:32031 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYAOACO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2008 19:02:14 -0500
In-Reply-To: <20080112205939.GA5291@mhcomputing.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Matthew Hall <mhall@mhcomputing.net>, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Saturday 12 January 2008 01:59:39 pm Matthew Hall wrote:
> Jeff Garzik forwarded me here to get some assistance resolving a 
> functionality regression in my sata_nv controller driver in recent Linux 
> kernels. I have attached the same data here that I ended up sending to 
> Jeff + others on the linux-ide list already. I assume you will probably 
> need other different data from Jeff so please let me know if any other 
> omitted information is required for diagnostics and I will respond ASAP.
> 
> I am using the Supermicro H8DCE motherboard. Some (not all) of the SATA
> channels quit working due to some kind of resource conflict when I
> upgrade to any kernel above 2.6.20.xx series, in my case I am running
> 2.6.20.21 SMP x86_64 presently.
> 
> The boot error which appears in dmesg for the missing SATA channels on
> 2.6.23.12 is pasted below.

This looks like the same problem reported here:

  https://bugzilla.redhat.com/show_bug.cgi?id=313491
  https://bugzilla.redhat.com/show_bug.cgi?id=280641

> PCI: Unable to reserve mem region #6:1000@dfefe000 for device 0000:80:07.0
> PCI: Unable to reserve mem region #6:1000@dfefd000 for device 0000:80:08.0

Your 2.6.23.12 /proc/iomem shows this:

  dfefd000-dfefdfff : 0000:80:08.0
    dfefd000-dfefd3ff : pnp 00:07
  dfefe000-dfefefff : 0000:80:07.0
    dfefe000-dfefe3ff : pnp 00:07

That means the dfefd000-dfefd3ff range is mentioned both as a
resource of an ACPI motherboard device (we call it "pnp 00:07"
above) and as a BAR of the SATA PCI device 0000:80:08.0.

The PNP "system" driver reserves that range to keep us from
putting another device on top of it, and the sata_nv reservation
fails because it extends past the end of the PNP reservation.

I think this is a bug in the BIOS description of the motherboard
device.  In 2.6.20, the PNP system driver reserved ioport resources
but ignored mmio resources.  In 2.6.23, the system driver reserves
both ioport and mmio resources, which I think is more correct, but
exposes this bug.

I posted the attached test patch to the redhat bugzilla above, but
nobody's tested it yet.  Can you try it?

Bjorn


Index: w/drivers/pnp/quirks.c
===================================================================
--- w.orig/drivers/pnp/quirks.c	2007-10-11 15:36:12.000000000 -0600
+++ w/drivers/pnp/quirks.c	2007-10-11 16:35:49.000000000 -0600
@@ -108,6 +108,47 @@
 		       "pnp: SB audio device quirk - increasing port range\n");
 }
 
+static int overlaps(resource_size_t start1, resource_size_t end1,
+		    resource_size_t start2, resource_size_t end2)
+{
+	if (start2 <= start1 && start1 < end2)
+		return 1;
+	if (start2 <= end1 && end1 < end2)
+		return 1;
+	return 0;
+}
+
+
+#include <linux/pci.h>
+
+static void quirk_supermicro_motherboard(struct pnp_dev *dev)
+{
+	struct pci_dev *pdev = NULL;
+	int i, j;
+
+	for_each_pci_dev(pdev) {
+		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+			if (!(pci_resource_flags(pdev, i) & IORESOURCE_MEM) ||
+			    pci_resource_len(pdev, i) == 0)
+				continue;
+
+			for (j = 0; j < PNP_MAX_MEM; j++) {
+				if (!pnp_mem_valid(dev, j) ||
+				    pnp_mem_len(dev, j) == 0)
+					continue;
+
+				if (overlaps(pnp_mem_start(dev, j),
+					     pnp_mem_end(dev, j),
+					     pci_resource_start(pdev, i),
+					     pci_resource_end(pdev, i))) {
+					dev_warn(&dev->dev, "mem resource overlaps %s BAR %d, disabling\n", pci_name(pdev), i);
+					pnp_mem_flags(dev, j) = 0;
+				}
+			}
+		}
+	}
+}
+
 /*
  *  PnP Quirks
  *  Cards or devices that need some tweaking due to incomplete resource info
@@ -128,6 +169,8 @@
 	{"CTL0043", quirk_sb16audio_resources},
 	{"CTL0044", quirk_sb16audio_resources},
 	{"CTL0045", quirk_sb16audio_resources},
+	{"PNP0c01", quirk_supermicro_motherboard},
+	{"PNP0c02", quirk_supermicro_motherboard},
 	{""}
 };
 


