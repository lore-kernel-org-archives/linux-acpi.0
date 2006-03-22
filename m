From: akpm@osdl.org
Subject: [patch 19/23] serial: remove 8250_acpi (replaced by 8250_pnp and PNPACPI)
Date: Tue, 21 Mar 2006 22:30:42 -0800
Message-ID: <200603220633.k2M6XuQY019583@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:30396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750858AbWCVGeO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Mar 2006 01:34:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, bjorn.helgaas@hp.com, ambx1@neo.rr.com, rmk@arm.linux.org.uk


From: Bjorn Helgaas <bjorn.helgaas@hp.com>

With the combination of PNPACPI and 8250_pnp, we no longer need 8250_acpi.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Adam Belay <ambx1@neo.rr.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 dev/null                |  183 --------------------------------------
 drivers/serial/Kconfig  |    8 -
 drivers/serial/Makefile |    1 
 3 files changed, 192 deletions(-)

diff -L drivers/serial/8250_acpi.c -puN drivers/serial/8250_acpi.c~serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi /dev/null
--- devel/drivers/serial/8250_acpi.c
+++ /dev/null	2003-09-15 06:40:47.000000000 -0700
@@ -1,183 +0,0 @@
-/*
- * Copyright (c) 2002-2003 Matthew Wilcox for Hewlett-Packard
- * Copyright (C) 2004 Hewlett-Packard Co
- *	Bjorn Helgaas <bjorn.helgaas@hp.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/serial_core.h>
-
-#include <acpi/acpi_bus.h>
-
-#include <asm/io.h>
-
-#include "8250.h"
-
-struct serial_private {
-	int	line;
-};
-
-static acpi_status acpi_serial_mmio(struct uart_port *port,
-				    struct acpi_resource_address64 *addr)
-{
-	port->mapbase = addr->minimum;
-	port->iotype = UPIO_MEM;
-	port->flags |= UPF_IOREMAP;
-	return AE_OK;
-}
-
-static acpi_status acpi_serial_port(struct uart_port *port,
-				    struct acpi_resource_io *io)
-{
-	if (io->address_length) {
-		port->iobase = io->minimum;
-		port->iotype = UPIO_PORT;
-	} else
-		printk(KERN_ERR "%s: zero-length IO port range?\n", __FUNCTION__);
-	return AE_OK;
-}
-
-static acpi_status acpi_serial_ext_irq(struct uart_port *port,
-				       struct acpi_resource_extended_irq *ext_irq)
-{
-	int rc;
-
-	if (ext_irq->interrupt_count > 0) {
-		rc = acpi_register_gsi(ext_irq->interrupts[0],
-	                   ext_irq->triggering, ext_irq->polarity);
-		if (rc < 0)
-			return AE_ERROR;
-		port->irq = rc;
-	}
-	return AE_OK;
-}
-
-static acpi_status acpi_serial_irq(struct uart_port *port,
-				   struct acpi_resource_irq *irq)
-{
-	int rc;
-
-	if (irq->interrupt_count > 0) {
-		rc = acpi_register_gsi(irq->interrupts[0],
-	                   irq->triggering, irq->polarity);
-		if (rc < 0)
-			return AE_ERROR;
-		port->irq = rc;
-	}
-	return AE_OK;
-}
-
-static acpi_status acpi_serial_resource(struct acpi_resource *res, void *data)
-{
-	struct uart_port *port = (struct uart_port *) data;
-	struct acpi_resource_address64 addr;
-	acpi_status status;
-
-	status = acpi_resource_to_address64(res, &addr);
-	if (ACPI_SUCCESS(status))
-		return acpi_serial_mmio(port, &addr);
-	else if (res->type == ACPI_RESOURCE_TYPE_IO)
-		return acpi_serial_port(port, &res->data.io);
-	else if (res->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ)
-		return acpi_serial_ext_irq(port, &res->data.extended_irq);
-	else if (res->type == ACPI_RESOURCE_TYPE_IRQ)
-		return acpi_serial_irq(port, &res->data.irq);
-	return AE_OK;
-}
-
-static int acpi_serial_add(struct acpi_device *device)
-{
-	struct serial_private *priv;
-	acpi_status status;
-	struct uart_port port;
-	int result;
-
-	memset(&port, 0, sizeof(struct uart_port));
-
-	port.uartclk = 1843200;
-	port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-
-	priv = kmalloc(sizeof(struct serial_private), GFP_KERNEL);
-	if (!priv) {
-		result = -ENOMEM;
-		goto fail;
-	}
-	memset(priv, 0, sizeof(*priv));
-
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-				     acpi_serial_resource, &port);
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto fail;
-	}
-
-	if (!port.mapbase && !port.iobase) {
-		printk(KERN_ERR "%s: no iomem or port address in %s _CRS\n",
-			__FUNCTION__, device->pnp.bus_id);
-		result = -ENODEV;
-		goto fail;
-	}
-
-	priv->line = serial8250_register_port(&port);
-	if (priv->line < 0) {
-		printk(KERN_WARNING "Couldn't register serial port %s: %d\n",
-			device->pnp.bus_id, priv->line);
-		result = -ENODEV;
-		goto fail;
-	}
-
-	acpi_driver_data(device) = priv;
-	return 0;
-
-fail:
-	kfree(priv);
-
-	return result;
-}
-
-static int acpi_serial_remove(struct acpi_device *device, int type)
-{
-	struct serial_private *priv;
-
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
-	priv = acpi_driver_data(device);
-	serial8250_unregister_port(priv->line);
-	kfree(priv);
-
-	return 0;
-}
-
-static struct acpi_driver acpi_serial_driver = {
-	.name =		"serial",
-	.class =	"",
-	.ids =		"PNP0501",
-	.ops =	{
-		.add =		acpi_serial_add,
-		.remove =	acpi_serial_remove,
-	},
-};
-
-static int __init acpi_serial_init(void)
-{
-	return acpi_bus_register_driver(&acpi_serial_driver);
-}
-
-static void __exit acpi_serial_exit(void)
-{
-	acpi_bus_unregister_driver(&acpi_serial_driver);
-}
-
-module_init(acpi_serial_init);
-module_exit(acpi_serial_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Generic 8250/16x50 ACPI serial driver");
diff -puN drivers/serial/Kconfig~serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi drivers/serial/Kconfig
--- devel/drivers/serial/Kconfig~serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi	2006-03-21 22:30:07.000000000 -0800
+++ devel-akpm/drivers/serial/Kconfig	2006-03-21 22:30:07.000000000 -0800
@@ -77,14 +77,6 @@ config SERIAL_8250_CS
 
 	  If unsure, say N.
 
-config SERIAL_8250_ACPI
-	bool "8250/16550 device discovery via ACPI namespace"
-	default y if IA64
-	depends on ACPI && SERIAL_8250
-	---help---
-	  If you wish to enable serial port discovery via the ACPI
-	  namespace, say Y here.  If unsure, say N.
-
 config SERIAL_8250_NR_UARTS
 	int "Maximum number of 8250/16550 serial ports"
 	depends on SERIAL_8250
diff -puN drivers/serial/Makefile~serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi drivers/serial/Makefile
--- devel/drivers/serial/Makefile~serial-remove-8250_acpi-replaced-by-8250_pnp-and-pnpacpi	2006-03-21 22:30:07.000000000 -0800
+++ devel-akpm/drivers/serial/Makefile	2006-03-21 22:30:07.000000000 -0800
@@ -5,7 +5,6 @@
 #
 
 serial-8250-y :=
-serial-8250-$(CONFIG_SERIAL_8250_ACPI) += 8250_acpi.o
 serial-8250-$(CONFIG_PNP) += 8250_pnp.o
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
_
