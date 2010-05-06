From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/9] PNPACPI: compute Address Space length rather than using
 _LEN
Date: Thu, 06 May 2010 03:03:14 -0400
Message-ID: <f238b414a74a13c3d62e31a08e81b585d750df74.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:49590 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0EFHD1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:27 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z003VBKXOPGL7@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:25 -0500 (CDT)
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
effectively reverts 3162b6f0c5e and replaces it with simpler code.

    https://bugzilla.kernel.org/show_bug.cgi?id=14337 (round)
    https://bugzilla.kernel.org/show_bug.cgi?id=15480 (truncate)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   26 ++++----------------------
 1 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 35bb44a..100e4d9 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -274,26 +274,6 @@ static void pnpacpi_parse_allocated_busresource(struct pnp_dev *dev,
 	pnp_add_bus_resource(dev, start, end);
 }
 
-static u64 addr_space_length(struct pnp_dev *dev, u64 min, u64 max, u64 len)
-{
-	u64 max_len;
-
-	max_len = max - min + 1;
-	if (len <= max_len)
-		return len;
-
-	/*
-	 * Per 6.4.3.5, _LEN cannot exceed _MAX - _MIN + 1, but some BIOSes
-	 * don't do this correctly, e.g.,
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=15480
-	 */
-	dev_info(&dev->dev,
-	         "resource length %#llx doesn't fit in %#llx-%#llx, trimming\n",
-		 (unsigned long long) len, (unsigned long long) min,
-		 (unsigned long long) max);
-	return max_len;
-}
-
 static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
 						  struct acpi_resource *res)
 {
@@ -309,7 +289,8 @@ static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
 		return;
 	}
 
-	len = addr_space_length(dev, p->minimum, p->maximum, p->address_length);
+	/* Windows apparently computes length rather than using _LEN */
+	len = p->maximum - p->minimum + 1;
 	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
@@ -330,7 +311,8 @@ static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev *dev,
 	int window;
 	u64 len;
 
-	len = addr_space_length(dev, p->minimum, p->maximum, p->address_length);
+	/* Windows apparently computes length rather than using _LEN */
+	len = p->maximum - p->minimum + 1;
 	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
-- 
1.6.0.6

