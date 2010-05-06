From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/9] ACPI/x86/PCI: compute Address Space length rather than
 using _LEN
Date: Thu, 06 May 2010 03:03:15 -0400
Message-ID: <86331c1ce7a892b29828f4d67a53c349565019ac.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64194 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0EFHDl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:41 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z00MPHKXOBR85@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:30 -0500 (CDT)
In-reply-to: <1273129401-12704-1-git-send-email-lenb@kernel.org>
In-reply-to: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
References: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ACPI _CRS Address Space Descriptors have _MIN, _MAX, and _LEN.  Linux has
been computing Address Spaces as [_MIN to _MIN + _LEN - 1].  Based on the
tests in the bug reports below, Windows apparently uses [_MIN to _MAX].

Per spec (ACPI 4.0, Table 6-40), for _CRS fixed-size, fixed location
descriptors, "_LEN must be (_MAX - _MIN + 1)", and when that's true, it
doesn't matter which way we compute the end.  But of course, there are
BIOSes that don't follow this rule, and we're better off if Linux handles
those exceptions the same way as Windows.

This patch makes Linux use [_MIN to _MAX], as Windows seems to do.  This
effectively reverts d558b483d5 and 03db42adfe and replaces them with
simpler code.

    https://bugzilla.kernel.org/show_bug.cgi?id=14337 (round)
    https://bugzilla.kernel.org/show_bug.cgi?id=15480 (truncate)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/pci/acpi.c |   40 ++--------------------------------------
 1 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index c7b1ebf..b31ec42 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -91,30 +91,6 @@ count_resource(struct acpi_resource *acpi_res, void *data)
 	return AE_OK;
 }
 
-static void
-align_resource(struct acpi_device *bridge, struct resource *res)
-{
-	int align = (res->flags & IORESOURCE_MEM) ? 16 : 4;
-
-	/*
-	 * Host bridge windows are not BARs, but the decoders on the PCI side
-	 * that claim this address space have starting alignment and length
-	 * constraints, so fix any obvious BIOS goofs.
-	 */
-	if (!IS_ALIGNED(res->start, align)) {
-		dev_printk(KERN_DEBUG, &bridge->dev,
-			   "host bridge window %pR invalid; "
-			   "aligning start to %d-byte boundary\n", res, align);
-		res->start &= ~(align - 1);
-	}
-	if (!IS_ALIGNED(res->end + 1, align)) {
-		dev_printk(KERN_DEBUG, &bridge->dev,
-			   "host bridge window %pR invalid; "
-			   "aligning end to %d-byte boundary\n", res, align);
-		res->end = ALIGN(res->end, align) - 1;
-	}
-}
-
 static acpi_status
 setup_resource(struct acpi_resource *acpi_res, void *data)
 {
@@ -124,7 +100,7 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	acpi_status status;
 	unsigned long flags;
 	struct resource *root, *conflict;
-	u64 start, end, max_len;
+	u64 start, end;
 
 	status = resource_to_addr(acpi_res, &addr);
 	if (!ACPI_SUCCESS(status))
@@ -141,19 +117,8 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	} else
 		return AE_OK;
 
-	max_len = addr.maximum - addr.minimum + 1;
-	if (addr.address_length > max_len) {
-		dev_printk(KERN_DEBUG, &info->bridge->dev,
-			   "host bridge window length %#llx doesn't fit in "
-			   "%#llx-%#llx, trimming\n",
-			   (unsigned long long) addr.address_length,
-			   (unsigned long long) addr.minimum,
-			   (unsigned long long) addr.maximum);
-		addr.address_length = max_len;
-	}
-
 	start = addr.minimum + addr.translation_offset;
-	end = start + addr.address_length - 1;
+	end = addr.maximum + addr.translation_offset;
 
 	res = &info->res[info->res_num];
 	res->name = info->name;
@@ -161,7 +126,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	res->start = start;
 	res->end = end;
 	res->child = NULL;
-	align_resource(info->bridge, res);
 
 	if (!pci_use_crs) {
 		dev_printk(KERN_DEBUG, &info->bridge->dev,
-- 
1.6.0.6

