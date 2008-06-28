From: Len Brown <lenb@kernel.org>
Subject: [PATCH 83/84] PNPACPI: add support for HP vendor-specific CCSR
 descriptors
Date: Sat, 28 Jun 2008 01:44:27 -0400
Message-ID: <d9a697cbee033fb7ef2d641b6febd303618f1b9b.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:51599 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYF1Fse (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:48:34 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500HHOS4XX304@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:48:34 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The HP CCSR descriptor describes MMIO address space that should appear
as a MEM resource.  This patch adds support for parsing these descriptors
in the _CRS data.

The visible effect of this is that these MEM resources will appear
in /sys/devices/pnp0/.../resources, which means that "lspnp -v" will
report it, user applications can use this to locate device CSR space,
and kernel drivers can use the normal PNP resource accessors to
locate them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   60 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index c2f59f4..d7e9f21 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2004 Matthieu Castet <castet.matthieu@free.fr>
  * Copyright (c) 2004 Li Shaohua <shaohua.li@intel.com>
+ * Copyright (C) 2008 Hewlett-Packard Development Company, L.P.
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -187,6 +189,61 @@ static void pnpacpi_parse_allocated_ioresource(struct pnp_dev *dev, u64 start,
 	pnp_add_io_resource(dev, start, end, flags);
 }
 
+/*
+ * Device CSRs that do not appear in PCI config space should be described
+ * via ACPI.  This would normally be done with Address Space Descriptors
+ * marked as "consumer-only," but old versions of Windows and Linux ignore
+ * the producer/consumer flag, so HP invented a vendor-defined resource to
+ * describe the location and size of CSR space.
+ */
+static struct acpi_vendor_uuid hp_ccsr_uuid = {
+	.subtype = 2,
+	.data = { 0xf9, 0xad, 0xe9, 0x69, 0x4f, 0x92, 0x5f, 0xab, 0xf6, 0x4a,
+	    0x24, 0xd2, 0x01, 0x37, 0x0e, 0xad },
+};
+
+static int vendor_resource_matches(struct pnp_dev *dev,
+				   struct acpi_resource_vendor_typed *vendor,
+				   struct acpi_vendor_uuid *match,
+				   int expected_len)
+{
+	int uuid_len = sizeof(vendor->uuid);
+	u8 uuid_subtype = vendor->uuid_subtype;
+	u8 *uuid = vendor->uuid;
+	int actual_len;
+
+	/* byte_length includes uuid_subtype and uuid */
+	actual_len = vendor->byte_length - uuid_len - 1;
+
+	if (uuid_subtype == match->subtype &&
+	    uuid_len == sizeof(match->data) &&
+	    memcmp(uuid, match->data, uuid_len) == 0) {
+		if (expected_len && expected_len != actual_len) {
+			dev_err(&dev->dev, "wrong vendor descriptor size; "
+				"expected %d, found %d bytes\n",
+				expected_len, actual_len);
+			return 0;
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
+				    struct acpi_resource_vendor_typed *vendor)
+{
+	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
+		u64 start, length;
+
+		memcpy(&start, vendor->byte_data, sizeof(start));
+		memcpy(&length, vendor->byte_data + 8, sizeof(length));
+
+		pnp_add_mem_resource(dev, start, start + length - 1, 0);
+	}
+}
+
 static void pnpacpi_parse_allocated_memresource(struct pnp_dev *dev,
 						u64 start, u64 len,
 						int write_protect)
@@ -237,6 +294,7 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	struct acpi_resource_dma *dma;
 	struct acpi_resource_io *io;
 	struct acpi_resource_fixed_io *fixed_io;
+	struct acpi_resource_vendor_typed *vendor_typed;
 	struct acpi_resource_memory24 *memory24;
 	struct acpi_resource_memory32 *memory32;
 	struct acpi_resource_fixed_memory32 *fixed_memory32;
@@ -306,6 +364,8 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		break;
 
 	case ACPI_RESOURCE_TYPE_VENDOR:
+		vendor_typed = &res->data.vendor_typed;
+		pnpacpi_parse_allocated_vendor(dev, vendor_typed);
 		break;
 
 	case ACPI_RESOURCE_TYPE_END_TAG:
-- 
1.5.6.1.89.gd544

