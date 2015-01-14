From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: tbinstal: Remove unused function
Date: Wed, 14 Jan 2015 08:49:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026B7443@SHSMSX101.ccr.corp.intel.com>
References: <1421174925-5796-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421174925-5796-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, "Moore, Robert" <robert.moore@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi, Rickard

This function contains logic that is only correct to iasl.
It seems we can move it to a separate file that can only be linked by iasl to avoid releasing this function to the kernel.
Let me do this in the ACPICA upstream.

Thanks
-Lv

> From: Rickard Strandqvist [mailto:rickard_strandqvist@spectrumdigital.se]
> Sent: Wednesday, January 14, 2015 2:49 AM
> To: Moore, Robert; Zheng, Lv
> Cc: Rickard Strandqvist; Wysocki, Rafael J; Len Brown; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] ACPICA: tbinstal: Remove unused function
> 
> Remove the function acpi_tb_store_table() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/acpi/acpica/actables.h |    5 -----
>  drivers/acpi/acpica/tbinstal.c |   37 -------------------------------------
>  2 files changed, 42 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
> index 1afe46e..7d65cac 100644
> --- a/drivers/acpi/acpica/actables.h
> +++ b/drivers/acpi/acpica/actables.h
> @@ -119,11 +119,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
>  			       u8 flags,
>  			       u8 reload, u8 override, u32 *table_index);
> 
> -acpi_status
> -acpi_tb_store_table(acpi_physical_address address,
> -		    struct acpi_table_header *table,
> -		    u32 length, u8 flags, u32 *table_index);
> -
>  void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
> 
>  void acpi_tb_terminate(void);
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
> index 755b90c..a998e8c 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -455,43 +455,6 @@ finish_override:
> 
>  /*******************************************************************************
>   *
> - * FUNCTION:    acpi_tb_store_table
> - *
> - * PARAMETERS:  address             - Table address
> - *              table               - Table header
> - *              length              - Table length
> - *              flags               - Install flags
> - *              table_index         - Where the table index is returned
> - *
> - * RETURN:      Status and table index.
> - *
> - * DESCRIPTION: Add an ACPI table to the global table list
> - *
> - ******************************************************************************/
> -
> -acpi_status
> -acpi_tb_store_table(acpi_physical_address address,
> -		    struct acpi_table_header * table,
> -		    u32 length, u8 flags, u32 *table_index)
> -{
> -	acpi_status status;
> -	struct acpi_table_desc *table_desc;
> -
> -	status = acpi_tb_get_next_root_index(table_index);
> -	if (ACPI_FAILURE(status)) {
> -		return (status);
> -	}
> -
> -	/* Initialize added table */
> -
> -	table_desc = &acpi_gbl_root_table_list.tables[*table_index];
> -	acpi_tb_init_table_descriptor(table_desc, address, flags, table);
> -	table_desc->pointer = table;
> -	return (AE_OK);
> -}
> -
> -/*******************************************************************************
> - *
>   * FUNCTION:    acpi_tb_uninstall_table
>   *
>   * PARAMETERS:  table_desc          - Table descriptor
> --
> 1.7.10.4
