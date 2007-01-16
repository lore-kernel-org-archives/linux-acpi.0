From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 5/5] ACPI: remove motherboard driver (redundant with PNP system driver)
Date: Tue, 16 Jan 2007 10:35:45 -0700
Message-ID: <200701161035.45188.bjorn.helgaas@hp.com>
References: <200701161028.10109.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:45278 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbXAPRgT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jan 2007 12:36:19 -0500
In-Reply-To: <200701161028.10109.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

The PNP system board driver (drivers/pnp/system.c) contains all the
same functionality, so we don't need the ACPI version.

Previously, a motherboard device would be claimed by *both* the ACPI and
PNP drivers, resulting in stuff like this in /proc/ioports:

    1200-121f : motherboard	<-- from drivers/acpi/motherboard.c
      1200-121f : pnp 00:0d	<-- from drivers/pnp/system.c

Make sure to enable CONFIG_PNP (and CONFIG_PNPACPI) to include the
PNP system board driver.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: mm-work13/drivers/acpi/Makefile
===================================================================
--- mm-work13.orig/drivers/acpi/Makefile	2007-01-08 12:03:18.000000000 -0700
+++ mm-work13/drivers/acpi/Makefile	2007-01-11 13:17:02.000000000 -0700
@@ -37,7 +37,7 @@
 
 obj-y				+= sleep/
 obj-y				+= bus.o glue.o
-obj-y				+= scan.o motherboard.o
+obj-y				+= scan.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
Index: mm-work13/drivers/acpi/motherboard.c
===================================================================
--- mm-work13.orig/drivers/acpi/motherboard.c	2007-01-11 12:35:28.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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
