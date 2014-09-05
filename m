From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acpi : Add container online uevent to acpi_bus_attach
Date: Fri, 5 Sep 2014 20:14:13 +0800
Message-ID: <20140905121413.GG2225@linux-rxt1.site>
References: <54095EE7.3080302@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:45920 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805AbaIEMOZ (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Fri, 5 Sep 2014 08:14:25 -0400
Content-Disposition: inline
In-Reply-To: <54095EE7.3080302@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

Hi Yasuaki, 

On Fri, Sep 05, 2014 at 03:57:43PM +0900, Yasuaki Ishimatsu wrote:
> Container online uevent was deleted by "46394fd01 : ACPI / hotplug:
> Move container-specific code out of the core" because container-
> specific uevent is raised to udev by attaching container device.
> But the container-specific uevent is not useful.
> 
> In my box, conainer device has CPU and memory devices. In this case,
> when hot adding container device, the following uevets are raised to
> udev.
> 
>   # udevadm monitor --kernel
>   monitor will print the received events for:
>   KERNEL - the kernel uevent
> 
>   KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
>   <snip>
>   KERNEL[...] add      /devices/system/memory/memory2048 (memory)
>   KERNEL[...] add      /devices/system/memory/memory2049 (memory)
>   <snip>
>   KERNEL[...] add      /devices/system/memory/memory2063 (memory)
>   <snip>
>   KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
>   <snip>
>   KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
> 
> When udev catches the container add uevent in my box, udev executes
> user land script for onlining all child's devices. But memory and CPU
> devices have not been attached at this time. So user land script fails.
> 
> One of solutions is that user land script waits for all child's devices
> to attach. But user land script has no way to know all child's devices
> were attached.
> 
> So the patch adds container online uevent to acpi_bus_sttach(). By
> applying
> the patch, container online uevent is raised to udev after all child's
> devices were attached as follows:
> 
>   # udevadm monitor --kernel
>   monitor will print the received events for:
>   KERNEL - the kernel uevent
> 
>   KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
>   <snip>
>   KERNEL[...] add      /devices/system/memory/memory2048 (memory)
>   KERNEL[...] add      /devices/system/memory/memory2049 (memory)
>   <snip>
>   KERNEL[...] add      /devices/system/memory/memory2063 (memory)
>   <snip>
>   KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
>   <snip>
>   KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
>   KERNEL[...] online   /devices/system/container/ACPI0004:01 (container)
> 
> So if user land script is executed after raising the container online
> uevent, it guarantees that all child's devices were attached.
> 
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Your patch works on my side.

Tested-by: Lee, Chun-Yi <jlee@suse.com>

Thanks a lot!
joey Lee

> ---
>  drivers/acpi/container.c | 15 +++++++++++++++
>  drivers/acpi/internal.h  |  7 +++++++
>  drivers/acpi/scan.c      |  3 +++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
> index 76f7cff..eba5746 100644
> --- a/drivers/acpi/container.c
> +++ b/drivers/acpi/container.c
> @@ -43,6 +43,21 @@ static const struct acpi_device_id container_device_ids[] = {
> 
>  #ifdef CONFIG_ACPI_CONTAINER
> 
> +void notify_container_device(struct acpi_device *adev)
> +{
> +	struct device *dev = acpi_driver_data(adev);
> +
> +	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
> +}
> +
> +int is_container_device(struct acpi_device *adev)
> +{
> +	if (acpi_match_device_ids(adev, container_device_ids))
> +		return 0;
> +
> +	return 1;
> +}
> +
>  static int acpi_container_offline(struct container_dev *cdev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&cdev->dev);
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 4c5cf77..12dd89b 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -45,6 +45,13 @@ static inline void register_dock_dependent_device(struct acpi_device *adev,
>  static inline int dock_notify(struct acpi_device *adev, u32 event) { return -ENODEV; }
>  static inline void acpi_dock_add(struct acpi_device *adev) {}
>  #endif
> +#if CONFIG_ACPI_CONTAINER
> +int is_container_device(struct acpi_device *adev);
> +void notify_container_device(struct acpi_device *adev);
> +#else
> +static inline int is_container_device(struct acpi_device *adev) { return 0; }
> +static inline void notify_container_device(struct acpi_device *adev) {}
> +#endif
>  #ifdef CONFIG_X86
>  void acpi_cmos_rtc_init(void);
>  #else
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9a92989..faa3d11 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2188,6 +2188,9 @@ static void acpi_bus_attach(struct acpi_device *device)
>   ok:
>  	list_for_each_entry(child, &device->children, node)
>  		acpi_bus_attach(child);
> +
> +	if (is_container_device(device))
> +		notify_container_device(device);
>  }
> 
>  /**
> -- 
> 1.8.3.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
