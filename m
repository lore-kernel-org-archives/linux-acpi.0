From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v3] acpi: configfs: Unload SSDT on configfs entry removal
Date: Tue, 4 Jul 2017 08:14:09 +0200
Message-ID: <ba9505c1-1412-42be-9af7-57972fc50d3f@siemens.com>
References: <e5c56c3f-5c9a-d689-90f0-b8e4c499199e@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:37803 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbdGDGO3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Jul 2017 02:14:29 -0400
In-Reply-To: <e5c56c3f-5c9a-d689-90f0-b8e4c499199e@siemens.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@acpica.org, "Moore, Robert" <robert.moore@intel.com>

On 2017-06-09 20:36, Jan Kiszka wrote:
> Call directly into acpica to load a table to obtain its index on return.
> We choose the direct call of acpica internal functions to avoid having
> to modify its API which is used outside of Linux as well.
> 
> Use that index to unload the table again when the corresponding
> directory in configfs gets removed. This allows to change SSDTs without
> rebooting the system. It also allows to destroy devices again that a
> dynamically loaded SSDT created.
> 
> This is widely similar to the DT overlay behavior.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Change in v3:
>  - fix breakage if acpi_configfs is modular
> 
>  drivers/acpi/acpi_configfs.c | 20 +++++++++++++++++++-
>  drivers/acpi/acpica/tbdata.c |  4 ++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 146a77fb762d..853bc7fc673f 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -15,11 +15,15 @@
>  #include <linux/configfs.h>
>  #include <linux/acpi.h>
>  
> +#include "acpica/accommon.h"
> +#include "acpica/actables.h"
> +
>  static struct config_group *acpi_table_group;
>  
>  struct acpi_table {
>  	struct config_item cfg;
>  	struct acpi_table_header *header;
> +	u32 index;
>  };
>  
>  static ssize_t acpi_table_aml_write(struct config_item *cfg,
> @@ -52,7 +56,11 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>  	if (!table->header)
>  		return -ENOMEM;
>  
> -	ret = acpi_load_table(table->header);
> +	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
> +	ret = acpi_tb_install_and_load_table(
> +			ACPI_PTR_TO_PHYSADDR(table->header),
> +			ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
> +			&table->index);
>  	if (ret) {
>  		kfree(table->header);
>  		table->header = NULL;
> @@ -215,8 +223,18 @@ static struct config_item *acpi_table_make_item(struct config_group *group,
>  	return &table->cfg;
>  }
>  
> +static void acpi_table_drop_item(struct config_group *group,
> +				 struct config_item *cfg)
> +{
> +	struct acpi_table *table = container_of(cfg, struct acpi_table, cfg);
> +
> +	ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
> +	acpi_tb_unload_table(table->index);
> +}
> +
>  struct configfs_group_operations acpi_table_group_ops = {
>  	.make_item = acpi_table_make_item,
> +	.drop_item = acpi_table_drop_item,
>  };
>  
>  static struct config_item_type acpi_tables_type = {
> diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
> index 27c5c27d4818..c9d6fa6d7cc6 100644
> --- a/drivers/acpi/acpica/tbdata.c
> +++ b/drivers/acpi/acpica/tbdata.c
> @@ -867,6 +867,8 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
>  	return_ACPI_STATUS(status);
>  }
>  
> +ACPI_EXPORT_SYMBOL(acpi_tb_install_and_load_table)
> +
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_tb_unload_table
> @@ -914,3 +916,5 @@ acpi_status acpi_tb_unload_table(u32 table_index)
>  	acpi_tb_set_table_loaded_flag(table_index, FALSE);
>  	return_ACPI_STATUS(status);
>  }
> +
> +ACPI_EXPORT_SYMBOL(acpi_tb_unload_table)
> 

Ping for this patch.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
