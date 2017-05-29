From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] acpi: configfs: Unload SSDT on configfs entry removal
Date: Mon, 29 May 2017 15:47:55 +0300
Message-ID: <20170529124755.GR2784@lahna.fi.intel.com>
References: <5f535371-1053-09c3-25b4-0b75a79a0ff5@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:47808 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbdE2MsB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 May 2017 08:48:01 -0400
Content-Disposition: inline
In-Reply-To: <5f535371-1053-09c3-25b4-0b75a79a0ff5@siemens.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@acpica.org, Bob Moore <robert.moore@intel.com>

On Mon, May 29, 2017 at 01:33:29PM +0200, Jan Kiszka wrote:
> Enhance acpi_load_table to also return the table index. Use that index
> to unload the table again when the corresponding directory in configfs
> gets removed. This allows to change SSDTs without rebooting the system.
> It also allows to destroy devices again that a dynamically loaded SSDT
> created.
> 
> This is widely similar to the DT overlay behavior.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Can someone explain to me why an unloaded table still sticks around in
> sysfs and why we cannot release its ID and rather have to use a new one
> when loading a modified version?

IIRC ACPICA relies the fact that SSDTs are never unloaded. Bob (CC'd)
can correct me if I got it wrong.

>  drivers/acpi/acpi_configfs.c      | 12 +++++++++++-
>  drivers/acpi/acpica/dbfileio.c    |  2 +-
>  drivers/acpi/acpica/tbxfload.c    | 38 +++++++++++++++++++++++++++++++++++---
>  drivers/firmware/efi/efi.c        |  2 +-
>  drivers/pci/hotplug/sgi_hotplug.c |  2 +-
>  include/acpi/acpixf.h             |  6 +++++-
>  6 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 146a77fb762d..dac8dbf16cc0 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -20,6 +20,7 @@ static struct config_group *acpi_table_group;
>  struct acpi_table {
>  	struct config_item cfg;
>  	struct acpi_table_header *header;
> +	u32 index;
>  };
>  
>  static ssize_t acpi_table_aml_write(struct config_item *cfg,
> @@ -52,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>  	if (!table->header)
>  		return -ENOMEM;
>  
> -	ret = acpi_load_table(table->header);
> +	ret = acpi_load_table(table->header, &table->index);
>  	if (ret) {
>  		kfree(table->header);
>  		table->header = NULL;
> @@ -215,8 +216,17 @@ static struct config_item *acpi_table_make_item(struct config_group *group,
>  	return &table->cfg;
>  }
>  
> +static void acpi_table_drop_item(struct config_group *group,
> +				 struct config_item *cfg)
> +{
> +	struct acpi_table *table = container_of(cfg, struct acpi_table, cfg);
> +
> +	acpi_unload_table(table->index);
> +}
> +
>  struct configfs_group_operations acpi_table_group_ops = {
>  	.make_item = acpi_table_make_item,
> +	.drop_item = acpi_table_drop_item,
>  };
>  
>  static struct config_item_type acpi_tables_type = {
> diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
> index 4d81ea291d93..4486ec8b995b 100644
> --- a/drivers/acpi/acpica/dbfileio.c
> +++ b/drivers/acpi/acpica/dbfileio.c
> @@ -129,7 +129,7 @@ acpi_status acpi_db_load_tables(struct acpi_new_table_desc *list_head)
>  	while (table_list_head) {
>  		table = table_list_head->table;
>  
> -		status = acpi_load_table(table);
> +		status = acpi_load_table(table, NULL);
>  		if (ACPI_FAILURE(status)) {
>  			if (status == AE_ALREADY_EXISTS) {
>  				acpi_os_printf
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index b71ce3b817ea..44e719303b58 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -304,6 +304,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>   *
>   * PARAMETERS:  table               - Pointer to a buffer containing the ACPI
>   *                                    table to be loaded.
> + *              table_index         - Pointer to a variable receiving the table
> + *                                    index, or NULL.
>   *
>   * RETURN:      Status
>   *
> @@ -314,10 +316,10 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
>   *              to ensure that the table is not deleted or unmapped.
>   *
>   ******************************************************************************/
> -acpi_status acpi_load_table(struct acpi_table_header *table)
> +acpi_status acpi_load_table(struct acpi_table_header *table, u32 *table_index)
>  {
> +	u32 table_index_dummy;
>  	acpi_status status;
> -	u32 table_index;
>  
>  	ACPI_FUNCTION_TRACE(acpi_load_table);
>  
> @@ -327,12 +329,15 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>  		return_ACPI_STATUS(AE_BAD_PARAMETER);
>  	}
>  
> +	if (!table_index)
> +		table_index = &table_index_dummy;
> +
>  	/* Install the table and load it into the namespace */
>  
>  	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
>  	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>  						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
> -						FALSE, &table_index);
> +						FALSE, table_index);
>  	return_ACPI_STATUS(status);
>  }
>  
> @@ -340,6 +345,33 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
>  
>  /*******************************************************************************
>   *
> + * FUNCTION:    acpi_unload_table
> + *
> + * PARAMETERS:  table_index         - Index of the table to be unloaded.
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Unloads the table and deletes all namespace objects associated
> + *              with that table. Unloading of the DSDT is not allowed.
> + *              Note: Mainly intended to support hotplug removal of SSDTs.
> + *
> + ******************************************************************************/
> +acpi_status acpi_unload_table(u32 table_index)
> +{
> +	ACPI_FUNCTION_TRACE(acpi_unload_table);
> +
> +	if (!table_index) {
> +		return_ACPI_STATUS(AE_BAD_PARAMETER);
> +	}
> +
> +	ACPI_INFO(("Host-directed Dynamic ACPI Table Unload:"));
> +	return acpi_tb_unload_table(table_index);
> +}
> +
> +ACPI_EXPORT_SYMBOL(acpi_unload_table)
> +
> +/*******************************************************************************
> + *
>   * FUNCTION:    acpi_unload_parent_table
>   *
>   * PARAMETERS:  object              - Handle to any namespace object owned by
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index b372aad3b449..8681c5536bfc 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -274,7 +274,7 @@ static __init int efivar_ssdt_load(void)
>  			goto free_data;
>  		}
>  
> -		ret = acpi_load_table(data);
> +		ret = acpi_load_table(data, NULL);
>  		if (ret) {
>  			pr_err("failed to load table: %d\n", ret);
>  			goto free_data;
> diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
> index 339bce0403dd..57d627d699b4 100644
> --- a/drivers/pci/hotplug/sgi_hotplug.c
> +++ b/drivers/pci/hotplug/sgi_hotplug.c
> @@ -355,7 +355,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
>  	if (SN_ACPI_BASE_SUPPORT() && ssdt) {
>  		acpi_status ret;
>  
> -		ret = acpi_load_table((struct acpi_table_header *)ssdt);
> +		ret = acpi_load_table((struct acpi_table_header *)ssdt, NULL);
>  		if (ACPI_FAILURE(ret)) {
>  			printk(KERN_ERR "%s: acpi_load_table failed (0x%x)\n",
>  			       __func__, ret);
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 15c86ce4df53..8d36a9a72532 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -487,7 +487,11 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>  					       u8 physical))
>  
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> -			    acpi_load_table(struct acpi_table_header *table))
> +			    acpi_load_table(struct acpi_table_header *table,
> +					    u32 *table_index))
> +
> +ACPI_EXTERNAL_RETURN_STATUS(acpi_status
> +			    acpi_unload_table(u32 table_index))
>  
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>  			    acpi_unload_parent_table(acpi_handle object))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
