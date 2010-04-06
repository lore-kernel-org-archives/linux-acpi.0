From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/12] PNPACPI: truncate _CRS windows with _LEN > _MAX - _MIN +
 1
Date: Tue, 06 Apr 2010 03:06:20 -0400
Message-ID: <3162b6f0c5e1fcad372d64194fb3cb968941b428.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:45564 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365Ab0DFHGq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:46 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G00J8512TUY90@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:35 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The ACPI spec (sec 6.4.3.5 in v4.0) requires that for Address Space Resource
Descriptors, _LEN <= _MAX - _MIN + 1 in all cases, but there are BIOSes that
violate this.  We experimentally determined that Windows truncates the
resource so it doesn't extend past _MAX, so let's do the same thing in
Linux.

http://bugzilla.kernel.org/show_bug.cgi?id=15480

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   42 ++++++++++++++++++++++++++++-----------
 1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 54514aa..fe5bfa9 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -273,12 +273,33 @@ static void pnpacpi_parse_allocated_busresource(struct pnp_dev *dev,
 	pnp_add_bus_resource(dev, start, end);
 }
 
+static u64 addr_space_length(struct pnp_dev *dev, u64 min, u64 max, u64 len)
+{
+	u64 max_len;
+
+	max_len = max - min + 1;
+	if (len <= max_len)
+		return len;
+
+	/*
+	 * Per 6.4.3.5, _LEN cannot exceed _MAX - _MIN + 1, but some BIOSes
+	 * don't do this correctly, e.g.,
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=15480
+	 */
+	dev_info(&dev->dev,
+	         "resource length %#llx doesn't fit in %#llx-%#llx, trimming\n",
+		 (unsigned long long) len, (unsigned long long) min,
+		 (unsigned long long) max);
+	return max_len;
+}
+
 static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
 						  struct acpi_resource *res)
 {
 	struct acpi_resource_address64 addr, *p = &addr;
 	acpi_status status;
 	int window;
+	u64 len;
 
 	status = acpi_resource_to_address64(res, p);
 	if (!ACPI_SUCCESS(status)) {
@@ -287,20 +308,18 @@ static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
 		return;
 	}
 
+	len = addr_space_length(dev, p->minimum, p->maximum, p->address_length);
 	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
-		pnpacpi_parse_allocated_memresource(dev,
-			p->minimum, p->address_length,
+		pnpacpi_parse_allocated_memresource(dev, p->minimum, len,
 			p->info.mem.write_protect, window);
 	else if (p->resource_type == ACPI_IO_RANGE)
-		pnpacpi_parse_allocated_ioresource(dev,
-			p->minimum, p->address_length,
+		pnpacpi_parse_allocated_ioresource(dev, p->minimum, len,
 			p->granularity == 0xfff ? ACPI_DECODE_10 :
 				ACPI_DECODE_16, window);
 	else if (p->resource_type == ACPI_BUS_NUMBER_RANGE)
-		pnpacpi_parse_allocated_busresource(dev, p->minimum,
-						    p->address_length);
+		pnpacpi_parse_allocated_busresource(dev, p->minimum, len);
 }
 
 static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev *dev,
@@ -308,21 +327,20 @@ static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev *dev,
 {
 	struct acpi_resource_extended_address64 *p = &res->data.ext_address64;
 	int window;
+	u64 len;
 
+	len = addr_space_length(dev, p->minimum, p->maximum, p->address_length);
 	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
-		pnpacpi_parse_allocated_memresource(dev,
-			p->minimum, p->address_length,
+		pnpacpi_parse_allocated_memresource(dev, p->minimum, len,
 			p->info.mem.write_protect, window);
 	else if (p->resource_type == ACPI_IO_RANGE)
-		pnpacpi_parse_allocated_ioresource(dev,
-			p->minimum, p->address_length,
+		pnpacpi_parse_allocated_ioresource(dev, p->minimum, len,
 			p->granularity == 0xfff ? ACPI_DECODE_10 :
 				ACPI_DECODE_16, window);
 	else if (p->resource_type == ACPI_BUS_NUMBER_RANGE)
-		pnpacpi_parse_allocated_busresource(dev, p->minimum,
-						    p->address_length);
+		pnpacpi_parse_allocated_busresource(dev, p->minimum, len);
 }
 
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
-- 
1.6.0.6

