From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [Openipmi-developer] Subject:[RFC Patch 1/2]IPMI/ACPI: Locate
	the	IPMI system interface in ACPI namespace
Date: Tue, 29 Sep 2009 10:49:41 +0800
Message-ID: <1254192581.4298.66.camel@localhost.localdomain>
References: <1254125998-24006-1-git-send-email-yakui.zhao@intel.com>
	 <4AC0CFC9.5050705@acm.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20237 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519AbZI2Cus (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Sep 2009 22:50:48 -0400
In-Reply-To: <4AC0CFC9.5050705@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "lenb@kernel.org" <lenb@kernel.org>

On Mon, 2009-09-28 at 23:01 +0800, Corey Minyard wrote:
> I've been looking for something like this for a while, but I didn't have
> a system that supports this, so I didn't have a way to test it.  Thanks
> for doing this.

> Now to the code.
> 
> In general, the code is not consistent in the way it uses blank lines
> between functions, if statements, etc.  Can you make it consistent (and
> consistent with the rest of the driver)?
Agree with what you said. I will make it cleaner.
> 
> Can you name all the functions starting with acpi_device or something
> like that to make their function clear?
> 
> You need to run this through the kernel checkpatch script, it has some
> coding style problems.
> 
> Can the old ACPI code go away?  I understand that it will be redundant
> with these additions, but I'm not 100% sure.
Now we can't delete the old ACPI code.
The IPMI system interface can be located in ACPI by using the following
two ways:
   1. locate it in SPMI table. This is done by using the old ACPI code.
   2. locate it in ACPI device tree. This is realized by enumerating the
ACPI device tree. And this is done in my patch.
> 
> Why not fill out an info structure directly in check_bmc_device and then
> call try_device_init_acpi() directly from there instead of creating a
> new structure device, allocating it, saving it in a list, etc.  That
> would save some code and simplify things a little.
What you said is also OK. But it will be more clearer to divide into two
steps. One is to locate all the IPMI system intefaces in ACPI device
tree and register them.

Another concern is that it will get some mutex lock when calling the
function of acpi_walk_namespace(The check_bmc_device is the callback
function user in acpi_walk_namespace). To avoid that the mutex is locked
for too long time, IMO it is reasonable to divide two steps.

> 
> +       if (device_count > 1) {
> +               printk(KERN_WARNING "More than one BMC device is found in "
> +                               "ACPI table\n");
> +               printk(KERN_WARNING "Of course the BMC device will be "
> +                               "registered\n");
> +       }
> 
> It's legal (and possible) to have more than one BMC.  I don't think this
> code is necessary.
Ok. I will delete this check.
> 
> +       if (resource->type == ACPI_RESOURCE_TYPE_MEMORY32 ||
> +               resource->type == ACPI_RESOURCE_TYPE_MEMORY24 ||
> +               resource->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
> +               printk(KERN_DEBUG
> +                       "Can't handle the Memory32/24/fixed32 type\n");
> +               printk(KERN_DEBUG "please send acpidump to "
> +                                       "linux-acpi@vger.kernel.org\n");
> +               return AE_OK;
> +       }
> 
> I don't really understand this, but debug is probably not the
> appropriate printk level for this if the user needs to see it.  Also,
> what is going on here?  Why isn't this supported?
In fact the above resource is parsed from the _CRS object defined in
IPMI device. The resource type for the following example is IO.
    For example:
    // Returns the "Current Resources"
Name(_CRS,
ResourceTemplate() {
  IO(Decode16, 0xCA9, 0, 3) // Ports 0xCA9, 0xCAA & 0xCAB
}
)


For most IPMI system interfaces defined in ACPI device tree, the address
type will be IO. 
But the IPMI 2.0 spec has an example definition of IPMI system
interface, in which the address type is 64-bit memory type. 

In fact I don't find that the resource type is
TYPE_MEMORY32/24/FIXED_MEMORY32 for the _CRS object. 
But I don't know whether it is necessary to support the above three
type. So when this message is complained, we can get the acpidump and
add the support for it.

Of course we can add the support of parsing the base address from the
MEMORY32/24/FIXED_MEMORY32 resource type.
> 
> +       /*
> +        * If the resource type is ACPI_RESOURCE_IRQ, it is not
> +        * supported.
> +        */
> 
> Why not?  Is there something else that should be logged or done?  Also, wouldn't you put this in an IRQ function?
OK. I will try to add the support of parsing the irq number when the
resource type is ACPI_RESOURCE_IRQ.
> 
> 
> +               if (p_ipmi->interrupttype) {
> +                       /*
> +                        * If it already support the interrupt through GPE,
> +                        * it is unnecessary to get this interrupt again.
> +                        */
> +                       printk(KERN_DEBUG "Interrupt through GPE is already"
> +                               " supported.\n");
> +                       return AE_OK;
> +               }
> +               if (extended_irq->interrupt_count != 1) {
> +                       printk(KERN_DEBUG "Incorrect resource setting about "
> +                                       "interrupt \n");
> +                       return AE_OK;
> +               }
> 
> I think the printks need to be a little clearer, and if the user needs
> to see them (like these are errors in the ACPI structures) they should
> be warnings or something like that.
Yes. The KERN_WARNING prefix should be used instead of KERN_DEBUG.

thanks.
> 
> Thanks,
> 
> -corey
> 
> yakui.zhao@intel.com wrote:
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
> >     2. register the IPMI system interface.
> >
> >
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > ---
> >  drivers/char/ipmi/ipmi_si_intf.c |  360 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 360 insertions(+)
> >
> > Index: linux-2.6/drivers/char/ipmi/ipmi_si_intf.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/char/ipmi/ipmi_si_intf.c   2009-09-21 16:49:29.000000000 +0800
> > +++ linux-2.6/drivers/char/ipmi/ipmi_si_intf.c        2009-09-28 11:43:53.000000000 +0800
> > @@ -1813,6 +1813,35 @@
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
> > +     u8 ipmi_revision;
> > +     u8 resource_count;
> > +     struct device *dev;
> > +};
> >
> >  /* For GPE-type interrupts. */
> >  static u32 ipmi_acpi_gpe(void *context)
> > @@ -2001,7 +2030,337 @@
> >
> >       return 0;
> >  }
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
> > +static acpi_status
> > +bmc_parse_io_ports(struct acpi_resource *resource, void *context)
> > +{
> > +     struct acpi_device_ipmi *p_ipmi = context;
> > +
> > +     /*
> > +      * If the resource type is ACPI_RESOURCE_IRQ, it is not
> > +      * supported.
> > +      */
> > +     if (resource->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
> > +             struct acpi_resource_extended_irq *extended_irq;
> > +             extended_irq = &resource->data.extended_irq;
> > +             if (p_ipmi->interrupttype) {
> > +                     /*
> > +                      * If it already support the interrupt through GPE,
> > +                      * it is unnecessary to get this interrupt again.
> > +                      */
> > +                     printk(KERN_DEBUG "Interrupt through GPE is already"
> > +                             " supported.\n");
> > +                     return AE_OK;
> > +             }
> > +             if (extended_irq->interrupt_count != 1) {
> > +                     printk(KERN_DEBUG "Incorrect resource setting about "
> > +                                     "interrupt \n");
> > +                     return AE_OK;
> > +             }
> > +             p_ipmi->global_interrupt = extended_irq->interrupts[0];
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
> > +             printk(KERN_DEBUG
> > +                     "Can't handle the Memory32/24/fixed32 type\n");
> > +             printk(KERN_DEBUG "please send acpidump to "
> > +                                     "linux-acpi@vger.kernel.org\n");
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
> >
> > +     return AE_OK;
> > +}
> > +
> > +/*
> > + *  parse_bmc_resource -- parse the BMC resources from ACPI
> > + *  @p_ipmi: the memory to store the BCM resource
> > + *  @handle: ACPI device handle
> > + */
> > +static int parse_bmc_resource(struct acpi_device_ipmi *p_ipmi,
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
> > +                             bmc_parse_io_ports, p_ipmi);
> > +     if (ACPI_FAILURE(status)) {
> > +             printk(KERN_WARNING "Can't parse the _CRS object \n");
> > +             return parse_ok;
> > +     }
> > +     if (!p_ipmi->resource_count) {
> > +             /* The incorrect IO/Memory address is parsed */
> > +             printk(KERN_WARNING "Incorrect IO/Memory address is parsed\n");
> > +             return parse_ok;
> > +     }
> > +     parse_ok = true;
> > +
> > +     return parse_ok;
> > +}
> > +
> > +const struct acpi_device_id ipmi_ids[] = {
> > +     {ACPI_VIDEO_HID, 0},
> > +     {"", 0},
> > +};
> > +/*
> > + * check_bmc_device -- check whether @handle is a BMC device and then
> > + *           get its corresponding resource. For example: IO/Mem
> > + *           address, interface type
> > + * @handle: ACPI device handle
> > + * @level : depth in the ACPI namespace tree
> > + * @context: the number of bmc device. In theory there is not more than
> > + *   one ACPI BMC device.
> > + * @rv: a return value to fill if desired (Not use)
> > + */
> > +static acpi_status
> > +check_bmc_device(acpi_handle handle, u32 level, void *context,
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
> > +             printk(KERN_DEBUG "Can't allocate memory for IPMI device\n");
> > +             return AE_OK;
> > +     }
> > +     p_ipmi->dev = &acpi_dev->dev;
> > +     if (!parse_bmc_resource(p_ipmi, handle)) {
> > +             kfree(p_ipmi);
> > +     } else {
> > +             list_add_tail(&p_ipmi->link, &acpi_ipmi);
> > +             *count = *count + 1;
> > +     }
> > +
> > +     return AE_OK;
> > +}
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
> > +                             check_bmc_device, &device_count, NULL);
> > +     if (!device_count) {
> > +             /* when no IPMI device is found in ACPI namespace, return */
> > +             return;
> > +     }
> > +     if (device_count > 1) {
> > +             printk(KERN_WARNING "More than one BMC device is found in "
> > +                             "ACPI table\n");
> > +             printk(KERN_WARNING "Of course the BMC device will be "
> > +                             "registered\n");
> > +     }
> > +     list_for_each_entry_safe(p_ipmi, p_ipmi2, &acpi_ipmi, link) {
> > +             try_init_acpi_device(p_ipmi);
> > +             list_del(&p_ipmi->link);
> > +             kfree(p_ipmi);
> > +     }
> > +
> > +     return;
> > +}
> >  static __devinit void acpi_find_bmc(void)
> >  {
> >       acpi_status      status;
> > @@ -2022,6 +2381,7 @@
> >
> >               try_init_acpi(spmi);
> >       }
> > +     acpi_device_find_bmc();
> >  }
> >  #endif
> >
> >
> > ------------------------------------------------------------------------------
> > Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> > is the only developer event you need to attend this year. Jumpstart your
> > developing skills, take BlackBerry mobile applications to market and stay
> > ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> > http://p.sf.net/sfu/devconf
> > _______________________________________________
> > Openipmi-developer mailing list
> > Openipmi-developer@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openipmi-developer
> >
> >
> 

