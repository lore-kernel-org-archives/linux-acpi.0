From: "Anderson, Brandon" <Brandon.Anderson@amd.com>
Subject: RE: [RFC PATCH 2/3] ACPI: Prototype of AMBA bus 'connector resource'
Date: Wed, 23 Oct 2013 15:32:15 +0000
Message-ID: <CE40542A5D952D47989966E71788B1840156EE91@satlexdag05.amd.com>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
 <1382402029-13381-3-git-send-email-brandon.anderson@amd.com>
 <5267B87E.7040501@linaro.org>
 <20131023124939.GB32653@xora-yoga-vm.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:38164
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751238Ab3JWPdp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Oct 2013 11:33:45 -0400
In-Reply-To: <20131023124939.GB32653@xora-yoga-vm.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "naresh.bhat@linaro.org" <naresh.bhat@linaro.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

Thank you Hanjun and Graeme for reviewing the clock definition.

Some devices have multiple clocks and they need to be labeled, so I propose the following format:

		Method(_DSM, 4, NotSerialized) {
			Store (Package (6)
			{
				"clock-name", "KMIREFCLK", "\\_SB_.CLK0",
			}, Local0)
			Return (Local0)
		}

Other custom parameters are required (for MMCI driver in particular), and they will fit into this format as well:

		Method(_DSM, 4, NotSerialized) {
			Store (Package (9)
			{
				"clock-name", "mclk", "\\_SB_.CLK0",
				"max-frequency", 12000000, "",
				"vmmc-supply", "", "",
			}, Local0)

			Return (Local0)
		}

Three fields must be specified for each entry (each line above is an entry). Is this acceptable?

Brandon


-----Original Message-----
From: Graeme Gregory [mailto:graeme.gregory@linaro.org] 
Sent: Wednesday, October 23, 2013 7:50 AM
To: Hanjun Guo
Cc: Anderson, Brandon; linaro-acpi@lists.linaro.org; linux-acpi@vger.kernel.org; lenb@kernel.org; rjw@sisk.pl; naresh.bhat@linaro.org; Suthikulpanit, Suravee
Subject: Re: [RFC PATCH 2/3] ACPI: Prototype of AMBA bus 'connector resource'

