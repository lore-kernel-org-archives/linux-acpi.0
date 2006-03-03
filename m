From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [Pcihpd-discuss] [RFC][PATCH] acpiphp: configure _PRT - V2
Date: Fri, 03 Mar 2006 10:04:34 -0800
Message-ID: <1141409074.5649.2.camel@whizzy>
References: <874q2f4wfr.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:15034 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161003AbWCCR6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Mar 2006 12:58:53 -0500
In-Reply-To: <874q2f4wfr.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: pcihpd-discuss@lists.sourceforge.net, Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, len.brown@intel.com

On Fri, 2006-03-03 at 20:08 +0900, MUNEDA Takahiro wrote:
> Hi,
> 
> Here is a take2 patch of "acpiphp: confiugre _PRT".
> The difference between the first patch is only the part of
> acpiphp_dock.c. The part of acpiphp_glue.c is not changed.
> 
> I could not get answer about the device without _STA method.
> If you have any good idea, please let me know. Here is a
> question which I described in my previous mail.
> 
> > But, if the devices do not have the _STA method, this patch
> > makes strange conditions. If the PCI device is hotplugged
> > once, there is no acpi_device struct. But if the PCI device
> > is not hotplugged yet, there is acpi_device struct.
> > 
> > I want to know this strange conditions are allowed or not.
> > Any comments are welcomed.
> 
> Attached patch is against 2.6.16-rc5-mm1 plus following patches.
> 
>  o Kristen's latest patch set
>  o Kenji's acpiphp: Scan slots under the nested P2P bridge
> 
> I tested this patch on my tiger4 box except for dock eject
> case, because I don't have any pc which has _DCK method.
> 
> Thanks,
> MUNE
> 
> --
> Current acpiphp does not free acpi_device structs when the
> PCI devices are removed. When the PCI device is added,
> acpi_bus_add() fails because acpi_device struct has already
> exists. So, _PRT method does not evaluate.
> 
> This patch fixes this issue.
> 
> Signed-off-by: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
> 
>  drivers/pci/hotplug/acpiphp_glue.c |   70 ++++++++++++++++---------------------
>  1 files changed, 32 insertions(+), 38 deletions(-)
> 
> Index: linux-2.6.16-rc5-mm1/drivers/pci/hotplug/acpiphp_glue.c
> ===================================================================
> --- linux-2.6.16-rc5-mm1.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ linux-2.6.16-rc5-mm1/drivers/pci/hotplug/acpiphp_glue.c
> @@ -841,36 +841,6 @@ static unsigned char acpiphp_max_busnr(s
>  }
>  
> 
> -
> -/**
> - *  get_func - get a pointer to acpiphp_func given a slot, device
> - *  @slot: slot to search
> - *  @dev:  pci_dev struct to match.
> - *
> - *  This function will increase the reference count of pci_dev,
> - *  so callers should call pci_dev_put when complete.
> - *
> - */
> -static struct acpiphp_func *
> -get_func(struct acpiphp_slot *slot, struct pci_dev *dev)
> -{
> -	struct acpiphp_func *func = NULL;
> -	struct pci_bus *bus = slot->bridge->pci_bus;
> -	struct pci_dev *pdev;
> -
> -	list_for_each_entry(func, &slot->funcs, sibling) {
> -		pdev = pci_get_slot(bus, PCI_DEVFN(slot->device,
> -					func->function));
> -		if (pdev) {
> -			if (pdev == dev)
> -				break;
> -			pci_dev_put(pdev);
> -		}
> -	}
> -	return func;
> -}
> -
> -
>  /**
>   * acpiphp_bus_add - add a new bus to acpi subsystem
>   * @func: acpiphp_func of the bridge
> @@ -917,6 +887,28 @@ acpiphp_bus_add_out:
>  }
>  
> 
> +/**
> + * acpiphp_bus_trim - trim a bus from acpi subsystem
> + * @handle: handle to acpi namespace
> + *
> + */
> +int acpiphp_bus_trim(acpi_handle handle)
> +{
> +	struct acpi_device *device;
> +	int retval;
> +
> +	retval = acpi_bus_get_device(handle, &device);
> +	if (retval) {
> +		dbg("acpi_device not found\n");
> +		return retval;
> +	}
> +
> +	retval = acpi_bus_trim(device, 1);
> +	if (retval)
> +		err("cannot remove from acpi list\n");
> +
> +	return 0;
> +}
>  
>  /**
>   * enable_device - enable, configure a slot
> @@ -963,19 +955,17 @@ static int enable_device(struct acpiphp_
>  			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
>  			    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
>  				max = pci_scan_bridge(bus, dev, max, pass);
> -				if (pass && dev->subordinate) {
> +				if (pass && dev->subordinate)
>  					pci_bus_size_bridges(dev->subordinate);
> -					func = get_func(slot, dev);
> -					if (func) {
> -						acpiphp_bus_add(func);
> -						/* side effect of get_func */
> -						pci_dev_put(dev);
> -					}
> -				}
>  			}
>  		}
>  	}
>  
> +	list_for_each (l, &slot->funcs) {
> +		func = list_entry(l, struct acpiphp_func, sibling);
> +		acpiphp_bus_add(func);
> +	}
> +
>  	pci_bus_assign_resources(bus);
>  	acpiphp_sanitize_bus(bus);
>  	pci_enable_bridges(bus);
> @@ -1012,6 +1002,10 @@ static int disable_device(struct acpiphp
>  
>  	list_for_each (l, &slot->funcs) {
>  		func = list_entry(l, struct acpiphp_func, sibling);
> +
> +		if (acpiphp_bus_trim(func->handle))
> +			continue;
> +
>  		if (!func->pci_dev)
>  			continue;
>  

So, this seems unlikely to me, but I just wanted to double check:  Is it
possible that acpiphp_bus_trim will ever return an error, but there is a
pci_dev struct that exists for this func?  If that's the case, then
wouldn't this leave a reference to pci_dev around since pci_dev_put
would never be called?

