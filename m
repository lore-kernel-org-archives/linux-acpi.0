From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Sun, 6 Nov 2011 14:42:15 +0100
Message-ID: <201111061442.16192.rjw@sisk.pl>
References: <20110929215907.21126.24480.stgit@amt.stowe> <CAL-B5D0Dp8AoMUUJxy58EMdL0k0LRwJ_xa3XRdGT32qrhR0D+g@mail.gmail.com> <201111050342.58975.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53043 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab1KFNjj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Nov 2011 08:39:39 -0500
In-Reply-To: <201111050342.58975.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On Saturday, November 05, 2011, Thomas Renninger wrote:
> On Saturday 05 November 2011 00:54:39 Myron Stowe wrote:
> ...
> > > Still, if Windows has duplicated code for APEI GAR handling (with
> > > additional mask value, for example ignoring bit width) and does it
> > > slightly different than they do it in other parts,
> > > we also might not come around APEI specific GAR checking/workarounds.
> > >
> > 
> > I've hit a snag - hopefully I'm just not seeing something obvious so I thought
> > I would relay what I'm encountering and see if you or Bjorn have any ideas.
> I see that this is yet another nasty problem of trying to let APEI use generic
> acpi_read/write funcs.
> 
> ...
>  
> > Thomas - this issue exists with either conversion approach (my approach of
> > getting acpi_read()/acpi_write() augmented to handle 'bit_offset' values and
> > using those or your idea of copying acpi_atomicio_read()/acpi_atomicio_write(),
> > changing their names to apei_read()/apei_write(), augmenting those to
> > handle 'bit_offset' values and using them).
> I can't see how it affects the two steps approach (if generic read/write could
> ever get used... The main and really nice win of your patches is getting
> rid of the duplicated and complicated/complex pre_map stuff).
> 
> What about below patch which even already compiles, it should work with your
> atomicio.c removal one(s) (but not without!)?

I haven't analysed it in detail, but it looks like it should work.

> Why would bit_offset handling need to be inside read/write funcs?

Because of the warning we wanted to remove?

> It could be done as before.

Yes, and I think it pretty much has to be done this way if the
APEI_EXEC_PRESERVE_REGISTER is to be handled correctly.

Thanks,
Rafael


