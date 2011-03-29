From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] acpi: Split out custom_method functionality into an own driver
Date: Tue, 29 Mar 2011 21:36:50 +0200
Message-ID: <201103292136.50214.rjw@sisk.pl>
References: <1301401990-35469-1-git-send-email-trenn@suse.de> <1301401990-35469-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53180 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab1C2Tgv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2011 15:36:51 -0400
In-Reply-To: <1301401990-35469-4-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Tuesday, March 29, 2011, Thomas Renninger wrote:
> With /sys/kernel/debug/acpi/custom_method root can write
> to arbitrary memory and increase his priveleges, even if
> these are restricted.
> 
> -> Make this an own debug .config option and warn about the
> security issue in the config description.
> 
> -> Still keep acpi/debugfs.c which now only creates and empty
>    /sys/kernel/debug/acpi directory. There might be other
>    users of it later.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Rafael J. Wysocki <rjw@sisk.pl>
> CC: lenb@kernel.org
> CC: rui.zhang@intel.com
> CC: linux-acpi@vger.kernel.org

OK, but you don't need to move custom_method to a separate file.  Why are
you doing that, exactly?

> ---
>  Documentation/acpi/method-customizing.txt |    5 ++
>  drivers/acpi/Kconfig                      |   12 ++++
>  drivers/acpi/Makefile                     |    1 +
>  drivers/acpi/custom_method.c              |  100 +++++++++++++++++++++++++++++
>  drivers/acpi/debugfs.c                    |   80 +-----------------------
>  5 files changed, 119 insertions(+), 79 deletions(-)
>  create mode 100644 drivers/acpi/custom_method.c
> 
> diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
> index 3e1d25a..5f55373 100644
> --- a/Documentation/acpi/method-customizing.txt
> +++ b/Documentation/acpi/method-customizing.txt
> @@ -66,3 +66,8 @@ Note: We can use a kernel with multiple custom ACPI method running,
>        But each individual write to debugfs can implement a SINGLE
>        method override. i.e. if we want to insert/override multiple
>        ACPI methods, we need to redo step c) ~ g) for multiple times.
> +
> +Note: Be aware that root can mis-use this driver to modify arbitrary
> +      memory and gain additional rights, if root's privileges got
> +      restricted (for example if root is not allowed to load additional
> +      modules after boot).
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 2aa042a..48dcbaf 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -381,6 +381,18 @@ config ACPI_HED
>  	  which is used to report some hardware errors notified via
>  	  SCI, mainly the corrected errors.
>  
> +config ACPI_CUSTOM_METHOD
> +	tristate "ACPI function runtime override debug utility (SECURITY ALERT)"

I wouldn't put the "SECURITY ALERT" in the option string.  I'd call it
"Allow ACPI methods to be inserted/replaced at run time"

> +	depends on DEBUG_FS
> +	default n
> +	help
> +	  This is an ACPI debug facility:

Here, I'd say:
"This debug facility allows ACPI AML methods to me inserted and/or replaced
without rebooting the system.  For details refer to "

> +	  Documentation/acpi/method-customizing.txt.
> +
> +	  Be aware that it allows root to override arbitrary memory and to gain
> +	  extended rights on systems where root privileges may be partly
> +	  restricted.

Here, I'd say.

"NOTE: This option is security sensitive, because it allows arbitrary kernel
memory to be written to by root (uid=0) users, allowing them to bypass certain
security measures (e.g. if root is not allowed to load additional kernel modules
after boot, this feature may be used to override that restriction)."

