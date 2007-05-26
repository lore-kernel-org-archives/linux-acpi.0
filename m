From: Richard Knutsson <ricknu-0@student.ltu.se>
Subject: Re: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations
 replaced with ARRAY_SIZE
Date: Sat, 26 May 2007 13:37:42 +0200
Message-ID: <46581C06.7000005@student.ltu.se>
References: <200705261239.27485.lists-receive@programmierforen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:54488 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbXEZLfR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 May 2007 07:35:17 -0400
In-Reply-To: <200705261239.27485.lists-receive@programmierforen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Drebes <lists-receive@programmierforen.de>
Cc: kernel-janitors@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org

Andi Drebes wrote:
> This patch replaces lines in the acpi subsystem that use
> sizeof/sizeof to determine the size of an array with the
> ARRAY_SIZE(x) macro.
>
> Signed-off-by: Andi Drebes <lists-receive@programmierforen.de>
> ---
> Compile tested with allyesconfig on i386.
> Diffed against Linus' git-tree.
>
>
> diff --git a/drivers/acpi/resources/rsdump.c b/drivers/acpi/resources/rsdump.c
> index 46da116..7b8e12d 100644
> --- a/drivers/acpi/resources/rsdump.c
> +++ b/drivers/acpi/resources/rsdump.c
> @@ -76,7 +76,7 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
>  
>  #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
>  #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
> -#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
> +#define ACPI_RSD_TABLE_SIZE(name)   (ARRAY_SIZE(name))
>   
Any reason to not just replace ACPI_RSD_TABLE_SIZE with ARRAY_SIZE? Got 
just 21 instances of it in the file (+ the define) and no more in the 
rest of the tree.
>  
>  /*******************************************************************************
>   *
> diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
> index 1285e91..4d59de2 100644
> --- a/drivers/acpi/tables/tbfadt.c
> +++ b/drivers/acpi/tables/tbfadt.c
> @@ -104,7 +104,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
>  	 ACPI_FADT_OFFSET(gpe1_block_length), ACPI_FADT_SEPARATE_LENGTH}
>  };
>  
> -#define ACPI_FADT_INFO_ENTRIES        (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
> +#define ACPI_FADT_INFO_ENTRIES        (ARRAY_SIZE(fadt_info_table))
>   
Normally I think this is ok when it is just a "constant", since the name 
of it may be more descriptive, but it is just used twice and I find 
(imho) ARRAY_SIZE(fadt_info_table) easier to understand.
>  
>  /*******************************************************************************
>   *
>   
cu
Richard Knutsson

