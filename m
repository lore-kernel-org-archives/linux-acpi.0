From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC 2/2]ACPI PNP driver
Date: Wed, 22 Sep 2004 12:35:07 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095827699.18437.139.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-A/kd7vxk6RW4mIn8v9DC"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthieu <castet.matthieu-GANU6spQydw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-A/kd7vxk6RW4mIn8v9DC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
This patch provides an ACPI based PNP driver. It is based on Matthieu
Castet's original work. With this patch, legacy device drivers (floppy
ACPI driver, COM ACPI driver, and ACPI motherboard driver) which
directly use ACPI can be removed, since now we have unified PNP
interface for legacy devices.

Thanks,
Shaohua

===== drivers/acpi/scan.c 1.30 vs edited =====
--- 1.30/drivers/acpi/scan.c	2004-08-10 01:03:16 +08:00
+++ edited/drivers/acpi/scan.c	2004-09-21 20:26:08 +08:00
@@ -161,7 +161,7 @@ acpi_bus_get_power_flags (
 	return 0;
 }
 
-static int
+int
 acpi_match_ids (
 	struct acpi_device	*device,
 	char			*ids)
===== include/linux/pnp.h 1.27 vs edited =====
--- 1.27/include/linux/pnp.h	2004-02-08 23:35:49 +08:00
+++ edited/include/linux/pnp.h	2004-09-21 20:43:06 +08:00
@@ -200,6 +200,7 @@ struct pnp_dev {
 	unsigned short	regs;		/* ISAPnP: supported registers */
 	int 		flags;		/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
+	void *data;
 };
 
 #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