On Wed, Oct 23, 2013 at 07:52:30PM +0800, Hanjun Guo wrote:
> On 2013-10-22 8:33, brandon.anderson@amd.com wrote:
> > From: Brandon Anderson <brandon.anderson@amd.com>
> > 
> > Add AMBA bus 'connector resource' module to call amba_device_add() for each device under the top-level 'AMBA0000' entry. Clock handling is yet to be implemented.
> > 
> > 
> > Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
> > ---
> >  drivers/acpi/acpi_platform.c |    2 +
> >  drivers/amba/Makefile        |    2 +-
> >  drivers/amba/acpi.c          |  162 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 165 insertions(+), 1 deletion(-)  create mode 
> > 100644 drivers/amba/acpi.c
> > 
> > diff --git a/drivers/acpi/acpi_platform.c 
> > b/drivers/acpi/acpi_platform.c index 37b8af8..fdfa990 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -36,6 +36,8 @@ static const struct acpi_device_id acpi_platform_device_ids[] = {
> >  	{ "LINA0007" }, /* armv8 pmu */
> >  	{ "LINA0008" }, /* Fixed clock */
> >  
> > +	{ "AMBA0000" },
> > +
> >  	{ }
> >  };
> >  
> > diff --git a/drivers/amba/Makefile b/drivers/amba/Makefile index 
> > 66e81c2..6d088e7 100644
> > --- a/drivers/amba/Makefile
> > +++ b/drivers/amba/Makefile
> > @@ -1,2 +1,2 @@
> > -obj-$(CONFIG_ARM_AMBA)		+= bus.o
> > +obj-$(CONFIG_ARM_AMBA)		+= bus.o acpi.o
> >  obj-$(CONFIG_TEGRA_AHB)		+= tegra-ahb.o
> > diff --git a/drivers/amba/acpi.c b/drivers/amba/acpi.c new file mode 
> > 100644 index 0000000..04efcbd
> > --- /dev/null
> > +++ b/drivers/amba/acpi.c
> > @@ -0,0 +1,162 @@
> > +/*
> > + * AMBA Connector Resource for ACPI
> > + *
> > + * Copyright (C) 2013 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Brandon Anderson <brandon.anderson@amd.com>
> > + *
> > + * This program is free software; you can redistribute it and/or 
> > +modify
> > + * it under the terms of the GNU General Public License version 2 
> > +as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +#include <linux/module.h>
> > +#include <linux/amba/bus.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/acpi.h>
> > +#include <linux/clkdev.h>
> > +
> > +static int acpi_amba_add_resource(struct acpi_resource *ares, void 
> > +*data) {
> > +	struct amba_device *dev = data;
> > +	struct resource r;
> > +	int irq_idx;
> > +
> > +	switch (ares->type)
> > +	{
> > +		case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> > +			if (!acpi_dev_resource_memory(ares, &dev->res)) {
> > +				pr_err("%s: failed to map memory resource\n", __func__);
> > +			}
> > +		break;
> > +		case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> > +			for (irq_idx = 0; irq_idx < AMBA_NR_IRQS; irq_idx++) {
> > +				if (acpi_dev_resource_interrupt(ares, irq_idx, &r)) {
> > +					dev->irq[irq_idx] = r.start;
> > +				} else {
> > +					break;
> > +				}
> > +			}
> > +
> > +		break;
> > +		default:
> > +			pr_debug("%s: unhandled acpi resource type= %d\n", __func__,
> > +					ares->type);
> > +		break;
> > +	}
> > +
> > +	return 1; /* Tell ACPI core to skip this resource */ }
> > +
> > +static void acpi_amba_register_clk(struct acpi_device *adev) {
> > +	/* TODO: Retrieve clock details from ACPI and register the appropriate
> > +	   clock under this device for amba subsystem and drivers to 
> > +reference */ }
> > +
> > +/* acpi_amba_add_device()
> > + *
> > + * ACPI equivalent to of_amba_device_create()  */ static 
> > +acpi_status acpi_amba_add_device(acpi_handle handle, u32 lvl_not_used,
> > +				 void *data, void **not_used)
> > +{
> > +	struct list_head resource_list;
> > +	struct acpi_device *adev;
> > +	struct amba_device *dev;
> > +	int ret;
> > +	struct platform_device *pdata = data;
> > +
> > +	if (acpi_bus_get_device(handle, &adev)) {
> > +		pr_err("%s: acpi_bus_get_device failed\n", __func__);
> > +		return AE_OK;
> > +	}
> > +
> > +	pr_debug("Creating amba device %s\n", dev_name(&adev->dev));
> > +
> > +	dev = amba_device_alloc(NULL, 0, 0);
> > +	if (!dev) {
> > +		pr_err("%s(): amba_device_alloc() failed for %s\n",
> > +		       __func__, dev_name(&adev->dev));
> > +		return AE_CTRL_TERMINATE;
> > +	}
> > +
> > +	/* setup generic device info */
> > +	dev->dev.coherent_dma_mask = ~0;
> > +	dev->dev.parent = pdata->dev.parent;
> > +	//dev->dev.platform_data = platform_data; //FIXME: is this needed by any drivers?
> > +	dev_set_name(&dev->dev, "%s", dev_name(&adev->dev));
> > +
> > +	/* setup amba-specific device info */
> > +	dev->dma_mask = ~0;
> > +
> > +	ACPI_HANDLE_SET(&dev->dev, handle);
> > +
> > +	INIT_LIST_HEAD(&resource_list);
> > +	acpi_dev_get_resources(adev, &resource_list,
> > +				     acpi_amba_add_resource, dev);
> > +	acpi_dev_free_resource_list(&resource_list);
> > +
> > +	/* Add clocks */
> > +	acpi_amba_register_clk(adev);
> > +
> > +	/* Read AMBA hardware ID and add device to system. If a driver matching
> > +	 *	hardware ID has already been registered, bind this device to it.
> > +	 *	Otherwise, the platform subsystem will match up the hardware ID when
> > +	 *	the matching driver is registered.
> > +	*/
> > +	ret = amba_device_add(dev, &iomem_resource);
> > +	if (ret) {
> > +		pr_err("%s(): amba_device_add() failed (%d) for %s\n",
> > +		       __func__, ret, dev_name(&adev->dev));
> > +		goto err_free;
> > +	}
> > +
> > +	return AE_OK;
> > +
> > +err_free:
> > +	amba_device_put(dev);
> > +	return AE_CTRL_TERMINATE;
> > +}
> > +
> > +static int acpi_amba_bus_probe(struct platform_device *pdev) {
> > +	// see if there's a top-level clock to use as default for sub-devices
> > +	//TODO
> 
> Hmm, how about add _DSM under each device object which need the clock?
> I mean some thing like (not the real ASL code):
> Device (SER0) {
> 	....
> 	Method(_DSM, 4, NotSerialized) {
> 		clock path = "\\_SB.SMB.CLK0"
> 	}
> }
> Then we can get the clock ACPI handle from the path, then ACPI dev, if 
> we we attach the pointer of clock struct to that ACPI handle, we can 
> directly get the clock struct.
> 
> \\_SB.SMB.CLK0 ->
>     clock ACPI handle ->
> 	clock ACPI dev ->
> 	   get the clk data
> 
> What do you think?
> 
This is certainly the form we should be using based on ACPI vs DT discussion at kernel plumbers conference.

Graeme



