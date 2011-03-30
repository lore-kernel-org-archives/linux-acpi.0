From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/3] acpi: Split out custom_method functionality into
 an own driver
Date: Wed, 30 Mar 2011 10:03:48 +0800
Message-ID: <1301450628.31460.116.camel@rui>
References: <1301401990-35469-1-git-send-email-trenn@suse.de>
	 <1301401990-35469-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64780 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348Ab1C3CEh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2011 22:04:37 -0400
In-Reply-To: <1301401990-35469-4-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2011-03-29 at 20:33 +0800, Thomas Renninger wrote:
> With /sys/kernel/debug/acpi/custom_method root can write
> to arbitrary memory and increase his priveleges, even if
> these are restricted.
> 
Sorry, I don't quite understand.

This interface just allocates a new piece of memory, copy the asl code
from user space and then attach it to ACPI namespace.

can you give more details about how it is misused to increase root's
privileges please?

thanks,
rui

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
> +	depends on DEBUG_FS
> +	default n
> +	help
> +	  This is an ACPI debug facility:
> +	  Documentation/acpi/method-customizing.txt.
> +
> +	  Be aware that it allows root to override arbitrary memory and to gain
> +	  extended rights on systems where root privileges may be partly
> +	  restricted.
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


