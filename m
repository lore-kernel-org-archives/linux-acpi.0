From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH v1 5/5] ipmi: add PNP discovery (ACPI namespace via
	PNPACPI)
Date: Fri, 27 Nov 2009 15:50:19 +0800
Message-ID: <1259308219.3810.7.camel@localhost.localdomain>
References: <20091118000427.14214.14043.stgit@bob.kio>
	 <20091118000534.14214.99332.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25129 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbZK0Hvx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Nov 2009 02:51:53 -0500
In-Reply-To: <20091118000534.14214.99332.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <myron.stowe@hp.com>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, Len Brown <lenb@kernel.org>

On Wed, 2009-11-18 at 08:05 +0800, Bjorn Helgaas wrote:
> This allows ipmi_si_intf.c to claim IPMI devices described in the ACPI
> namespace.  Using PNP makes it simpler to parse the IRQ/IO/memory resources
> of the device.

Hi, Bjorn
    Will you please try to push this patch set that detects the IPMI
device defined in ACPI namespace by using Pnp device driver? This is
related with the IPMI subsystem.
    I test it on one server. It can detect the IPMI system interface
defined in ACPI namespace correctly. And it can also work correctly with
the my second patch that enables the ACPI AML code to communicate with
the IPMI device.  

    A small concern is whether we can complain some warning message when
there exist both the GPE and interrupt for the IPMI device. According to
the IPMI 2.0 spec this is disallowed to define both the GPE and
interrupt irq for the same IPMI system interface.

Thanks.
   Yakui

> 
> We look at any SPMI tables before looking for devices in the namespace.
> 
> This is based on ipmi_pci_probe().
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c |  104 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 104 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index b58e587..679cd08 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -64,6 +64,7 @@
>  #include <linux/dmi.h>
>  #include <linux/string.h>
>  #include <linux/ctype.h>
> +#include <linux/pnp.h>
>  
>  #ifdef CONFIG_PPC_OF
>  #include <linux/of_device.h>
> @@ -2023,6 +2024,103 @@ static __devinit void spmi_find_bmc(void)
>  		try_init_spmi(spmi);
>  	}
>  }
> +
> +static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
> +				    const struct pnp_device_id *dev_id)
> +{
> +	struct acpi_device *acpi_dev;
> +	struct smi_info *info;
> +	acpi_handle handle;
> +	acpi_status status;
> +	unsigned long long tmp;
> +
> +	acpi_dev = pnp_acpi_device(dev);
> +	if (!acpi_dev)
> +		return -ENODEV;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->addr_source = "ACPI";
> +
> +	handle = acpi_dev->handle;
> +
> +	/* _IFT tells us the interface type: KCS, BT, etc */
> +	status = acpi_evaluate_integer(handle, "_IFT", NULL, &tmp);
> +	if (ACPI_FAILURE(status))
> +		goto err_free;
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
> +	default:
> +		dev_info(&dev->dev, "unknown interface type %lld\n", tmp);
> +		goto err_free;
> +	}
> +
> +	if (pnp_port_valid(dev, 0)) {
> +		info->io_setup = port_setup;
> +		info->io.addr_type = IPMI_IO_ADDR_SPACE;
> +		info->io.addr_data = pnp_port_start(dev, 0);
> +	} else if (pnp_mem_valid(dev, 0)) {
> +		info->io_setup = mem_setup;
> +		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
> +		info->io.addr_data = pnp_mem_start(dev, 0);
> +	} else {
> +		dev_err(&dev->dev, "no I/O or memory address\n");
> +		goto err_free;
> +	}
> +
> +	info->io.regspacing = DEFAULT_REGSPACING;
> +	info->io.regsize = DEFAULT_REGSPACING;
> +	info->io.regshift = 0;
> +
> +	/* If _GPE exists, use it; otherwise use standard interrupts */
> +	status = acpi_evaluate_integer(handle, "_GPE", NULL, &tmp);
> +	if (ACPI_SUCCESS(status)) {
> +		info->irq = tmp;
> +		info->irq_setup = acpi_gpe_irq_setup;

Had better complain some warning message when the interrupt irq is found
for IPMI system interface.
> +	} else if (pnp_irq_valid(dev, 0)) {
> +		info->irq = pnp_irq(dev, 0);
> +		info->irq_setup = std_irq_setup;
> +	}
> +
> +	info->dev = &acpi_dev->dev;
> +	pnp_set_drvdata(dev, info);
> +
> +	return try_smi_init(info);
> +
> +err_free:
> +	kfree(info);
> +	return -EINVAL;
> +}
> +
> +static void __devexit ipmi_pnp_remove(struct pnp_dev *dev)
> +{
> +	struct smi_info *info = pnp_get_drvdata(dev);
> +
> +	cleanup_one_si(info);
> +}
> +
> +static const struct pnp_device_id pnp_dev_table[] = {
> +	{"IPI0001", 0},
> +	{"", 0},
> +};
> +
> +static struct pnp_driver ipmi_pnp_driver = {
> +	.name		= DEVICE_NAME,
> +	.probe		= ipmi_pnp_probe,
> +	.remove		= __devexit_p(ipmi_pnp_remove),
> +	.id_table	= pnp_dev_table,
> +};
>  #endif
>  
>  #ifdef CONFIG_DMI
> @@ -3106,6 +3204,9 @@ static __devinit int init_ipmi_si(void)
>  #ifdef CONFIG_ACPI
>  	spmi_find_bmc();
>  #endif
> +#ifdef CONFIG_PNP
> +	pnp_register_driver(&ipmi_pnp_driver);
> +#endif
>  
>  #ifdef CONFIG_PCI
>  	rv = pci_register_driver(&ipmi_pci_driver);
> @@ -3229,6 +3330,9 @@ static __exit void cleanup_ipmi_si(void)
>  #ifdef CONFIG_PCI
>  	pci_unregister_driver(&ipmi_pci_driver);
>  #endif
> +#ifdef CONFIG_PNP
> +	pnp_unregister_driver(&ipmi_pnp_driver);
> +#endif
>  
>  #ifdef CONFIG_PPC_OF
>  	of_unregister_platform_driver(&ipmi_of_platform_driver);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

