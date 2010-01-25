From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 10/12] ACPI: processor: refactor internal
 map_lsapic_id()
Date: Mon, 25 Jan 2010 14:22:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1001251421440.27862@chino.kir.corp.google.com>
References: <20100125213221.28510.74078.stgit@bob.kio> <20100125214129.28510.72412.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754142Ab0AYWW3@vger.kernel.org>
In-Reply-To: <20100125214129.28510.72412.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 25 Jan 2010, Alex Chiang wrote:

> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 9213f95..ec5989c 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -83,27 +83,17 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>  {
>  	struct acpi_madt_local_sapic *lsapic =
>  		(struct acpi_madt_local_sapic *)entry;
> -	u32 tmp = (lsapic->id << 8) | lsapic->eid;
>  
> -	/* Only check enabled APICs*/
>  	if (!(lsapic->lapic_flags & ACPI_MADT_ENABLED))
>  		return 0;
>  
> -	/* Device statement declaration type */
>  	if (device_declaration) {
> -		if (entry->length < 16)
> -			printk(KERN_ERR PREFIX
> -			    "Invalid LSAPIC with Device type processor (SAPIC ID %#x)\n",
> -			    tmp);

Why drop this error message?

> -		else if (lsapic->uid == acpi_id)
> -			goto found;
> -	/* Processor statement declaration type */
> -	} else if (lsapic->processor_id == acpi_id)
> -		goto found;
> +		if ((entry->length < 16) || (lsapic->uid != acpi_id))
> +			return 0;
> +	} else if (lsapic->processor_id != acpi_id)
> +		return 0;
>  
> -	return 0;
> -found:
> -	*apic_id = tmp;
> +	*apic_id = (lsapic->id << 8) | lsapic->eid;
>  	return 1;
>  }
>  
