From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/2] x86/PCI: compute Address Space length rather than using
	_LEN
Date: Tue, 27 Apr 2010 14:45:43 -0600
Message-ID: <20100427204543.23753.60113.stgit@bob.kio>
References: <20100427202122.23753.63421.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:40498 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab0D0UqL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 16:46:11 -0400
In-Reply-To: <20100427202122.23753.63421.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org


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
---

 arch/x86/pci/acpi.c |   40 ++--------------------------------------
 1 files changed, 2 insertions(+), 38 deletions(-)


diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 44f83ce..31930fd 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -121,30 +121,6 @@ count_resource(struct acpi_resource *acpi_res, void *data)
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
@@ -154,7 +130,7 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	acpi_status status;
 	unsigned long flags;
 	struct resource *root, *conflict;
-	u64 start, end, max_len;
+	u64 start, end;
 
 	status = resource_to_addr(acpi_res, &addr);
 	if (!ACPI_SUCCESS(status))
@@ -171,19 +147,8 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
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
@@ -191,7 +156,6 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	res->start = start;
 	res->end = end;
 	res->child = NULL;
-	align_resource(info->bridge, res);
 
 	if (!pci_use_crs) {
 		dev_printk(KERN_DEBUG, &info->bridge->dev,

