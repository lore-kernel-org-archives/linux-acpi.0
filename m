From: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: [RFC/patch] ACPI in linux PnP layer
Date: Mon, 20 Sep 2004 15:04:55 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <c0a09e5c040920150413cbc270@mail.gmail.com>
References: <1094304174.4139c1aeb3e0f@imp4-q.free.fr>
Reply-To: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_226_29779618.1095717895975"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1094304174.4139c1aeb3e0f-tGfbPE6xMHyksujEA26zIQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

------=_Part_226_29779618.1095717895975
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Did anyone else see Matthieu's post to lkml a while back and were
there any comments? Is this going to get applied, or if not why not?

Thanks -- Andy

---------- Forwarded message ----------
From: castet.matthieu-GANU6spQydw@public.gmane.org <castet.matthieu-GANU6spQydw@public.gmane.org>
Date: Sat,  4 Sep 2004 15:22:54 +0200
Subject: [RFC/patch] ACPI in linux PnP layer
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I have started to plug acpi in PnP layer.
A first patch add the function acpi_driver_scan, that allow to call a function
for each acpi device.
I have to do that because acpi is load before PnP, and it can't add my function
in acpi_bus_add (driver/acpi/scan.c).

The second patch is the PnP acpi driver.
It parse possible and activated resources.
It use acpi_register_gsi to activate irq (is that need ???)

Also there are no disable/set acpi resource support, nor ADDRESS resource
support.

But it work well with drivers that work with pnpbios(parport, serial, ...).

What do you think of it ?
Any comment ?

Matthieu

PS : please CC me since I'm not subscribed to lkml.

------=_Part_226_29779618.1095717895975
Content-Type: application/octet-stream; name=acpi.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="acpi.patch"

diff -ruN --exclude='*.cmd' --exclude='*.o' --exclude='*.ko' linux.old/drivers/acpi/scan.c linux-2.6.9/drivers/acpi/scan.c
--- linux.old/drivers/acpi/scan.c	2004-09-04 14:16:37.000000000 +0200
+++ linux-2.6.9/drivers/acpi/scan.c	2004-09-04 14:39:47.000000000 +0200
@@ -8,6 +8,7 @@
 #include <acpi/acpi_drivers.h>
 #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
 
+#include <linux/module.h>
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME		("scan")
@@ -1070,4 +1071,22 @@
 	return_VALUE(result);
 }
 
+int acpi_driver_scan(void (* handler)(struct acpi_device * dev))
+{
+	struct list_head * node, * next;
+	if (!handler)
+		 return_VALUE(-EINVAL);
+
+	spin_lock(&acpi_device_lock);
+	list_for_each_safe(node, next, &acpi_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, g_list);
+		spin_unlock(&acpi_device_lock);
+		handler(dev);
+		spin_lock(&acpi_device_lock);
+	}
+	spin_unlock(&acpi_device_lock);
+	return_VALUE(0);
+}
+
 subsys_initcall(acpi_scan_init);
+EXPORT_SYMBOL(acpi_driver_scan);

------=_Part_226_29779618.1095717895975
Content-Type: application/octet-stream; name=pnpacpi.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pnpacpi.patch"

diff -ruN --exclude='*.cmd' --exclude='*.o' --exclude='*.ko' linux.old/drivers/pnp/Kconfig linux-2.6.9/drivers/pnp/Kconfig
--- linux.old/drivers/pnp/Kconfig	2004-06-16 07:19:23.000000000 +0200
+++ linux-2.6.9/drivers/pnp/Kconfig	2004-09-04 14:07:46.000000000 +0200
@@ -35,5 +35,7 @@
 
 source "drivers/pnp/pnpbios/Kconfig"
 
+source "drivers/pnp/pnpacpi/Kconfig"
+
 endmenu
 
