From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] IPMI/ACPI: Locate the IPMI system interface in
	ACPI namespace
Date: Tue, 27 Oct 2009 09:02:55 +0800
Message-ID: <1256605375.3563.182.camel@localhost.localdomain>
References: <1256564026-9855-1-git-send-email-yakui.zhao@intel.com>
	 <200910260920.11124.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39592 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059AbZJ0BES (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2009 21:04:18 -0400
In-Reply-To: <200910260920.11124.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2009-10-26 at 23:20 +0800, Bjorn Helgaas wrote:
> On Monday 26 October 2009 07:33:45 am yakui.zhao@intel.com wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >
> > According to the IPMI 2.0 spec the IPMI system interface can be located with
> > ACPI. One is located in SPMI table(Service Processor Management Interface
> > table). Another is located in ACPI namespace.
> > This patch is to locate the IPMI system interface in ACPI namespace and
> > register it.
> > It includes the following two steps:
> >    1. enumerate the ACPI device tree to find the IPMI system interface
> >       The IPMI device type is IPI0001. When the device is found, it
> > will continue to parse the corresponding resources.
> >         For example:
> >               interface type (KCS, BT, SMIC) (SSIF is not supported)
> >               interrupt number and type (_GPE or GSI)
> >               Memory or IO base address
> >     2. register the IPMI system interface

> As far as I can tell, these patches are unchanged from the original
> ones you posted here:
>   http://marc.info/?l=linux-acpi&m=125420227326811&w=2
>   http://marc.info/?l=linux-acpi&m=125420227426814&w=2
I refresh them based on the latest upstream branch. Of course I do the
small change about the second patch. It is mainly about the coding
style.

In fact you mention two issues about the two patches:
   1: Load a PNP driver for it to register the IPMI system interface.
This is about the first patch.
   2. coding style( for example: comments, the definition about some
variables).

For the first issue: Before I start the first patch, I consider using
the PNP device driver. But I find that it is so complex because of the
following two points:
    1. One is that we can't register the IPMI system interface if the
boot option of "pnpacpi=off" is added. This will also depend on the PNP
module.
    2. The second is that there exist so many cases about the IPMI
IO/memory resource definition. Maybe there exist both IO/memory resource
definition for one IPMI device. In such case we can't know which should
be selected. At the same time we have similar issues about the interrupt
type. So I decide to parse the IO/memory/interrupt resource
independently.
Very sorry that I don't reply the above points in the discussion.

For the second patch: 
   I update the coding style about the comments. But I don't change the
coding style about the variable definition as it doesn't matter. At the
same time it is easy to understand by using the explicit definition.
   For example: 
      if (acpi_disabled)
               return;

thanks.
   yakui

> Either you mistakenly posted the original patches again, or you
> didn't address a single piece of the feedback we gave you.
> 
> Please don't waste my time asking for comments if you're just going
> to ignore them.
> 
> It's OK if you think my suggestions are incorrect, but I expect you
> to at least acknowledge them and explain why you disagree with me, so
> we can have a discussion about it.
> 
> Bjorn
> 
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > ---
> >  drivers/char/ipmi/ipmi_si_intf.c |  394 ++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 394 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > index d2e6980..94d14bc 100644
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -1813,6 +1813,35 @@ static __devinit void hardcode_find_bmc(void)
> >   * are no more.
> >   */
> >  static int acpi_failure;
> > +static LIST_HEAD(acpi_ipmi);
> > +
> > +struct acpi_device_ipmi {
> > +     struct list_head link;
> > +     u8 interfacetype;
> > +     /*
> > +      * Bit 0 - SCI interrupt supported
> > +      * Bit 1 - I/O APIC/SAPIC
> > +      */
> > +     u8      interrupttype;
> > +     /*
> > +      * If bit 0 of InterruptType is set, then this is the SCI
> > +      * interrupt in the GPEx_STS register.
> > +      */
> > +     u8      gpe;
> > +     /*
> > +      * If bit 1 of InterruptType is set, then this is the I/O
> > +      * APIC/SAPIC interrupt.
> > +      */
> > +     u32     global_interrupt;
> > +
> > +     /* The actual register address. */
> > +     struct acpi_generic_address addr;
> > +     struct acpi_generic_address sm_addr;
> > +
> > +     u16 ipmi_revision;
> > +     u8 resource_count;
> > +     struct device *dev;
> > +};
> >
> >  /* For GPE-type interrupts. */
> >  static u32 ipmi_acpi_gpe(void *context)
> > @@ -2002,6 +2031,367 @@ static __devinit int try_init_acpi(struct SPMITable *spmi)
> >       return 0;
> >  }
> >
> > +static __devinit int try_init_acpi_device(struct acpi_device_ipmi *spmi)
> > +{
> > +     struct smi_info  *info;
> > +     u8               addr_space;
> > +
> > +     if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> > +             addr_space = IPMI_MEM_ADDR_SPACE;
> > +     else
> > +             addr_space = IPMI_IO_ADDR_SPACE;
> > +
> > +     info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +     if (!info) {
> > +             printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     info->addr_source = "ACPI";
> > +
> > +     /* Figure out the interface type. */
> > +     switch (spmi->interfacetype) {
> > +     case 1: /* KCS */
> > +             info->si_type = SI_KCS;
> > +             break;
> > +     case 2: /* SMIC */
> > +             info->si_type = SI_SMIC;
> > +             break;
> > +     case 3: /* BT */
> > +             info->si_type = SI_BT;
> > +             break;
> > +     default:
> > +             printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
> > +                     spmi->interfacetype);
> > +             kfree(info);
> > +             return -EIO;
> > +     }
> > +
> > +     if (spmi->interrupttype & 1) {
> > +             /* We've got a GPE interrupt. */
> > +             info->irq = spmi->gpe;
> > +             info->irq_setup = acpi_gpe_irq_setup;
> > +     } else if (spmi->interrupttype & 2) {
> > +             /* We've got an APIC/SAPIC interrupt. */
> > +             info->irq = spmi->global_interrupt;
> > +             info->irq_setup = std_irq_setup;
> > +     } else {
> > +             /* Use the default interrupt setting. */
> > +             info->irq = 0;
> > +             info->irq_setup = NULL;
> > +     }
> > +
> > +     if (spmi->addr.bit_width) {
> > +             /* A (hopefully) properly formed register bit width. */
> > +             info->io.regspacing = spmi->addr.bit_width / 8;
> > +     } else {
> > +             info->io.regspacing = DEFAULT_REGSPACING;
> > +     }
> > +     info->io.regsize = info->io.regspacing;
> > +     info->io.regshift = spmi->addr.bit_offset;
> > +
> > +     if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> > +             info->io_setup = mem_setup;
> > +             info->io.addr_type = IPMI_MEM_ADDR_SPACE;
> > +     } else if (spmi->addr.space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> > +             info->io_setup = port_setup;
> > +             info->io.addr_type = IPMI_IO_ADDR_SPACE;
> > +     } else {
> > +             kfree(info);
> > +             printk(KERN_WARNING
> > +                    "ipmi_si: Unknown ACPI I/O Address type\n");
> > +             return -EIO;
> > +     }
> > +     info->io.addr_data = spmi->addr.address;
> > +     info->dev = spmi->dev;
> > +
> > +     try_smi_init(info);
> > +
> > +     return 0;
> > +}
> > +
> > +static acpi_status
> > +acpi_parse_io_ports(struct acpi_resource *resource, void *context)
> > +{
> > +     struct acpi_device_ipmi *p_ipmi = context;
> > +
> > +     if (resource->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ ||
> > +             resource->type == ACPI_RESOURCE_TYPE_IRQ) {
> > +             unsigned int irq_number;
> > +             if (p_ipmi->interrupttype) {
> > +                     /*
> > +                      * If it already support the interrupt through GPE,
> > +                      * it is unnecessary to get this interrupt again.
> > +                      */
> > +                     printk(KERN_WARNING "Interrupt through GPE is already"
> > +                             " supported.\n");
> > +                     return AE_OK;
> > +             }
> > +             if (resource->type == ACPI_RESOURCE_TYPE_IRQ) {
> > +                     struct acpi_resource_irq *irq;
> > +                     irq = &resource->data.irq;
> > +                     if (irq->interrupt_count != 1) {
> > +                             printk(KERN_WARNING "incorrect IRQ is "
> > +                                     "defined in _CRS\n");
> > +                             return AE_OK;
> > +                     }
> > +                     irq_number = irq->interrupts[0];
> > +             } else {
> > +                     struct acpi_resource_extended_irq *extended_irq;
> > +                     extended_irq = &resource->data.extended_irq;
> > +                     if (extended_irq->interrupt_count != 1) {
> > +                             printk(KERN_WARNING "incorrect IRQ is "
> > +                                     "defined in _CRS\n");
> > +                             return AE_OK;
> > +                     }
> > +                     irq_number = extended_irq->interrupts[0];
> > +             }
> > +             p_ipmi->global_interrupt = irq_number;
> > +             if (p_ipmi->global_interrupt) {
> > +                     /* GSI interrupt type */
> > +                     p_ipmi->interrupttype |= 0x02;
> > +             }
> > +             return AE_OK;
> > +     }
> > +     if (resource->type == ACPI_RESOURCE_TYPE_IO ||
> > +             resource->type == ACPI_RESOURCE_TYPE_FIXED_IO) {
> > +             u16 address;
> > +             struct acpi_resource_io *io;
> > +             struct acpi_resource_fixed_io *fixed_io;
> > +
> > +             fixed_io = &resource->data.fixed_io;
> > +             if (p_ipmi->resource_count) {
> > +                     /*
> > +                      * Multiply definitions of IO/memory address are
> > +                      * obtained. It is incorrect. We will continue
> > +                      * to use the first IO/memory definition.
> > +                      * If not correct, please fix me.
> > +                      */
> > +                     return AE_OK;
> > +             }
> > +             if (resource->type == ACPI_RESOURCE_TYPE_IO) {
> > +                     io = &resource->data.io;
> > +                     if (!io->minimum) {
> > +                             /* when IO address is zero, return */
> > +                             return AE_OK;
> > +                     }
> > +                     address = io->minimum;
> > +             } else {
> > +                     fixed_io = &resource->data.fixed_io;
> > +                     if (!fixed_io->address)
> > +                             return AE_OK;
> > +                     address = fixed_io->address;
> > +             }
> > +             p_ipmi->resource_count++;
> > +             p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_IO;
> > +             p_ipmi->addr.address = address;
> > +             return AE_OK;
> > +     }
> > +
> > +     if (resource->type == ACPI_RESOURCE_TYPE_MEMORY32 ||
> > +             resource->type == ACPI_RESOURCE_TYPE_MEMORY24 ||
> > +             resource->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
> > +             u32 address;
> > +             if (p_ipmi->resource_count) {
> > +                     /*
> > +                      * Multiply definitions of IO/memory address are
> > +                      * obtained. It is incorrect. We will continue
> > +                      * to use the first IO/memory definition.
> > +                      * If not correct, please fix me.
> > +                      */
> > +                     return AE_OK;
> > +             }
> > +             if (resource->type == ACPI_RESOURCE_TYPE_MEMORY32) {
> > +                     struct acpi_resource_memory32 *memory32;
> > +                     memory32 = &resource->data.memory32;
> > +                     address = memory32->minimum;
> > +             } else if (resource->type == ACPI_RESOURCE_TYPE_MEMORY24) {
> > +                     struct acpi_resource_memory24 *memory24;
> > +                     memory24 = &resource->data.memory24;
> > +                     address = memory24->minimum;
> > +             } else {
> > +                     struct acpi_resource_fixed_memory32 *fixed_memory32;
> > +                     fixed_memory32 = &resource->data.fixed_memory32;
> > +                     address = fixed_memory32->address;
> > +             }
> > +             p_ipmi->resource_count++;
> > +             p_ipmi->addr.address = (u64) address;
> > +             p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
> > +             return AE_OK;
> > +     }
> > +     if (resource->type == ACPI_RESOURCE_TYPE_ADDRESS16 ||
> > +             resource->type == ACPI_RESOURCE_TYPE_ADDRESS32 ||
> > +             resource->type == ACPI_RESOURCE_TYPE_ADDRESS64) {
> > +             struct acpi_resource_address64 address64;
> > +             acpi_resource_to_address64(resource, &address64);
> > +             if (p_ipmi->resource_count) {
> > +                     /*
> > +                      * Multiply definitions of IO/memory address are
> > +                      * obtained. It is incorrect. We will continue
> > +                      * to use the first IO/memory definition.
> > +                      * If not correct, please fix me.
> > +                      */
> > +                     return AE_OK;
> > +             }
> > +             if (address64.resource_type != ACPI_MEMORY_RANGE &&
> > +                     address64.resource_type != ACPI_IO_RANGE) {
> > +                     /* ignore the incorrect resource type */
> > +                     return AE_OK;
> > +             }
> > +             p_ipmi->addr.address = address64.minimum;
> > +             p_ipmi->resource_count++;
> > +             if (address64.resource_type == ACPI_MEMORY_RANGE)
> > +                     p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
> > +             else
> > +                     p_ipmi->addr.space_id = ACPI_ADR_SPACE_SYSTEM_IO;
> > +
> > +             return AE_OK;
> > +     }
> > +
> > +     return AE_OK;
> > +}
> > +
> > +/*
> > + *  acpi_parse_bmc_resource -- parse the BMC resources from ACPI
> > + *  @p_ipmi: the memory to store the BCM resource
> > + *  @handle: ACPI device handle
> > + */
> > +static int acpi_parse_bmc_resource(struct acpi_device_ipmi *p_ipmi,
> > +                     acpi_handle handle)
> > +{
> > +     int parse_ok = false;
> > +     unsigned long long      temp_data;
> > +     acpi_status status;
> > +
> > +     /* According to IPMI spec there should exist the _IFT method
> > +      * for the IPMI device. So when there is no _IFT, it is regarded
> > +      * as the incorrect BMC device and won't parse the resource again.
> > +      */
> > +     status = acpi_evaluate_integer(handle, "_IFT", NULL, &temp_data);
> > +     if (ACPI_FAILURE(status))
> > +             return parse_ok;
> > +
> > +     p_ipmi->interfacetype = temp_data;
> > +     /* Figure out the interface type. If the interface type is not
> > +      * KCS/SMIC/BT, it is regared as the incorrect IPMI device.
> > +      * Of course the SSIF interface type is also defined, but we
> > +      * can't handle it. So it is not supported */
> > +     switch (temp_data) {
> > +     case 1: /* KCS */
> > +     case 2: /* SMIC */
> > +     case 3: /* BT */
> > +             break;
> > +     default:
> > +             printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
> > +                     p_ipmi->interfacetype);
> > +             return parse_ok;
> > +     }
> > +     /* check whether there exists the _GPE method. If it exists, it
> > +      * means that interrupt through GPE is supported.
> > +      */
> > +     temp_data = 0;
> > +     status = acpi_evaluate_integer(handle, "_GPE", NULL, &temp_data);
> > +     if (ACPI_SUCCESS(status)) {
> > +             p_ipmi->gpe = temp_data;
> > +             /* set the GPE interrupt type */
> > +             p_ipmi->interrupttype |= 0x01;
> > +     }
> > +     /* get the IPMI revision */
> > +     temp_data = 0;
> > +     status = acpi_evaluate_integer(handle, "_SRV", NULL,  &temp_data);
> > +     if (ACPI_SUCCESS(status))
> > +             p_ipmi->ipmi_revision = temp_data;
> > +
> > +     status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> > +                             acpi_parse_io_ports, p_ipmi);
> > +     if (ACPI_FAILURE(status)) {
> > +             printk(KERN_WARNING "Can't parse the _CRS object \n");
> > +             return parse_ok;
> > +     }
> > +     if (!p_ipmi->resource_count) {
> > +             /* The incorrect IO/Memory address is parsed */
> > +             printk(KERN_ERR "Incorrect IO/Memory address is parsed\n");
> > +             return parse_ok;
> > +     }
> > +     parse_ok = true;
> > +
> > +     return parse_ok;
> > +}
> > +
> > +const struct acpi_device_id ipmi_ids[] = {
> > +     {"IPI0001", 0},
> > +     {"", 0},
> > +};
> > +
> > +/*
> > + * acpi_check_bmc_device -- check whether @handle is a BMC device and then
> > + *           get its corresponding resource. For example: IO/Mem
> > + *           address, interface type
> > + * @handle: ACPI device handle
> > + * @level : depth in the ACPI namespace tree
> > + * @context: the number of bmc device. In theory there is not more than
> > + *   one ACPI BMC device.
> > + * @rv: a return value to fill if desired (Not use)
> > + */
> > +static acpi_status
> > +acpi_check_bmc_device(acpi_handle handle, u32 level, void *context,
> > +                     void **return_value)
> > +{
> > +     struct acpi_device *acpi_dev;
> > +     struct acpi_device_ipmi *p_ipmi = NULL;
> > +     int *count = (int *)context;
> > +
> > +     acpi_dev = NULL;
> > +     /* Get the acpi device for device handle */
> > +     if (acpi_bus_get_device(handle, &acpi_dev) || !acpi_dev) {
> > +             /* If there is no ACPI device for handle, return */
> > +             return AE_OK;
> > +     }
> > +
> > +     if (acpi_match_device_ids(acpi_dev, ipmi_ids))
> > +             return AE_OK;
> > +
> > +     p_ipmi = kzalloc(sizeof(*p_ipmi), GFP_KERNEL);
> > +     if (!p_ipmi) {
> > +             printk(KERN_ERR "Can't allocate memory for IPMI device\n");
> > +             return AE_OK;
> > +     }
> > +     p_ipmi->dev = &acpi_dev->dev;
> > +     if (!acpi_parse_bmc_resource(p_ipmi, handle)) {
> > +             kfree(p_ipmi);
> > +     } else {
> > +             list_add_tail(&p_ipmi->link, &acpi_ipmi);
> > +             *count = *count + 1;
> > +     }
> > +
> > +     return AE_OK;
> > +}
> > +
> > +static __devinit void acpi_device_find_bmc(void)
> > +{
> > +     acpi_status      status;
> > +     int              device_count = 0;
> > +     struct acpi_device_ipmi *p_ipmi, *p_ipmi2;
> > +
> > +     if (acpi_disabled)
> > +             return;
> > +
> > +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> > +                             ACPI_UINT32_MAX,
> > +                             acpi_check_bmc_device, &device_count, NULL);
> > +     if (!device_count) {
> > +             /* when no IPMI device is found in ACPI namespace, return */
> > +             return;
> > +     }
> > +     list_for_each_entry_safe(p_ipmi, p_ipmi2, &acpi_ipmi, link) {
> > +             try_init_acpi_device(p_ipmi);
> > +             list_del(&p_ipmi->link);
> > +             kfree(p_ipmi);
> > +     }
> > +
> > +     return;
> > +}
> > +
> >  static __devinit void acpi_find_bmc(void)
> >  {
> >       acpi_status      status;
> > @@ -2014,6 +2404,7 @@ static __devinit void acpi_find_bmc(void)
> >       if (acpi_failure)
> >               return;
> >
> > +     /* locate the IPMI system interface in ACPI SPMI table */
> >       for (i = 0; ; i++) {
> >               status = acpi_get_table(ACPI_SIG_SPMI, i+1,
> >                                       (struct acpi_table_header **)&spmi);
> > @@ -2022,6 +2413,9 @@ static __devinit void acpi_find_bmc(void)
> >
> >               try_init_acpi(spmi);
> >       }
> > +
> > +     /* locate the IPMI system interface in ACPI device */
> > +     acpi_device_find_bmc();
> >  }
> >  #endif
> >
> 
> 

