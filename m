From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] 2.4.23-pre3 ACPI fixes series (2/3)
Date: Fri, 5 Sep 2003 21:25:17 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD1D@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks Andrew,

I pulled this one into the acpi patch when I got back from vacation
earlier this week.  Should be tested with the rest for a few days and if
all goes well pushed mid next week.

Cheers,
-Len

> -----Original Message-----
> From: Andrew de Quincey [mailto:adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org] 
> Sent: Friday, September 05, 2003 8:16 PM
> To: Jeff Garzik
> Cc: torvalds-3NddpPZAyC0@public.gmane.org; lkml; 
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-acpi
> Subject: [PATCH] 2.4.23-pre3 ACPI fixes series (2/3)
> 
> 
> This patch retries IRQ programming with an extended IRQ 
> resource descriptor
> if using a standard IRQ descriptor fails.
> 
> 
> --- linux-2.4.23-pre3.picmode/drivers/acpi/pci_link.c	
> 2003-09-05 23:54:45.522947816 +0100
> +++ linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c	
> 2003-09-05 23:54:59.945755216 +0100
> @@ -290,7 +290,8 @@
>  	struct acpi_buffer	buffer = {sizeof(resource)+1, 
> &resource};
>  	int			i = 0;
>  	int			valid = 0;
> -
> +	int			resource_type = 0;
> +   
>  	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
>  
>  	if (!link || !irq)
> @@ -312,13 +313,24 @@
>  			return_VALUE(-EINVAL);
>  		}
>  	}
> + 
> +	/* If IRQ<=15, first try with a "normal" IRQ 
> descriptor. If that fails, try with
> +	 * an extended one */
> +	if (irq <= 15) {
> +		resource_type = ACPI_RSTYPE_IRQ;
> +	} else {
> +		resource_type = ACPI_RSTYPE_EXT_IRQ;
> +	}
> +
> +retry_programming:
>     
>  	memset(&resource, 0, sizeof(resource));
>  
>  	/* NOTE: PCI interrupts are always level / active_low / 
> shared. But not all
>  	   interrupts > 15 are PCI interrupts. Rely on the ACPI 
> IRQ definition for 
>  	   parameters */
> -	if (irq <= 15) {	
> +	switch(resource_type) {
> +	case ACPI_RSTYPE_IRQ:
>  		resource.res.id = ACPI_RSTYPE_IRQ;
>  		resource.res.length = sizeof(struct acpi_resource);
>  		resource.res.data.irq.edge_level = link->irq.edge_level;
> @@ -326,8 +338,9 @@
>  		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
>  		resource.res.data.irq.number_of_interrupts = 1;
>  		resource.res.data.irq.interrupts[0] = irq;
> -	}
> -	else {
> +		break;
> +	 
> +	case ACPI_RSTYPE_EXT_IRQ:
>  		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
>  		resource.res.length = sizeof(struct acpi_resource);
>  		
> resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
> @@ -337,11 +350,21 @@
>  		resource.res.data.extended_irq.number_of_interrupts = 1;
>  		resource.res.data.extended_irq.interrupts[0] = irq;
>  		/* ignore resource_source, it's optional */
> +		break;
>  	}
>  	resource.end.id = ACPI_RSTYPE_END_TAG;
>  
>  	/* Attempt to set the resource */
>  	status = acpi_set_current_resources(link->handle, &buffer);
> +   
> +	/* if we failed and IRQ <= 15, try again with an 
> extended descriptor */
> +	if (ACPI_FAILURE(status) && (resource_type == 
> ACPI_RSTYPE_IRQ)) {
> +                resource_type = ACPI_RSTYPE_EXT_IRQ;
> +                printk(PREFIX "Retrying with extended IRQ 
> descriptor\n");
> +                goto retry_programming;
> +	}
> +
> +	/* check for total failure */
>  	if (ACPI_FAILURE(status)) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error 
> evaluating _SRS\n"));
>  		return_VALUE(-ENODEV);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