> ---
>  drivers/acpi/apei/apei-base.c     |   91 +++++++++++++++++++++++++++++++++++-
>  drivers/acpi/apei/apei-internal.h |    3 +
>  drivers/acpi/apei/ghes.c          |    2 +-
>  drivers/acpi/atomicio.c           |   42 -----------------
>  include/acpi/atomicio.h           |    3 -
>  5 files changed, 92 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 6154036..9be1a58 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -70,7 +70,7 @@ int __apei_exec_read_register(struct acpi_whea_header *entry, u64 *val)
>  {
>  	int rc;
>  
> -	rc = acpi_atomic_read(val, &entry->register_region);
> +	rc = apei_gar_read(val, &entry->register_region);
>  	if (rc)
>  		return rc;
>  	*val >>= entry->register_region.bit_offset;
> @@ -116,13 +116,13 @@ int __apei_exec_write_register(struct acpi_whea_header *entry, u64 val)
>  	val <<= entry->register_region.bit_offset;
>  	if (entry->flags & APEI_EXEC_PRESERVE_REGISTER) {
>  		u64 valr = 0;
> -		rc = acpi_atomic_read(&valr, &entry->register_region);
> +		rc = apei_gar_read(&valr, &entry->register_region);
>  		if (rc)
>  			return rc;
>  		valr &= ~(entry->mask << entry->register_region.bit_offset);
>  		val |= valr;
>  	}
> -	rc = acpi_atomic_write(val, &entry->register_region);
> +	rc = apei_gar_write(val, &entry->register_region);
>  
>  	return rc;
>  }
> @@ -553,6 +553,91 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr)
>  	return 0;
>  }
>  
> +int apei_gar_read(u64 *val, struct acpi_generic_address *reg)
> +{
> +	u64 paddr;
> +	int rc;
> +	u32 tmp_val;
> +	acpi_status status;
> +	u32 width = reg->bit_width;
> +
> +	if (width == 64)
> +		width = 32;	/* Break into two 32-bit transfers */
> +
> +	rc = apei_check_gar(reg, &paddr);
> +	if (rc)
> +		return rc;
> +
> +	*val = 0;
> +	switch (reg->space_id) {
> +	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
> +		/* This part is copy and pasted from acpi_read */
> +		status = acpi_os_read_memory((acpi_physical_address)
> +					     paddr, &tmp_val, width);
> +		if (ACPI_FAILURE(status))
> +			return -EIO;
> +		*val = tmp_val;
> +
> +		if (reg->bit_width == 64) {
> +
> +			/* Read the top 32 bits */
> +
> +			status = acpi_os_read_memory((acpi_physical_address)
> +				     (paddr + 4), &tmp_val, 32);
> +			if (ACPI_FAILURE(status))
> +				return -EIO;
> +			*val |= ((u64)tmp_val << 32);
> +		}
> +	case ACPI_ADR_SPACE_SYSTEM_IO:
> +		status = acpi_os_read_port(paddr, (u32 *)val, reg->bit_width);
> +		if (ACPI_FAILURE(status))
> +		    return -EIO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(apei_gar_read);
> +
> +int apei_gar_write(u64 val, struct acpi_generic_address *reg)
> +{
> +	u64 paddr;
> +	int rc;
> +	acpi_status status;
> +	u32 width = reg->bit_width;
> +
> +	if (width == 64)
> +		width = 32;	/* Break into two 32-bit transfers */
> +
> +	rc = apei_check_gar(reg, &paddr);
> +	if (rc)
> +		return rc;
> +
> +	switch (reg->space_id) {
> +	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
> +		/* This part is copy and pasted from acpi_write */
> +		status = acpi_os_write_memory((acpi_physical_address)
> +					      paddr, ACPI_LODWORD(val), width);
> +
> +		if (ACPI_FAILURE(status))
> +			return -EIO;
> +
> +		if (reg->bit_width == 64) {
> +			status = acpi_os_write_memory((acpi_physical_address)
> +				      (paddr + 4), ACPI_HIDWORD(val), 32);
> +
> +			if (ACPI_FAILURE(status))
> +				return -EIO;
> +		}
> +	case ACPI_ADR_SPACE_SYSTEM_IO:
> +		status = acpi_os_write_port(paddr, val, reg->bit_width);
> +		if (ACPI_FAILURE(status))
> +		    return -EIO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(apei_gar_write);
> +
>  static int collect_res_callback(struct apei_exec_context *ctx,
>  				struct acpi_whea_header *entry,
>  				void *data)
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index f57050e..0380cf7 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -68,6 +68,9 @@ static inline int apei_exec_run_optional(struct apei_exec_context *ctx, u8 actio
>  /* IP has been set in instruction function */
>  #define APEI_EXEC_SET_IP	1
>  
> +int apei_gar_read(u64 *val, struct acpi_generic_address *reg);
> +int apei_gar_write(u64 val, struct acpi_generic_address *reg);
> +
>  int __apei_exec_read_register(struct acpi_whea_header *entry, u64 *val);
>  int __apei_exec_write_register(struct acpi_whea_header *entry, u64 val);
>  int apei_exec_read_register(struct apei_exec_context *ctx,
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b8e08cb..4273b2f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -399,7 +399,7 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
>  	u32 len;
>  	int rc;
>  
> -	rc = acpi_atomic_read(&buf_paddr, &g->error_status_address);
> +	rc = apei_gar_read(&buf_paddr, &g->error_status_address);
>  	if (rc) {
>  		if (!silent && printk_ratelimit())
>  			pr_warning(FW_WARN GHES_PFX
> diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
> index 7489b89..2fb3fc0 100644
> --- a/drivers/acpi/atomicio.c
> +++ b/drivers/acpi/atomicio.c
> @@ -321,45 +321,3 @@ static int acpi_atomic_write_mem(u64 paddr, u64 val, u32 width)
>  
>  	return 0;
>  }
> -
> -/* GAR accessing in atomic (including NMI) or process context */
> -int acpi_atomic_read(u64 *val, struct acpi_generic_address *reg)
> -{
> -	u64 paddr;
> -	int rc;
> -
> -	rc = acpi_check_gar(reg, &paddr, 1);
> -	if (rc)
> -		return rc;
> -
> -	*val = 0;
> -	switch (reg->space_id) {
> -	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
> -		return acpi_atomic_read_mem(paddr, val, reg->bit_width);
> -	case ACPI_ADR_SPACE_SYSTEM_IO:
> -		return acpi_os_read_port(paddr, (u32 *)val, reg->bit_width);
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(acpi_atomic_read);
> -
> -int acpi_atomic_write(u64 val, struct acpi_generic_address *reg)
> -{
> -	u64 paddr;
> -	int rc;
> -
> -	rc = acpi_check_gar(reg, &paddr, 1);
> -	if (rc)
> -		return rc;
> -
> -	switch (reg->space_id) {
> -	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
> -		return acpi_atomic_write_mem(paddr, val, reg->bit_width);
> -	case ACPI_ADR_SPACE_SYSTEM_IO:
> -		return acpi_os_write_port(paddr, val, reg->bit_width);
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(acpi_atomic_write);
> diff --git a/include/acpi/atomicio.h b/include/acpi/atomicio.h
> index 8b9fb4b..e38090c 100644
> --- a/include/acpi/atomicio.h
> +++ b/include/acpi/atomicio.h
> @@ -4,7 +4,4 @@
>  int acpi_pre_map_gar(struct acpi_generic_address *reg);
>  int acpi_post_unmap_gar(struct acpi_generic_address *reg);
>  
> -int acpi_atomic_read(u64 *val, struct acpi_generic_address *reg);
> -int acpi_atomic_write(u64 val, struct acpi_generic_address *reg);
> -
>  #endif
> 
> 

