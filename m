From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 28/28] PNPACPI: add support for HP vendor-specific CCSR descriptors
Date: Tue, 17 Jun 2008 16:58:51 -0600
Message-ID: <20080617225913.505623057@ldl.fc.hp.com>
References: <20080617225823.045233728@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:17748 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760638AbYFQXAT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 19:00:19 -0400
Content-Disposition: inline; filename=pnpacpi-hp-vendor-descriptor
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@gmail.com>

The HP CCSR descriptor describes MMIO address space that should appear
as a MEM resource.  This patch adds support for parsing these descriptors
in the _CRS data.

The visible effect of this is that these MEM resources will appear
in /sys/devices/pnp0/.../resources, which means that "lspnp -v" will
report it, user applications can use this to locate device CSR space,
and kernel drivers can use the normal PNP resource accessors to
locate them.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work14/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work14.orig/drivers/pnp/pnpacpi/rsparser.c	2008-06-17 15:52:36.000000000 -0600
+++ work14/drivers/pnp/pnpacpi/rsparser.c	2008-06-17 16:37:40.000000000 -0600
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2004 Matthieu Castet <castet.matthieu@free.fr>
  * Copyright (c) 2004 Li Shaohua <shaohua.li@intel.com>
+ * Copyright (C) 2008 Hewlett-Packard Development Company, L.P.
+ *	Bjorn Helgaas <bjorn.helgaas@hp.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -187,6 +189,61 @@ static void pnpacpi_parse_allocated_iore
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
@@ -237,6 +294,7 @@ static acpi_status pnpacpi_allocated_res
 	struct acpi_resource_dma *dma;
 	struct acpi_resource_io *io;
 	struct acpi_resource_fixed_io *fixed_io;
+	struct acpi_resource_vendor_typed *vendor_typed;
 	struct acpi_resource_memory24 *memory24;
 	struct acpi_resource_memory32 *memory32;
 	struct acpi_resource_fixed_memory32 *fixed_memory32;
@@ -306,6 +364,8 @@ static acpi_status pnpacpi_allocated_res
 		break;
 
 	case ACPI_RESOURCE_TYPE_VENDOR:
+		vendor_typed = &res->data.vendor_typed;
+		pnpacpi_parse_allocated_vendor(dev, vendor_typed);
 		break;
 
 	case ACPI_RESOURCE_TYPE_END_TAG:

-- 
