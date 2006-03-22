From: akpm@osdl.org
Subject: [patch 04/23] PNPACPI: fix non-memory address space descriptor handling
Date: Tue, 21 Mar 2006 22:30:29 -0800
Message-ID: <200603220633.k2M6XgUr019535@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:8380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbWCVGds (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 01:33:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Fix resource_type handling for QWORD, DWORD, and WORD Address Space
Descriptors.  Previously we ignored the resource_type, so I/O ports and bus
number ranges were incorrectly parsed as memory ranges.

Sample PCI root bridge resources from HP rx2600 before this patch:

    # cat /sys/bus/pnp/devices/00:02/resources
    state = active
    mem 0x0-0x1f
    mem 0x0-0x3af
    mem 0x3e0-0x1fff
    mem 0x80000000-0x8fffffff

With this patch:

    # cat /sys/bus/pnp/devices/00:02/resources
    state = active
    io 0x0-0x3af
    io 0x3e0-0x1fff
    mem 0x80000000-0x8fffffff
    mem 0x80004000000-0x80103fffffe

Changes:
    0x0-0x1f PCI bus number range was incorrectly reported as memory, now
	not reported at all
    0x0-0x3af I/O port range was incorrectly reported as memory
    0x3e0-0x1fff I/O port range was incorrectly reported as memory
    0x80004000000-0x80103fffffe memory range wasn't reported at all because
	we only support PNP_MAX_MEM (4) memory resources

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pnp/pnpacpi/rsparser.c |   35 ++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 12 deletions(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-fix-non-memory-address-space-descriptor-handling drivers/pnp/pnpacpi/rsparser.c
--- devel/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-fix-non-memory-address-space-descriptor-handling	2006-03-21 22:30:04.000000000 -0800
+++ devel-akpm/drivers/pnp/pnpacpi/rsparser.c	2006-03-21 22:30:04.000000000 -0800
@@ -120,7 +120,7 @@ pnpacpi_parse_allocated_dmaresource(stru
 
 static void
 pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
-	u32 io, u32 len)
+	u64 io, u64 len)
 {
 	int i = 0;
 	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
@@ -156,6 +156,27 @@ pnpacpi_parse_allocated_memresource(stru
 	}
 }
 
+static void
+pnpacpi_parse_allocated_address_space(struct pnp_resource_table *res_table,
+	struct acpi_resource *res)
+{
+	struct acpi_resource_address64 addr, *p = &addr;
+	acpi_status status;
+
+	status = acpi_resource_to_address64(res, p);
+	if (!ACPI_SUCCESS(status)) {
+		pnp_warn("PnPACPI: failed to convert resource type %d",
+			res->type);
+		return;
+	}
+
+	if (p->resource_type == ACPI_MEMORY_RANGE)
+		pnpacpi_parse_allocated_memresource(res_table,
+				p->minimum, p->address_length);
+	else if (p->resource_type == ACPI_IO_RANGE)
+		pnpacpi_parse_allocated_ioresource(res_table,
+				p->minimum, p->address_length);
+}
 
 static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	void *data)
@@ -221,19 +242,9 @@ static acpi_status pnpacpi_allocated_res
 				res->data.fixed_memory32.address_length);
 		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
-		pnpacpi_parse_allocated_memresource(res_table,
-				res->data.address16.minimum,
-				res->data.address16.address_length);
-		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
-		pnpacpi_parse_allocated_memresource(res_table,
-				res->data.address32.minimum,
-				res->data.address32.address_length);
-		break;
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
-		pnpacpi_parse_allocated_memresource(res_table,
-		res->data.address64.minimum,
-		res->data.address64.address_length);
+		pnpacpi_parse_allocated_address_space(res_table, res);
 		break;
 
 	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
_
