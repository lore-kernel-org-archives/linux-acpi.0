From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/4 V2] ACPI: introduce drivers/acpi/debugfs.c
Date: Sun, 13 Jun 2010 10:39:23 +0800
Message-ID: <1276396763.19052.18982.camel@rzhang1-desktop>
References: <1276328777.19052.17844.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19891 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab0FMCjB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jun 2010 22:39:01 -0400
In-Reply-To: <1276328777.19052.17844.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2010-06-12 at 15:46 +0800, Zhang, Rui wrote:
> Introduce drivers/acpi/debugfs.c.
> 
> Code for ACPI debugfs I/F, i.e. /sys/kernel/debug/acpi/custom_method,
> is moved to this file.
> 
> And make ACPI debugfs always built in,
> even if CONFIG_ACPI_DEBUG is cleared.
> 
forgot to mention, this adds about 400bytes code to ACPI, when
CONFIG_ACPI_DEBUG is cleared.

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Makefile   |    2 
>  drivers/acpi/bus.c      |    2 
>  drivers/acpi/debug.c    |   97 ------------------------------------------------
>  drivers/acpi/debugfs.c  |   84 +++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h |    6 +-
>  5 files changed, 89 insertions(+), 102 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/debug.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/debug.c
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -/*
> - * debug.c - ACPI debug interface to userspace.
> - */
> -
> -#include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/moduleparam.h>
> -#include <linux/debugfs.h>
> -#include <linux/slab.h>
> -#include <asm/uaccess.h>
> -#include <acpi/acpi_drivers.h>
> -
> -#define _COMPONENT		ACPI_SYSTEM_COMPONENT
> -ACPI_MODULE_NAME("debug");
> -
> -/* --------------------------------------------------------------------------
> -				DebugFS Interface
> -   -------------------------------------------------------------------------- */
> -
> -static ssize_t cm_write(struct file *file, const char __user *user_buf,
> -			size_t count, loff_t *ppos)
> -{
> -	static char *buf;
> -	static int uncopied_bytes;
> -	struct acpi_table_header table;
> -	acpi_status status;
> -
> -	if (!(*ppos)) {
> -		/* parse the table header to get the table length */
> -		if (count <= sizeof(struct acpi_table_header))
> -			return -EINVAL;
> -		if (copy_from_user(&table, user_buf,
> -			sizeof(struct acpi_table_header)))
> -			return -EFAULT;
> -		uncopied_bytes = table.length;
> -		buf = kzalloc(uncopied_bytes, GFP_KERNEL);
> -		if (!buf)
> -			return -ENOMEM;
> -	}
> -
> -	if (uncopied_bytes < count) {
> -		kfree(buf);
> -		return -EINVAL;
> -	}
> -
> -	if (copy_from_user(buf + (*ppos), user_buf, count)) {
> -		kfree(buf);
> -		return -EFAULT;
> -	}
> -
> -	uncopied_bytes -= count;
> -	*ppos += count;
> -
> -	if (!uncopied_bytes) {
> -		status = acpi_install_method(buf);
> -		kfree(buf);
> -		if (ACPI_FAILURE(status))
> -			return -EINVAL;
> -		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
> -	}
> -
> -	return count;
> -}
> -
> -static const struct file_operations cm_fops = {
> -	.write = cm_write,
> -};
> -
> -static int acpi_debugfs_init(void)
> -{
> -	struct dentry *acpi_dir, *cm_dentry;
> -
> -	acpi_dir = debugfs_create_dir("acpi", NULL);
> -	if (!acpi_dir)
> -		goto err;
> -
> -	cm_dentry = debugfs_create_file("custom_method", S_IWUGO,
> -					acpi_dir, NULL, &cm_fops);
> -	if (!cm_dentry)
> -		goto err;
> -
> -	return 0;
> -
> -err:
> -	if (acpi_dir)
> -		debugfs_remove(acpi_dir);
> -	return -EINVAL;
> -}
> -
> -int __init acpi_debug_init(void)
> -{
> -	acpi_debugfs_init();
> -	return 0;
> -}
> Index: linux-2.6/drivers/acpi/debugfs.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/acpi/debugfs.c
> @@ -0,0 +1,84 @@
> +/*
> + * debugfs.c - ACPI debugfs interface to userspace.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/debugfs.h>
> +#include <acpi/acpi_drivers.h>
> +
> +#define _COMPONENT		ACPI_SYSTEM_COMPONENT
> +ACPI_MODULE_NAME("debugfs");
> +
> +/* --------------------------------------------------------------------------
> +				DebugFS Interface
> +   -------------------------------------------------------------------------- */
> +
> +static ssize_t cm_write(struct file *file, const char __user *user_buf,
> +			size_t count, loff_t *ppos)
> +{
> +	static char *buf;
> +	static int uncopied_bytes;
> +	struct acpi_table_header table;
> +	acpi_status status;
> +
> +	if (!(*ppos)) {
> +		/* parse the table header to get the table length */
> +		if (count <= sizeof(struct acpi_table_header))
> +			return -EINVAL;
> +		if (copy_from_user(&table, user_buf,
> +			sizeof(struct acpi_table_header)))
> +			return -EFAULT;
> +		uncopied_bytes = table.length;
> +		buf = kzalloc(uncopied_bytes, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +	}
> +
> +	if (uncopied_bytes < count) {
> +		kfree(buf);
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(buf + (*ppos), user_buf, count)) {
> +		kfree(buf);
> +		return -EFAULT;
> +	}
> +
> +	uncopied_bytes -= count;
> +	*ppos += count;
> +
> +	if (!uncopied_bytes) {
> +		status = acpi_install_method(buf);
> +		kfree(buf);
> +		if (ACPI_FAILURE(status))
> +			return -EINVAL;
> +		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations cm_fops = {
> +	.write = cm_write,
> +};
> +
> +int __init acpi_debugfs_init(void)
> +{
> +	struct dentry *acpi_dir, *cm_dentry;
> +
> +	acpi_dir = debugfs_create_dir("acpi", NULL);
> +	if (!acpi_dir)
> +		goto err;
> +
> +	cm_dentry = debugfs_create_file("custom_method", S_IWUGO,
> +					acpi_dir, NULL, &cm_fops);
> +	if (!cm_dentry)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	if (acpi_dir)
> +		debugfs_remove(acpi_dir);
> +	return -EINVAL;
> +}
> Index: linux-2.6/drivers/acpi/Makefile
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/Makefile
> +++ linux-2.6/drivers/acpi/Makefile
> @@ -39,7 +39,7 @@ acpi-y				+= pci_root.o pci_link.o pci_i
>  acpi-y				+= power.o
>  acpi-y				+= event.o
>  acpi-y				+= sysfs.o
> -acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
> +acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
>  acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  ifdef CONFIG_ACPI_VIDEO
> Index: linux-2.6/drivers/acpi/internal.h
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/internal.h
> +++ linux-2.6/drivers/acpi/internal.h
> @@ -24,10 +24,10 @@ int init_acpi_device_notify(void);
>  int acpi_scan_init(void);
>  int acpi_sysfs_init(void);
>  
> -#ifdef CONFIG_ACPI_DEBUG
> -int acpi_debug_init(void);
> +#ifdef CONFIG_DEBUG_FS
> +int acpi_debugfs_init(void);
>  #else
> -static inline int acpi_debug_init(void) { return 0; }
> +static inline int acpi_debugfs_init(void) { return 0; }
>  #endif
>  
>  /* --------------------------------------------------------------------------
> Index: linux-2.6/drivers/acpi/bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/bus.c
> +++ linux-2.6/drivers/acpi/bus.c
> @@ -1035,7 +1035,7 @@ static int __init acpi_init(void)
>  	acpi_ec_init();
>  	acpi_power_init();
>  	acpi_sysfs_init();
> -	acpi_debug_init();
> +	acpi_debugfs_init();
>  	acpi_sleep_proc_init();
>  	acpi_wakeup_device_init();
>  	return result;
> 
> 


