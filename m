From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PNPACPI: truncate _CRS windows with _LEN > _MAX - _MIN + 1
Date: Thu, 25 Mar 2010 21:19:33 +0100
Message-ID: <201003252119.33497.rjw@sisk.pl>
References: <20100325163249.11395.76426.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51310 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664Ab0CYUQY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Mar 2010 16:16:24 -0400
In-Reply-To: <20100325163249.11395.76426.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bob Moore <robert.moore@intel.com>, Adam Belay <abelay@mit.edu>, linux-acpi@vger.kernel.org

On Thursday 25 March 2010, Bjorn Helgaas wrote:
> 
> The ACPI spec (sec 6.4.3.5 in v4.0) requires that for Address Space Resource
> Descriptors, _LEN <= _MAX - _MIN + 1 in all cases, but there are BIOSes that
> violate this.  We experimentally determined that Windows truncates the
> resource so it doesn't extend past _MAX, so let's do the same thing in
> Linux.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=15480
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
> 
>  drivers/pnp/pnpacpi/rsparser.c |   42 +++++++++++++++++++++++++++++-----------
>  1 files changed, 30 insertions(+), 12 deletions(-)
> 
> 
> diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
> index 54514aa..fe5bfa9 100644
> --- a/drivers/pnp/pnpacpi/rsparser.c
> +++ b/drivers/pnp/pnpacpi/rsparser.c
> @@ -273,12 +273,33 @@ static void pnpacpi_parse_allocated_busresource(struct pnp_dev *dev,
>  	pnp_add_bus_resource(dev, start, end);
>  }
>  
> +static u64 addr_space_length(struct pnp_dev *dev, u64 min, u64 max, u64 len)
> +{
> +	u64 max_len;
> +
> +	max_len = max - min + 1;
> +	if (len <= max_len)
> +		return len;
> +
> +	/*
> +	 * Per 6.4.3.5, _LEN cannot exceed _MAX - _MIN + 1, but some BIOSes
> +	 * don't do this correctly, e.g.,
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=15480
> +	 */
> +	dev_info(&dev->dev,
> +	         "resource length %#llx doesn't fit in %#llx-%#llx, trimming\n",
> +		 (unsigned long long) len, (unsigned long long) min,
> +		 (unsigned long long) max);
> +	return max_len;
> +}
> +
>  static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
>  						  struct acpi_resource *res)
>  {
>  	struct acpi_resource_address64 addr, *p = &addr;
>  	acpi_status status;
>  	int window;
> +	u64 len;
>  
>  	status = acpi_resource_to_address64(res, p);
>  	if (!ACPI_SUCCESS(status)) {
> @@ -287,20 +308,18 @@ static void pnpacpi_parse_allocated_address_space(struct pnp_dev *dev,
>  		return;
>  	}
>  
> +	len = addr_space_length(dev, p->minimum, p->maximum, p->address_length);
>  	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
>  
>  	if (p->resource_type == ACPI_MEMORY_RANGE)
> -		pnpacpi_parse_allocated_memresource(dev,
> -			p->minimum, p->address_length,
> +		pnpacpi_parse_allocated_memresource(dev, p->minimum, len,
>  			p->info.mem.write_protect, window);
>  	else if (p->resource_type == ACPI_IO_RANGE)
> -		pnpacpi_parse_allocated_ioresource(dev,
> -			p->minimum, p->address_length,
> +		pnpacpi_parse_allocated_ioresource(dev, p->minimum, len,
>  			p->granularity == 0xfff ? ACPI_DECODE_10 :
>  				ACPI_DECODE_16, window);
>  	else if (p->resource_type == ACPI_BUS_NUMBER_RANGE)
> -		pnpacpi_parse_allocated_busresource(dev, p->minimum,
> -						    p->address_length);
> +		pnpacpi_parse_allocated_busresource(dev, p->minimum, len);
>  }
>  
>  static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev *dev,
> @@ -308,21 +327,20 @@ static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev *dev,
>  {
>  	struct acpi_resource_extended_address64 *p = &res->data.ext_address64;
>  	int window;
> +	u64 len;
>  
> +	len = addr_space_length(dev, p->minimum, p->maximum, p->address_length);
>  	window = (p->producer_consumer == ACPI_PRODUCER) ? 1 : 0;
>  
>  	if (p->resource_type == ACPI_MEMORY_RANGE)
> -		pnpacpi_parse_allocated_memresource(dev,
> -			p->minimum, p->address_length,
> +		pnpacpi_parse_allocated_memresource(dev, p->minimum, len,
>  			p->info.mem.write_protect, window);
>  	else if (p->resource_type == ACPI_IO_RANGE)
> -		pnpacpi_parse_allocated_ioresource(dev,
> -			p->minimum, p->address_length,
> +		pnpacpi_parse_allocated_ioresource(dev, p->minimum, len,
>  			p->granularity == 0xfff ? ACPI_DECODE_10 :
>  				ACPI_DECODE_16, window);
>  	else if (p->resource_type == ACPI_BUS_NUMBER_RANGE)
> -		pnpacpi_parse_allocated_busresource(dev, p->minimum,
> -						    p->address_length);
> +		pnpacpi_parse_allocated_busresource(dev, p->minimum, len);
>  }
>  
>  static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
> 
> 
> 

