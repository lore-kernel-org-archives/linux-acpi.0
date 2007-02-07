From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/140] ACPI: remove motherboard driver (redundant with PNP system driver)
Date: Wed,  7 Feb 2007 13:50:39 -0500
Message-ID: <11708744071019-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:45778 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422742AbXBGSxa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:30 -0500
In-Reply-To: <11708744062538-git-send-email-lenb@kernel.org>
Message-Id: <5eca338fb510af78eee5372ff6a3525768ab913f.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

The PNP system board driver (drivers/pnp/system.c) contains all the
same functionality, so we don't need the ACPI version.

Previously, a motherboard device would be claimed by *both* the ACPI and
PNP drivers, resulting in stuff like this in /proc/ioports:

    1200-121f : motherboard	<-- from drivers/acpi/motherboard.c
      1200-121f : pnp 00:0d	<-- from drivers/pnp/system.c

Make sure to enable CONFIG_PNP (and CONFIG_PNPACPI) to include the
PNP system board driver.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile      |    2 +-
 drivers/acpi/motherboard.c |  131 --------------------------------------------
 2 files changed, 1 insertions(+), 132 deletions(-)
 delete mode 100644 drivers/acpi/motherboard.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index a749510..62b3dd5 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -37,7 +37,7 @@ endif
 
 obj-y				+= sleep/
 obj-y				+= bus.o glue.o
-obj-y				+= scan.o motherboard.o
+obj-y				+= scan.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
diff --git a/drivers/acpi/motherboard.c b/drivers/acpi/motherboard.c
deleted file mode 100644
index cddab7b..0000000
--- a/drivers/acpi/motherboard.c
+++ /dev/null
@@ -1,131 +0,0 @@
-/* 
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or (at
- *  your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- */
-
-/* Purpose: Prevent PCMCIA cards from using motherboard resources. */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/ioport.h>
-#include <asm/io.h>
-
-#include <acpi/acpi_bus.h>
-#include <acpi/acpi_drivers.h>
-
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("acpi_motherboard")
-
-/* Dell use PNP0C01 instead of PNP0C02 */
-#define ACPI_MB_HID			"PNP0C01,PNP0C02"
-/**
- * Doesn't care about legacy IO ports, only IO ports beyond 0x1000 are reserved
- * Doesn't care about the failure of 'request_region', since other may reserve
- * the io ports as well
- */
-#define IS_RESERVED_ADDR(base, len) \
-	(((len) > 0) && ((base) > 0) && ((base) + (len) < IO_SPACE_LIMIT) \
-	&& ((base) + (len) > PCIBIOS_MIN_IO))
-/*
- * Clearing the flag (IORESOURCE_BUSY) allows drivers to use
- * the io ports if they really know they can use it, while
- * still preventing hotplug PCI devices from using it.
- */
-
-/*
- * When CONFIG_PNP is enabled, pnp/system.c binds to PNP0C01
- * and PNP0C02, redundant with acpi_reserve_io_ranges().
- * But acpi_reserve_io_ranges() is necessary for !CONFIG_PNP.
- */
-static acpi_status acpi_reserve_io_ranges(struct acpi_resource *res, void *data)
-{
-	struct resource *requested_res = NULL;
-
-
-	if (res->type == ACPI_RESOURCE_TYPE_IO) {
-		struct acpi_resource_io *io_res = &res->data.io;
-
-		if (io_res->minimum != io_res->maximum)
-			return AE_OK;
-		if (IS_RESERVED_ADDR
-		    (io_res->minimum, io_res->address_length)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Motherboard resources 0x%08x - 0x%08x\n",
-					  io_res->minimum,
-					  io_res->minimum +
-					  io_res->address_length));
-			requested_res =
-			    request_region(io_res->minimum,
-					   io_res->address_length, "motherboard");
-		}
-	} else if (res->type == ACPI_RESOURCE_TYPE_FIXED_IO) {
-		struct acpi_resource_fixed_io *fixed_io_res =
-		    &res->data.fixed_io;
-
-		if (IS_RESERVED_ADDR
-		    (fixed_io_res->address, fixed_io_res->address_length)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Motherboard resources 0x%08x - 0x%08x\n",
-					  fixed_io_res->address,
-					  fixed_io_res->address +
-					  fixed_io_res->address_length));
-			requested_res =
-			    request_region(fixed_io_res->address,
-					   fixed_io_res->address_length,
-					   "motherboard");
-		}
-	} else {
-		/* Memory mapped IO? */
-	}
-
-	if (requested_res)
-		requested_res->flags &= ~IORESOURCE_BUSY;
-	return AE_OK;
-}
-
-static int acpi_motherboard_add(struct acpi_device *device)
-{
-	if (!device)
-		return -EINVAL;
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			    acpi_reserve_io_ranges, NULL);
-
-	return 0;
-}
-
-static struct acpi_driver acpi_motherboard_driver = {
-	.name = "motherboard",
-	.class = "",
-	.ids = ACPI_MB_HID,
-	.ops = {
-		.add = acpi_motherboard_add,
-		},
-};
-
-static int __init acpi_motherboard_init(void)
-{
-	acpi_bus_register_driver(&acpi_motherboard_driver);
-	return 0;
-}
-
-/**
- * Reserve motherboard resources after PCI claim BARs,
- * but before PCI assign resources for uninitialized PCI devices
- */
-fs_initcall(acpi_motherboard_init);
-- 
1.5.0.rc3.39.gec804