diff -ruN --exclude='*.cmd' --exclude='*.o' --exclude='*.ko' linux.old/drivers/pnp/Makefile linux-2.6.9/drivers/pnp/Makefile
--- linux.old/drivers/pnp/Makefile	2004-06-16 07:18:38.000000000 +0200
+++ linux-2.6.9/drivers/pnp/Makefile	2004-09-04 14:12:57.000000000 +0200
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
+obj-$(CONFIG_PNPACPI)		+= pnpacpi/
diff -ruN --exclude='*.cmd' --exclude='*.o' --exclude='*.ko' linux.old/drivers/pnp/pnpacpi/core.c linux-2.6.9/drivers/pnp/pnpacpi/core.c
--- linux.old/drivers/pnp/pnpacpi/core.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-09-04 14:50:32.000000000 +0200
@@ -0,0 +1,608 @@
+/*
+ * pnpacpi -- PnP ACPI driver
+ *
+ * Copyright (c) 2004 Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>
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
+/* TODO
+ * adress handling
+ * set/disble device
+ * code cleanning + memleak
+ * hotplug device
+ * remove device
+ */
+ 
+#include <acpi/acpi_bus.h>
+#include <linux/acpi.h>
+#include <linux/pnp.h>
+
+#define MAX_DEVICE 50
+static struct acpi_device * self [MAX_DEVICE] = {[0 ... (MAX_DEVICE-1)] = NULL};
+
+void *pnpacpi_kmalloc(size_t size, int f)
+{
+	void *p = kmalloc( size, f );
+	if ( p == NULL )
+		printk(KERN_ERR "PnPACPI: kmalloc() failed\n");
+	else
+		memset(p, 0, size);
+	return p;
+}
+/*
+ * Compatible Device IDs
+ */
+
+void pnpidacpi_to_pnpid(char *id, char *str)
+{
+	str[0] = id[0];
+	str[1] = id[1];
+	str[2] = id[2];
+	str[3] = tolower(id[3]);
+	str[4] = tolower(id[4]);
+	str[5] = tolower(id[5]);
+	str[6] = tolower(id[6]);
+	str[7] = '\0';
+
+	return;
+}
+
+/*
+ * Allocated Resources
+ */
+
+static void
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+{
+	int i = 0;
+	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_IRQ) i++;
+	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->irq_resource[i].start =
+		res->irq_resource[i].end = (unsigned long) irq;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
+{
+	int i = 0;
+	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_DMA) i++;
+	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
+		res->dma_resource[i].start =
+		res->dma_resource[i].end = (unsigned long) dma;
+	}
+}
+
+static void
+pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res, int io, int len)
+{
+	int i = 0;
+	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_PORT) i++;
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
+pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res, int mem, int len)
+{
+	int i = 0;
+	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_MEM) i++;
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
+static acpi_status acpi_pnp_allocated_resource(struct acpi_resource *res, void *data)
+{
+	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
+	//printk("res id %x\n",res->id);
+
+	switch (res->id) {
+	case ACPI_RSTYPE_IRQ:
+		if (res->data.irq.number_of_interrupts > 0)
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				/* is it ok ?
+				 * produce IOAPIC[0]: Invalid reference to IRQ 0
+				 */
+				acpi_register_gsi(res->data.irq.interrupts[0],
+					res->data.irq.edge_level,
+					res->data.irq.active_high_low));
+		break;
+
+	case ACPI_RSTYPE_EXT_IRQ:
+		if (res->data.extended_irq.number_of_interrupts > 0)
+			pnpacpi_parse_allocated_irqresource(res_table, 
+				acpi_register_gsi(res->data.extended_irq.interrupts[0],
+					res->data.extended_irq.edge_level,
+					res->data.extended_irq.active_high_low));
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
+#if 0
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
+	/*
+	case ACPI_RSTYPE_ADDRESS64:
+		pnpacpi_parse_allocated_memresource(res_table, 
+		res->data.address64.min_address_range, 
+		res->data.address64.address_length);
+		break;
+	*/
+#endif
+	default:
+		printk(KERN_WARNING "PnPACPI: Alloc type : %d not handle\n", 
+				res->id);
+	}
+			
+	return AE_OK;
+}
+
+static acpi_status acpi_pnp_parse_allocated_resource(struct acpi_device *device, struct pnp_resource_table * res)
+{
+	/* Blank the resource table values */
+	pnp_init_resource_table(res);
+
+	return acpi_walk_resources(device->handle, METHOD_NAME__CRS, acpi_pnp_allocated_resource, res);
+}
+
+
+static void pnpacpi_parse_dma_option(struct pnp_option *option, struct acpi_resource_dma *p)
+{
+	int i;
+	struct pnp_dma * dma;
+	dma = pnpacpi_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
+	if (!dma)
+		return;
+
+	for(i=0; i<p->number_of_channels; i++)
+		dma->map |= 1<<p->channels[i];
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
+	}
+
+
+	pnp_register_dma_resource(option,dma);
+	return;
+}
+
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
+static void pnpacpi_parse_irq_option(struct pnp_option *option, struct acpi_resource_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i=0; i<p->number_of_interrupts; i++)
+		irq->map |= 1<<p->interrupts[i];
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option,irq);
+	return;
+}
+
+static void pnpacpi_parse_ext_irq_option(struct pnp_option *option, struct acpi_resource_ext_irq *p)
+{
+	int i;
+	struct pnp_irq * irq;
+	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
+	if (!irq)
+		return;
+
+	for(i=0; i<p->number_of_interrupts; i++)
+		irq->map |= 1<<p->interrupts[i];
+	irq->flags = irq_flags(p->edge_level, p->active_high_low);
+
+	pnp_register_irq_resource(option,irq);
+	return;
+}
+
+static void
+pnpacpi_parse_port_option(struct pnp_option *option, struct acpi_resource_io *io)
+{
+	struct pnp_port * port;
+	port = pnpacpi_kmalloc(sizeof(struct pnp_port), GFP_KERNEL);
+	if (!port)
+		return;
+	port->min = io->min_base_address;
+	port->max = io->max_base_address;
+	port->align = io->alignment;
+	port->size = io->range_length;
+	port->flags = ACPI_DECODE_16 == io->io_decode ? PNP_PORT_FLAG_16BITADDR : 0;
+	pnp_register_port_resource(option,port);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_port_option(struct pnp_option *option, struct acpi_resource_fixed_io *io)
+{
+	struct pnp_port * port;
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
+pnpacpi_parse_mem24_option(struct pnp_option *option, struct acpi_resource_mem24 *p)
+{
+	struct pnp_mem * mem;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = ACPI_READ_WRITE_MEMORY == p->read_write_attribute ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_mem32_option(struct pnp_option *option, struct acpi_resource_mem32 *p)
+{
+	struct pnp_mem * mem;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = p->min_base_address;
+	mem->max = p->max_base_address;
+	mem->align = p->alignment;
+	mem->size = p->range_length;
+
+	mem->flags = ACPI_READ_WRITE_MEMORY == p->read_write_attribute ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+static void
+pnpacpi_parse_fixed_mem32_option(struct pnp_option *option, struct acpi_resource_fixed_mem32 *p)
+{
+	struct pnp_mem * mem;
+	mem = pnpacpi_kmalloc(sizeof(struct pnp_mem), GFP_KERNEL);
+	if (!mem)
+		return;
+	mem->min = mem->max = p->range_base_address;
+	mem->size = p->range_length;
+	mem->align = 0;
+
+	mem->flags = ACPI_READ_WRITE_MEMORY == p->read_write_attribute ?
+			IORESOURCE_MEM_WRITEABLE : 0;
+
+	pnp_register_mem_resource(option,mem);
+	return;
+}
+
+//XXX
+static struct pnp_option *option, *option_independent;
+
+static acpi_status acpi_pnp_option_resource(struct acpi_resource *res, void *data)
+{
+	int priority = 0;
+	struct pnp_dev *dev = (struct pnp_dev *)data;
+	//printk("pos res id %x\n",res->id);
+
+	switch (res->id) {
+		case ACPI_RSTYPE_IRQ:
+			pnpacpi_parse_irq_option(option, &res->data.irq);
+		break;
+		case ACPI_RSTYPE_EXT_IRQ:
+			pnpacpi_parse_ext_irq_option(option, &res->data.extended_irq);
+		break;
+		case ACPI_RSTYPE_DMA:
+			pnpacpi_parse_dma_option(option, &res->data.dma);
+						
+		break;
+		case ACPI_RSTYPE_IO:
+			pnpacpi_parse_port_option(option, &res->data.io);
+			break;
+		case ACPI_RSTYPE_FIXED_IO:
+			pnpacpi_parse_fixed_port_option(option, &res->data.fixed_io);
+			break;
+		case ACPI_RSTYPE_MEM24:
+			pnpacpi_parse_mem24_option(option, &res->data.memory24);
+			break;
+		case ACPI_RSTYPE_MEM32:
+			pnpacpi_parse_mem32_option(option, &res->data.memory32);
+			break;
+		case ACPI_RSTYPE_FIXED_MEM32:
+			pnpacpi_parse_fixed_mem32_option(option, &res->data.fixed_memory32);
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
+			option = pnp_register_dependent_option(dev, priority);
+			if (!option)
+				return -1;
+			break;
+		case ACPI_RSTYPE_END_DPF:
+			if (option_independent == option)
+				printk(KERN_WARNING "PnPACPI: Missing SMALL_TAG_STARTDEP tag\n");
+			option = option_independent;
+			break;
+		default:
+			printk(KERN_WARNING "PnPACPI: Option type : %d not handle\n", res->id);
+	}
+			
+	return AE_OK;
+}
+
+static int pnpacpi_get_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+{
+
+	acpi_status status;
+	status = acpi_pnp_parse_allocated_resource(self[dev->number], &dev->res);
+	return ACPI_FAILURE(status)?-ENODEV:0;
+}
+
+static int pnpacpi_set_resources(struct pnp_dev * dev, struct pnp_resource_table * res)
+{
+	printk(KERN_WARNING "PnPACPI: Not implemented\n");
+	return -ENODEV;
+}
+
+static int pnpacpi_disable_resources(struct pnp_dev *dev)
+{
+	printk(KERN_WARNING "PnPACPI: Not implemented\n");
+	return -ENODEV;
+}
+
+struct pnp_protocol pnpacpi_protocol = {
+	.name	= "Plug and Play ACPI",
+	.get	= pnpacpi_get_resources,
+	.set	= pnpacpi_set_resources,
+	.disable = pnpacpi_disable_resources,
+};
+
+static int acpi_pnp_add_device(struct acpi_device *device)
+{
+	acpi_status status;
+	struct pnp_id *dev_id;
+	char id[8];
+	struct pnp_dev *dev;
+
+	static int num = 0;
+
+	if(num>=MAX_DEVICE)
+		return -ENODEV;
+
+	if (strlen(acpi_device_hid(device)) != 7) {
+		//printk("device : hid %s %d\n", id, strlen(id));
+		return -1;
+	}
+	
+	//printk("device : hid %s \n", acpi_device_hid(device));
+	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
+	if (!dev)
+		return -1;
+
+	dev->number = num++;
+	self[dev->number] = device;
+	strncpy(dev->name ,device->pnp.bus_id, PNP_NAME_LEN);
+
+
+	/* set the initial values for the PnP device */
+	dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+	if (!dev_id)
+		goto err;
+	pnpidacpi_to_pnpid(acpi_device_hid(device),id);
+	memcpy(dev_id->id,id,7);
+
+	pnp_add_id(dev_id, dev);
+	//parse allocated resource
+	status = acpi_pnp_parse_allocated_resource(device, &dev->res);
+	if (ACPI_FAILURE(status)) {
+		//printk(KERN_DEBUG "METHOD_NAME__CRS faillure\n");
+		dev->active = 0;
+		//return -EIO;
+	}
+	else
+		dev->active = 1;
+
+	option_independent = option = pnp_register_independent_option(dev);
+	if (!option)
+		goto err;
+	status = acpi_walk_resources(device->handle, METHOD_NAME__PRS, acpi_pnp_option_resource, dev);
+	/*if (ACPI_FAILURE(status))
+		printk(KERN_DEBUG "METHOD_NAME__PRS faillure\n");
+		//return -EIO;
+	*/
+
+	if (device->flags.compatible_ids) {
+		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		int i;
+
+		for (i = 0; i < cid_list->count; i++) {
+			dev_id = pnpacpi_kmalloc(sizeof(struct pnp_id), GFP_KERNEL);
+			if (!dev_id)
+				continue;
+
+			memcpy(dev_id->id,cid_list->id[i].value,7);
+			pnp_add_id(dev_id, dev);
+		}
+	}
+
+#if 0
+	dev->flags = node->flags;
+	if (!(dev->flags & PNPBIOS_NO_CONFIG))
+		dev->capabilities |= PNP_CONFIGURABLE;
+	if (!(dev->flags & PNPBIOS_NO_DISABLE))
+		dev->capabilities |= PNP_DISABLE;
+	dev->capabilities |= PNP_READ;
+	if (pnpacpi_is_dynamic(dev))
+		dev->capabilities |= PNP_WRITE;
+	if (dev->flags & PNPBIOS_REMOVABLE)
+		dev->capabilities |= PNP_REMOVABLE;
+#endif
+
+	dev->protocol = &pnpacpi_protocol;
+
+	/* clear out the damaged flags */
+	if (!dev->active)
+		pnp_init_resource_table(&dev->res);
+	pnp_add_device(dev);
+	return 0;
+
+err:
+	kfree(dev);
+	return -1;
+}
+
+static void acpi_pnp_add_device_handler(struct acpi_device *device)
+{
+	acpi_pnp_add_device(device);
+}
+
+//XXX put in a header file...
+extern int acpi_driver_scan(void (* handler)(struct acpi_device * dev));
+
+int __init pnpacpi_init(void)
+{
+	printk(KERN_INFO "PnP ACPI init\n");
+	pnp_register_protocol(&pnpacpi_protocol);
+	return acpi_driver_scan(acpi_pnp_add_device_handler);
+}
+device_initcall(pnpacpi_init);
+
+EXPORT_SYMBOL(pnpacpi_protocol);
diff -ruN --exclude='*.cmd' --exclude='*.o' --exclude='*.ko' linux.old/drivers/pnp/pnpacpi/Kconfig linux-2.6.9/drivers/pnp/pnpacpi/Kconfig
--- linux.old/drivers/pnp/pnpacpi/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/Kconfig	2004-09-04 14:11:36.000000000 +0200
@@ -0,0 +1,10 @@
+#
+# Plug and Play ACPI configuration
+#
+config PNPACPI
+	bool "Plug and Play ACPI support (EXPERIMENTAL)"
+	depends on PNP && X86 && ACPI_BUS && EXPERIMENTAL
+	depends on !PNPBIOS
+	default y
+	---help---
+	Todo
diff -ruN --exclude='*.cmd' --exclude='*.o' --exclude='*.ko' linux.old/drivers/pnp/pnpacpi/Makefile linux-2.6.9/drivers/pnp/pnpacpi/Makefile
--- linux.old/drivers/pnp/pnpacpi/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/Makefile	2004-09-04 14:37:53.000000000 +0200
@@ -0,0 +1,5 @@
+#
+# Makefile for the kernel PNPACPI driver.
+#
+
+obj-y := core.o
diff -ruN --exclude='*.cmd' --exclude='*.o' --exclude='*.ko' linux.old/drivers/pnp/pnpbios/Kconfig linux-2.6.9/drivers/pnp/pnpbios/Kconfig
--- linux.old/drivers/pnp/pnpbios/Kconfig	2004-06-16 07:19:44.000000000 +0200
+++ linux-2.6.9/drivers/pnp/pnpbios/Kconfig	2004-09-04 14:11:31.000000000 +0200
@@ -4,6 +4,8 @@
 config PNPBIOS
 	bool "Plug and Play BIOS support (EXPERIMENTAL)"
 	depends on PNP && X86 && EXPERIMENTAL
+	depends on !PNPACPI
+	default n
 	---help---
 	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
 	  Specification Version 1.0A May 5, 1994" to autodetect built-in

------=_Part_226_29779618.1095717895975--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
