From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/2] x86/PCI: fix bogus host bridge window start/end alignment
	from _CRS
Date: Wed, 04 Nov 2009 10:39:18 -0700
Message-ID: <20091104173918.17517.1738.stgit@bob.kio>
References: <20091104173601.17517.71697.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:44582 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464AbZKDRjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2009 12:39:14 -0500
In-Reply-To: <20091104173601.17517.71697.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

PCI device BARs are guaranteed to start and end on at least a four-byte
(I/O) or a sixteen-byte (MMIO) boundary because they're aligned on their
size and the low BAR bits are reserved.  PCI-to-PCI bridge apertures
have even larger alignment restrictions.

However, some BIOSes (e.g., HP DL360 BIOS P31) report host bridge windows
like "[io  0x0000-0x2cfe]".  This is wrong because it excludes the last
port at 0x2cff: it's impossible for a downstream device to claim 0x2cfe
without also claiming 0x2cff.  In fact, this BIOS configures a device
behind the bridge to "[io  0x2c00-0x2cff]", so we know the window actually
does include 0x2cff.

This patch rounds the start and end of apertures to the appropriate
boundary.  I experimentally determined that Windows contains a similar
workaround; details here:

    http://bugzilla.kernel.org/show_bug.cgi?id=14337

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/pci/acpi.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 54db5a0..8ddf4f4 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -59,6 +59,30 @@ bus_has_transparent_bridge(struct pci_bus *bus)
 	return false;
 }
 
+static void
+align_resource(struct acpi_device *bridge, struct resource *res)
+{
+	int align = (res->flags & IORESOURCE_MEM) ? 16 : 4;
+
+	/*
+	 * Host bridge windows are not BARs, but the decoders on the PCI side
+	 * that claim this address space have starting alignment and length
+	 * constraints, so fix any obvious BIOS goofs.
+	 */
+	if (res->start & (align - 1)) {
+		dev_printk(KERN_DEBUG, &bridge->dev,
+			   "host bridge window %pR invalid; "
+			   "aligning start to %d-byte boundary\n", res, align);
+		res->start &= ~(align - 1);
+	}
+	if ((res->end + 1) & (align - 1)) {
+		dev_printk(KERN_DEBUG, &bridge->dev,
+			   "host bridge window %pR invalid; "
+			   "aligning end to %d-byte boundary\n", res, align);
+		res->end = roundup(res->end, align) - 1;
+	}
+}
+
 static acpi_status
 setup_resource(struct acpi_resource *acpi_res, void *data)
 {
@@ -107,6 +131,7 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	res->start = start;
 	res->end = end;
 	res->child = NULL;
+	align_resource(info->bridge, res);
 
 	if (!(pci_probe & PCI_USE__CRS)) {
 		dev_printk(KERN_DEBUG, &info->bridge->dev,

