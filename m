From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: sata_nv does not function in kernel > 2.6.20.21... possible ACPI or PCI involvement?
Date: Wed, 16 Jan 2008 14:07:37 -0700
Message-ID: <200801161407.38280.bjorn.helgaas@hp.com>
References: <20080112205939.GA5291@mhcomputing.net> <200801141702.26914.bjorn.helgaas@hp.com> <20080115043804.GA17040@mhcomputing.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:33980 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYAPVHL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jan 2008 16:07:11 -0500
In-Reply-To: <20080115043804.GA17040@mhcomputing.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Hall <mhall@mhcomputing.net>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Monday 14 January 2008 09:38:04 pm Matthew Hall wrote:
> On Mon, Jan 14, 2008 at 05:02:26PM -0700, Bjorn Helgaas wrote:
> > I think this is a bug in the BIOS description of the motherboard
> > device.  In 2.6.20, the PNP system driver reserved ioport resources
> > but ignored mmio resources.  In 2.6.23, the system driver reserves
> > both ioport and mmio resources, which I think is more correct, but
> > exposes this bug.
> ... 
> > I posted the attached test patch to the redhat bugzilla above, but
> > nobody's tested it yet.  Can you try it?
> 
> The patch applied, booted, ran, and solved the problem perfectly. Do you 
> want any output or configuration files to verify anything? Let me know 
> if there is anything I can do to help. Other than that if you think it 
> is safe to apply this, I am in favor of adding it to the mainline or 
> other appropriate tree.

Matthew,

Can you please try the revised patch below?  It's not generic like
my first one, but I think it's a little safer because it doesn't
rely on the discovery of PCI devices before the PNP quirk is run.

Thanks,
  Bjorn




PNP: disable Supermicro H8DCE motherboard resources that overlap SATA BARs

Some Supermicro BIOSes apparently describe a SATA PCI BAR as a motherboard
resource.  The PNP system driver claims motherboard resources, and this
prevents the sata_nv driver from requesting it later.

This patch disables the PNP0C01/PNP0C02 resources so they won't be claimed
by the PNP system driver, so they'll available for sata_nv.

References:
    https://bugzilla.redhat.com/show_bug.cgi?id=280641
    https://bugzilla.redhat.com/show_bug.cgi?id=313491
    http://lkml.org/lkml/2008/1/9/449
    http://thread.gmane.org/gmane.linux.acpi.devel/27312

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work5/drivers/pnp/quirks.c
===================================================================
--- work5.orig/drivers/pnp/quirks.c	2008-01-04 14:34:43.000000000 -0700
+++ work5/drivers/pnp/quirks.c	2008-01-16 13:12:53.000000000 -0700
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/pnp.h>
 #include <linux/io.h>
+#include <linux/dmi.h>
 #include <linux/kallsyms.h>
 #include "base.h"
 
@@ -108,6 +109,46 @@
 		       "pnp: SB audio device quirk - increasing port range\n");
 }
 
+static void quirk_supermicro_h8dce_system(struct pnp_dev *dev)
+{
+	int i;
+	static struct dmi_system_id supermicro_h8dce[] = {
+		{
+			.ident = "Supermicro H8DCE",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Supermicro"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "H8DCE"),
+			},
+		},
+		{ }
+	};
+
+	if (!dmi_check_system(supermicro_h8dce))
+		return;
+
+	/*
+	 * On the Supermicro H8DCE, there's a system device with resources
+	 * that overlap BAR 6 of the built-in SATA PCI adapter.  If the PNP
+	 * system device claims them, the sata_nv driver won't be able to.
+	 * More details at:
+	 *     https://bugzilla.redhat.com/show_bug.cgi?id=280641
+	 *     https://bugzilla.redhat.com/show_bug.cgi?id=313491
+	 *     http://lkml.org/lkml/2008/1/9/449
+	 *     http://thread.gmane.org/gmane.linux.acpi.devel/27312
+	 */
+	for (i = 0; i < PNP_MAX_MEM; i++) {
+		if (pnp_mem_valid(dev, i) && pnp_mem_len(dev, i) &&
+		    (pnp_mem_start(dev, i) & 0xdfef0000) == 0xdfef0000) {
+			dev_warn(&dev->dev, "disabling 0x%llx-0x%llx to prevent"
+				" conflict with sata_nv PCI device\n",
+				(unsigned long long) pnp_mem_start(dev, i),
+				(unsigned long long) (pnp_mem_start(dev, i) +
+					pnp_mem_len(dev, i) - 1));
+			pnp_mem_flags(dev, i) = 0;
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
+	{"PNP0c01", quirk_supermicro_h8dce_system},
+	{"PNP0c02", quirk_supermicro_h8dce_system},
 	{""}
 };
 
