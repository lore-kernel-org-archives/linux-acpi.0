From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v1] PNPACPI: ignore Consumer/Producer bit;
	all bridge resources are windows
Date: Tue, 16 Mar 2010 14:26:27 -0600
Message-ID: <20100316202627.25544.28033.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:22957 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756424Ab0CPU0c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Mar 2010 16:26:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>


The Consumer/Producer bit in Address Space Descriptors is useless because
BIOS vendors don't use it consistently.  We have to assume that all
resources of bridges are really Producers, i.e., windows to the secondary
bus.

The Consumer/Producer bit was removed from the ACPI 2.0c spec for this
reason.  It was mistakenly added back in ACPI 3.0, but of course, it's
still useless.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pnp/pnpacpi/rsparser.c |   42 +++++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 7 deletions(-)


diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 54514aa..7158882 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -176,6 +176,33 @@ static int dma_flags(struct pnp_dev *dev, int type, int bus_master,
 	return flags;
 }
 
+/*
+ * BIOS vendors haven't used the Consumer/Producer bit in Address Space
+ * Descriptors consistently, so it was removed in ACPI 2.0c.  It was
+ * mistakenly re-added in ACPI 3.0, but is still useless because we have
+ * no way of knowing when it's valid.  All we can really do is assume that
+ * all resources on bridge devices are Producers.  Most bridges put their
+ * Consumer resources in PCI config space, but HP's vendor-defined CCSR
+ * resource can be used for non-PCI config Consumer resources if necessary.
+ */
+static struct acpi_device_id acpi_bridge_list[] = {
+	{ "PNP0A00" },
+	{ "PNP0A01" },
+	{ "PNP0A02" },
+	{ "PNP0A03" },
+	{ "PNP0A08" },
+	{ "" },
+};
+
+static int resource_is_window(struct pnp_dev *dev, struct acpi_resource *res)
+{
+	struct acpi_device *acpi_dev = dev->data;
+
+	if (acpi_match_device_ids(acpi_dev, acpi_bridge_list) == 0)
+		return 1;
+	return 0;
+}
+
 static void pnpacpi_parse_allocated_ioresource(struct pnp_dev *dev, u64 start,
 					       u64 len, int io_decode,
 					       int window)
@@ -287,7 +314,7 @@ static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
 		return;
 	}
 
-	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
+	window = resource_is_window(dev, res);
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(dev,
@@ -309,7 +336,7 @@ static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev *dev,
 	struct acpi_resource_extended_address64 *p = &res->data.ext_address64;
 	int window;
 
-	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
+	window = resource_is_window(dev, res);
 
 	if (p->resource_type == ACPI_MEMORY_RANGE)
 		pnpacpi_parse_allocated_memresource(dev,
@@ -387,7 +414,7 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		pnpacpi_parse_allocated_ioresource(dev,
 			io->minimum,
 			io->address_length,
-			io->io_decode, 0);
+			io->io_decode, resource_is_window(dev, res));
 		break;
 
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
@@ -399,7 +426,7 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		pnpacpi_parse_allocated_ioresource(dev,
 			fixed_io->address,
 			fixed_io->address_length,
-			ACPI_DECODE_10, 0);
+			ACPI_DECODE_10, resource_is_window(dev, res));
 		break;
 
 	case ACPI_RESOURCE_TYPE_VENDOR:
@@ -415,21 +442,22 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		pnpacpi_parse_allocated_memresource(dev,
 			memory24->minimum,
 			memory24->address_length,
-			memory24->write_protect, 0);
+			memory24->write_protect, resource_is_window(dev, res));
 		break;
 	case ACPI_RESOURCE_TYPE_MEMORY32:
 		memory32 = &res->data.memory32;
 		pnpacpi_parse_allocated_memresource(dev,
 			memory32->minimum,
 			memory32->address_length,
-			memory32->write_protect, 0);
+			memory32->write_protect, resource_is_window(dev, res));
 		break;
 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 		fixed_memory32 = &res->data.fixed_memory32;
 		pnpacpi_parse_allocated_memresource(dev,
 			fixed_memory32->address,
 			fixed_memory32->address_length,
-			fixed_memory32->write_protect, 0);
+			fixed_memory32->write_protect,
+			resource_is_window(dev, res));
 		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:

