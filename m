From: yakui.zhao@intel.com
Subject: Subject:[RFC Patch 1/2]IPMI/ACPI: Locate the IPMI system interface in ACPI namespace
Date: Mon, 28 Sep 2009 16:19:57 +0800
Message-ID: <1254125998-24006-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26082 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbZI1IU4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Sep 2009 04:20:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
Cc: lenb@kernel.org, minyard@acm.org, Zhao Yakui <yakui.zhao@intel.com>

According to the IPMI 2.0 spec the IPMI system interface can be located with
ACPI. One is located in SPMI table(Service Processor Management Interface
table). Another is located in ACPI namespace.
This patch is to locate the IPMI system interface in ACPI namespace and
register it.
It includes the following two steps:
   1. enumerate the ACPI device tree to find the IPMI system interface
	The IPMI device type is IPI0001. When the device is found, it
will continue to parse the corresponding resources.
        For example: 
		interface type (KCS, BT, SMIC) (SSIF is not supported)
		interrupt number and type (_GPE or GSI)
		Memory or IO base address
    2. register the IPMI system interface.
			

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |  360 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 360 insertions(+)

Index: linux-2.6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.orig/drivers/char/ipmi/ipmi_si_intf.c	2009-09-21 16:49:29.000000000 +0800
+++ linux-2.6/drivers/char/ipmi/ipmi_si_intf.c	2009-09-28 11:43:53.000000000 +0800
@@ -1813,6 +1813,35 @@
  * are no more.
  */
 static int acpi_failure;
+static LIST_HEAD(acpi_ipmi);
+
+struct acpi_device_ipmi {
+	struct list_head link;
+	u8 interfacetype;
+	/*
+	 * Bit 0 - SCI interrupt supported
+	 * Bit 1 - I/O APIC/SAPIC
+	 */
+	u8	interrupttype;
+	/*
+	 * If bit 0 of InterruptType is set, then this is the SCI
+	 * interrupt in the GPEx_STS register.
+	 */
+	u8	gpe;
+	/*
+	 * If bit 1 of InterruptType is set, then this is the I/O
+	 * APIC/SAPIC interrupt.
+	 */
+	u32	global_interrupt;
+
+	/* The actual register address. */
+	struct acpi_generic_address addr;
+	struct acpi_generic_address sm_addr;
+
+	u8 ipmi_revision;
+	u8 resource_count;
+	struct device *dev;
+};
 
 /* For GPE-type interrupts. */
 static u32 ipmi_acpi_gpe(void *context)
@@ -2001,7 +2030,337 @@
 
 	return 0;
 }
