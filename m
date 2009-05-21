From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNPACPI: parse Extended Address Space Descriptors
Date: Thu, 21 May 2009 15:49:59 -0600
Message-ID: <20090521214959.25180.16974.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:36693 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbZEUVuA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 17:50:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, Adam Belay <abelay@mit.edu>

Extended Address Space Descriptors are new in ACPI 3.0 and allow the
BIOS to communicate device resource cacheability attributes (write-back,
write-through, uncacheable, etc) to the OS.

Previously, PNPACPI ignored these descriptors, so if a BIOS used them,
a device could be responding at addresses the OS doesn't know about.
This patch adds support for these descriptors in _CRS and _PRS.  We
don't attempt to encode them for _SRS (just like we don't attempt to
encode the existing 16-, 32-, and 64-bit Address Space Descriptors).

Unfortunately, I don't have a way to test this.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pnp/pnpacpi/rsparser.c |   46 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index adf1785..e2a87fc 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -287,6 +287,25 @@ static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
 				ACPI_DECODE_16);
 }
 
+static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev *dev,
+						      struct acpi_resource *res)
+{
+	struct acpi_resource_extended_address64 *p = &res->data.ext_address64;
+
+	if (p->producer_consumer == ACPI_PRODUCER)
+		return;
+
+	if (p->resource_type == ACPI_MEMORY_RANGE)
+		pnpacpi_parse_allocated_memresource(dev,
+			p->minimum, p->address_length,
+			p->info.mem.write_protect);
+	else if (p->resource_type == ACPI_IO_RANGE)
+		pnpacpi_parse_allocated_ioresource(dev,
+			p->minimum, p->address_length,
+			p->granularity == 0xfff ? ACPI_DECODE_10 :
+				ACPI_DECODE_16);
+}
+
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 					      void *data)
 {
@@ -400,8 +419,7 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
-		if (res->data.ext_address64.producer_consumer == ACPI_PRODUCER)
-			return AE_OK;
+		pnpacpi_parse_allocated_ext_address_space(dev, res);
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
@@ -630,6 +648,28 @@ static __init void pnpacpi_parse_address_option(struct pnp_dev *dev,
 					   IORESOURCE_IO_FIXED);
 }
 
+static __init void pnpacpi_parse_ext_address_option(struct pnp_dev *dev,
+						    unsigned int option_flags,
+						    struct acpi_resource *r)
+{
+	struct acpi_resource_extended_address64 *p = &r->data.ext_address64;
+	unsigned char flags = 0;
+
+	if (p->address_length == 0)
+		return;
+
+	if (p->resource_type == ACPI_MEMORY_RANGE) {
+		if (p->info.mem.write_protect == ACPI_READ_WRITE_MEMORY)
+			flags = IORESOURCE_MEM_WRITEABLE;
+		pnp_register_mem_resource(dev, option_flags, p->minimum,
+					  p->minimum, 0, p->address_length,
+					  flags);
+	} else if (p->resource_type == ACPI_IO_RANGE)
+		pnp_register_port_resource(dev, option_flags, p->minimum,
+					   p->minimum, 0, p->address_length,
+					   IORESOURCE_IO_FIXED);
+}
+
 struct acpipnp_parse_option_s {
 	struct pnp_dev *dev;
 	unsigned int option_flags;
@@ -711,6 +751,7 @@ static __init acpi_status pnpacpi_option_resource(struct acpi_resource *res,
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
+		pnpacpi_parse_ext_address_option(dev, option_flags, res);
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
@@ -765,6 +806,7 @@ static int pnpacpi_supported_resource(struct acpi_resource *res)
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
+	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		return 1;
 	}

