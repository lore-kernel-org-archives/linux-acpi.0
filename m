From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / OSL: Add kerneldoc comments to memory mapping functions
Date: Sat, 02 Jan 2016 03:10:29 +0100
Message-ID: <1924205.GeqOOh5IKj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62726 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751354AbcABBjy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jan 2016 20:39:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mathias Krause <minipli@googlemail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add kerneldoc comments to acpi_os_map_iomem() and acpi_os_unmap_iomem()
and explain why the latter needs the __ref annotation in one of them
(as suggested by Mathias Krause).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -366,6 +366,19 @@ static void acpi_unmap(acpi_physical_add
 		iounmap(vaddr);
 }
 
+/**
+ * acpi_os_map_iomem - Get a virtual address for a given physical address range.
+ * @phys: Start of the physical address range to map.
+ * @size: Size of the physical address range to map.
+ *
+ * Look up the given physical address range in the list of existing ACPI memory
+ * mappings.  If found, get a reference to it and return a pointer to it (its
+ * virtual address).  If not found, map it, add it to that list and return a
+ * pointer to it.
+ *
+ * During early init (when acpi_gbl_permanent_mmap has not been set yet) this
+ * routine simply calls __acpi_map_table() to get the job done.
+ */
 void __iomem *__init_refok
 acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
 {
@@ -441,6 +454,20 @@ static void acpi_os_map_cleanup(struct a
 	}
 }
 
+/**
+ * acpi_os_unmap_iomem - Drop a memory mapping reference.
+ * @virt: Start of the address range to drop a reference to.
+ * @size: Size of the address range to drop a reference to.
+ *
+ * Look up the given virtual address range in the list of existing ACPI memory
+ * mappings, drop a reference to it and unmap it if there are no more active
+ * references to it.
+ *
+ * During early init (when acpi_gbl_permanent_mmap has not been set yet) this
+ * routine simply calls __acpi_unmap_table() to get the job done.  Since
+ * __acpi_unmap_table() is an __init function, the __ref annotation is needed
+ * here.
+ */
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;

