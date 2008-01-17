From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] PNP: disable Supermicro H8DCE motherboard resources that overlap SATA BARs
Date: Thu, 17 Jan 2008 16:03:18 -0700
Message-ID: <200801171603.20987.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:5847 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbYAQXCx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jan 2008 18:02:53 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Matthew Hall <mhall@mhcomputing.net>, Robert Hancock <hancockr@shaw.ca>, Willem Riede <wriede@riede.org>, Karl Bellve <karl.bellve@umassmed.edu>, Jon Stanley <jonstanley@gmail.com>

Some Supermicro BIOSes describe a SATA PCI BAR as a motherboard
resource.  The PNP system driver claims motherboard resources, and
this prevents the sata_nv driver from requesting it later.

This patch disables the PNP0C01/PNP0C02 resources so they won't be
claimed by the PNP system driver, so they'll available for sata_nv.

This fixes the bugs below, where sata_nv detects only two out of four
SATA drives.  The signature includes dmesg lines similar to these:

  pnp: 00:09: iomem range 0xdfefc000-0xdfefcfff has been reserved
  pnp: 00:09: iomem range 0xdfefd000-0xdfefd3ff has been reserved
  pnp: 00:09: iomem range 0xdfefe000-0xdfefe3ff has been reserved

  PCI: Unable to reserve mem region #6:1000@dfefd000 for device 0000:80:07.0
  sata_nv: probe of 0000:80:07.0 failed with error -16
  PCI: Unable to reserve mem region #6:1000@dfefe000 for device 0000:80:08.0
  sata_nv: probe of 0000:80:08.0 failed with error -16

References:
    https://bugzilla.redhat.com/show_bug.cgi?id=280641
    https://bugzilla.redhat.com/show_bug.cgi?id=313491
    http://lkml.org/lkml/2008/1/9/449
    http://thread.gmane.org/gmane.linux.acpi.devel/27312

This is post-2.6.24 material.

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
 
