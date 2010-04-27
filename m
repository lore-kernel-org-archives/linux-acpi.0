From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/2] PNPACPI: compute Address Space length rather than using
	_LEN
Date: Tue, 27 Apr 2010 14:45:38 -0600
Message-ID: <20100427204538.23753.49273.stgit@bob.kio>
References: <20100427202122.23753.63421.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:37592 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0D0Upj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Apr 2010 16:45:39 -0400
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
effectively reverts 3162b6f0c5e and replaces it with simpler code.

    https://bugzilla.kernel.org/show_bug.cgi?id=14337 (round)
    https://bugzilla.kernel.org/show_bug.cgi?id=15480 (truncate)

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

