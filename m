From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] ACPI: Recode the acpi_get_pci_rootbridge_handle() to boot faster
Date: Fri, 12 Jan 2007 12:10:19 -0700
Message-ID: <200701121210.19779.bjorn.helgaas@hp.com>
References: <BD66F1A3AD5256419EBBAAA492578482E224D5@G3W0068.americas.hpqcorp.net> <200612061017.10405.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:42728 "EHLO atlrel6.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964950AbXALTK0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jan 2007 14:10:26 -0500
In-Reply-To: <200612061017.10405.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Justin" <justin.chen@hp.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, "Li, Shaohua" <shaohua.li@intel.com>

On Wednesday 06 December 2006 10:17, Bjorn Helgaas wrote:
> Here's a non-line-wrapped version.  Justin sent this yesterday
> but it didn't make it to the list for some reason, so I'm
> trying again.

Ping!  Any reaction to this?  It makes a BIG difference in
boot time on large system.s

> Move acpi_get_pci_rootbridge_handle() from glue.c to pci_root.c and get the
> root bridge acpi handles by searching the &acpi_pci_roots list instead of
> walking through the ACPI name space.  This significantly reduces boot time
> on large I/O systems.
> 
> Signed-off-by: Justin Chen <justin.chen@hp.com>
> 
> diff -Nru a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> --- a/drivers/acpi/pci_root.c	2006-11-29 13:57:37.000000000 -0800
> +++ b/drivers/acpi/pci_root.c	2006-12-04 14:41:14.551395167 -0800
> @@ -116,6 +116,19 @@
>  
>  EXPORT_SYMBOL(acpi_pci_unregister_driver);
>  
> +acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
> +{
> +	struct acpi_pci_root *tmp;
> +	
> +	list_for_each_entry(tmp, &acpi_pci_roots, node) {
> +		if ((tmp->id.segment == (u16) seg) && (tmp->id.bus == (u16) bus))
> +			return tmp->device->handle;
> +	}
> +	return NULL;		
> +}
> +
> +EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
> +
>  static acpi_status
>  get_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
>  {
> diff -Nru a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> --- a/drivers/acpi/glue.c	2006-12-04 14:42:53.067995523 -0800
> +++ b/drivers/acpi/glue.c	2006-12-04 14:44:42.723267617 -0800
> @@ -86,125 +86,6 @@
>  	return ret;
>  }
>  
> -/* Get PCI root bridge's handle from its segment and bus number */
> -struct acpi_find_pci_root {
> -	unsigned int seg;
> -	unsigned int bus;
> -	acpi_handle handle;
> -};
> -
> -static acpi_status
> -do_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
> -{
> -	unsigned long *busnr = (unsigned long *)data;
> -	struct acpi_resource_address64 address;
> -
> -	if (resource->type != ACPI_RESOURCE_TYPE_ADDRESS16 &&
> -	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS32 &&
> -	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS64)
> -		return AE_OK;
> -
> -	acpi_resource_to_address64(resource, &address);
> -	if ((address.address_length > 0) &&
> -	    (address.resource_type == ACPI_BUS_NUMBER_RANGE))
> -		*busnr = address.minimum;
> -
> -	return AE_OK;
> -}
> -
> -static int get_root_bridge_busnr(acpi_handle handle)
> -{
> -	acpi_status status;
> -	unsigned long bus, bbn;
> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -
> -	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> -
> -	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL,
> -				       &bbn);
> -	if (status == AE_NOT_FOUND) {
> -		/* Assume bus = 0 */
> -		printk(KERN_INFO PREFIX
> -		       "Assume root bridge [%s] bus is 0\n",
> -		       (char *)buffer.pointer);
> -		status = AE_OK;
> -		bbn = 0;
> -	}
> -	if (ACPI_FAILURE(status)) {
> -		bbn = -ENODEV;
> -		goto exit;
> -	}
> -	if (bbn > 0)
> -		goto exit;
> -
> -	/* _BBN in some systems return 0 for all root bridges */
> -	bus = -1;
> -	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> -				     do_root_bridge_busnr_callback, &bus);
> -	/* If _CRS failed, we just use _BBN */
> -	if (ACPI_FAILURE(status) || (bus == -1))
> -		goto exit;
> -	/* We select _CRS */
> -	if (bbn != bus) {
> -		printk(KERN_INFO PREFIX
> -		       "_BBN and _CRS returns different value for %s. Select _CRS\n",
> -		       (char *)buffer.pointer);
> -		bbn = bus;
> -	}
> -      exit:
> -	kfree(buffer.pointer);
> -	return (int)bbn;
> -}
> -
> -static acpi_status
> -find_pci_rootbridge(acpi_handle handle, u32 lvl, void *context, void **rv)
> -{
> -	struct acpi_find_pci_root *find = (struct acpi_find_pci_root *)context;
> -	unsigned long seg, bus;
> -	acpi_status status;
> -	int tmp;
> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -
> -	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> -
> -	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL, &seg);
> -	if (status == AE_NOT_FOUND) {
> -		/* Assume seg = 0 */
> -		status = AE_OK;
> -		seg = 0;
> -	}
> -	if (ACPI_FAILURE(status)) {
> -		status = AE_CTRL_DEPTH;
> -		goto exit;
> -	}
> -
> -	tmp = get_root_bridge_busnr(handle);
> -	if (tmp < 0) {
> -		printk(KERN_ERR PREFIX
> -		       "Find root bridge failed for %s\n",
> -		       (char *)buffer.pointer);
> -		status = AE_CTRL_DEPTH;
> -		goto exit;
> -	}
> -	bus = tmp;
> -
> -	if (seg == find->seg && bus == find->bus)
> -		find->handle = handle;
> -	status = AE_OK;
> -      exit:
> -	kfree(buffer.pointer);
> -	return status;
> -}
> -
> -acpi_handle acpi_get_pci_rootbridge_handle(unsigned int seg, unsigned int bus)
> -{
> -	struct acpi_find_pci_root find = { seg, bus, NULL };
> -
> -	acpi_get_devices(PCI_ROOT_HID_STRING, find_pci_rootbridge, &find, NULL);
> -	return find.handle;
> -}
> -EXPORT_SYMBOL_GPL(acpi_get_pci_rootbridge_handle);
> -
>  /* Get device's handler per its address under its parent */
>  struct acpi_find_child {
>  	acpi_handle handle;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
