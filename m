From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: [PATCH 2/2] GPE block driver
Date: Wed, 25 May 2005 13:36:57 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840836E7CF@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, matthew-Ztpu424NOJ8@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

 Hi,

Do you have updated patch for the comments below? I'm sorry I jump into =
a rather old thread.

Thanks,
Luming

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Brown, Len
>Sent: 2005=C4=EA4=D4=C214=C8=D5 10:52
>To: Matthew Wilcox
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; matthew-Ztpu424NOJ8@public.gmane.org
>Subject: [ACPI] RE: [PATCH 2/2] GPE block driver
>
>>
>>GPE block driver
>>
>>This simple driver sets up the ACPI core to handle GPE blocks that are
>>not described in the FADT.
>>
>>Index: ./drivers/acpi/Kconfig
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>RCS file: /var/cvs/linux-2.6/drivers/acpi/Kconfig,v
>>retrieving revision 1.16
>>diff -u -p -r1.16 Kconfig
>>--- ./drivers/acpi/Kconfig	22 Jan 2005 14:59:09 -0000	1.16
>>+++ ./drivers/acpi/Kconfig	26 Jan 2005 19:16:52 -0000
>>@@ -134,6 +134,20 @@ config ACPI_FAN
>> 	  This driver adds support for ACPI fan devices,=20
>>allowing user-mode=20
>> 	  applications to perform basic fan control (on, off, status).
>>=20
>>+config ACPI_GPE_BLOCK
>>+	tristate "GPE block"
>>+	depends on ACPI_INTERPRETER
>>+	depends on !IA64_SGI_SN
>>+	default m
>>+	help
>>+	  GPE block devices are used to expand the number of ACPI events
>>+	  available to the system.  Common uses include=20
>>expansion chassis
>>+	  and laptop docking stations.  If you don't know whether you
>>+	  have one or not, it is safe to say Y.
>>+	 =20
>>+	  To compile this driver as a module, choose M here: the module
>>+	  will be called gpe-block.
>>+
>
>if this is built as a module, then it looks we have a symbol problem
>below.
>
>> config ACPI_PROCESSOR
>> 	tristate "Processor"
>> 	depends on ACPI_INTERPRETER
>>Index: ./drivers/acpi/Makefile
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>RCS file: /var/cvs/linux-2.6/drivers/acpi/Makefile,v
>>retrieving revision 1.7
>>diff -u -p -r1.7 Makefile
>>--- ./drivers/acpi/Makefile	12 Jan 2005 20:16:09 -0000	1.7
>>+++ ./drivers/acpi/Makefile	26 Jan 2005 19:16:52 -0000
>>@@ -42,6 +42,7 @@ obj-$(CONFIG_ACPI_BATTERY)	+=3D battery.o
>> obj-$(CONFIG_ACPI_BUTTON)	+=3D button.o
>> obj-$(CONFIG_ACPI_EC)		+=3D ec.o
>> obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
>>+obj-$(CONFIG_ACPI_GPE_BLOCK)	+=3D gpe-block.o
>> obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
>> obj-$(CONFIG_ACPI_PCI)		+=3D pci_root.o=20
>>pci_link.o pci_irq.o pci_bind.o
>> obj-$(CONFIG_ACPI_POWER)	+=3D power.o
>>Index: ./drivers/acpi/gpe-block.c
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>RCS file: ./drivers/acpi/gpe-block.c
>>diff -N ./drivers/acpi/gpe-block.c
>>--- /dev/null	1 Jan 1970 00:00:00 -0000
>>+++ ./drivers/acpi/gpe-block.c	26 Jan 2005 19:16:52 -0000
>>@@ -0,0 +1,163 @@
>>+/*
>>+ * drivers/acpi/gpe-block.c
>>+ *
>>+ * Copyright (c) Matthew Wilcox for Hewlett Packard 2004
>>+ *
>>+ * This program is free software; you can redistribute it=20
>>and/or modify
>>+ * it under the terms of the GNU General Public License as=20
>>published by
>>+ * the Free Software Foundation; either version 2 of the=20
>>License, or (at
>>+ * your option) any later version.
>>+ */
>>+
>>+#include <linux/acpi.h>
>>+#include <linux/ioport.h>
>>+#include <linux/module.h>
>>+#include <acpi/acpi_bus.h>
>>+#include <acpi/acpi_drivers.h>
>>+#include <acpi/acpixf.h>
>>+#include <acpi/acnamesp.h>
>>+
>>+MODULE_AUTHOR("Matthew Wilcox <willy-VXdhtT5mjnY@public.gmane.org>");
>>+MODULE_LICENSE("GPL");
>>+MODULE_VERSION("0.3");
>>+
>>+#define NAME "gpe-block"
>>+
>>+struct gpe_block {
>>+	struct acpi_generic_address address;
>>+	u32 register_count;
>>+	u32 interrupt_level;
>
>interrupt_number?
>
>
>>+};
>>+
>>+static acpi_status acpi_gpe_block_crs_irq(struct=20
>>acpi_resource_ext_irq *irq,
>>+		struct gpe_block *data)
>>+{
>>+	acpi_register_gsi(irq->interrupts[0], irq->edge_level,
>>+			irq->active_high_low);
>>+	data->interrupt_level =3D irq->interrupts[0];
>>+	return AE_OK;
>>+}
>>+
>>+static acpi_status acpi_gpe_block_crs_addr(struct=20
>>acpi_resource_address64 *addr,
>>+		struct gpe_block *data)
>>+{
>>+	int size =3D addr->max_address_range -=20
>>addr->min_address_range + 1;
>>+	if (addr->resource_type =3D=3D ACPI_MEMORY_RANGE) {
>>+		data->address.address_space_id =3D=20
>>ACPI_ADR_SPACE_SYSTEM_MEMORY;
>>+		if=20
>>(!request_mem_region(addr->min_address_range, size, NAME))
>>+			return AE_CTRL_TERMINATE;
>>+
>>+	} else if (addr->resource_type =3D=3D ACPI_IO_RANGE) {
>>+		data->address.address_space_id =3D=20
>>ACPI_ADR_SPACE_SYSTEM_IO;
>>+		if (!request_region(addr->min_address_range,=20
>>size, NAME))
>>+			return AE_CTRL_TERMINATE;
>>+	} else {
>>+		return AE_CTRL_TERMINATE;
>>+	}
>>+
>>+	data->address.register_bit_width =3D ACPI_GPE_REGISTER_WIDTH;
>>+	data->address.register_bit_offset =3D ACPI_GPE_REGISTER_WIDTH;
>>+	data->address.address =3D addr->min_address_range;
>>+	data->register_count =3D size / 2;
>>+
>>+	return AE_OK;
>>+}
>>+
>>+static acpi_status acpi_gpe_block_crs_add(struct=20
>>acpi_resource *res, void *data)
>>+{
>>+	if (res->id =3D=3D ACPI_RSTYPE_EXT_IRQ)
>>+		return=20
>>acpi_gpe_block_crs_irq(&res->data.extended_irq, data);
>>+
>>+	if (res->id =3D=3D ACPI_RSTYPE_ADDRESS16 ||
>>+	    res->id =3D=3D ACPI_RSTYPE_ADDRESS32 ||
>>+	    res->id =3D=3D ACPI_RSTYPE_ADDRESS64) {
>>+		struct acpi_resource_address64 address;
>>+		acpi_resource_to_address64(res, &address);
>>+		return acpi_gpe_block_crs_addr(&address, data);
>>+	}
>>+
>>+	return AE_OK;
>>+}
>>+
>>+static acpi_status acpi_gpe_block_crs_remove(struct=20
>>acpi_resource *res,
>>+		void *context)
>>+{
>>+	struct acpi_resource_address64 addr;
>>+	int size;
>>+
>>+	if (res->id !=3D ACPI_RSTYPE_ADDRESS16 &&
>>+	    res->id !=3D ACPI_RSTYPE_ADDRESS32 &&
>>+	    res->id !=3D ACPI_RSTYPE_ADDRESS64)
>>+		return AE_OK;
>
>wouldn't this be an error rather than AE_OK?
>
>>+
>>+	acpi_resource_to_address64(res, &addr);
>>+
>>+	size =3D addr.max_address_range - addr.min_address_range + 1;
>>+	if (addr.resource_type =3D=3D ACPI_MEMORY_RANGE) {
>>+		release_mem_region(addr.min_address_range, size);
>>+	} else if (addr.resource_type =3D=3D ACPI_IO_RANGE) {
>>+		release_region(addr.min_address_range, size);
>>+	}
>>+	return AE_OK;
>
>perhaps better with a switch statement
>and if not mem or IO then default return error?
>
>>+}
>>+
>>+static int acpi_gpe_block_add(struct acpi_device *device)
>>+{
>>+	struct gpe_block block;
>>+
>>+	memset(&block, 0, sizeof(block));
>>+	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>>+			acpi_gpe_block_crs_add, &block);
>>+
>>+	/* Decline to handle GPE blocks with no _CRS. */
>>+	if (block.register_count =3D=3D 0)
>>+		return -ENODEV;
>>+
>>+	acpi_install_gpe_block(device->handle, &block.address,
>>+			block.register_count, block.interrupt_level);
>>+
>>+	return AE_OK;
>>+}
>>+
>>+static int acpi_gpe_block_remove(struct acpi_device *device,=20
>int type)
>>+{
>>+	struct acpi_namespace_node *node;
>>+	union acpi_operand_object *obj_desc;
>>+
>>+	node =3D acpi_ns_map_handle_to_node(device->handle);
>
>this guy isn't exported to modules.
>
>>+	if(!node)
>>+		goto Exit;
>>+	obj_desc =3D acpi_ns_get_attached_object (node);
>>+	if(!obj_desc)
>>+		goto Exit;
>>+	acpi_hw_disable_gpe_block(NULL, obj_desc->device.gpe_block);
>>+	acpi_os_sleep(1);
>
>comment why we sleep here?
>
>probably good to add a comment that we need to wait
>for the work queues to flush before we remove the block.
>
>>+	acpi_os_wait_events_complete(NULL);
>>+	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>>+			acpi_gpe_block_crs_remove, NULL);
>>+Exit:
>>+	return acpi_remove_gpe_block(device->handle);
>>+}
>>+
>>+static struct acpi_driver acpi_gpe_block_driver =3D {
>>+	.name =3D		NAME,
>>+	.ids =3D		"ACPI0006",
>
>we'll #define ACPI0006 soon...
>
>>+	.ops =3D	{
>>+		.add =3D		acpi_gpe_block_add,
>>+		.remove =3D	acpi_gpe_block_remove,
>>+	},
>>+};
>>+
>>+static int __init acpi_gpe_block_init(void)
>>+{
>>+	int result =3D acpi_bus_register_driver(&acpi_gpe_block_driver);
>>+	return (result < 0) ? -ENODEV : 0;
>>+}
>>+
>>+static void __exit acpi_gpe_block_exit(void)
>>+{
>>+	acpi_bus_unregister_driver(&acpi_gpe_block_driver);
>>+}
>>+
>>+module_init(acpi_gpe_block_init);
>>+module_exit(acpi_gpe_block_exit);
>>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from=20
>real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dick
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
