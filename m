From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] PNPACPI: fix non-memory address space descriptor handling
Date: Thu, 2 Feb 2006 10:50:07 -0700
Message-ID: <200602021050.07867.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:46253 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750893AbWBBRuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2006 12:50:16 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Fix resource_type handling for QWORD, DWORD, and WORD Address Space
Descriptors.  Previously we ignored the resource_type, so I/O ports
and bus number ranges were incorrectly parsed as memory ranges.

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

Index: work-mm4/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm4.orig/drivers/pnp/pnpacpi/rsparser.c	2006-02-01 17:07:06.000000000 -0700
+++ work-mm4/drivers/pnp/pnpacpi/rsparser.c	2006-02-02 10:35:54.000000000 -0700
@@ -120,7 +120,7 @@
 
 static void
 pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
-	u32 io, u32 len)
+	u64 io, u64 len)
 {
 	int i = 0;
 	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
@@ -156,6 +156,27 @@
 	}
 }
 
+static void
+pnpacpi_parse_allocated_address_space(struct pnp_resource_table * res_table,
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
@@ -221,19 +242,9 @@
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
