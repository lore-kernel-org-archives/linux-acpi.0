From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2] ACPICA: Detect duplicate SSDT tables
Date: Wed, 15 Mar 2017 01:13:01 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE4A41C@SHSMSX101.ccr.corp.intel.com>
References: <20170314204556.16099-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42445 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbdCOBNG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Mar 2017 21:13:06 -0400
In-Reply-To: <20170314204556.16099-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi, Hans

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hans de
> Goede
> Subject: [PATCH v2] ACPICA: Detect duplicate SSDT tables
> 
> Some machines have the exact (byte for byte) same SSDT tables multiple
> times in the root_table_list. Detect this and silently skip the duplicates
> rather then printing a scary looking set of errors.

The problems are:
1. ACPICA messes up table install sanity check and table load sanity check.
   For table install check, we only need to check address and table type (physical address or virtual address).
   For table load check, we may do byte for byte comparison.
2. ACPICA only implements table load sanity check for Load opcode, it doesn't cover LoadTable opcode and static loaded tables.

So this really needs not only the following change, but a slight bigger one.

Thanks and best regards
Lv

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use existing acpi_tb_compare_tables helper
> ---
>  drivers/acpi/acpica/actables.h |  2 ++
>  drivers/acpi/acpica/tbinstal.c |  6 +-----
>  drivers/acpi/acpica/tbxfload.c | 27 ++++++++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
> index c8da453..d50437c 100644
> --- a/drivers/acpi/acpica/actables.h
> +++ b/drivers/acpi/acpica/actables.h
> @@ -99,6 +99,8 @@ acpi_tb_find_table(char *signature,
>  /*
>   * tbinstal - Table removal and deletion
>   */
> +u8 acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
> +
>  acpi_status acpi_tb_resize_root_table_list(void);
> 
>  acpi_status acpi_tb_validate_table(struct acpi_table_desc *table_desc);
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
> index 4620f3c..1431bfa 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -48,10 +48,6 @@
>  #define _COMPONENT          ACPI_TABLES
>  ACPI_MODULE_NAME("tbinstal")
> 
> -/* Local prototypes */
> -static u8
> -acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
> -
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_tb_compare_tables
> @@ -66,7 +62,7 @@ acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index);
>   *
>   ******************************************************************************/
> 
> -static u8
> +u8
>  acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
>  {
>  	acpi_status status = AE_OK;
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index b71ce3b..2f718b0 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -125,6 +125,30 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
> 
>  /*******************************************************************************
>   *
> + * FUNCTION:    acpi_tb_find_duplicate_ssdt
> + *
> + * PARAMETERS:  table         - validated acpi_table_desc of table to check
> + *              index         - index of table to find a duplicate of
> + *
> + * RETURN:      TRUE if a duplicate is found, FALSE if not
> + *
> + * DESCRIPTION: Private helper function for acpi_tb_load_namespace to
> + *              avoid trying to load duplicate ssdt tables
> + *
> + ******************************************************************************/
> +static u8 acpi_tb_find_duplicate_ssdt(struct acpi_table_desc *table, u32 index)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < index; ++i)
> +		if (acpi_tb_compare_tables(table, i))
> +			return TRUE;
> +
> +	return FALSE;
> +}
> +
> +/*******************************************************************************
> + *
>   * FUNCTION:    acpi_tb_load_namespace
>   *
>   * PARAMETERS:  None
> @@ -212,7 +236,8 @@ acpi_status acpi_tb_load_namespace(void)
>  					   ACPI_SIG_PSDT)
>  		     && !ACPI_COMPARE_NAME(table->signature.ascii,
>  					   ACPI_SIG_OSDT))
> -		    || ACPI_FAILURE(acpi_tb_validate_table(table))) {
> +		    || ACPI_FAILURE(acpi_tb_validate_table(table))
> +		    || acpi_tb_find_duplicate_ssdt(table, i)) {
>  			continue;
>  		}
> 
> --
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
