From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] ipmi: Convert the IPMI SI ACPI handling to a platform
 device
Date: Tue, 16 Jun 2015 19:39:13 -0500
Message-ID: <5580C1B1.5090704@mvista.com>
References: <1433939665-24345-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433939665-24345-1-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Ping, anyone one the ACPI list care to comment on this?

I should give some history here.  The IPMI spec specifies four different
IPMI interfaces using the IPI0001 ID.  Three of the interfaces are close
enough that they are in the same driver, since they all have about the
same behavior and the differences can be handled by a small state
machine.  However, one interface is quite different since it runs over
SMBus, so I wrote a different driver for it.

IPI0001 was hard-coded in the acpi_pnp_device_ids table, and that was
preventing the SMBus interface from finding IPI0001, even when it was
inside the SMBus ACPI path.  However, removing the direct PNP
nterfaces and instead using the platform interface allowed the removal
of IPI0001 from the acpi_pnp_device_ids table, and that seems to allow
both the SMBus and platform IPMI interface to work properly.

I have two specific questions:

  * Is having two device drivers handle the same id like this right?

  * Will automatic module loading do the right thing here?  To work right,
    it would have to load both drivers and succeed if one of the drivers
    succeeded.


There is a proposal on the table to create a new device id for the SMBus
interface, but if that could be avoided it would be better, I think.

Thanks,

-corey