===== include/acpi/acpi_bus.h 1.18 vs edited =====
--- 1.18/include/acpi/acpi_bus.h	2004-07-14 13:22:19 +08:00
+++ edited/include/acpi/acpi_bus.h	2004-09-21 20:28:07 +08:00
@@ -322,6 +322,7 @@ int acpi_bus_receive_event (struct acpi_
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 
+int acpi_match_ids (struct acpi_device	*device, char	*ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
===== drivers/pnp/Kconfig 1.8 vs edited =====
--- 1.8/drivers/pnp/Kconfig	2004-02-09 00:58:50 +08:00
+++ edited/drivers/pnp/Kconfig	2004-09-21 20:22:51 +08:00
@@ -35,5 +35,7 @@ source "drivers/pnp/isapnp/Kconfig"
 
 source "drivers/pnp/pnpbios/Kconfig"
 
+source "drivers/pnp/pnpacpi/Kconfig"
+
 endmenu
 
===== drivers/pnp/Makefile 1.14 vs edited =====
--- 1.14/drivers/pnp/Makefile	2003-08-06 05:21:26 +08:00
+++ edited/drivers/pnp/Makefile	2004-09-21 20:22:45 +08:00
@@ -6,3 +6,4 @@ obj-y		:= core.o card.o driver.o resourc
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
+obj-$(CONFIG_PNPACPI)		+= pnpacpi/
===== drivers/pnp/pnpbios/Kconfig 1.2 vs edited =====
--- 1.2/drivers/pnp/pnpbios/Kconfig	2004-06-01 17:27:56 +08:00
+++ edited/drivers/pnp/pnpbios/Kconfig	2004-09-21 20:25:07 +08:00
@@ -4,6 +4,7 @@
 config PNPBIOS
 	bool "Plug and Play BIOS support (EXPERIMENTAL)"
 	depends on PNP && X86 && EXPERIMENTAL
+	default n
 	---help---
 	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
 	  Specification Version 1.0A May 5, 1994" to autodetect built-in
===== drivers/pnp/pnpacpi/core.c 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/core.c	2004-09-21 20:32:35 +08:00
+++ edited/drivers/pnp/pnpacpi/core.c	2004-09-22 10:37:42 +08:00
@@ -0,0 +1,240 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
+ */
+ 
+#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+#include "pnpacpi.h"
+
+static char excluded_id_list[] __devinitdata =
+	"PNP0C0A," /* Battery */
+	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
+	"PNP0C09," /* EC */
+	"PNP0C0B," /* Fan */
+	"PNP0A03," /* PCI root */
+	"PNP0C0F," /* Link device */
+	"PNP0000," /* PIC */
+	"PNP0100," /* Timer */
+	;
+static int __devinit is_exclusive_device(struct acpi_device *dev)
+{
+	if(!acpi_match_ids(dev, excluded_id_list))
+		return 1;
+	return 0;
+}
+
+void *pnpacpi_kmalloc(size_t size, int f)
+{
+	void *p = kmalloc(size, f);
+	if (p)
+		memset(p, 0, size);
+	return p;
+}
+
+/*
+ * Compatible Device IDs
+ */
+static void __devinit pnpidacpi_to_pnpid(char *id, char *str)
+{
+	str[0] = id[0];
+	str[1] = id[1];
+	str[2] = id[2];
+	str[3] = tolower(id[3]);
+	str[4] = tolower(id[4]);
+	str[5] = tolower(id[5]);
+	str[6] = tolower(id[6]);
+	str[7] = '\0';
+}
+
+static int pnpacpi_get_resources(struct pnp_dev * dev, struct
pnp_resource_table * res)
+{
+	acpi_status status;
+	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data, 
+		&dev->res);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+static int pnpacpi_set_resources(struct pnp_dev * dev, struct
pnp_resource_table * res)
+{
+	acpi_handle handle = dev->data;
+	struct acpi_buffer buffer;
+	int ret = 0;
+	acpi_status status;
+
+	ret = pnpacpi_build_resource_template(handle, &buffer);
+	if (ret)
+		return ret;
+	ret = pnpacpi_encode_resources(res, &buffer);
+	if (ret) {
+		kfree(buffer.pointer);
+		return ret;
+	}
+	status = acpi_set_current_resources(handle, &buffer);
+	if (ACPI_FAILURE(status))
+		ret = -EINVAL;
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static int pnpacpi_disable_resources(struct pnp_dev *dev)
+{
+	acpi_status status;
+	status = acpi_evaluate_object((acpi_handle)dev->data, 
+		"_DIS", NULL, NULL);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+struct pnp_protocol pnpacpi_protocol = {
+	.name	= "Plug and Play ACPI",
+	.get	= pnpacpi_get_resources,
+	.set	= pnpacpi_set_resources,
+	.disable = pnpacpi_disable_resources,
+};
+
+static int __devinit pnpacpi_add_device(struct acpi_device *device)
+{
+	acpi_handle temp = NULL;
+	acpi_status status;
+	struct pnp_id *dev_id;
+	char id[8];
+	struct pnp_dev *dev;
+	static int num = 0;
+
+	if ((strlen(acpi_device_hid(device)) != 7) ||
+		is_exclusive_device(device))
+		return 0;
+
+	pnpidacpi_to_pnpid(acpi_device_hid(device), id);
+	
+	pnp_dbg("ACPI device : hid %s \n", acpi_device_hid(device));
+	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	if (!dev) {
+		pnp_err("Out of memory");
+		return -1;
+	}
+	dev->data = device->handle;
+	/* .enabled means if the device can decode the resources */
+	dev->active = device->status.enabled;
+	status = acpi_get_handle(device->handle, "_SRS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_CONFIGURABLE;
+	dev->capabilities |= PNP_READ;
+	if (device->flags.dynamic_status)
+		dev->capabilities |= PNP_WRITE;
+	if (device->flags.removable)
+		dev->capabilities |= PNP_REMOVABLE;
+	status = acpi_get_handle(device->handle, "_DIS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_DISABLE;
+
+	dev->protocol = &pnpacpi_protocol;
+
+	if(strlen(acpi_device_name(device)))
+		strncpy(dev->name, acpi_device_name(device), PNP_NAME_LEN);
+	else
+		strncpy(dev->name, acpi_device_bid(device), PNP_NAME_LEN);
+
+	dev->number = num;
+	
+	/* set the initial values for the PnP device */
+	dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	if (!dev_id)
+		goto err;
+	memcpy(dev_id->id, id, 7);
+
+	pnp_add_id(dev_id, dev);
+	
+	if(dev->active) {
+		/* parse allocated resource */
+		status = pnpacpi_parse_allocated_resource(device->handle, &dev->res);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: METHOD_NAME__CRS faillure for %s", id);
+			goto err1;
+		}
+	}
+
+	if(dev->capabilities & PNP_CONFIGURABLE) {
+		status = pnpacpi_parse_resource_option_data(device->handle, 
+			dev);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: _PRS failed for %s", id);
+			goto err1;
+		}
+	}
+	
+	/* parse compatible ids */
+	if (device->flags.compatible_ids) {
+		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		int i;
+
+		for (i = 0; i < cid_list->count; i++) {
+			if (strlen(cid_list->id[i].value) != 7)
+				continue;	
+			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), 
+				GFP_KERNEL);
+			if (!dev_id)
+				continue;
+
+			pnpidacpi_to_pnpid(cid_list->id[i].value, id);
+			memcpy(dev_id->id, id, 7);
+			pnp_add_id(dev_id, dev);
+		}
+	}
+
+	/* clear out the damaged flags */
+	if (!dev->active)
+		pnp_init_resource_table(&dev->res);
+	pnp_add_device(dev);
+	num ++;
+	return 0;
+err1:
+	kfree(dev_id);
+err:
+	kfree(dev);
+	return -1;
+}
+
+static acpi_status __init pnpacpi_add_device_handler(acpi_handle
handle,
+		u32 lvl, void *context, void **rv)
+{
+	struct acpi_device *device;
+
+	if (!acpi_bus_get_device(handle, &device))
+		pnpacpi_add_device(device);
+	return AE_OK;
+}
+
+int __init pnpacpi_init(void)
+{
+	if (acpi_disabled) {
+		pnp_info("PnP ACPI: acpi disable");
+		return 0;
+	}
+	pnp_info("PnP ACPI init");
+	pnp_register_protocol(&pnpacpi_protocol);
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, pnpacpi_add_device_handler,
+			NULL, NULL);
+	return 0;
+}
+subsys_initcall(pnpacpi_init);
+
+EXPORT_SYMBOL(pnpacpi_protocol);
===== drivers/pnp/pnpacpi/Kconfig 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/Kconfig	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/Kconfig	2004-09-21 20:33:09 +08:00
@@ -0,0 +1,9 @@
+#
+# Plug and Play ACPI configuration
+#
+config PNPACPI
+	bool "Plug and Play ACPI support (EXPERIMENTAL)"
+	depends on PNP && X86 && ACPI_BUS && !PNPBIOS && EXPERIMENTAL
+	default y
+	---help---
+	Todo
===== drivers/pnp/pnpacpi/Makefile 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/Makefile	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/Makefile	2004-09-21 20:33:09 +08:00
@@ -0,0 +1,5 @@
+#
+# Makefile for the kernel PNPACPI driver.
+#
+
+obj-y := core.o rsparser.o
===== drivers/pnp/pnpacpi/pnpacpi.h 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/pnpacpi.h	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/pnpacpi.h	2004-09-21 20:35:29 +08:00
@@ -0,0 +1,13 @@
+#ifndef ACPI_PNP_H
+#define ACPI_PNP_H
+
+#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+
+void *pnpacpi_kmalloc(size_t size, int f);
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle, struct
pnp_resource_table*);
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle, struct
pnp_dev*);
+int pnpacpi_encode_resources(struct pnp_resource_table *, struct
acpi_buffer *);
+int pnpacpi_build_resource_template(acpi_handle, struct acpi_buffer*);
+#endif
===== drivers/pnp/pnpacpi/rsparser.c 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/rsparser.c	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/rsparser.c	2004-09-22 10:59:39 +08:00
@@ -0,0 +1,810 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include "pnpacpi.h"
+
+#define valid_IRQ(i) (((i) != 0) && ((i) != 2) && ((i) < 16))
+/*
+ * Allocated Resources
+ */
+static int irq_flags(int edge_level, int active_high_low)
+{
+	int flag;
+	if (edge_level == ACPI_LEVEL_SENSITIVE) {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWLEVEL;
+		else
+			flag = IORESOURCE_IRQ_HIGHLEVEL;
+	}
+	else {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWEDGE;
+		else
+			flag = IORESOURCE_IRQ_HIGHEDGE;
+	}
+	return flag;
+}
+
+static void decode_irq_flags(int flag, int *edge_level, int
*active_high_low)
+{
+	switch (flag) {
+	case IORESOURCE_IRQ_LOWLEVEL:
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHLEVEL:	
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	case IORESOURCE_IRQ_LOWEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res,
int irq)
+{
+	int i = 0;
+	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_IRQ)
+		i++;
+	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET
flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->irq_resource[i].start =(unsigned long) irq;
+		res->irq_resource[i].end = (unsigned long) irq;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res,
int dma)
+{
+	int i = 0;
+	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_DMA)
+		i++;
+	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET
flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->dma_resource[i].start =(unsigned long) dma;
+		res->dma_resource[i].end = (unsigned long) dma;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
+	int io, int len)
+{
+	int i = 0;
+	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_PORT)
+		i++;
+	if (i < PNP_MAX_PORT) {
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET
flag
+		if (len <= 0 || (io + len -1) >= 0x10003) {
+			res->port_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->port_resource[i].start = (unsigned long) io;
+		res->port_resource[i].end = (unsigned long)(io + len - 1);
+	}
+}
+
+static void
+pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
+	int mem, int len)
+{
+	int i = 0;
+	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
+			(i < PNP_MAX_MEM))
+		i++;
+	if (i < PNP_MAX_MEM) {
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET
flag
+		if (len <= 0) {
+			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->mem_resource[i].start = (unsigned long) mem;
+		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+	}
+}
+
+
+static acpi_status pnpacpi_allocated_resource(struct acpi_resource
*res,
+	void *data)
+{
+	struct pnp_resource_table * res_table = (struct pnp_resource_table
*)data;
+
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+		if ((res->data.irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.irq.interrupts[0],
+					res->data.irq.edge_level,
+					res->data.irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.irq.interrupts[0]);
+		}
+		break;
+
+	case ACPI_RSTYPE_EXT_IRQ:
+		if ((res->data.extended_irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.extended_irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.extended_irq.interrupts[0],
+					res->data.extended_irq.edge_level,
+					res->data.extended_irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0]);
+		}
+		break;
+	case ACPI_RSTYPE_DMA:
+		if (res->data.dma.number_of_channels > 0)
+			pnpacpi_parse_allocated_dmaresource(res_table, 
+					res->data.dma.channels[0]);
+		break;
+	case ACPI_RSTYPE_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.io.min_base_address, 
+				res->data.io.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.fixed_io.base_address, 
+				res->data.fixed_io.range_length);
+		break;
+	case ACPI_RSTYPE_MEM24:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory24.min_base_address, 
+				res->data.memory24.range_length);
+		break;
+	case ACPI_RSTYPE_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory32.min_base_address, 
+				res->data.memory32.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.fixed_memory32.range_base_address, 
+				res->data.fixed_memory32.range_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS16:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address16.min_address_range, 
+				res->data.address16.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address32.min_address_range, 
+				res->data.address32.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS64:
+		pnpacpi_parse_allocated_memresource(res_table, 
+		res->data.address64.min_address_range, 
+		res->data.address64.address_length);
+		break;
+	default:
+		pnp_warn("PnPACPI: Alloc type : %d not handle", 
+				res->id);
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle, struct
pnp_resource_table * res)
+{
+	/* Blank the resource table values */
+	pnp_init_resource_table(res);
+
+	return acpi_walk_resources(handle, METHOD_NAME__CRS,
pnpacpi_allocated_resource, res);
+}
+
+static void pnpacpi_parse_dma_option(struct pnp_option *option, struct
acpi_resource_dma *p)
+{
+	int i;
+	struct pnp_dma * dma;
+
+	if (p->number_of_channels <= 0)
+		return;
+	dma = pnpacpi_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	if (!dma)
+		return;
+
+	for(i = 0; i < p->number_of_channels; i++)
+		dma->map |= 1 << p->channels[i];
+	dma->flags = 0;
+	if (p->bus_master)
+		dma->flags |= IORESOURCE_DMA_MASTER;
+	switch (p->type) {
+	case ACPI_COMPATIBILITY:
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		break;
+	case ACPI_TYPE_A:
+		dma->flags |= IORESOURCE_DMA_TYPEA;
+		break;
+	case ACPI_TYPE_B:
+		dma->flags |= IORESOURCE_DMA_TYPEB;
+		break;
+	case ACPI_TYPE_F:
+		dma->flags |= IORESOURCE_DMA_TYPEF;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		pnp_err("Invalid DMA type");
+	}
+	switch (p->transfer) {
+	case ACPI_TRANSFER_8:
+		dma->flags |= IORESOURCE_DMA_8BIT;
+		break;
+	case ACPI_TRANSFER_8_16:
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		break;
+	case ACPI_TRANSFER_16:
+		dma->flags |= IORESOURCE_DMA_16BIT;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		pnp_err("Invalid DMA transfer type");
+	}
+
+	pnp_register_dma_resource(option,dma);
+	return;
+}
+
+	
+static void pnpacpi_parse_irq_option(struct pnp_option *option,
+	struct acpi_resource_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+	
+	if (p->number_of_interrupts <= 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		irq->map |= 1 << p->interrupts[i];
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void pnpacpi_parse_ext_irq_option(struct pnp_option *option,
+	struct acpi_resource_ext_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+
+	if (p->number_of_interrupts <= 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		irq->map |= 1 << p->interrupts[i];
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void
+pnpacpi_parse_port_option(struct pnp_option *option,
+	struct acpi_resource_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length <= 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = io->min_base_address;
+	port->max = io->max_base_address;
+	port->align = io->alignment;
+	port->size = io->range_length;
+	port->flags = ACPI_DECODE_16 == io->io_decode ? 
+		PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_port_option(struct pnp_option *option,
+	struct acpi_resource_fixed_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length <= 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = port->max = io->base_address;
+	port->size = io->range_length;
+	port->align = 0;
+	port->flags = PNP_PORT_FLAG_FIXED;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_mem24_option(struct pnp_option *option,
+	struct acpi_resource_mem24 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length <= 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_mem32_option(struct pnp_option *option,
+	struct acpi_resource_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length <= 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
+	struct acpi_resource_fixed_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length <= 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = mem->max = p->range_base_address;
+	mem->size = p->range_length;
+	mem->align = 0;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+struct acpipnp_parse_option_s {
+	struct pnp_option *option;
+	struct pnp_dev *dev;
+};
+
+static acpi_status pnpacpi_option_resource(struct acpi_resource *res, 
+	void *data)
+{
+	int priority = 0;
+	struct acpipnp_parse_option_s *parse_data = (struct
acpipnp_parse_option_s *)data;
+	struct pnp_dev *dev = parse_data->dev;
+	struct pnp_option *option = parse_data->option;
+
+	switch (res->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnpacpi_parse_irq_option(option, &res->data.irq);
+			break;
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnpacpi_parse_ext_irq_option(option,
+				&res->data.extended_irq);
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnpacpi_parse_dma_option(option, &res->data.dma);	
+			break;
+		case ACPI_RSTYPE_IO:
+			pnpacpi_parse_port_option(option, &res->data.io);
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnpacpi_parse_fixed_port_option(option,
+				&res->data.fixed_io);
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnpacpi_parse_mem24_option(option, &res->data.memory24);
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnpacpi_parse_mem32_option(option, &res->data.memory32);
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnpacpi_parse_fixed_mem32_option(option,
+				&res->data.fixed_memory32);
+			break;
+		case ACPI_RSTYPE_START_DPF:
+			switch (res->data.start_dpf.compatibility_priority) {
+				case ACPI_GOOD_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_PREFERRED;
+					break;
+					
+				case ACPI_ACCEPTABLE_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_ACCEPTABLE;
+					break;
+
+				case ACPI_SUB_OPTIMAL_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_FUNCTIONAL;
+					break;
+				default:
+					priority = PNP_RES_PRIORITY_INVALID;
+					break;
+			}
+			/* TBD: Considering performace/robustness bits */
+			option = pnp_register_dependent_option(dev, priority);
+			if (!option)
+				return AE_ERROR;
+			parse_data->option = option;	
+			break;
+		case ACPI_RSTYPE_END_DPF:
+			return AE_CTRL_TERMINATE;
+		default:
+			pnp_warn("PnPACPI: Option type : %d not handle", res->id);
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle handle, 
+	struct pnp_dev *dev)
+{
+	acpi_status status;
+	struct acpipnp_parse_option_s parse_data;
+
+	parse_data.option = pnp_register_independent_option(dev);
+	if (!parse_data.option)
+		return AE_ERROR;
+	parse_data.dev = dev;
+	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
+		pnpacpi_option_resource, &parse_data);
+
+	return status;
+}
+
+/*
+ * Set resource
+ */
+static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
+	void *data)
+{
+	int *res_cnt = (int *)data;
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*res_cnt) ++;
+	default:
+		return AE_OK;
+	}
+	return AE_OK;
+}
+
+static acpi_status pnpacpi_type_resources(struct acpi_resource *res,
+	void *data)
+{
+	struct acpi_resource **resource = (struct acpi_resource **)data;	
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*resource)->id = res->id;
+		(*resource)++;
+	default:
+		return AE_OK;
+	}
+
+	return AE_OK;
+}
+
+int pnpacpi_build_resource_template(acpi_handle handle, 
+	struct acpi_buffer *buffer)
+{
+	struct acpi_resource *resource;
+	int res_cnt = 0;
+	acpi_status status;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_count_resources, &res_cnt);
+	if (ACPI_FAILURE(status)) {
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	if (!res_cnt)
+		return -EINVAL;
+	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
+	buffer->pointer = pnpacpi_kmalloc(buffer->length - 1, GFP_KERNEL);
+	if (!buffer->pointer)
+		return -ENOMEM;
+	pnp_dbg("Res cnt %d", res_cnt);
+	resource = (struct acpi_resource *)buffer->pointer;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_type_resources, &resource);
+	if (ACPI_FAILURE(status)) {
+		kfree(buffer->pointer);
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	/* resource will pointer the end resource now */
+	resource->id = ACPI_RSTYPE_END_TAG;
+
+	return 0;
+}
+
+static void pnpacpi_encode_irq(struct acpi_resource *resource, 
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.irq.edge_level = edge_level;
+	resource->data.irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.irq.number_of_interrupts = 1;
+	resource->data.irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_ext_irq(struct acpi_resource *resource,
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_EXT_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
+	resource->data.extended_irq.edge_level = edge_level;
+	resource->data.extended_irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.extended_irq.number_of_interrupts = 1;
+	resource->data.extended_irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_dma(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_DMA;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
+	if (p->flags & IORESOURCE_DMA_COMPATIBLE)
+		resource->data.dma.type = ACPI_COMPATIBILITY;
+	else if (p->flags & IORESOURCE_DMA_TYPEA)
+		resource->data.dma.type = ACPI_TYPE_A;
+	else if (p->flags & IORESOURCE_DMA_TYPEB)
+		resource->data.dma.type = ACPI_TYPE_B;
+	else if (p->flags & IORESOURCE_DMA_TYPEF)
+		resource->data.dma.type = ACPI_TYPE_F;
+	if (p->flags & IORESOURCE_DMA_8BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8;
+	else if (p->flags & IORESOURCE_DMA_8AND16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8_16;
+	else if (p->flags & IORESOURCE_DMA_16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_16;
+	resource->data.dma.bus_master = p->flags & IORESOURCE_DMA_MASTER;
+	resource->data.dma.number_of_channels = 1;
+	resource->data.dma.channels[0] = p->start;
+}
+
+static void pnpacpi_encode_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_IO;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
+	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
+		ACPI_DECODE_16 : ACPI_DECODE_10; 
+	resource->data.io.min_base_address = p->start;
+	resource->data.io.max_base_address = p->end;
+	resource->data.io.alignment = 0; /* Correct? */
+	resource->data.io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_IO;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_io.base_address = p->start;
+	resource->data.fixed_io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem24(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM24;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_mem will copy pnp_mem->flags into p->flags */
+	resource->data.memory24.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory24.min_base_address = p->start;
+	resource->data.memory24.max_base_address = p->end;
+	resource->data.memory24.alignment = 0;
+	resource->data.memory24.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory32.min_base_address = p->start;
+	resource->data.memory32.max_base_address = p->end;
+	resource->data.memory32.alignment = 0;
+	resource->data.memory32.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.fixed_memory32.range_base_address = p->start;
+	resource->data.fixed_memory32.range_length = p->end - p->start + 1;
+}
+
+int pnpacpi_encode_resources(struct pnp_resource_table *res_table, 
+	struct acpi_buffer *buffer)
+{
+	int i = 0;
+	/* pnpacpi_build_resource_template allocates extra mem */
+	int res_cnt = (buffer->length - 1)/sizeof(struct acpi_resource) - 1;
+	struct acpi_resource *resource = (struct
acpi_resource*)buffer->pointer;
+	int port = 0, irq = 0, dma = 0, mem = 0;
+
+	pnp_dbg("res cnt %d", res_cnt);
+	while (i < res_cnt) {
+		switch(resource->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnp_dbg("Encode irq");
+			pnpacpi_encode_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnp_dbg("Encode ext irq");
+			pnpacpi_encode_ext_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnp_dbg("Encode dma");
+			pnpacpi_encode_dma(resource, 
+				&res_table->dma_resource[dma]);
+			dma ++;
+			break;
+		case ACPI_RSTYPE_IO:
+			pnp_dbg("Encode io");
+			pnpacpi_encode_io(resource, 
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnp_dbg("Encode fixed io");
+			pnpacpi_encode_fixed_io(resource,
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnp_dbg("Encode mem24");
+			pnpacpi_encode_mem24(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnp_dbg("Encode mem32");
+			pnpacpi_encode_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnp_dbg("Encode fixed mem32");
+			pnpacpi_encode_fixed_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		default: /* other type */
+			pnp_warn("Invalid type");
+		}
+		resource ++;
+		i ++;
+	}
+	return 0;
+}


--=-A/kd7vxk6RW4mIn8v9DC
Content-Disposition: attachment; filename=pnp-acpi.patch
Content-Type: text/x-patch; name=pnp-acpi.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== drivers/acpi/scan.c 1.30 vs edited =====
--- 1.30/drivers/acpi/scan.c	2004-08-10 01:03:16 +08:00
+++ edited/drivers/acpi/scan.c	2004-09-21 20:26:08 +08:00
@@ -161,7 +161,7 @@ acpi_bus_get_power_flags (
 	return 0;
 }
 
-static int
+int
 acpi_match_ids (
 	struct acpi_device	*device,
 	char			*ids)
===== include/linux/pnp.h 1.27 vs edited =====
--- 1.27/include/linux/pnp.h	2004-02-08 23:35:49 +08:00
+++ edited/include/linux/pnp.h	2004-09-21 20:43:06 +08:00
@@ -200,6 +200,7 @@ struct pnp_dev {
 	unsigned short	regs;		/* ISAPnP: supported registers */
 	int 		flags;		/* used by protocols */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
+	void *data;
 };
 
 #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
===== include/acpi/acpi_bus.h 1.18 vs edited =====
--- 1.18/include/acpi/acpi_bus.h	2004-07-14 13:22:19 +08:00
+++ edited/include/acpi/acpi_bus.h	2004-09-21 20:28:07 +08:00
@@ -322,6 +322,7 @@ int acpi_bus_receive_event (struct acpi_
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 
+int acpi_match_ids (struct acpi_device	*device, char	*ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
===== drivers/pnp/Kconfig 1.8 vs edited =====
--- 1.8/drivers/pnp/Kconfig	2004-02-09 00:58:50 +08:00
+++ edited/drivers/pnp/Kconfig	2004-09-21 20:22:51 +08:00
@@ -35,5 +35,7 @@ source "drivers/pnp/isapnp/Kconfig"
 
 source "drivers/pnp/pnpbios/Kconfig"
 
+source "drivers/pnp/pnpacpi/Kconfig"
+
 endmenu
 
===== drivers/pnp/Makefile 1.14 vs edited =====
--- 1.14/drivers/pnp/Makefile	2003-08-06 05:21:26 +08:00
+++ edited/drivers/pnp/Makefile	2004-09-21 20:22:45 +08:00
@@ -6,3 +6,4 @@ obj-y		:= core.o card.o driver.o resourc
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
+obj-$(CONFIG_PNPACPI)		+= pnpacpi/
===== drivers/pnp/pnpbios/Kconfig 1.2 vs edited =====
--- 1.2/drivers/pnp/pnpbios/Kconfig	2004-06-01 17:27:56 +08:00
+++ edited/drivers/pnp/pnpbios/Kconfig	2004-09-21 20:25:07 +08:00
@@ -4,6 +4,7 @@
 config PNPBIOS
 	bool "Plug and Play BIOS support (EXPERIMENTAL)"
 	depends on PNP && X86 && EXPERIMENTAL
+	default n
 	---help---
 	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
 	  Specification Version 1.0A May 5, 1994" to autodetect built-in
===== drivers/pnp/pnpacpi/core.c 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/core.c	2004-09-21 20:32:35 +08:00
+++ edited/drivers/pnp/pnpacpi/core.c	2004-09-22 10:37:42 +08:00
@@ -0,0 +1,240 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+ 
+#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+#include "pnpacpi.h"
+
+static char excluded_id_list[] __devinitdata =
+	"PNP0C0A," /* Battery */
+	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
+	"PNP0C09," /* EC */
+	"PNP0C0B," /* Fan */
+	"PNP0A03," /* PCI root */
+	"PNP0C0F," /* Link device */
+	"PNP0000," /* PIC */
+	"PNP0100," /* Timer */
+	;
+static int __devinit is_exclusive_device(struct acpi_device *dev)
+{
+	if(!acpi_match_ids(dev, excluded_id_list))
+		return 1;
+	return 0;
+}
+
+void *pnpacpi_kmalloc(size_t size, int f)
+{
+	void *p = kmalloc(size, f);
+	if (p)
+		memset(p, 0, size);
+	return p;
+}
+
+/*
+ * Compatible Device IDs
+ */
+static void __devinit pnpidacpi_to_pnpid(char *id, char *str)
+{
+	str[0] = id[0];
+	str[1] = id[1];
+	str[2] = id[2];
+	str[3] = tolower(id[3]);
+	str[4] = tolower(id[4]);
+	str[5] = tolower(id[5]);
+	str[6] = tolower(id[6]);
+	str[7] = '\0';
+}
+
+static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+{
+	acpi_status status;
+	status = pnpacpi_parse_allocated_resource((acpi_handle)dev->data, 
+		&dev->res);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+static int pnpacpi_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+{
+	acpi_handle handle = dev->data;
+	struct acpi_buffer buffer;
+	int ret = 0;
+	acpi_status status;
+
+	ret = pnpacpi_build_resource_template(handle, &buffer);
+	if (ret)
+		return ret;
+	ret = pnpacpi_encode_resources(res, &buffer);
+	if (ret) {
+		kfree(buffer.pointer);
+		return ret;
+	}
+	status = acpi_set_current_resources(handle, &buffer);
+	if (ACPI_FAILURE(status))
+		ret = -EINVAL;
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static int pnpacpi_disable_resources(struct pnp_dev *dev)
+{
+	acpi_status status;
+	status = acpi_evaluate_object((acpi_handle)dev->data, 
+		"_DIS", NULL, NULL);
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+struct pnp_protocol pnpacpi_protocol = {
+	.name	= "Plug and Play ACPI",
+	.get	= pnpacpi_get_resources,
+	.set	= pnpacpi_set_resources,
+	.disable = pnpacpi_disable_resources,
+};
+
+static int __devinit pnpacpi_add_device(struct acpi_device *device)
+{
+	acpi_handle temp = NULL;
+	acpi_status status;
+	struct pnp_id *dev_id;
+	char id[8];
+	struct pnp_dev *dev;
+	static int num = 0;
+
+	if ((strlen(acpi_device_hid(device)) != 7) ||
+		is_exclusive_device(device))
+		return 0;
+
+	pnpidacpi_to_pnpid(acpi_device_hid(device), id);
+	
+	pnp_dbg("ACPI device : hid %s \n", acpi_device_hid(device));
+	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	if (!dev) {
+		pnp_err("Out of memory");
+		return -1;
+	}
+	dev->data = device->handle;
+	/* .enabled means if the device can decode the resources */
+	dev->active = device->status.enabled;
+	status = acpi_get_handle(device->handle, "_SRS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_CONFIGURABLE;
+	dev->capabilities |= PNP_READ;
+	if (device->flags.dynamic_status)
+		dev->capabilities |= PNP_WRITE;
+	if (device->flags.removable)
+		dev->capabilities |= PNP_REMOVABLE;
+	status = acpi_get_handle(device->handle, "_DIS", &temp);
+	if (ACPI_SUCCESS(status))
+		dev->capabilities |= PNP_DISABLE;
+
+	dev->protocol = &pnpacpi_protocol;
+
+	if(strlen(acpi_device_name(device)))
+		strncpy(dev->name, acpi_device_name(device), PNP_NAME_LEN);
+	else
+		strncpy(dev->name, acpi_device_bid(device), PNP_NAME_LEN);
+
+	dev->number = num;
+	
+	/* set the initial values for the PnP device */
+	dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	if (!dev_id)
+		goto err;
+	memcpy(dev_id->id, id, 7);
+
+	pnp_add_id(dev_id, dev);
+	
+	if(dev->active) {
+		/* parse allocated resource */
+		status = pnpacpi_parse_allocated_resource(device->handle, &dev->res);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: METHOD_NAME__CRS faillure for %s", id);
+			goto err1;
+		}
+	}
+
+	if(dev->capabilities & PNP_CONFIGURABLE) {
+		status = pnpacpi_parse_resource_option_data(device->handle, 
+			dev);
+		if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+			pnp_err("PnPACPI: _PRS failed for %s", id);
+			goto err1;
+		}
+	}
+	
+	/* parse compatible ids */
+	if (device->flags.compatible_ids) {
+		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		int i;
+
+		for (i = 0; i < cid_list->count; i++) {
+			if (strlen(cid_list->id[i].value) != 7)
+				continue;	
+			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), 
+				GFP_KERNEL);
+			if (!dev_id)
+				continue;
+
+			pnpidacpi_to_pnpid(cid_list->id[i].value, id);
+			memcpy(dev_id->id, id, 7);
+			pnp_add_id(dev_id, dev);
+		}
+	}
+
+	/* clear out the damaged flags */
+	if (!dev->active)
+		pnp_init_resource_table(&dev->res);
+	pnp_add_device(dev);
+	num ++;
+	return 0;
+err1:
+	kfree(dev_id);
+err:
+	kfree(dev);
+	return -1;
+}
+
+static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
+		u32 lvl, void *context, void **rv)
+{
+	struct acpi_device *device;
+
+	if (!acpi_bus_get_device(handle, &device))
+		pnpacpi_add_device(device);
+	return AE_OK;
+}
+
+int __init pnpacpi_init(void)
+{
+	if (acpi_disabled) {
+		pnp_info("PnP ACPI: acpi disable");
+		return 0;
+	}
+	pnp_info("PnP ACPI init");
+	pnp_register_protocol(&pnpacpi_protocol);
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, pnpacpi_add_device_handler,
+			NULL, NULL);
+	return 0;
+}
+subsys_initcall(pnpacpi_init);
+
+EXPORT_SYMBOL(pnpacpi_protocol);
===== drivers/pnp/pnpacpi/Kconfig 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/Kconfig	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/Kconfig	2004-09-21 20:33:09 +08:00
@@ -0,0 +1,9 @@
+#
+# Plug and Play ACPI configuration
+#
+config PNPACPI
+	bool "Plug and Play ACPI support (EXPERIMENTAL)"
+	depends on PNP && X86 && ACPI_BUS && !PNPBIOS && EXPERIMENTAL
+	default y
+	---help---
+	Todo
===== drivers/pnp/pnpacpi/Makefile 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/Makefile	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/Makefile	2004-09-21 20:33:09 +08:00
@@ -0,0 +1,5 @@
+#
+# Makefile for the kernel PNPACPI driver.
+#
+
+obj-y := core.o rsparser.o
===== drivers/pnp/pnpacpi/pnpacpi.h 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/pnpacpi.h	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/pnpacpi.h	2004-09-21 20:35:29 +08:00
@@ -0,0 +1,13 @@
+#ifndef ACPI_PNP_H
+#define ACPI_PNP_H
+
+#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+
+void *pnpacpi_kmalloc(size_t size, int f);
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle, struct pnp_resource_table*);
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle, struct pnp_dev*);
+int pnpacpi_encode_resources(struct pnp_resource_table *, struct acpi_buffer *);
+int pnpacpi_build_resource_template(acpi_handle, struct acpi_buffer*);
+#endif
===== drivers/pnp/pnpacpi/rsparser.c 1.1 vs edited =====
--- 1.1/drivers/pnp/pnpacpi/rsparser.c	2004-09-21 20:32:36 +08:00
+++ edited/drivers/pnp/pnpacpi/rsparser.c	2004-09-22 10:59:39 +08:00
@@ -0,0 +1,810 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
+ * Copyright (c) 2004 Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include "pnpacpi.h"
+
+#define valid_IRQ(i) (((i) != 0) && ((i) != 2) && ((i) < 16))
+/*
+ * Allocated Resources
+ */
+static int irq_flags(int edge_level, int active_high_low)
+{
+	int flag;
+	if (edge_level == ACPI_LEVEL_SENSITIVE) {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWLEVEL;
+		else
+			flag = IORESOURCE_IRQ_HIGHLEVEL;
+	}
+	else {
+		if(active_high_low == ACPI_ACTIVE_LOW)
+			flag = IORESOURCE_IRQ_LOWEDGE;
+		else
+			flag = IORESOURCE_IRQ_HIGHEDGE;
+	}
+	return flag;
+}
+
+static void decode_irq_flags(int flag, int *edge_level, int *active_high_low)
+{
+	switch (flag) {
+	case IORESOURCE_IRQ_LOWLEVEL:
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHLEVEL:	
+		*edge_level = ACPI_LEVEL_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	case IORESOURCE_IRQ_LOWEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_LOW;
+		break;
+	case IORESOURCE_IRQ_HIGHEDGE:
+		*edge_level = ACPI_EDGE_SENSITIVE;
+		*active_high_low = ACPI_ACTIVE_HIGH;
+		break;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+{
+	int i = 0;
+	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_IRQ)
+		i++;
+	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->irq_resource[i].start =(unsigned long) irq;
+		res->irq_resource[i].end = (unsigned long) irq;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
+{
+	int i = 0;
+	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_DMA)
+		i++;
+	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->dma_resource[i].start =(unsigned long) dma;
+		res->dma_resource[i].end = (unsigned long) dma;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
+	int io, int len)
+{
+	int i = 0;
+	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
+			i < PNP_MAX_PORT)
+		i++;
+	if (i < PNP_MAX_PORT) {
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		if (len <= 0 || (io + len -1) >= 0x10003) {
+			res->port_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->port_resource[i].start = (unsigned long) io;
+		res->port_resource[i].end = (unsigned long)(io + len - 1);
+	}
+}
+
+static void
+pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
+	int mem, int len)
+{
+	int i = 0;
+	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
+			(i < PNP_MAX_MEM))
+		i++;
+	if (i < PNP_MAX_MEM) {
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		if (len <= 0) {
+			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->mem_resource[i].start = (unsigned long) mem;
+		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+	}
+}
+
+
+static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
+	void *data)
+{
+	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
+
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+		if ((res->data.irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.irq.interrupts[0],
+					res->data.irq.edge_level,
+					res->data.irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.irq.interrupts[0]);
+		}
+		break;
+
+	case ACPI_RSTYPE_EXT_IRQ:
+		if ((res->data.extended_irq.number_of_interrupts > 0) &&
+			valid_IRQ(res->data.extended_irq.interrupts[0])) {
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.extended_irq.interrupts[0],
+					res->data.extended_irq.edge_level,
+					res->data.extended_irq.active_high_low));
+			pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0]);
+		}
+		break;
+	case ACPI_RSTYPE_DMA:
+		if (res->data.dma.number_of_channels > 0)
+			pnpacpi_parse_allocated_dmaresource(res_table, 
+					res->data.dma.channels[0]);
+		break;
+	case ACPI_RSTYPE_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.io.min_base_address, 
+				res->data.io.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_IO:
+		pnpacpi_parse_allocated_ioresource(res_table, 
+				res->data.fixed_io.base_address, 
+				res->data.fixed_io.range_length);
+		break;
+	case ACPI_RSTYPE_MEM24:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory24.min_base_address, 
+				res->data.memory24.range_length);
+		break;
+	case ACPI_RSTYPE_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.memory32.min_base_address, 
+				res->data.memory32.range_length);
+		break;
+	case ACPI_RSTYPE_FIXED_MEM32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.fixed_memory32.range_base_address, 
+				res->data.fixed_memory32.range_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS16:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address16.min_address_range, 
+				res->data.address16.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS32:
+		pnpacpi_parse_allocated_memresource(res_table, 
+				res->data.address32.min_address_range, 
+				res->data.address32.address_length);
+		break;
+	case ACPI_RSTYPE_ADDRESS64:
+		pnpacpi_parse_allocated_memresource(res_table, 
+		res->data.address64.min_address_range, 
+		res->data.address64.address_length);
+		break;
+	default:
+		pnp_warn("PnPACPI: Alloc type : %d not handle", 
+				res->id);
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_allocated_resource(acpi_handle handle, struct pnp_resource_table * res)
+{
+	/* Blank the resource table values */
+	pnp_init_resource_table(res);
+
+	return acpi_walk_resources(handle, METHOD_NAME__CRS, pnpacpi_allocated_resource, res);
+}
+
+static void pnpacpi_parse_dma_option(struct pnp_option *option, struct acpi_resource_dma *p)
+{
+	int i;
+	struct pnp_dma * dma;
+
+	if (p->number_of_channels <= 0)
+		return;
+	dma = pnpacpi_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	if (!dma)
+		return;
+
+	for(i = 0; i < p->number_of_channels; i++)
+		dma->map |= 1 << p->channels[i];
+	dma->flags = 0;
+	if (p->bus_master)
+		dma->flags |= IORESOURCE_DMA_MASTER;
+	switch (p->type) {
+	case ACPI_COMPATIBILITY:
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		break;
+	case ACPI_TYPE_A:
+		dma->flags |= IORESOURCE_DMA_TYPEA;
+		break;
+	case ACPI_TYPE_B:
+		dma->flags |= IORESOURCE_DMA_TYPEB;
+		break;
+	case ACPI_TYPE_F:
+		dma->flags |= IORESOURCE_DMA_TYPEF;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_COMPATIBLE;
+		pnp_err("Invalid DMA type");
+	}
+	switch (p->transfer) {
+	case ACPI_TRANSFER_8:
+		dma->flags |= IORESOURCE_DMA_8BIT;
+		break;
+	case ACPI_TRANSFER_8_16:
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		break;
+	case ACPI_TRANSFER_16:
+		dma->flags |= IORESOURCE_DMA_16BIT;
+		break;
+	default:
+		/* Set a default value ? */
+		dma->flags |= IORESOURCE_DMA_8AND16BIT;
+		pnp_err("Invalid DMA transfer type");
+	}
+
+	pnp_register_dma_resource(option,dma);
+	return;
+}
+
+	
+static void pnpacpi_parse_irq_option(struct pnp_option *option,
+	struct acpi_resource_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+	
+	if (p->number_of_interrupts <= 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		irq->map |= 1 << p->interrupts[i];
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void pnpacpi_parse_ext_irq_option(struct pnp_option *option,
+	struct acpi_resource_ext_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+
+	if (p->number_of_interrupts <= 0)
+		return;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i = 0; i < p->number_of_interrupts; i++)
+		irq->map |= 1 << p->interrupts[i];
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option, irq);
+	return;
+}
+
+static void
+pnpacpi_parse_port_option(struct pnp_option *option,
+	struct acpi_resource_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length <= 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = io->min_base_address;
+	port->max = io->max_base_address;
+	port->align = io->alignment;
+	port->size = io->range_length;
+	port->flags = ACPI_DECODE_16 == io->io_decode ? 
+		PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_port_option(struct pnp_option *option,
+	struct acpi_resource_fixed_io *io)
+{
+	struct pnp_port * port;
+
+	if (io->range_length <= 0)
+		return;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = port->max = io->base_address;
+	port->size = io->range_length;
+	port->align = 0;
+	port->flags = PNP_PORT_FLAG_FIXED;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_mem24_option(struct pnp_option *option,
+	struct acpi_resource_mem24 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length <= 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_mem32_option(struct pnp_option *option,
+	struct acpi_resource_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length <= 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_mem32_option(struct pnp_option *option,
+	struct acpi_resource_fixed_mem32 *p)
+{
+	struct pnp_mem * mem;
+
+	if (p->range_length <= 0)
+		return;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = mem->max = p->range_base_address;
+	mem->size = p->range_length;
+	mem->align = 0;
+
+	mem->flags = (ACPI_READ_WRITE_MEMORY == p->read_write_attribute) ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+struct acpipnp_parse_option_s {
+	struct pnp_option *option;
+	struct pnp_dev *dev;
+};
+
+static acpi_status pnpacpi_option_resource(struct acpi_resource *res, 
+	void *data)
+{
+	int priority = 0;
+	struct acpipnp_parse_option_s *parse_data = (struct acpipnp_parse_option_s *)data;
+	struct pnp_dev *dev = parse_data->dev;
+	struct pnp_option *option = parse_data->option;
+
+	switch (res->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnpacpi_parse_irq_option(option, &res->data.irq);
+			break;
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnpacpi_parse_ext_irq_option(option,
+				&res->data.extended_irq);
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnpacpi_parse_dma_option(option, &res->data.dma);	
+			break;
+		case ACPI_RSTYPE_IO:
+			pnpacpi_parse_port_option(option, &res->data.io);
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnpacpi_parse_fixed_port_option(option,
+				&res->data.fixed_io);
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnpacpi_parse_mem24_option(option, &res->data.memory24);
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnpacpi_parse_mem32_option(option, &res->data.memory32);
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnpacpi_parse_fixed_mem32_option(option,
+				&res->data.fixed_memory32);
+			break;
+		case ACPI_RSTYPE_START_DPF:
+			switch (res->data.start_dpf.compatibility_priority) {
+				case ACPI_GOOD_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_PREFERRED;
+					break;
+					
+				case ACPI_ACCEPTABLE_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_ACCEPTABLE;
+					break;
+
+				case ACPI_SUB_OPTIMAL_CONFIGURATION:
+					priority = PNP_RES_PRIORITY_FUNCTIONAL;
+					break;
+				default:
+					priority = PNP_RES_PRIORITY_INVALID;
+					break;
+			}
+			/* TBD: Considering performace/robustness bits */
+			option = pnp_register_dependent_option(dev, priority);
+			if (!option)
+				return AE_ERROR;
+			parse_data->option = option;	
+			break;
+		case ACPI_RSTYPE_END_DPF:
+			return AE_CTRL_TERMINATE;
+		default:
+			pnp_warn("PnPACPI: Option type : %d not handle", res->id);
+	}
+			
+	return AE_OK;
+}
+
+acpi_status pnpacpi_parse_resource_option_data(acpi_handle handle, 
+	struct pnp_dev *dev)
+{
+	acpi_status status;
+	struct acpipnp_parse_option_s parse_data;
+
+	parse_data.option = pnp_register_independent_option(dev);
+	if (!parse_data.option)
+		return AE_ERROR;
+	parse_data.dev = dev;
+	status = acpi_walk_resources(handle, METHOD_NAME__PRS, 
+		pnpacpi_option_resource, &parse_data);
+
+	return status;
+}
+
+/*
+ * Set resource
+ */
+static acpi_status pnpacpi_count_resources(struct acpi_resource *res,
+	void *data)
+{
+	int *res_cnt = (int *)data;
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*res_cnt) ++;
+	default:
+		return AE_OK;
+	}
+	return AE_OK;
+}
+
+static acpi_status pnpacpi_type_resources(struct acpi_resource *res,
+	void *data)
+{
+	struct acpi_resource **resource = (struct acpi_resource **)data;	
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+	case ACPI_RSTYPE_EXT_IRQ:
+	case ACPI_RSTYPE_DMA:
+	case ACPI_RSTYPE_IO:
+	case ACPI_RSTYPE_FIXED_IO:
+	case ACPI_RSTYPE_MEM24:
+	case ACPI_RSTYPE_MEM32:
+	case ACPI_RSTYPE_FIXED_MEM32:
+#if 0
+	case ACPI_RSTYPE_ADDRESS16:
+	case ACPI_RSTYPE_ADDRESS32:
+	case ACPI_RSTYPE_ADDRESS64:
+#endif
+		(*resource)->id = res->id;
+		(*resource)++;
+	default:
+		return AE_OK;
+	}
+
+	return AE_OK;
+}
+
+int pnpacpi_build_resource_template(acpi_handle handle, 
+	struct acpi_buffer *buffer)
+{
+	struct acpi_resource *resource;
+	int res_cnt = 0;
+	acpi_status status;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_count_resources, &res_cnt);
+	if (ACPI_FAILURE(status)) {
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	if (!res_cnt)
+		return -EINVAL;
+	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
+	buffer->pointer = pnpacpi_kmalloc(buffer->length - 1, GFP_KERNEL);
+	if (!buffer->pointer)
+		return -ENOMEM;
+	pnp_dbg("Res cnt %d", res_cnt);
+	resource = (struct acpi_resource *)buffer->pointer;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, 
+		pnpacpi_type_resources, &resource);
+	if (ACPI_FAILURE(status)) {
+		kfree(buffer->pointer);
+		pnp_err("Evaluate _CRS failed");
+		return -EINVAL;
+	}
+	/* resource will pointer the end resource now */
+	resource->id = ACPI_RSTYPE_END_TAG;
+
+	return 0;
+}
+
+static void pnpacpi_encode_irq(struct acpi_resource *resource, 
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.irq.edge_level = edge_level;
+	resource->data.irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.irq.number_of_interrupts = 1;
+	resource->data.irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_ext_irq(struct acpi_resource *resource,
+	struct resource *p)
+{
+	int edge_level, active_high_low;
+	
+	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
+		&active_high_low);
+	resource->id = ACPI_RSTYPE_EXT_IRQ;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.extended_irq.producer_consumer = ACPI_CONSUMER;
+	resource->data.extended_irq.edge_level = edge_level;
+	resource->data.extended_irq.active_high_low = active_high_low;
+	if (edge_level == ACPI_EDGE_SENSITIVE)
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	else
+		resource->data.irq.shared_exclusive = ACPI_SHARED;
+	resource->data.extended_irq.number_of_interrupts = 1;
+	resource->data.extended_irq.interrupts[0] = p->start;
+}
+
+static void pnpacpi_encode_dma(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_DMA;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
+	if (p->flags & IORESOURCE_DMA_COMPATIBLE)
+		resource->data.dma.type = ACPI_COMPATIBILITY;
+	else if (p->flags & IORESOURCE_DMA_TYPEA)
+		resource->data.dma.type = ACPI_TYPE_A;
+	else if (p->flags & IORESOURCE_DMA_TYPEB)
+		resource->data.dma.type = ACPI_TYPE_B;
+	else if (p->flags & IORESOURCE_DMA_TYPEF)
+		resource->data.dma.type = ACPI_TYPE_F;
+	if (p->flags & IORESOURCE_DMA_8BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8;
+	else if (p->flags & IORESOURCE_DMA_8AND16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_8_16;
+	else if (p->flags & IORESOURCE_DMA_16BIT)
+		resource->data.dma.transfer = ACPI_TRANSFER_16;
+	resource->data.dma.bus_master = p->flags & IORESOURCE_DMA_MASTER;
+	resource->data.dma.number_of_channels = 1;
+	resource->data.dma.channels[0] = p->start;
+}
+
+static void pnpacpi_encode_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_IO;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_port will copy pnp_port->flags into p->flags */
+	resource->data.io.io_decode = (p->flags & PNP_PORT_FLAG_16BITADDR)?
+		ACPI_DECODE_16 : ACPI_DECODE_10; 
+	resource->data.io.min_base_address = p->start;
+	resource->data.io.max_base_address = p->end;
+	resource->data.io.alignment = 0; /* Correct? */
+	resource->data.io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_io(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_IO;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_io.base_address = p->start;
+	resource->data.fixed_io.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem24(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM24;
+	resource->length = sizeof(struct acpi_resource);
+	/* Note: pnp_assign_mem will copy pnp_mem->flags into p->flags */
+	resource->data.memory24.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory24.min_base_address = p->start;
+	resource->data.memory24.max_base_address = p->end;
+	resource->data.memory24.alignment = 0;
+	resource->data.memory24.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.memory32.min_base_address = p->start;
+	resource->data.memory32.max_base_address = p->end;
+	resource->data.memory32.alignment = 0;
+	resource->data.memory32.range_length = p->end - p->start + 1;
+}
+
+static void pnpacpi_encode_fixed_mem32(struct acpi_resource *resource,
+	struct resource *p)
+{
+	resource->id = ACPI_RSTYPE_FIXED_MEM32;
+	resource->length = sizeof(struct acpi_resource);
+	resource->data.fixed_memory32.read_write_attribute =
+		(p->flags & IORESOURCE_MEM_WRITEABLE) ?
+		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
+	resource->data.fixed_memory32.range_base_address = p->start;
+	resource->data.fixed_memory32.range_length = p->end - p->start + 1;
+}
+
+int pnpacpi_encode_resources(struct pnp_resource_table *res_table, 
+	struct acpi_buffer *buffer)
+{
+	int i = 0;
+	/* pnpacpi_build_resource_template allocates extra mem */
+	int res_cnt = (buffer->length - 1)/sizeof(struct acpi_resource) - 1;
+	struct acpi_resource *resource = (struct acpi_resource*)buffer->pointer;
+	int port = 0, irq = 0, dma = 0, mem = 0;
+
+	pnp_dbg("res cnt %d", res_cnt);
+	while (i < res_cnt) {
+		switch(resource->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnp_dbg("Encode irq");
+			pnpacpi_encode_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnp_dbg("Encode ext irq");
+			pnpacpi_encode_ext_irq(resource, 
+				&res_table->irq_resource[irq]);
+			irq++;
+			break;
+		case ACPI_RSTYPE_DMA:
+			pnp_dbg("Encode dma");
+			pnpacpi_encode_dma(resource, 
+				&res_table->dma_resource[dma]);
+			dma ++;
+			break;
+		case ACPI_RSTYPE_IO:
+			pnp_dbg("Encode io");
+			pnpacpi_encode_io(resource, 
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnp_dbg("Encode fixed io");
+			pnpacpi_encode_fixed_io(resource,
+				&res_table->port_resource[port]);
+			port ++;
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnp_dbg("Encode mem24");
+			pnpacpi_encode_mem24(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnp_dbg("Encode mem32");
+			pnpacpi_encode_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnp_dbg("Encode fixed mem32");
+			pnpacpi_encode_fixed_mem32(resource,
+				&res_table->mem_resource[mem]);
+			mem ++;
+			break;
+		default: /* other type */
+			pnp_warn("Invalid type");
+		}
+		resource ++;
+		i ++;
+	}
+	return 0;
+}

--=-A/kd7vxk6RW4mIn8v9DC--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
