From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / table: Add new function to get table entries
Date: Wed, 26 Nov 2014 23:14:11 +0100
Message-ID: <3690114.UPTfuA83uf@vostro.rjw.lan>
References: <1417010474-2399-1-git-send-email-hanjun.guo@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57787 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753359AbaKZVw5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2014 16:52:57 -0500
In-Reply-To: <1417010474-2399-1-git-send-email-hanjun.guo@linaro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On Wednesday, November 26, 2014 10:01:13 PM Hanjun Guo wrote:
> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> 
> The acpi_table_parse() function has a callback that
> passes a pointer to a table_header. Add a new function
> which takes this pointer and parses its entries. This
> eliminates the need to re-traverse all the tables for
> each call. e.g. as in acpi_table_parse_madt() which is
> normally called after acpi_table_parse().
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/tables.c | 63 +++++++++++++++++++++++++++++++++++----------------
>  include/linux/acpi.h  |  4 ++++
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 6d5a6cd..f1debe9 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -190,30 +190,24 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  	}
>  }
>  
> -
>  int __init
> -acpi_table_parse_entries(char *id,
> -			     unsigned long table_size,
> -			     int entry_id,
> -			     acpi_tbl_entry_handler handler,
> -			     unsigned int max_entries)
> +acpi_parse_entries(char *id, unsigned long table_size,

Why isn't this static?  Are you going to use it somewhere else?

> +		acpi_tbl_entry_handler handler,
> +		struct acpi_table_header *table_header,
> +		int entry_id, unsigned int max_entries)
>  {
> -	struct acpi_table_header *table_header = NULL;
>  	struct acpi_subtable_header *entry;
> -	unsigned int count = 0;
> +	int count = 0;
>  	unsigned long table_end;
> -	acpi_size tbl_size;
>  
>  	if (acpi_disabled)
>  		return -ENODEV;
>  
> -	if (!handler)
> +	if (!id || !handler)
>  		return -EINVAL;
>  
> -	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
> -		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
> -	else
> -		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
> +	if (!table_size)
> +		return -EINVAL;
>  
>  	if (!table_header) {
>  		pr_warn("%4.4s not present\n", id);
> @@ -232,7 +226,7 @@ acpi_table_parse_entries(char *id,
>  		if (entry->type == entry_id
>  		    && (!max_entries || count++ < max_entries))
>  			if (handler(entry, table_end))
> -				goto err;
> +				return -EINVAL;
>  
>  		/*
>  		 * If entry->length is 0, break from this loop to avoid
> @@ -240,22 +234,53 @@ acpi_table_parse_entries(char *id,
>  		 */
>  		if (entry->length == 0) {
>  			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
> -			goto err;
> +			return -EINVAL;
>  		}
>  
>  		entry = (struct acpi_subtable_header *)
>  		    ((unsigned long)entry + entry->length);
>  	}
> +
>  	if (max_entries && count > max_entries) {
>  		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
>  			id, entry_id, count - max_entries, count);
>  	}
>  
> -	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
>  	return count;
> -err:
> +}
> +
> +int __init
> +acpi_table_parse_entries(char *id,
> +			 unsigned long table_size,
> +			 int entry_id,
> +			 acpi_tbl_entry_handler handler,
> +			 unsigned int max_entries)
> +{
> +	struct acpi_table_header *table_header = NULL;
> +	acpi_size tbl_size;
> +	int count;
> +	u32 instance = 0;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	if (!id || !handler)
> +		return -EINVAL;
> +
> +	if (!strncmp(id, ACPI_SIG_MADT, 4))
> +		instance = acpi_apic_instance;
> +
> +	acpi_get_table_with_size(id, instance, &table_header, &tbl_size);
> +	if (!table_header) {
> +		pr_warn("%4.4s not present\n", id);
> +		return -ENODEV;
> +	}
> +
> +	count = acpi_parse_entries(id, table_size, handler, table_header,
> +			entry_id, max_entries);
> +
>  	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
> -	return -EINVAL;
> +	return count;
>  }
>  
>  int __init
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index e09f7f4..d7a5fcf 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -124,6 +124,10 @@ int acpi_numa_init (void);
>  
>  int acpi_table_init (void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
> +int __init acpi_parse_entries(char *id, unsigned long table_size,
> +			      acpi_tbl_entry_handler handler,
> +			      struct acpi_table_header *table_header,
> +			      int entry_id, unsigned int max_entries);
>  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>  				    int entry_id,
>  				    acpi_tbl_entry_handler handler,
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
