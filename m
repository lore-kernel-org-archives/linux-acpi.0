From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / APEI: Boot Error Record Table processing was needlessly complicated
Date: Fri, 05 May 2017 21:52:24 +0200
Message-ID: <4487859.ZpYz6V1TKk@aspire.rjw.lan>
References: <20170505181037.31668-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49053 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751284AbdEET6s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2017 15:58:48 -0400
In-Reply-To: <20170505181037.31668-1-tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

On Friday, May 05, 2017 11:10:37 AM Luck, Tony wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> Quoting version 6.1 of the ACPI specification. Section 18.3.1 "Boot
> Error Source" says:
> 
>   The Boot Error Region is a range of addressable memory OSPM can access
>   during initialization to determine if an unhandled error condition
>   occurred. System firmware must report this memory range as firmware
>   reserved. The format of the Boot Error Region follow that of an Error
>   Status Block, this is defined in Section 18.3.2.7. The format of the
>   error status block is described by Table 18-342.
> 
> This clarifies some points that were obfuscated in earlier versions.
> E.g. there is no longer a separate table to describe the format of the
> "Boot Error Region" (which was identical to the "Error Status Block").
> Also saying "follow that of *an* Error Status Block" makes it clear that
> there is just one block (which can still contain multiple "Generic Error
> Data Entry structures").
> 
> The loop inside bert_print_all() is unnecessary (but probably harmless
> as the "while (remain > sizeof(struct acpi_bert_region))" loop should
> terminate after we skipped over the first entry.
> 
> We can drop the "bert_print_all()" function and just move the four
> relevant lines inline in "bert_init()". Since there are no remaining
> users of "struct acpi_bert_region" we delete it from <acpi/actbl1.h>
> 
> Cc: Len Brown <lenb@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/bert.c | 54 +++++++-----------------------------------------
>  include/acpi/actbl1.h    | 11 +---------
>  2 files changed, 8 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> index 12771fcf0417..b28e1573d4cf 100644
> --- a/drivers/acpi/apei/bert.c
> +++ b/drivers/acpi/apei/bert.c
> @@ -34,50 +34,6 @@
>  
>  static int bert_disable;
>  
> -static void __init bert_print_all(struct acpi_bert_region *region,
> -				  unsigned int region_len)
> -{
> -	struct acpi_hest_generic_status *estatus =
> -		(struct acpi_hest_generic_status *)region;
> -	int remain = region_len;
> -	u32 estatus_len;
> -
> -	if (!estatus->block_status)
> -		return;
> -
> -	while (remain > sizeof(struct acpi_bert_region)) {
> -		if (cper_estatus_check(estatus)) {
> -			pr_err(FW_BUG "Invalid error record.\n");
> -			return;
> -		}
> -
> -		estatus_len = cper_estatus_len(estatus);
> -		if (remain < estatus_len) {
> -			pr_err(FW_BUG "Truncated status block (length: %u).\n",
> -			       estatus_len);
> -			return;
> -		}
> -
> -		pr_info_once("Error records from previous boot:\n");
> -
> -		cper_estatus_print(KERN_INFO HW_ERR, estatus);
> -
> -		/*
> -		 * Because the boot error source is "one-time polled" type,
> -		 * clear Block Status of current Generic Error Status Block,
> -		 * once it's printed.
> -		 */
> -		estatus->block_status = 0;
> -
> -		estatus = (void *)estatus + estatus_len;
> -		/* No more error records. */
> -		if (!estatus->block_status)
> -			return;
> -
> -		remain -= estatus_len;
> -	}
> -}
> -
>  static int __init setup_bert_disable(char *str)
>  {
>  	bert_disable = 1;
> @@ -89,7 +45,7 @@ __setup("bert_disable", setup_bert_disable);
>  static int __init bert_check_table(struct acpi_table_bert *bert_tab)
>  {
>  	if (bert_tab->header.length < sizeof(struct acpi_table_bert) ||
> -	    bert_tab->region_length < sizeof(struct acpi_bert_region))
> +	    bert_tab->region_length < sizeof(struct acpi_hest_generic_status))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -98,7 +54,7 @@ static int __init bert_check_table(struct acpi_table_bert *bert_tab)
>  static int __init bert_init(void)
>  {
>  	struct apei_resources bert_resources;
> -	struct acpi_bert_region *boot_error_region;
> +	struct acpi_hest_generic_status *boot_error_region;
>  	struct acpi_table_bert *bert_tab;
>  	unsigned int region_len;
>  	acpi_status status;
> @@ -138,7 +94,11 @@ static int __init bert_init(void)
>  		goto out_fini;
>  	boot_error_region = ioremap_cache(bert_tab->address, region_len);
>  	if (boot_error_region) {
> -		bert_print_all(boot_error_region, region_len);
> +		if (boot_error_region->block_status) {
> +			pr_info("Error records from previous boot:\n");
> +			cper_estatus_print(KERN_INFO HW_ERR, boot_error_region);
> +			boot_error_region->block_status = 0;
> +		}
>  		iounmap(boot_error_region);
>  	} else {
>  		rc = -ENOMEM;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index b4ce55c008b0..cf0bd26774aa 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -127,16 +127,7 @@ struct acpi_table_bert {
>  	struct acpi_table_header header;	/* Common ACPI table header */
>  	u32 region_length;	/* Length of the boot error region */
>  	u64 address;		/* Physical address of the error region */
> -};
> -
> -/* Boot Error Region (not a subtable, pointed to by Address field above) */
> -
> -struct acpi_bert_region {
> -	u32 block_status;	/* Type of error information */
> -	u32 raw_data_offset;	/* Offset to raw error data */
> -	u32 raw_data_length;	/* Length of raw error data */
> -	u32 data_length;	/* Length of generic error data */
> -	u32 error_severity;	/* Severity code */
> +				/* which is a struct acpi_hest_generic_status */
>  };
>  
>  /* Values for block_status flags above */
> 

The actbl1.h change should be routed through the upstream ACPICA I think
after we've dropped all things depending on it from the kernel.

Thanks,
Rafael

