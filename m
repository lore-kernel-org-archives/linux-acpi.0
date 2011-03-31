From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] acpi: Cleanup custom_method debug stuff
Date: Thu, 31 Mar 2011 23:39:14 +0200
Message-ID: <201103312339.14686.rjw@sisk.pl>
References: <1301571400-9861-1-git-send-email-trenn@suse.de> <1301571400-9861-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36537 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758992Ab1CaVjA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Mar 2011 17:39:00 -0400
In-Reply-To: <1301571400-9861-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Thursday, March 31, 2011, Thomas Renninger wrote:
> - Move param aml_debug_output to other params into sysfs.c
> - Split acpi_debugfs_init to prepare custom_method to be
>   an own .config option and driver.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> CC: lenb@kernel.org
> CC: rui.zhang@intel.com
> CC: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/debugfs.c  |   32 +++++++++++++-------------------
>  drivers/acpi/internal.h |    3 ++-
>  drivers/acpi/sysfs.c    |    8 ++++++++
>  3 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
> index 384f7ab..e7abc6e 100644
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
> -
> -	acpi_dir = debugfs_create_dir("acpi", NULL);
> -	if (!acpi_dir)
> -		goto err;
> +	if (!acpi_debugfs_dir)
> +		return -ENOENT;
>  
>  	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
> -					acpi_dir, NULL, &cm_fops);
> +					acpi_debugfs_dir, NULL, &cm_fops);
>  	if (!cm_dentry)
> -		goto err;
> +		return -ENODEV;
>  
>  	return 0;
> +}
> +
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
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 61891e7..77255f2 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -220,6 +220,14 @@ module_param_call(trace_state, param_set_trace_state, param_get_trace_state,
>  		  NULL, 0644);
>  #endif /* CONFIG_ACPI_DEBUG */
>  
> +
> +/* /sys/modules/acpi/parameters/aml_debug_output */
> +
> +module_param_named(aml_debug_output, acpi_gbl_enable_aml_debug_object,
> +		   bool, 0644);
> +MODULE_PARM_DESC(aml_debug_output,
> +		 "To enable/disable the ACPI Debug Object output.");
> +
>  /* /sys/module/acpi/parameters/acpica_version */
>  static int param_get_acpica_version(char *buffer, struct kernel_param *kp)
>  {
> 

