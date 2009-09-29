From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC Patch 1/2]IPMI/ACPI: Locate the IPMI system interface in ACPI namespace
Date: Tue, 29 Sep 2009 09:51:48 -0600
Message-ID: <200909290951.49902.bjorn.helgaas@hp.com>
References: <1254202194-7630-1-git-send-email-yakui.zhao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:3632 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbZI2Pvr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2009 11:51:47 -0400
In-Reply-To: <1254202194-7630-1-git-send-email-yakui.zhao@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui.zhao@intel.com
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org, minyard@acm.org

On Monday 28 September 2009 11:29:53 pm yakui.zhao@intel.com wrote:
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
> According to the IPMI 2.0 spec the IPMI system interface can be located with
> ACPI. One is located in SPMI table(Service Processor Management Interface
> table). Another is located in ACPI namespace.
> This patch is to locate the IPMI system interface in ACPI namespace and
> register it.
> It includes the following two steps:
>    1. enumerate the ACPI device tree to find the IPMI system interface
> 	The IPMI device type is IPI0001. When the device is found, it
> will continue to parse the corresponding resources.
>         For example: 
> 		interface type (KCS, BT, SMIC) (SSIF is not supported)
> 		interrupt number and type (_GPE or GSI)
> 		Memory or IO base address
>     2. register the IPMI system interface.

I echo Corey's coding style comments.  The lack of consistency makes
it hard to read and review.

I don't like the fact that in this patch, you use acpi_walk_namespace()
to look for an IPI0001 device, and in the second patch, you register a
driver for IPI0001 devices.  You're making two bindings -- the one
done "by hand" here, and the other done by acpi_bus_register_driver().
There should only be one binding between the IPI0001 device and a driver,
so somehow the code in these two patches should be integrated.

The acpi_parse_io_ports() function is big and complicated, and that
points out another problem.  We shouldn't have to write all that code
every time we write an ACPI device driver.

I think you should register a *PNP* driver for IPI0001 devices, not an
ACPI driver.  That way, you can take advantage of all the resource
parsing code in PNPACPI, and all the acpi_parse_io_ports() code would
go away.

There is a problem here, though, because you still need ACPI so you
can evaluate _IFT, _GPE, _SRV, etc.  I think you should fix this by
adding a PNP interface to get back the ACPI handle from a PNP device
(this interface would fail if the device is not a PNPACPI device).

Bjorn


> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c |  394 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 394 insertions(+)
> 
> Index: linux-2.6/drivers/char/ipmi/ipmi_si_intf.c
> ===================================================================
> --- linux-2.6.orig/drivers/char/ipmi/ipmi_si_intf.c	2009-09-28 16:46:07.000000000 +0800
> +++ linux-2.6/drivers/char/ipmi/ipmi_si_intf.c	2009-09-29 13:18:17.000000000 +0800
> @@ -1813,6 +1813,35 @@
>   * are no more.
>   */
>  static int acpi_failure;
> +static LIST_HEAD(acpi_ipmi);
> +
> +struct acpi_device_ipmi {
> +	struct list_head link;
> +	u8 interfacetype;
> +	/*
> +	 * Bit 0 - SCI interrupt supported
> +	 * Bit 1 - I/O APIC/SAPIC
> +	 */
> +	u8	interrupttype;
> +	/*
> +	 * If bit 0 of InterruptType is set, then this is the SCI
> +	 * interrupt in the GPEx_STS register.
> +	 */
> +	u8	gpe;
> +	/*
> +	 * If bit 1 of InterruptType is set, then this is the I/O
> +	 * APIC/SAPIC interrupt.
> +	 */
> +	u32	global_interrupt;
> +
> +	/* The actual register address. */
> +	struct acpi_generic_address addr;
> +	struct acpi_generic_address sm_addr;
> +
> +	u16 ipmi_revision;
> +	u8 resource_count;
> +	struct device *dev;
> +};
>  
>  /* For GPE-type interrupts. */
>  static u32 ipmi_acpi_gpe(void *context)
> @@ -2002,6 +2031,367 @@
>  	return 0;
>  }
>  
> +static __devinit int try_init_acpi_device(struct acpi_device_ipmi *spmi)
> +{
> +	struct smi_info  *info;
> +	u8 		 addr_space;
> +
> +	if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +		addr_space = IPMI_MEM_ADDR_SPACE;
> +	else
> +		addr_space = IPMI_IO_ADDR_SPACE;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
> +		return -ENOMEM;
> +	}
> +
> +	info->addr_source = "ACPI";
> +
> +	/* Figure out the interface type. */
> +	switch (spmi->interfacetype) {
> +	case 1:	/* KCS */
> +		info->si_type = SI_KCS;
> +		break;
> +	case 2:	/* SMIC */
> +		info->si_type = SI_SMIC;
> +		break;
> +	case 3:	/* BT */
> +		info->si_type = SI_BT;
> +		break;
> +	default:
> +		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
> +			spmi->interfacetype);
> +		kfree(info);
> +		return -EIO;
> +	}
> +
> +	if (spmi->interrupttype & 1) {
> +		/* We've got a GPE interrupt. */
> +		info->irq = spmi->gpe;
> +		info->irq_setup = acpi_gpe_irq_setup;
> +	} else if (spmi->interrupttype & 2) {
> +		/* We've got an APIC/SAPIC interrupt. */
> +		info->irq = spmi->global_interrupt;
> +		info->irq_setup = std_irq_setup;
> +	} else {
> +		/* Use the default interrupt setting. */
> +		info->irq = 0;
> +		info->irq_setup = NULL;
> +	}
> +
> +	if (spmi->addr.bit_width) {
> +		/* A (hopefully) properly formed register bit width. */
> +		info->io.regspacing = spmi->addr.bit_width / 8;
> +	} else {
> +		info->io.regspacing = DEFAULT_REGSPACING;
> +	}
> +	info->io.regsize = info->io.regspacing;
> +	info->io.regshift = spmi->addr.bit_offset;
> +
> +	if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +		info->io_setup = mem_setup;
> +		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
> +	} else if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> +		info->io_setup = port_setup;
> +		info->io.addr_type = IPMI_IO_ADDR_SPACE;
> +	} else {
> +		kfree(info);
> +		printk(KERN_WARNING
> +		       "ipmi_si: Unknown ACPI I/O Address type\n");
> +		return -EIO;
> +	}
> +	info->io.addr_data = spmi->addr.address;
> +	info->dev = spmi->dev;
> +
> +	try_smi_init(info);
> +
> +	return 0;
> +}
> +
> +static acpi_status
> +acpi_parse_io_ports(struct acpi_resource *resource, void *context)
> +{
> +	struct acpi_device_ipmi *p_ipmi = context;
> +
> +	if (resource->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ ||
> +		resource->type == ACPI_RESOURCE_TYPE_IRQ) {
> +		unsigned int irq_number;
> +		if (p_ipmi->interrupttype) {
> +			/*
> +			 * If it already support the interrupt through GPE,
> +			 * it is unnecessary to get this interrupt again.
> +			 */
> +			printk(KERN_WARNING "Interrupt through GPE is already"
> +				" supported.\n");
> +			return AE_OK;
> +		}
> +		if (resource->type == ACPI_RESOURCE_TYPE_IRQ) {
> +			struct acpi_resource_irq *irq;
> +			irq = &resource->data.irq;
> +			if (irq->interrupt_count != 1) {
> +				printk(KERN_WARNING "incorrect IRQ is "
> +					"defined in _CRS\n");
> +				return AE_OK;
> +			}
> +			irq_number = irq->interrupts[0];
> +		} else {
> +			struct acpi_resource_extended_irq *extended_irq;
> +			extended_irq = &resource->data.extended_irq;
> +			if (extended_irq->interrupt_count != 1) {
> +				printk(KERN_WARNING "incorrect IRQ is "
> +					"defined in _CRS\n");
> +				return AE_OK;
> +			}
> +			irq_number = extended_irq->interrupts[0];
> +		}
> +		p_ipmi->global_interrupt = irq_number;
> +		if (p_ipmi->global_interrupt) {
> +			/* GSI interrupt type */
> +			p_ipmi->interrupttype |= 0x02;
> +		}
> +		return AE_OK;
> +	}
> +	if (resource->type == ACPI_RESOURCE_TYPE_IO ||
> +		resource->type == ACPI_RESOURCE_TYPE_FIXED_IO) {
> +		u16 address;
> +		struct acpi_resource_io *io;
> +		struct acpi_resource_fixed_io *fixed_io;
> +
> +		fixed_io = &resource->data.fixed_io;
> +		if (p_ipmi->resource_count) {
> +			/*
> +			 * Multiply definitions of IO/memory address are
> +			 * obtained. It is incorrect. We will continue
> +			 * to use the first IO/memory definition.
> +			 * If not correct, please fix me.
> +			 */
> +			return AE_OK;
> +		}
> +		if (resource->type == ACPI_RESOURCE_TYPE_IO) {
> +			io = &resource->data.io;
> +			if (!io->minimum) {
> +				/* when IO address is zero, return */
> +				return AE_OK;
> +			}
> +			address = io->minimum;
> +		} else {
> +			fixed_io = &resource->data.fixed_io;
> +			if (!fixed_io->address)
> +				return AE_OK;
> +			address = fixed_io->address;
> +		}
> +		p_ipmi->resource_count++;
> +		p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_IO;
> +		p_ipmi->addr.address = address;
> +		return AE_OK;
> +	}
> +
> +	if (resource->type == ACPI_RESOURCE_TYPE_MEMORY32 ||
> +		resource->type == ACPI_RESOURCE_TYPE_MEMORY24 ||
> +		resource->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
> +		u32 address;
> +		if (p_ipmi->resource_count) {
> +			/*
> +			 * Multiply definitions of IO/memory address are
> +			 * obtained. It is incorrect. We will continue
> +			 * to use the first IO/memory definition.
> +			 * If not correct, please fix me.
> +			 */
> +			return AE_OK;
> +		}
> +		if (resource->type == ACPI_RESOURCE_TYPE_MEMORY32) {
> +			struct acpi_resource_memory32 *memory32;
> +			memory32 = &resource->data.memory32;
> +			address = memory32->minimum;
> +		} else if (resource->type == ACPI_RESOURCE_TYPE_MEMORY24) {
> +			struct acpi_resource_memory24 *memory24;
> +			memory24 = &resource->data.memory24;
> +			address = memory24->minimum;
> +		} else {
> +			struct acpi_resource_fixed_memory32 *fixed_memory32;
> +			fixed_memory32 = &resource->data.fixed_memory32;
> +			address = fixed_memory32->address;
> +		}
> +		p_ipmi->resource_count++;
> +		p_ipmi->addr.address = (u64) address;
> +		p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
> +		return AE_OK;
> +	}
> +	if (resource->type == ACPI_RESOURCE_TYPE_ADDRESS16 ||
> +		resource->type == ACPI_RESOURCE_TYPE_ADDRESS32 ||
> +		resource->type == ACPI_RESOURCE_TYPE_ADDRESS64) {
> +		struct acpi_resource_address64 address64;
> +		acpi_resource_to_address64(resource, &address64);
> +		if (p_ipmi->resource_count) {
> +			/*
> +			 * Multiply definitions of IO/memory address are
> +			 * obtained. It is incorrect. We will continue
> +			 * to use the first IO/memory definition.
> +			 * If not correct, please fix me.
> +			 */
> +			return AE_OK;
> +		}
> +		if (address64.resource_type != ACPI_MEMORY_RANGE &&
> +			address64.resource_type != ACPI_IO_RANGE) {
> +			/* ignore the incorrect resource type */
> +			return AE_OK;
> +		}
> +		p_ipmi->addr.address = address64.minimum;
> +		p_ipmi->resource_count++;
> +		if (address64.resource_type == ACPI_MEMORY_RANGE)
> +			p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
> +		else
> +			p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_IO;
> +
> +		return AE_OK;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +/*
> + *  acpi_parse_bmc_resource -- parse the BMC resources from ACPI
> + *  @p_ipmi: the memory to store the BCM resource
> + *  @handle: ACPI device handle
> + */
> +static int acpi_parse_bmc_resource(struct acpi_device_ipmi *p_ipmi,
> +			acpi_handle handle)
> +{
> +	int parse_ok = false;
> +	unsigned long long	temp_data;
> +	acpi_status status;
> +
> +	/* According to IPMI spec there should exist the _IFT method
> +	 * for the IPMI device. So when there is no _IFT, it is regarded
> +	 * as the incorrect BMC device and won't parse the resource again.
> +	 */
> +	status = acpi_evaluate_integer(handle, "_IFT", NULL, &temp_data);
> +	if (ACPI_FAILURE(status))
> +		return parse_ok;
> +
> +	p_ipmi->interfacetype = temp_data;
> +	/* Figure out the interface type. If the interface type is not
> +	 * KCS/SMIC/BT, it is regared as the incorrect IPMI device.
> +	 * Of course the SSIF interface type is also defined, but we
> +	 * can't handle it. So it is not supported */
> +	switch (temp_data) {
> +	case 1:	/* KCS */
> +	case 2:	/* SMIC */
> +	case 3:	/* BT */
> +		break;
> +	default:
> +		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
> +			p_ipmi->interfacetype);
> +		return parse_ok;
> +	}
> +	/* check whether there exists the _GPE method. If it exists, it
> +	 * means that interrupt through GPE is supported.
> +	 */
> +	temp_data = 0;
> +	status = acpi_evaluate_integer(handle, "_GPE", NULL, &temp_data);
> +	if (ACPI_SUCCESS(status)) {
> +		p_ipmi->gpe = temp_data;
> +		/* set the GPE interrupt type */
> +		p_ipmi->interrupttype |= 0x01;
> +	}
> +	/* get the IPMI revision */
> +	temp_data = 0;
> +	status = acpi_evaluate_integer(handle, "_SRV", NULL,  &temp_data);
> +	if (ACPI_SUCCESS(status))
> +		p_ipmi->ipmi_revision = temp_data;
> +
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				acpi_parse_io_ports, p_ipmi);
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_WARNING "Can't parse the _CRS object \n");
> +		return parse_ok;
> +	}
> +	if (!p_ipmi->resource_count) {
> +		/* The incorrect IO/Memory address is parsed */
> +		printk(KERN_ERR "Incorrect IO/Memory address is parsed\n");
> +		return parse_ok;
> +	}
> +	parse_ok = true;
> +
> +	return parse_ok;
> +}
> +
> +const struct acpi_device_id ipmi_ids[] = {
> +	{"IPI0001", 0},
> +	{"", 0},
> +};
> +
> +/*
> + * acpi_check_bmc_device -- check whether @handle is a BMC device and then
> + *		get its corresponding resource. For example: IO/Mem
> + *		address, interface type
> + * @handle: ACPI device handle
> + * @level : depth in the ACPI namespace tree
> + * @context: the number of bmc device. In theory there is not more than
> + * 	one ACPI BMC device.
> + * @rv: a return value to fill if desired (Not use)
> + */
> +static acpi_status
> +acpi_check_bmc_device(acpi_handle handle, u32 level, void *context,
> +			void **return_value)
> +{
> +	struct acpi_device *acpi_dev;
> +	struct acpi_device_ipmi *p_ipmi = NULL;
> +	int *count = (int *)context;
> +
> +	acpi_dev = NULL;
> +	/* Get the acpi device for device handle */
> +	if (acpi_bus_get_device(handle, &acpi_dev) || !acpi_dev) {
> +		/* If there is no ACPI device for handle, return */
> +		return AE_OK;
> +	}
> +
> +	if (acpi_match_device_ids(acpi_dev, ipmi_ids))
> +		return AE_OK;
> +
> +	p_ipmi = kzalloc(sizeof(*p_ipmi), GFP_KERNEL);
> +	if (!p_ipmi) {
> +		printk(KERN_ERR "Can't allocate memory for IPMI device\n");
> +		return AE_OK;
> +	}
> +	p_ipmi->dev = &acpi_dev->dev;
> +	if (!acpi_parse_bmc_resource(p_ipmi, handle)) {
> +		kfree(p_ipmi);
> +	} else {
> +		list_add_tail(&p_ipmi->link, &acpi_ipmi);
> +		*count = *count + 1;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static __devinit void acpi_device_find_bmc(void)
> +{
> +	acpi_status      status;
> +	int              device_count = 0;
> +	struct acpi_device_ipmi *p_ipmi, *p_ipmi2;
> +
> +	if (acpi_disabled)
> +		return;
> +
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +				ACPI_UINT32_MAX,
> +				acpi_check_bmc_device, &device_count, NULL);
> +	if (!device_count) {
> +		/* when no IPMI device is found in ACPI namespace, return */
> +		return;
> +	}
> +	list_for_each_entry_safe(p_ipmi, p_ipmi2, &acpi_ipmi, link) {
> +		try_init_acpi_device(p_ipmi);
> +		list_del(&p_ipmi->link);
> +		kfree(p_ipmi);
> +	}
> +
> +	return;
> +}
> +
>  static __devinit void acpi_find_bmc(void)
>  {
>  	acpi_status      status;
> @@ -2014,6 +2404,7 @@
>  	if (acpi_failure)
>  		return;
>  
> +	/* locate the IPMI system interface in ACPI SPMI table */
>  	for (i = 0; ; i++) {
>  		status = acpi_get_table(ACPI_SIG_SPMI, i+1,
>  					(struct acpi_table_header **)&spmi);
> @@ -2022,6 +2413,9 @@
>  
>  		try_init_acpi(spmi);
>  	}
> +
> +	/* locate the IPMI system interface in ACPI device */
> +	acpi_device_find_bmc();
>  }
>  #endif
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