+static __devinit int try_init_acpi_device(struct acpi_device_ipmi *spmi)
+{
+	struct smi_info  *info;
+	u8 		 addr_space;
+
+	if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		addr_space = IPMI_MEM_ADDR_SPACE;
+	else
+		addr_space = IPMI_IO_ADDR_SPACE;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
+		return -ENOMEM;
+	}
+
+	info->addr_source = "ACPI";
+
+	/* Figure out the interface type. */
+	switch (spmi->interfacetype) {
+	case 1:	/* KCS */
+		info->si_type = SI_KCS;
+		break;
+	case 2:	/* SMIC */
+		info->si_type = SI_SMIC;
+		break;
+	case 3:	/* BT */
+		info->si_type = SI_BT;
+		break;
+	default:
+		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
+			spmi->interfacetype);
+		kfree(info);
+		return -EIO;
+	}
+
+	if (spmi->interrupttype & 1) {
+		/* We've got a GPE interrupt. */
+		info->irq = spmi->gpe;
+		info->irq_setup = acpi_gpe_irq_setup;
+	} else if (spmi->interrupttype & 2) {
+		/* We've got an APIC/SAPIC interrupt. */
+		info->irq = spmi->global_interrupt;
+		info->irq_setup = std_irq_setup;
+	} else {
+		/* Use the default interrupt setting. */
+		info->irq = 0;
+		info->irq_setup = NULL;
+	}
+
+	if (spmi->addr.bit_width) {
+		/* A (hopefully) properly formed register bit width. */
+		info->io.regspacing = spmi->addr.bit_width / 8;
+	} else {
+		info->io.regspacing = DEFAULT_REGSPACING;
+	}
+	info->io.regsize = info->io.regspacing;
+	info->io.regshift = spmi->addr.bit_offset;
+
+	if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		info->io_setup = mem_setup;
+		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
+	} else if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		info->io_setup = port_setup;
+		info->io.addr_type = IPMI_IO_ADDR_SPACE;
+	} else {
+		kfree(info);
+		printk(KERN_WARNING
+		       "ipmi_si: Unknown ACPI I/O Address type\n");
+		return -EIO;
+	}
+	info->io.addr_data = spmi->addr.address;
+	info->dev = spmi->dev;
+
+	try_smi_init(info);
+
+	return 0;
+}
+static acpi_status
+bmc_parse_io_ports(struct acpi_resource *resource, void *context)
+{
+	struct acpi_device_ipmi *p_ipmi = context;
+
+	/*
+	 * If the resource type is ACPI_RESOURCE_IRQ, it is not
+	 * supported.
+	 */
+	if (resource->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
+		struct acpi_resource_extended_irq *extended_irq;
+		extended_irq = &resource->data.extended_irq;
+		if (p_ipmi->interrupttype) {
+			/*
+			 * If it already support the interrupt through GPE,
+			 * it is unnecessary to get this interrupt again.
+			 */
+			printk(KERN_DEBUG "Interrupt through GPE is already"
+				" supported.\n");
+			return AE_OK;
+		}
+		if (extended_irq->interrupt_count != 1) {
+			printk(KERN_DEBUG "Incorrect resource setting about "
+					"interrupt \n");
+			return AE_OK;
+		}
+		p_ipmi->global_interrupt = extended_irq->interrupts[0];
+		if (p_ipmi->global_interrupt) {
+			/* GSI interrupt type */
+			p_ipmi->interrupttype |= 0x02;
+		}
+		return AE_OK;
+	}
+	if (resource->type == ACPI_RESOURCE_TYPE_IO ||
+		resource->type == ACPI_RESOURCE_TYPE_FIXED_IO) {
+		u16 address;
+		struct acpi_resource_io *io;
+		struct acpi_resource_fixed_io *fixed_io;
+
+		fixed_io = &resource->data.fixed_io;
+		if (p_ipmi->resource_count) {
+			/*
+			 * Multiply definitions of IO/memory address are
+			 * obtained. It is incorrect. We will continue
+			 * to use the first IO/memory definition.
+			 * If not correct, please fix me.
+			 */
+			return AE_OK;
+		}
+		if (resource->type == ACPI_RESOURCE_TYPE_IO) {
+			io = &resource->data.io;
+			if (!io->minimum) {
+				/* when IO address is zero, return */
+				return AE_OK;
+			}
+			address = io->minimum;
+		} else {
+			fixed_io = &resource->data.fixed_io;
+			if (!fixed_io->address)
+				return AE_OK;
+			address = fixed_io->address;
+		}
+		p_ipmi->resource_count++;
+		p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_IO;
+		p_ipmi->addr.address = address;
+		return AE_OK;
+	}
+
+	if (resource->type == ACPI_RESOURCE_TYPE_MEMORY32 ||
+		resource->type == ACPI_RESOURCE_TYPE_MEMORY24 ||
+		resource->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
+		printk(KERN_DEBUG
+			"Can't handle the Memory32/24/fixed32 type\n");
+		printk(KERN_DEBUG "please send acpidump to "
+					"linux-acpi@vger.kernel.org\n");
+		return AE_OK;
+	}
+	if (resource->type == ACPI_RESOURCE_TYPE_ADDRESS16 ||
+		resource->type == ACPI_RESOURCE_TYPE_ADDRESS32 ||
+		resource->type == ACPI_RESOURCE_TYPE_ADDRESS64) {
+		struct acpi_resource_address64 address64;
+		acpi_resource_to_address64(resource, &address64);
+		if (p_ipmi->resource_count) {
+			/*
+			 * Multiply definitions of IO/memory address are
+			 * obtained. It is incorrect. We will continue
+			 * to use the first IO/memory definition.
+			 * If not correct, please fix me.
+			 */
+			return AE_OK;
+		}
+		if (address64.resource_type != ACPI_MEMORY_RANGE &&
+			address64.resource_type != ACPI_IO_RANGE) {
+			/* ignore the incorrect resource type */
+			return AE_OK;
+		}
+		p_ipmi->addr.address = address64.minimum;
+		p_ipmi->resource_count++;
+		if (address64.resource_type == ACPI_MEMORY_RANGE)
+			p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
+		else
+			p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_IO;
+
+		return AE_OK;
+	}
 
+	return AE_OK;
+}
+
+/*
+ *  parse_bmc_resource -- parse the BMC resources from ACPI
+ *  @p_ipmi: the memory to store the BCM resource
+ *  @handle: ACPI device handle
+ */
+static int parse_bmc_resource(struct acpi_device_ipmi *p_ipmi,
+			acpi_handle handle)
+{
+	int parse_ok = false;
+	unsigned long long	temp_data;
+	acpi_status status;
+
+	/* According to IPMI spec there should exist the _IFT method
+	 * for the IPMI device. So when there is no _IFT, it is regarded
+	 * as the incorrect BMC device and won't parse the resource again.
+	 */
+	status = acpi_evaluate_integer(handle, "_IFT", NULL, &temp_data);
+	if (ACPI_FAILURE(status))
+		return parse_ok;
+
+	p_ipmi->interfacetype = temp_data;
+	/* Figure out the interface type. If the interface type is not
+	 * KCS/SMIC/BT, it is regared as the incorrect IPMI device.
+	 * Of course the SSIF interface type is also defined, but we
+	 * can't handle it. So it is not supported */
+	switch (temp_data) {
+	case 1:	/* KCS */
+	case 2:	/* SMIC */
+	case 3:	/* BT */
+		break;
+	default:
+		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
+			p_ipmi->interfacetype);
+		return parse_ok;
+	}
+	/* check whether there exists the _GPE method. If it exists, it
+	 * means that interrupt through GPE is supported.
+	 */
+	temp_data = 0;
+	status = acpi_evaluate_integer(handle, "_GPE", NULL, &temp_data);
+	if (ACPI_SUCCESS(status)) {
+		p_ipmi->gpe = temp_data;
+		/* set the GPE interrupt type */
+		p_ipmi->interrupttype |= 0x01;
+	}
+	/* get the IPMI revision */
+	temp_data = 0;
+	status = acpi_evaluate_integer(handle, "_SRV", NULL,  &temp_data);
+	if (ACPI_SUCCESS(status))
+		p_ipmi->ipmi_revision = temp_data;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				bmc_parse_io_ports, p_ipmi);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_WARNING "Can't parse the _CRS object \n");
+		return parse_ok;
+	}
+	if (!p_ipmi->resource_count) {
+		/* The incorrect IO/Memory address is parsed */
+		printk(KERN_WARNING "Incorrect IO/Memory address is parsed\n");
+		return parse_ok;
+	}
+	parse_ok = true;
+
+	return parse_ok;
+}
+
+const struct acpi_device_id ipmi_ids[] = {
+	{ACPI_VIDEO_HID, 0},
+	{"", 0},
+};
+/*
+ * check_bmc_device -- check whether @handle is a BMC device and then
+ *		get its corresponding resource. For example: IO/Mem
+ *		address, interface type
+ * @handle: ACPI device handle
+ * @level : depth in the ACPI namespace tree
+ * @context: the number of bmc device. In theory there is not more than
+ * 	one ACPI BMC device.
+ * @rv: a return value to fill if desired (Not use)
+ */
+static acpi_status
+check_bmc_device(acpi_handle handle, u32 level, void *context,
+			void **return_value)
+{
+	struct acpi_device *acpi_dev;
+	struct acpi_device_ipmi *p_ipmi = NULL;
+	int *count = (int *)context;
+
+	acpi_dev = NULL;
+	/* Get the acpi device for device handle */
+	if (acpi_bus_get_device(handle, &acpi_dev) || !acpi_dev) {
+		/* If there is no ACPI device for handle, return */
+		return AE_OK;
+	}
+
+	if (acpi_match_device_ids(acpi_dev, ipmi_ids))
+		return AE_OK;
+
+	p_ipmi = kzalloc(sizeof(*p_ipmi), GFP_KERNEL);
+	if (!p_ipmi) {
+		printk(KERN_DEBUG "Can't allocate memory for IPMI device\n");
+		return AE_OK;
+	}
+	p_ipmi->dev = &acpi_dev->dev;
+	if (!parse_bmc_resource(p_ipmi, handle)) {
+		kfree(p_ipmi);
+	} else {
+		list_add_tail(&p_ipmi->link, &acpi_ipmi);
+		*count = *count + 1;
+	}
+
+	return AE_OK;
+}
+static __devinit void acpi_device_find_bmc(void)
+{
+	acpi_status      status;
+	int              device_count = 0;
+	struct acpi_device_ipmi *p_ipmi, *p_ipmi2;
+
+	if (acpi_disabled)
+		return;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				ACPI_UINT32_MAX,
+				check_bmc_device, &device_count, NULL);
+	if (!device_count) {
+		/* when no IPMI device is found in ACPI namespace, return */
+		return;
+	}
+	if (device_count > 1) {
+		printk(KERN_WARNING "More than one BMC device is found in "
+				"ACPI table\n");
+		printk(KERN_WARNING "Of course the BMC device will be "
+				"registered\n");
+	}
+	list_for_each_entry_safe(p_ipmi, p_ipmi2, &acpi_ipmi, link) {
+		try_init_acpi_device(p_ipmi);
+		list_del(&p_ipmi->link);
+		kfree(p_ipmi);
+	}
+
+	return;
+}
 static __devinit void acpi_find_bmc(void)
 {
 	acpi_status      status;
@@ -2022,6 +2381,7 @@
 
 		try_init_acpi(spmi);
 	}
+	acpi_device_find_bmc();
 }
 #endif
 
