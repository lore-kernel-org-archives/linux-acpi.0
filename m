From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH v3 3/3] acpi : acpi_bus_trim() stops removing devices
 when failing to remove the device
Date: Tue, 09 Oct 2012 16:02:29 +0800
Message-ID: <5073DA15.4040501@cn.fujitsu.com>
References: <4FFEB35A.6030500@jp.fujitsu.com> <4FFEB4F9.7000906@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:54439 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab2JIH4y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2012 03:56:54 -0400
In-Reply-To: <4FFEB4F9.7000906@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, srivatsa.bhat@linux.vnet.ibm.com, toshi.kani@hp.com

Hi, ishimatsu:

At 07/12/2012 07:28 PM, Yasuaki Ishimatsu Wrote:
> acpi_bus_trim() stops removing devices, when acpi_bus_remove() return error
> number. But acpi_bus_remove() cannot return error number correctly.
> acpi_bus_remove() only return -EINVAL, when dev argument is NULL. Thus even if
> device cannot be removed correctly, acpi_bus_trim() ignores and continues to
> remove devices. acpi_bus_hot_remove_device() uses acpi_bus_trim() for removing
> devices. Therefore acpi_bus_hot_remove_device() can send "_EJ0" to firmware,
> even if the device is running on the system. In this case, the system cannot
> work well. So acpi_bus_trim() should check whether device was removed or not
> correctly. The patch adds error check into some functions to remove the device.

What is the status about this patch?

Vasilis Liaskovitis found a similar bug about the memory hotplug, and this patch
can fix this problem:
https://lkml.org/lkml/2012/9/26/318

Thanks
Wen Congyang
> 
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> ---
>  drivers/acpi/scan.c    |   15 ++++++++++++---
>  drivers/base/dd.c      |   22 +++++++++++++++++-----
>  include/linux/device.h |    2 +-
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> Index: linux-3.5-rc6/drivers/acpi/scan.c
> ===================================================================
> --- linux-3.5-rc6.orig/drivers/acpi/scan.c	2012-07-12 20:11:37.316443808 +0900
> +++ linux-3.5-rc6/drivers/acpi/scan.c	2012-07-12 20:17:17.927185231 +0900
> @@ -425,12 +425,17 @@ static int acpi_device_remove(struct dev
>  {
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  	struct acpi_driver *acpi_drv = acpi_dev->driver;
> +	int ret;
> 
>  	if (acpi_drv) {
>  		if (acpi_drv->ops.notify)
>  			acpi_device_remove_notify_handler(acpi_dev);
> -		if (acpi_drv->ops.remove)
> -			acpi_drv->ops.remove(acpi_dev, acpi_dev->removal_type);
> +		if (acpi_drv->ops.remove) {
> +			ret = acpi_drv->ops.remove(acpi_dev,
> +						   acpi_dev->removal_type);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  	acpi_dev->driver = NULL;
>  	acpi_dev->driver_data = NULL;
> @@ -1208,11 +1213,15 @@ static int acpi_device_set_context(struc
> 
>  static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
>  {
> +	int ret;
> +
>  	if (!dev)
>  		return -EINVAL;
> 
>  	dev->removal_type = ACPI_BUS_REMOVAL_EJECT;
> -	device_release_driver(&dev->dev);
> +	ret = device_release_driver(&dev->dev);
> +	if (ret)
> +		return ret;
> 
>  	if (!rmdevice)
>  		return 0;
> Index: linux-3.5-rc6/drivers/base/dd.c
> ===================================================================
> --- linux-3.5-rc6.orig/drivers/base/dd.c	2012-07-12 20:11:37.316443808 +0900
> +++ linux-3.5-rc6/drivers/base/dd.c	2012-07-12 20:17:17.928185218 +0900
> @@ -464,9 +464,10 @@ EXPORT_SYMBOL_GPL(driver_attach);
>   * __device_release_driver() must be called with @dev lock held.
>   * When called for a USB interface, @dev->parent lock must be held as well.
>   */
> -static void __device_release_driver(struct device *dev)
> +static int __device_release_driver(struct device *dev)
>  {
>  	struct device_driver *drv;
> +	int ret;
> 
>  	drv = dev->driver;
>  	if (drv) {
> @@ -482,9 +483,11 @@ static void __device_release_driver(stru
>  		pm_runtime_put_sync(dev);
> 
>  		if (dev->bus && dev->bus->remove)
> -			dev->bus->remove(dev);
> +			ret = dev->bus->remove(dev);
>  		else if (drv->remove)
> -			drv->remove(dev);
> +			ret = drv->remove(dev);
> +		if (ret)
> +			goto rollback;
>  		devres_release_all(dev);
>  		dev->driver = NULL;
>  		klist_remove(&dev->p->knode_driver);
> @@ -494,6 +497,12 @@ static void __device_release_driver(stru
>  						     dev);
> 
>  	}
> +
> +	return ret;
> +
> +rollback:
> +	driver_sysfs_add(dev);
> +	return ret;
>  }
> 
>  /**
> @@ -503,16 +512,19 @@ static void __device_release_driver(stru
>   * Manually detach device from driver.
>   * When called for a USB interface, @dev->parent lock must be held.
>   */
> -void device_release_driver(struct device *dev)
> +int device_release_driver(struct device *dev)
>  {
> +	int ret;
>  	/*
>  	 * If anyone calls device_release_driver() recursively from
>  	 * within their ->remove callback for the same device, they
>  	 * will deadlock right here.
>  	 */
>  	device_lock(dev);
> -	__device_release_driver(dev);
> +	ret = __device_release_driver(dev);
>  	device_unlock(dev);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(device_release_driver);
> 
> Index: linux-3.5-rc6/include/linux/device.h
> ===================================================================
> --- linux-3.5-rc6.orig/include/linux/device.h	2012-07-12 20:11:37.317443779 +0900
> +++ linux-3.5-rc6/include/linux/device.h	2012-07-12 20:17:17.936185118 +0900
> @@ -827,7 +827,7 @@ static inline void *dev_get_platdata(con
>   * for information on use.
>   */
>  extern int __must_check device_bind_driver(struct device *dev);
> -extern void device_release_driver(struct device *dev);
> +extern int device_release_driver(struct device *dev);
>  extern int  __must_check device_attach(struct device *dev);
>  extern int __must_check driver_attach(struct device_driver *drv);
>  extern int __must_check device_reprobe(struct device *dev);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

