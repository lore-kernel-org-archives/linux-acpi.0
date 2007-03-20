From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: [PATCH 2/8] [-mm] ACPI: add ACPI EC sysfs interface
Date: Tue, 20 Mar 2007 12:25:14 +0300
Message-ID: <45FFA87A.7040406@linux.intel.com>
References: <1174382479.8833.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:29562 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933004AbXCTJZS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Mar 2007 05:25:18 -0400
In-Reply-To: <1174382479.8833.81.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

NAK

This information has no meaning in userspace.
So either make it just a printk (KERN_INFO) at init time or drop it 
completely.


Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
>
> Add ACPI Embedded Controller sysfs interface.
>
> Attribute	Mode	Description
> gpe		RO	bit assignment of the SCI interrupt within
> 			the GPEx_STS register of a GPE block described
> 			in FADT that EC will trigger
> command_port	RO	the status/command port for the EC
> data_port	RO	the data port for the EC
> global_lock	RO	
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/ec.c |   96 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 88 insertions(+), 8 deletions(-)
>
> Index: linux-2.6.21-rc4-mm1/drivers/acpi/ec.c
> ===================================================================
> --- linux-2.6.21-rc4-mm1.orig/drivers/acpi/ec.c	2007-03-20 16:16:26.000000000 +0800
> +++ linux-2.6.21-rc4-mm1/drivers/acpi/ec.c	2007-03-20 16:16:29.000000000 +0800
> @@ -514,8 +514,67 @@ acpi_ec_space_handler(u32 function,
>  }
>  
>  /* --------------------------------------------------------------------------
> +                              FS Interface (/sys)
> +   -------------------------------------------------------------------------- */
> +static ssize_t
> +acpi_ec_gpe_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_ec *ec = acpi_driver_data(dev);
> +
> +	if (!ec)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "0x%02x\n", (u32)ec->gpe);
> +}
> +static ACPI_DEVICE_ATTR(gpe, 0444, acpi_ec_gpe_show, NULL);
> +
> +static ssize_t
> +acpi_ec_command_port_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_ec *ec = acpi_driver_data(dev);
> +
> +	if (!ec)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "0x%02x\n", (u32)ec->command_addr);
> +}
> +static ACPI_DEVICE_ATTR(command_port, 0444, acpi_ec_command_port_show, NULL);
> +
> +static ssize_t
> +acpi_ec_data_port_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_ec *ec = acpi_driver_data(dev);
> +
> +	if (!ec)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "0x%02x\n", (u32)ec->data_addr);
> +}
> +static ACPI_DEVICE_ATTR(data_port, 0444, acpi_ec_data_port_show, NULL);
> +
> +static ssize_t
> +acpi_ec_global_lock_show(struct acpi_device *dev, char *buf)
> +{
> +	struct acpi_ec *ec = acpi_driver_data(dev);
> +
> +	if (!ec)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "%u\n", (u32)ec->global_lock);
> +}
> +static ACPI_DEVICE_ATTR(global_lock, 0444, acpi_ec_global_lock_show, NULL);
> +
> +static struct device_attribute * ec_attr[] = {
> +	GET_DEV_ATTR(gpe),
> +	GET_DEV_ATTR(command_port),
> +	GET_DEV_ATTR(data_port),
> +	GET_DEV_ATTR(global_lock),
> +	NULL,
> +};
> +/* --------------------------------------------------------------------------
>                                FS Interface (/proc)
>     -------------------------------------------------------------------------- */
> +#ifdef CONFIG_ACPI_PROCFS
>  
>  static struct proc_dir_entry *acpi_ec_dir;
>  
> @@ -548,7 +607,7 @@ static struct file_operations acpi_ec_in
>  	.owner = THIS_MODULE,
>  };
>  
> -static int acpi_ec_add_fs(struct acpi_device *device)
> +static int acpi_ec_add_procfs(struct acpi_device *device)
>  {
>  	struct proc_dir_entry *entry = NULL;
>  
> @@ -572,7 +631,7 @@ static int acpi_ec_add_fs(struct acpi_de
>  	return 0;
>  }
>  
> -static int acpi_ec_remove_fs(struct acpi_device *device)
> +static void acpi_ec_remove_procfs(struct acpi_device *device)
>  {
>  
>  	if (acpi_device_dir(device)) {
> @@ -581,9 +640,26 @@ static int acpi_ec_remove_fs(struct acpi
>  		acpi_device_dir(device) = NULL;
>  	}
>  
> +	return ;
> +}
> +
> +static int acpi_ec_procfs_init(void)
> +{
> +	acpi_ec_dir = proc_mkdir(ACPI_EC_CLASS, acpi_root_dir);
> +	if (!acpi_ec_dir)
> +		return -ENODEV;
> +
>  	return 0;
>  }
>  
> +static void acpi_ec_procfs_exit(void)
> +{
> +	remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
> +	return ;
> +}
> +#else
> +DECLARE_ACPI_DEVICE_PROCFS(ec);
> +#endif
>  /* --------------------------------------------------------------------------
>                                 Driver Interface
>     -------------------------------------------------------------------------- */
> @@ -643,7 +719,9 @@ static int acpi_ec_add(struct acpi_devic
>  	ec->handle = device->handle;
>  	acpi_driver_data(device) = ec;
>  
> -	acpi_ec_add_fs(device);
> +	acpi_device_add_sysfs(device, ec_attr);
> +
> +	acpi_ec_add_procfs(device);
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s [%s] (gpe %d) interrupt mode.",
>  			  acpi_device_name(device), acpi_device_bid(device),
> @@ -660,7 +738,8 @@ static int acpi_ec_remove(struct acpi_de
>  		return -EINVAL;
>  
>  	ec = acpi_driver_data(device);
> -	acpi_ec_remove_fs(device);
> +	acpi_ec_remove_procfs(device);
> +	acpi_device_remove_sysfs(device, ec_attr);
>  	acpi_driver_data(device) = NULL;
>  	if (ec == first_ec)
>  		first_ec = NULL;
> @@ -844,14 +923,15 @@ static int __init acpi_ec_init(void)
>  	if (acpi_disabled)
>  		return 0;
>  
> -	acpi_ec_dir = proc_mkdir(ACPI_EC_CLASS, acpi_root_dir);
> -	if (!acpi_ec_dir)
> +	result = acpi_ec_procfs_init();
> +	if (result)
>  		return -ENODEV;
>  
>  	/* Now register the driver for the EC */
> +	acpi_ec_driver.owner = THIS_MODULE;
>  	result = acpi_bus_register_driver(&acpi_ec_driver);
>  	if (result < 0) {
> -		remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
> +		acpi_ec_procfs_exit();
>  		return -ENODEV;
>  	}
>  
> @@ -867,7 +947,7 @@ static void __exit acpi_ec_exit(void)
>  
>  	acpi_bus_unregister_driver(&acpi_ec_driver);
>  
> -	remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
> +	acpi_ec_procfs_exit();
>  
>  	return;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