On 06/10/2015 07:34 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> The IPMI SI driver was using direct PNP, but that was not really
> ideal because the IPMI device is a platform device.  There was
> some special handling in the acpi_pnp.c code for making this work,
> but that was breaking ACPI handling for the IPMI SSIF driver.
>
> So use a platform device for ACPI detection and remove the
> entry from acpi_pnp.c.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/acpi/acpi_pnp.c          |   2 -
>  drivers/char/ipmi/ipmi_si_intf.c | 320 +++++++++++++++++++--------------------
>  2 files changed, 157 insertions(+), 165 deletions(-)
>
>
> I'm posting this, primarily for comments from the ACPI group, since I'm
> removing IPI0001 from the acpi_pnp_device_ids array, and to be sure that
> I'm doing this correctly.
>
> Also, anyone feel free to test this, obviously :).
>
> Thanks,
>
> -corey
>
>
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index ff6d8ad..896351be 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -19,8 +19,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
>  	{"PNP0600"},		/* Generic ESDI/IDE/ATA compatible hard disk controller */
>  	/* floppy */
>  	{"PNP0700"},
> -	/* ipmi_si */
> -	{"IPI0001"},
>  	/* tpm_inf_pnp */
>  	{"IFX0101"},		/* Infineon TPMs */
>  	{"IFX0102"},		/* Infineon TPMs */
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index e8b406b..7a93574 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -64,7 +64,6 @@
>  #include <linux/dmi.h>
>  #include <linux/string.h>
>  #include <linux/ctype.h>
> -#include <linux/pnp.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
> @@ -309,9 +308,6 @@ static int num_force_kipmid;
>  #ifdef CONFIG_PCI
>  static bool pci_registered;
>  #endif
> -#ifdef CONFIG_ACPI
> -static bool pnp_registered;
> -#endif
>  #ifdef CONFIG_PARISC
>  static bool parisc_registered;
>  #endif
> @@ -2233,134 +2229,6 @@ static void spmi_find_bmc(void)
>  		try_init_spmi(spmi);
>  	}
>  }
> -
> -static int ipmi_pnp_probe(struct pnp_dev *dev,
> -				    const struct pnp_device_id *dev_id)
> -{
> -	struct acpi_device *acpi_dev;
> -	struct smi_info *info;
> -	struct resource *res, *res_second;
> -	acpi_handle handle;
> -	acpi_status status;
> -	unsigned long long tmp;
> -	int rv = -EINVAL;
> -
> -	acpi_dev = pnp_acpi_device(dev);
> -	if (!acpi_dev)
> -		return -ENODEV;
> -
> -	info = smi_info_alloc();
> -	if (!info)
> -		return -ENOMEM;
> -
> -	info->addr_source = SI_ACPI;
> -	printk(KERN_INFO PFX "probing via ACPI\n");
> -
> -	handle = acpi_dev->handle;
> -	info->addr_info.acpi_info.acpi_handle = handle;
> -
> -	/* _IFT tells us the interface type: KCS, BT, etc */
> -	status = acpi_evaluate_integer(handle, "_IFT", NULL, &tmp);
> -	if (ACPI_FAILURE(status)) {
> -		dev_err(&dev->dev, "Could not find ACPI IPMI interface type\n");
> -		goto err_free;
> -	}
> -
> -	switch (tmp) {
> -	case 1:
> -		info->si_type = SI_KCS;
> -		break;
> -	case 2:
> -		info->si_type = SI_SMIC;
> -		break;
> -	case 3:
> -		info->si_type = SI_BT;
> -		break;
> -	case 4: /* SSIF, just ignore */
> -		rv = -ENODEV;
> -		goto err_free;
> -	default:
> -		dev_info(&dev->dev, "unknown IPMI type %lld\n", tmp);
> -		goto err_free;
> -	}
> -
> -	res = pnp_get_resource(dev, IORESOURCE_IO, 0);
> -	if (res) {
> -		info->io_setup = port_setup;
> -		info->io.addr_type = IPMI_IO_ADDR_SPACE;
> -	} else {
> -		res = pnp_get_resource(dev, IORESOURCE_MEM, 0);
> -		if (res) {
> -			info->io_setup = mem_setup;
> -			info->io.addr_type = IPMI_MEM_ADDR_SPACE;
> -		}
> -	}
> -	if (!res) {
> -		dev_err(&dev->dev, "no I/O or memory address\n");
> -		goto err_free;
> -	}
> -	info->io.addr_data = res->start;
> -
> -	info->io.regspacing = DEFAULT_REGSPACING;
> -	res_second = pnp_get_resource(dev,
> -			       (info->io.addr_type == IPMI_IO_ADDR_SPACE) ?
> -					IORESOURCE_IO : IORESOURCE_MEM,
> -			       1);
> -	if (res_second) {
> -		if (res_second->start > info->io.addr_data)
> -			info->io.regspacing = res_second->start - info->io.addr_data;
> -	}
> -	info->io.regsize = DEFAULT_REGSPACING;
> -	info->io.regshift = 0;
> -
> -	/* If _GPE exists, use it; otherwise use standard interrupts */
> -	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
> -	if (ACPI_SUCCESS(status)) {
> -		info->irq = tmp;
> -		info->irq_setup = acpi_gpe_irq_setup;
> -	} else if (pnp_irq_valid(dev, 0)) {
> -		info->irq = pnp_irq(dev, 0);
> -		info->irq_setup = std_irq_setup;
> -	}
> -
> -	info->dev = &dev->dev;
> -	pnp_set_drvdata(dev, info);
> -
> -	dev_info(info->dev, "%pR regsize %d spacing %d irq %d\n",
> -		 res, info->io.regsize, info->io.regspacing,
> -		 info->irq);
> -
> -	rv = add_smi(info);
> -	if (rv)
> -		kfree(info);
> -
> -	return rv;
> -
> -err_free:
> -	kfree(info);
> -	return rv;
> -}
> -
> -static void ipmi_pnp_remove(struct pnp_dev *dev)
> -{
> -	struct smi_info *info = pnp_get_drvdata(dev);
> -
> -	cleanup_one_si(info);
> -}
> -
> -static const struct pnp_device_id pnp_dev_table[] = {
> -	{"IPI0001", 0},
> -	{"", 0},
> -};
> -
> -static struct pnp_driver ipmi_pnp_driver = {
> -	.name		= DEVICE_NAME,
> -	.probe		= ipmi_pnp_probe,
> -	.remove		= ipmi_pnp_remove,
> -	.id_table	= pnp_dev_table,
> -};
> -
> -MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
>  #endif
>  
>  #ifdef CONFIG_DMI
> @@ -2669,10 +2537,20 @@ static struct pci_driver ipmi_pci_driver = {
>  };
>  #endif /* CONFIG_PCI */
>  
> -static const struct of_device_id ipmi_match[];
> -static int ipmi_probe(struct platform_device *dev)
> -{
>  #ifdef CONFIG_OF
> +static const struct of_device_id of_ipmi_match[] =
> +{
> +	{ .type = "ipmi", .compatible = "ipmi-kcs",
> +	  .data = (void *)(unsigned long) SI_KCS },
> +	{ .type = "ipmi", .compatible = "ipmi-smic",
> +	  .data = (void *)(unsigned long) SI_SMIC },
> +	{ .type = "ipmi", .compatible = "ipmi-bt",
> +	  .data = (void *)(unsigned long) SI_BT },
> +	{},
> +};
> +
> +static int of_ipmi_probe(struct platform_device *dev)
> +{
>  	const struct of_device_id *match;
>  	struct smi_info *info;
>  	struct resource resource;
> @@ -2683,9 +2561,9 @@ static int ipmi_probe(struct platform_device *dev)
>  
>  	dev_info(&dev->dev, "probing via device tree\n");
>  
> -	match = of_match_device(ipmi_match, &dev->dev);
> +	match = of_match_device(of_ipmi_match, &dev->dev);
>  	if (!match)
> -		return -EINVAL;
> +		return -ENODEV;
>  
>  	if (!of_device_is_available(np))
>  		return -EINVAL;
> @@ -2754,33 +2632,160 @@ static int ipmi_probe(struct platform_device *dev)
>  		kfree(info);
>  		return ret;
>  	}
> -#endif
>  	return 0;
>  }
> +#else
> +#define of_ipmi_match NULL
> +static int of_ipmi_probe(struct platform_device *dev)
> +{
> +	return -ENODEV;
> +}
> +#endif
>  
> -static int ipmi_remove(struct platform_device *dev)
> +#ifdef CONFIG_ACPI
> +static int acpi_ipmi_probe(struct platform_device *dev)
>  {
> -#ifdef CONFIG_OF
> -	cleanup_one_si(dev_get_drvdata(&dev->dev));
> +	struct smi_info *info;
> +	struct resource *res, *res_second;
> +	acpi_handle handle;
> +	acpi_status status;
> +	unsigned long long tmp;
> +	int rv = -EINVAL;
> +
> +	handle = ACPI_HANDLE(&dev->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	info = smi_info_alloc();
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->addr_source = SI_ACPI;
> +	printk(KERN_INFO PFX "probing via ACPI\n");
> +
> +	info->addr_info.acpi_info.acpi_handle = handle;
> +
> +	/* _IFT tells us the interface type: KCS, BT, etc */
> +	status = acpi_evaluate_integer(handle, "_IFT", NULL, &tmp);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&dev->dev, "Could not find ACPI IPMI interface type\n");
> +		goto err_free;
> +	}
> +
> +	switch (tmp) {
> +	case 1:
> +		info->si_type = SI_KCS;
> +		break;
> +	case 2:
> +		info->si_type = SI_SMIC;
> +		break;
> +	case 3:
> +		info->si_type = SI_BT;
> +		break;
> +	case 4: /* SSIF, just ignore */
> +		rv = -ENODEV;
> +		goto err_free;
> +	default:
> +		dev_info(&dev->dev, "unknown IPMI type %lld\n", tmp);
> +		goto err_free;
> +	}
> +
> +	res = platform_get_resource(dev, IORESOURCE_IO, 0);
> +	if (res) {
> +		info->io_setup = port_setup;
> +		info->io.addr_type = IPMI_IO_ADDR_SPACE;
> +	} else {
> +		res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +		if (res) {
> +			info->io_setup = mem_setup;
> +			info->io.addr_type = IPMI_MEM_ADDR_SPACE;
> +		}
> +	}
> +	if (!res) {
> +		dev_err(&dev->dev, "no I/O or memory address\n");
> +		goto err_free;
> +	}
> +	info->io.addr_data = res->start;
> +
> +	info->io.regspacing = DEFAULT_REGSPACING;
> +	res_second = platform_get_resource(dev,
> +			       (info->io.addr_type == IPMI_IO_ADDR_SPACE) ?
> +					IORESOURCE_IO : IORESOURCE_MEM,
> +			       1);
> +	if (res_second) {
> +		if (res_second->start > info->io.addr_data)
> +			info->io.regspacing = res_second->start - info->io.addr_data;
> +	}
> +	info->io.regsize = DEFAULT_REGSPACING;
> +	info->io.regshift = 0;
> +
> +	/* If _GPE exists, use it; otherwise use standard interrupts */
> +	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
> +	if (ACPI_SUCCESS(status)) {
> +		info->irq = tmp;
> +		info->irq_setup = acpi_gpe_irq_setup;
> +	} else {
> +		int irq = platform_get_irq(dev, 0);
> +
> +		if (irq > 0) {
> +			info->irq = irq;
> +			info->irq_setup = std_irq_setup;
> +		}
> +	}
> +
> +	info->dev = &dev->dev;
> +	platform_set_drvdata(dev, info);
> +
> +	dev_info(info->dev, "%pR regsize %d spacing %d irq %d\n",
> +		 res, info->io.regsize, info->io.regspacing,
> +		 info->irq);
> +
> +	rv = add_smi(info);
> +	if (rv)
> +		kfree(info);
> +
> +	return rv;
> +
> +err_free:
> +	kfree(info);
> +	return rv;
> +}
> +
> +static struct acpi_device_id acpi_ipmi_match[] = {
> +	{ "IPI0001", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_ipmi_match);
> +#else
> +static int acpi_ipmi_probe(struct platform_device *dev)
> +{
> +	return -ENODEV;
> +}
>  #endif
> -	return 0;
> +
> +static int ipmi_probe(struct platform_device *dev)
> +{
> +	if (of_ipmi_probe(dev) == 0)
> +		return 0;
> +
> +	return acpi_ipmi_probe(dev);
>  }
>  
> -static const struct of_device_id ipmi_match[] =
> +static int ipmi_remove(struct platform_device *dev)
>  {
> -	{ .type = "ipmi", .compatible = "ipmi-kcs",
> -	  .data = (void *)(unsigned long) SI_KCS },
> -	{ .type = "ipmi", .compatible = "ipmi-smic",
> -	  .data = (void *)(unsigned long) SI_SMIC },
> -	{ .type = "ipmi", .compatible = "ipmi-bt",
> -	  .data = (void *)(unsigned long) SI_BT },
> -	{},
> -};
> +	struct smi_info *info = dev_get_drvdata(&dev->dev);
> +
> +	if (info)
> +		cleanup_one_si(info);
> +
> +	return 0;
> +}
>  
>  static struct platform_driver ipmi_driver = {
>  	.driver = {
>  		.name = DEVICE_NAME,
> -		.of_match_table = ipmi_match,
> +		.of_match_table = of_ipmi_match,
> +		.acpi_match_table = ACPI_PTR(acpi_ipmi_match),
>  	},
>  	.probe		= ipmi_probe,
>  	.remove		= ipmi_remove,
> @@ -3692,13 +3697,6 @@ static int init_ipmi_si(void)
>  	}
>  #endif
>  
> -#ifdef CONFIG_ACPI
> -	if (si_tryacpi) {
> -		pnp_register_driver(&ipmi_pnp_driver);
> -		pnp_registered = true;
> -	}
> -#endif
> -
>  #ifdef CONFIG_DMI
>  	if (si_trydmi)
>  		dmi_find_bmc();
> @@ -3850,10 +3848,6 @@ static void cleanup_ipmi_si(void)
>  	if (pci_registered)
>  		pci_unregister_driver(&ipmi_pci_driver);
>  #endif
> -#ifdef CONFIG_ACPI
> -	if (pnp_registered)
> -		pnp_unregister_driver(&ipmi_pnp_driver);
> -#endif
>  #ifdef CONFIG_PARISC
>  	if (parisc_registered)
>  		unregister_parisc_driver(&ipmi_parisc_driver);
