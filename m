From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Detect duplicate SSDT tables
Date: Tue, 28 Feb 2017 05:19:03 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE430EF@SHSMSX101.ccr.corp.intel.com>
References: <20170227093432.3308-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32575 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751659AbdB1Fbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Feb 2017 00:31:35 -0500
In-Reply-To: <20170227093432.3308-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Subject: [PATCH] ACPICA: Detect duplicate SSDT tables
> 
> Some machines have the exact (byte for byte) same SSDT tables multiple
> times in the root_table_list.

Could you give a machine list here?

> Detect this and silently skip the duplicates
> rather then printing a scary looking set of errors.

Why will this matter to OSPMs?
And should we add non-costless steps just in order to reduce errors,
while the errors are on the contrary useful (indicating platform issues)?

Thanks
Lv

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpica/tbxfload.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index 82019c0..1971cd7 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -125,6 +125,44 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
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
> +	struct acpi_table_desc *dup;
> +	u32 i;
> +
> +	for (i = 0; i < index; ++i) {
> +		dup = &acpi_gbl_root_table_list.tables[i];
> +
> +		if (!acpi_gbl_root_table_list.tables[i].address ||
> +		    (!ACPI_COMPARE_NAME(dup->signature.ascii, ACPI_SIG_SSDT)
> +		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
> +					   ACPI_SIG_PSDT)
> +		     && !ACPI_COMPARE_NAME(dup->signature.ascii,
> +					   ACPI_SIG_OSDT))
> +		    || ACPI_FAILURE(acpi_tb_validate_table(dup))
> +		    || dup->length != table->length) {
> +			continue;
> +		}
> +
> +		if (memcmp(dup->pointer, table->pointer, table->length) == 0)
> +			return TRUE;
> +	}
> +	return FALSE;
> +}
> +
> +/*******************************************************************************
> + *
>   * FUNCTION:    acpi_tb_load_namespace
>   *
>   * PARAMETERS:  None
> @@ -212,7 +250,8 @@ acpi_status acpi_tb_load_namespace(void)
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

