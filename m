From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v3 2/2] PCI Hotplug: acpiphp: get pci_bus from acpi handle correctly
Date: Fri, 24 Jul 2009 10:35:58 -0600
Message-ID: <200907241035.59208.bjorn.helgaas@hp.com>
References: <20090723230026.4247.12759.stgit@bob.kio> <20090723230305.4247.81288.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:43759 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbZGXQgR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2009 12:36:17 -0400
In-Reply-To: <20090723230305.4247.81288.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: jbarnes@virtuousgeek.org, lenb@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday 23 July 2009 05:03:05 pm Alex Chiang wrote:
> We cannot simply call acpi_get_pci_dev() on any random ACPI handle
> and hope that it works, because a PCI root bridge may not have
> an associated struct pci_dev.
> 
> This is allowed per the PCI specification, and is referred to as a
> non-materialized bridge.
> 
> So, depending on the type of PCI bridge that the handle points to,
> use the appropriate interface to return the struct pci_bus correctly.
> 
> Signed-off-by: Alex Chiang <achiang@hp.com>

Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

> ---
> 
>  drivers/pci/hotplug/acpiphp_glue.c |   28 +++++++++++++++++-----------
>  1 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 0cb0f83..2e5f259 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -62,6 +62,22 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus);
>  static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
>  static void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context);
>  
> +static struct pci_bus *pci_bus_from_handle(acpi_handle handle)
> +{
> +	struct pci_bus *pbus;
> +	struct acpi_pci_root *root;
> +
> +	root = acpi_pci_find_root(handle);
> +	if (root)
> +		pbus = root->bus;
> +	else {
> +		struct pci_dev *pdev = acpi_get_pci_dev(handle);
> +		pbus = pdev->subordinate;
> +		pci_dev_put(pdev);
> +	}
> +	return pbus;
> +}
> +
>  /* callback routine to check for the existence of a pci dock device */
>  static acpi_status
>  is_pci_dock_device(acpi_handle handle, u32 lvl, void *context, void **rv)
> @@ -1387,16 +1403,7 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
>  /* Program resources in newly inserted bridge */
>  static int acpiphp_configure_bridge (acpi_handle handle)
>  {
> -	struct pci_dev *dev;
> -	struct pci_bus *bus;
> -
> -	dev = acpi_get_pci_dev(handle);
> -	if (!dev) {
> -		err("cannot get PCI domain and bus number for bridge\n");
> -		return -EINVAL;
> -	}
> -
> -	bus = dev->bus;
> +	struct pci_bus *bus = pci_bus_from_handle(handle);
>  
>  	pci_bus_size_bridges(bus);
>  	pci_bus_assign_resources(bus);
> @@ -1404,7 +1411,6 @@ static int acpiphp_configure_bridge (acpi_handle handle)
>  	acpiphp_set_hpp_values(handle, bus);
>  	pci_enable_bridges(bus);
>  	acpiphp_configure_ioapics(handle);
> -	pci_dev_put(dev);
>  	return 0;
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


