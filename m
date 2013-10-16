From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Resend PATCH 3/5] ACPI: Add new
 acpi_dev_resource_address_space_full() function
Date: Wed, 16 Oct 2013 17:18:36 -0600
Message-ID: <20131016231836.GC17866@google.com>
References: <1381493941-4650-1-git-send-email-tianyu.lan@intel.com>
 <1381493941-4650-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46285 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760702Ab3JPXSj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2013 19:18:39 -0400
Received: by mail-ie0-f176.google.com with SMTP id u16so2561955iet.21
        for <linux-acpi@vger.kernel.org>; Wed, 16 Oct 2013 16:18:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381493941-4650-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com
Cc: lenb@kernel.org, rjw@sisk.pl, yinghai@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 11, 2013 at 08:18:59PM +0800, tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> Make acpi_dev_resource_address_space() to accept struct
> acpi_resource_address64 as param and rename it to *_full.
> 
> This is for some cases that acpi address info is also needed
> after convert from acpi resouce to generic resource.

s/resouce/resource/

> Add acpi_dev_resource_addres_space() again as a wrapper of new

acpi_dev_resource_address_space() (spelled wrong above).

> function for original users.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/resource.c | 53 ++++++++++++++++++++++++++++++++++---------------
>  include/linux/acpi.h    |  3 +++
>  2 files changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 84bc3db..2e395ba 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -162,19 +162,21 @@ bool acpi_dev_resource_io(struct acpi_resource *ares, struct resource *res)
>  EXPORT_SYMBOL_GPL(acpi_dev_resource_io);
>  
>  /**
> - * acpi_dev_resource_address_space - Extract ACPI address space information.
> + * acpi_dev_resource_address_space_full - Extract ACPI address space information.
>   * @ares: Input ACPI resource object.
> + * @addr: Output ACPI resource address64 space object.
>   * @res: Output generic resource object.
>   *
>   * Check if the given ACPI resource object represents an address space resource
> - * and if that's the case, use the information in it to populate the generic
> - * resource object pointed to by @res.
> + * and if that's the case, convert it to ACPI resource address64 space object
> + * pointed to by @addr and use the information to populate the generic resource
> + * object pointed to by @re.

s/@re/@res/ or maybe even just use this:

"If @ares is an address space resource, convert it to an
acpi_resource_address64 and use that to populate the generic @res."

>   */
> -bool acpi_dev_resource_address_space(struct acpi_resource *ares,
> +bool acpi_dev_resource_address_space_full(struct acpi_resource *ares,
> +				     struct acpi_resource_address64 *addr,
>  				     struct resource *res)
>  {
>  	acpi_status status;
> -	struct acpi_resource_address64 addr;
>  	bool window;
>  	u64 len;
>  	u8 io_decode;
> @@ -188,29 +190,29 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>  		return false;
>  	}
>  
> -	status = acpi_resource_to_address64(ares, &addr);
> +	status = acpi_resource_to_address64(ares, addr);
>  	if (ACPI_FAILURE(status))
>  		return true;

You didn't actually change this, but it looks wrong to return "true"
here, because we haven't filled in "res".  Returning "true" will cause
acpi_dev_process_resource() to call acpi_dev_new_resource_entry() with
a struct resource that's full of zeroes.

I think the best fix would be to remove this code just above:

        switch (ares->type) {
        case ACPI_RESOURCE_TYPE_ADDRESS16:
        case ACPI_RESOURCE_TYPE_ADDRESS32:
        case ACPI_RESOURCE_TYPE_ADDRESS64:
                break;
        default:
                return false;
        }

and return "false" if acpi_resource_to_address64() fails.

>  
> -	res->start = addr.minimum + addr.translation_offset;
> -	res->end = addr.maximum + addr.translation_offset;
> -	window = addr.producer_consumer == ACPI_PRODUCER;
> +	res->start = addr->minimum + addr->translation_offset;
> +	res->end = addr->maximum + addr->translation_offset;
> +	window = addr->producer_consumer == ACPI_PRODUCER;
>  
> -	switch(addr.resource_type) {
> +	switch (addr->resource_type) {
>  	case ACPI_MEMORY_RANGE:
> -		len = addr.maximum - addr.minimum + 1;
> +		len = addr->maximum - addr->minimum + 1;
>  		res->flags = acpi_dev_memresource_flags(len,
> -						addr.info.mem.write_protect,
> +						addr->info.mem.write_protect,
>  						window);
>  
> -		if (addr.info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
> +		if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
>  			res->flags |= IORESOURCE_PREFETCH;
>  		break;
>  	case ACPI_IO_RANGE:
> -		io_decode = addr.granularity == 0xfff ?
> +		io_decode = addr->granularity == 0xfff ?
>  				ACPI_DECODE_10 : ACPI_DECODE_16;
> -		res->flags = acpi_dev_ioresource_flags(addr.minimum,
> -						       addr.maximum,
> +		res->flags = acpi_dev_ioresource_flags(addr->minimum,
> +						       addr->maximum,
>  						       io_decode, window);
>  		break;
>  	case ACPI_BUS_NUMBER_RANGE:
> @@ -222,6 +224,25 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(acpi_dev_resource_address_space_full);
> +
> +/**
> + * acpi_dev_resource_address_space - Extract ACPI address space information.
> + * @ares: Input ACPI resource object.
> + * @res: Output generic resource object.
> + *
> + * Check if the given ACPI resource object represents an address space resource
> + * and if that's the case, use the information in it to populate the generic
> + * resource object pointed to by @res.

"If @ares is an address space resource, use it to populate the generic @res."

> + */
> +bool acpi_dev_resource_address_space(struct acpi_resource *ares,
> +				     struct resource *res)
> +{
> +	struct acpi_resource_address64 addr;
> +
> +	return acpi_dev_resource_address_space_full(ares, &addr,
> +							 res);
> +}
>  EXPORT_SYMBOL_GPL(acpi_dev_resource_address_space);
>  
>  /**
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a5db4ae..1f6701e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -260,6 +260,9 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res);
>  bool acpi_dev_resource_io(struct acpi_resource *ares, struct resource *res);
>  bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>  				     struct resource *res);
> +bool acpi_dev_resource_address_space_full(struct acpi_resource *ares,
> +				struct acpi_resource_address64 *addr,
> +				struct resource *res);
>  bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
>  					 struct resource *res);
>  unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
> -- 
> 1.8.2.1
> 
