From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH -v2 2/2] ACPI, APEI, PCIE AER, use general HEST table
 parsing in AER firmware_first setup
Date: Fri, 12 Mar 2010 12:43:01 +0900
Message-ID: <4B99B845.70600@jp.fujitsu.com>
References: <1268273698-21940-1-git-send-email-ying.huang@intel.com> <1268273698-21940-2-git-send-email-ying.huang@intel.com> <1268273698-21940-3-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:40203 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab0CLDn7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Mar 2010 22:43:59 -0500
In-Reply-To: <1268273698-21940-3-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

(2010/03/11 11:14), Huang Ying wrote:
> -EXPORT_SYMBOL_GPL(acpi_hest_firmware_first_pci);
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -134,4 +134,13 @@ static inline int aer_osc_setup(struct p
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI_APEI
> +extern void aer_set_firmware_first(struct pci_dev *pci_dev);
> +#else
> +static inline void aer_set_firmware_first(struct pci_dev *pci_dev)
> +{
> +	pci_dev->__aer_firmware_first_valid = 1;
> +}
> +#endif
> +
>  #endif /* _AERDRV_H_ */

How about having aer_get_firmware_first() in this header too?

> --- a/drivers/pci/pcie/aer/aerdrv_acpi.c
> +++ b/drivers/pci/pcie/aer/aerdrv_acpi.c
 :
> +#ifdef CONFIG_ACPI_APEI
 :
> +void aer_set_firmware_first(struct pci_dev *pci_dev)
> +{
 :
> +}
> +#endif
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -30,12 +30,19 @@ static int nosourceid;
>  module_param(forceload, bool, 0);
>  module_param(nosourceid, bool, 0);
>  
> +static int pcie_aer_get_firmware_first(struct pci_dev *dev)
> +{
> +	if (!dev->__aer_firmware_first_valid)
> +		aer_set_firmware_first(dev);
> +	return dev->__aer_firmware_first;
> +}
> +

Then you can put pcie_aer_get_firmware_first() to next to
pcie_aer_set_firmware_first() in aerdrv_acpi.c, which is
the best file for these functions I think.

> @@ -872,7 +879,7 @@ out:
>  	if (forceload) {
>  		dev_printk(KERN_DEBUG, &dev->device,
>  			   "aerdrv forceload requested.\n");
> -		dev->port->aer_firmware_first = 0;
> +		dev->port->__aer_firmware_first = 0;
>  		return 0;
>  	}
>  	return -ENXIO;

I'd like to see a purpose-oriented method here, something like
pcie_aer_force_firmware_first_to(dev, forcedvalue).

Or, it would be more better, change pcie_aer_set_firmware_first()
(= currently used by APEI only) to static with better name.

E.g. 
  Before:		After:

  # get a flag that tells @dev is firmware first or not
    pcie_aer_get_firmware_first(dev)
			=> pcie_aer_get_firmware_first(dev) # no change

  # set a flag that tells @dev is firmware first or not
    dev->port->__aer_firmware_first = X
			=> pcie_aer_set_firmware_first(dev, X)

  # parse hest to know @dev is firmware first or not
    pcie_aer_set_firmware_first(dev)
			=> aer_parse_hest_for(dev)

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -311,7 +311,8 @@ struct pci_dev {
>  	unsigned int	is_virtfn:1;
>  	unsigned int	reset_fn:1;
>  	unsigned int    is_hotplug_bridge:1;
> -	unsigned int    aer_firmware_first:1;
> +	unsigned int    __aer_firmware_first_valid:1;
> +	unsigned int	__aer_firmware_first:1;
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */

BTW, what the prefix "__" for?

I recommend you to separate this 2/2 patch into 2 pieces,
one for PCI addressed to Jesse, and another is for ACPI.
i.e.:

 [PATCH] PCIE, AER: arrange pcie_aer_{get,set}_firmware_first
 [PATCH 1/2] ACPI, APEI: Make APEI core configurable built-in
 [PATCH 2/2] ACPI, APEI: use general HEST table parsing in AER

You can make 3rd patch to contain only *acpi* changes, remove of
acpi/hest.c and modify of pcie/aer/aerdrv_acpi.c.
Then it will be easy-to-pull for Len, right?


Thanks,
H.Seto