> +
>  source "drivers/acpi/apei/Kconfig"
>  
>  endif	# ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d113fa5..cba0b23 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_ACPI_SBS)		+= sbs.o
>  obj-$(CONFIG_ACPI_POWER_METER)	+= power_meter.o
>  obj-$(CONFIG_ACPI_HED)		+= hed.o
>  obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
> +obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o processor_throttling.o
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> new file mode 100644
> index 0000000..dc554c2
> --- /dev/null
> +++ b/drivers/acpi/custom_method.c
> @@ -0,0 +1,100 @@
> +/*
> + * debugfs.c - ACPI debugfs interface to userspace.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/uaccess.h>
> +#include <linux/debugfs.h>
> +#include <acpi/acpi_drivers.h>
> +
> +#include "internal.h"
> +
> +#define _COMPONENT		ACPI_SYSTEM_COMPONENT
> +ACPI_MODULE_NAME("custom_method");
> +MODULE_LICENSE("GPL");
> +
> +static struct dentry *cm_dentry;
> +
> +/* /sys/kernel/debug/acpi/custom_method */
> +
> +static ssize_t cm_write(struct file *file, const char __user * user_buf,
> +			size_t count, loff_t *ppos)
> +{
> +	static char *buf;
> +	static u32 max_size;
> +	static u32 uncopied_bytes;
> +
> +	struct acpi_table_header table;
> +	acpi_status status;
> +
> +	if (!(*ppos)) {
> +		/* parse the table header to get the table length */
> +		if (count <= sizeof(struct acpi_table_header))
> +			return -EINVAL;
> +		if (copy_from_user(&table, user_buf,
> +				   sizeof(struct acpi_table_header)))
> +			return -EFAULT;
> +		uncopied_bytes = max_size = table.length;
> +		buf = kzalloc(max_size, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +	}
> +
> +	if (buf == NULL)
> +		return -EINVAL;
> +
> +	if ((*ppos > max_size) ||
> +	    (*ppos + count > max_size) ||
> +	    (*ppos + count < count) ||
> +	    (count > uncopied_bytes))
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf + (*ppos), user_buf, count)) {
> +		kfree(buf);
> +		buf = NULL;
> +		return -EFAULT;
> +	}
> +
> +	uncopied_bytes -= count;
> +	*ppos += count;
> +
> +	if (!uncopied_bytes) {
> +		status = acpi_install_method(buf);
> +		kfree(buf);
> +		buf = NULL;
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
> +	.llseek = default_llseek,
> +};
> +
> +static int __init acpi_custom_method_init(void)
> +{
> +	if (acpi_debugfs_dir == NULL)
> +		return -ENOENT;
> +
> + 	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
> +					acpi_debugfs_dir, NULL, &cm_fops);
> +	if (cm_dentry == NULL)
> +		return -ENODEV;
> +
> + 	return 0;
> +}
> +
> +static void __exit acpi_custom_method_exit(void)
> +{
> +	if (cm_dentry)
> +		debugfs_remove(cm_dentry);
> + }
> +
> +module_init(acpi_custom_method_init);
> +module_exit(acpi_custom_method_exit);
> diff --git a/drivers/acpi/debugfs.c b/drivers/acpi/debugfs.c
> index 32945c7..182a9fc 100644
> --- a/drivers/acpi/debugfs.c
> +++ b/drivers/acpi/debugfs.c
> @@ -3,9 +3,6 @@
>   */
>  
>  #include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/uaccess.h>
>  #include <linux/debugfs.h>
>  #include <acpi/acpi_drivers.h>
>  
> @@ -13,84 +10,9 @@
>  ACPI_MODULE_NAME("debugfs");
>  
>  struct dentry *acpi_debugfs_dir;
> -static struct dentry *cm_dentry;
> -
> -/* /sys/kernel/debug/acpi/custom_method */
> -
> -static ssize_t cm_write(struct file *file, const char __user * user_buf,
> -			size_t count, loff_t *ppos)
> -{
> -	static char *buf;
> -	static u32 max_size;
> -	static u32 uncopied_bytes;
> -
> -	struct acpi_table_header table;
> -	acpi_status status;
> -
> -	if (!(*ppos)) {
> -		/* parse the table header to get the table length */
> -		if (count <= sizeof(struct acpi_table_header))
> -			return -EINVAL;
> -		if (copy_from_user(&table, user_buf,
> -				   sizeof(struct acpi_table_header)))
> -			return -EFAULT;
> -		uncopied_bytes = max_size = table.length;
> -		buf = kzalloc(max_size, GFP_KERNEL);
> -		if (!buf)
> -			return -ENOMEM;
> -	}
> -
> -	if (buf == NULL)
> -		return -EINVAL;
> -
> -	if ((*ppos > max_size) ||
> -	    (*ppos + count > max_size) ||
> -	    (*ppos + count < count) ||
> -	    (count > uncopied_bytes))
> -		return -EINVAL;
> -
> -	if (copy_from_user(buf + (*ppos), user_buf, count)) {
> -		kfree(buf);
> -		buf = NULL;
> -		return -EFAULT;
> -	}
> -
> -	uncopied_bytes -= count;
> -	*ppos += count;
> -
> -	if (!uncopied_bytes) {
> -		status = acpi_install_method(buf);
> -		kfree(buf);
> -		buf = NULL;
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
> -	.llseek = default_llseek,
> -};
> -
> -static int __init acpi_custom_method_init(void)
> -{
> -	if (acpi_debugfs_dir == NULL)
> -		return -ENOENT;
> -
> - 	cm_dentry = debugfs_create_file("custom_method", S_IWUSR,
> -					acpi_debugfs_dir, NULL, &cm_fops);
> -	if (cm_dentry == NULL)
> -		return -ENODEV;
> -
> - 	return 0;
> -}
> +EXPORT_SYMBOL_GPL(acpi_debugfs_dir);
>  
>  void __init acpi_debugfs_init(void)
>  {
>  	acpi_debugfs_dir = debugfs_create_dir("acpi", NULL);
> -
> -	acpi_custom_method_init();
>  }
> 

