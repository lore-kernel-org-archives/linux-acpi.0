From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] acpi: Cleanup custom_method debug stuff
Date: Wed, 30 Mar 2011 09:37:45 +0800
Message-ID: <1301449065.31460.75.camel@rui>
References: <1301401990-35469-1-git-send-email-trenn@suse.de>
	 <1301401990-35469-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:10594 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978Ab1C3Bie (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2011 21:38:34 -0400
In-Reply-To: <1301401990-35469-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2011-03-29 at 20:33 +0800, Thomas Renninger wrote:
> - Revert param aml_debug_output, it's not used.

NAK.

void
acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
                        u32 level, u32 index)
{
	...
        if (!acpi_gbl_enable_aml_debug_object &&
            !(acpi_dbg_level & ACPI_LV_DEBUG_OBJECT)) {
                return_VOID;
        }
	...
}

Users can set acpi_gbl_enable_aml_debug_object via module parameter
aml_bug_output, thus enable the ACPI Debug output at runtime.

thanks,
rui

> - Split acpi_debugfs_init to prepare custom_method to be
>   an own .config option and driver.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Rafael J. Wysocki <rjw@sisk.pl>
> CC: lenb@kernel.org
> CC: rui.zhang@intel.com
> CC: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/debugfs.c  |   36 +++++++++++++++---------------------
>  drivers/acpi/internal.h |    3 ++-
>  2 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
> index 384f7ab..32945c7 100644
> --- a/drivers/acpi/debugfs.c
> +++ b/drivers/acpi/debugfs.c
> @@ -12,13 +12,8 @@
>  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
>  ACPI_MODULE_NAME("debugfs");
>  
> -
> -/* /sys/modules/acpi/parameters/aml_debug_output */
> -
> -module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
> -		   bool, 0644);
> -MODULE_PARM_DESC(aml_debug_output,
> -		 "To enable/disable the ACPI Debug Object output.");
> +struct dentry *acpi_debugfs_dir;
> +static struct dentry *cm_dentry;
>  
>  /* /sys/kernel/debug/acpi/custom_method */
>  
> @@ -80,23 +75,22 @@ static const struct file_operations cm_fops = {
>  	.llseek = default_llseek,
>  };
>  
> -int __init acpi_debugfs_init(void)
> +static int __init acpi_custom_method_init(void)
>  {
> -	struct dentry *acpi_dir, *cm_dentry;
> +	if (acpi_debugfs_dir == NULL)
> +		return -ENOENT;
>  
> -	acpi_dir = debugfs_create_dir("acpi", NULL);
> -	if (!acpi_dir)
> -		goto err;
> + 	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
> +					acpi_debugfs_dir, NULL, &cm_fops);
> +	if (cm_dentry == NULL)
> +		return -ENODEV;
>  
> -	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
> -					acpi_dir, NULL, &cm_fops);
> -	if (!cm_dentry)
> -		goto err;
> + 	return 0;
> +}
>  
> -	return 0;
> +void __init acpi_debugfs_init(void)
> +{
> +	acpi_debugfs_dir = debugfs_create_dir("acpi", NULL);
>  
> -err:
> -	if (acpi_dir)
> -		debugfs_remove(acpi_dir);
> -	return -EINVAL;
> +	acpi_custom_method_init();
>  }
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index b1cc81a..afc1a1c 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -30,9 +30,10 @@ int acpi_scan_init(void);
>  int acpi_sysfs_init(void);
>  
>  #ifdef CONFIG_DEBUG_FS
> +extern struct dentry *acpi_debugfs_dir;
>  int acpi_debugfs_init(void);
>  #else
> -static inline int acpi_debugfs_init(void) { return 0; }
> +static inline void acpi_debugfs_init(void) { return; }
>  #endif
>  
>  /* --------------------------------------------------------------------------


