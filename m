From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH] acpi : Add container online uevent to acpi_bus_attach
Date: Wed, 10 Sep 2014 12:16:43 +0900
Message-ID: <540FC29B.7010808@jp.fujitsu.com>
References: <54095EE7.3080302@jp.fujitsu.com> <6346979.uGFiy3j9K2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:56429 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbaIJDRS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 23:17:18 -0400
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [10.0.237.131])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 164A53EE0AE
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2014 12:17:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 2309DAC06B3
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2014 12:17:16 +0900 (JST)
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A74A8E08008
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2014 12:17:15 +0900 (JST)
In-Reply-To: <6346979.uGFiy3j9K2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, jlee@suse.com

(2014/09/08 6:34), Rafael J. Wysocki wrote:
> On Friday, September 05, 2014 03:57:43 PM Yasuaki Ishimatsu wrote:
>> Container online uevent was deleted by "46394fd01 : ACPI / hotplug:
>> Move container-specific code out of the core" because container-
>> specific uevent is raised to udev by attaching container device.
>> But the container-specific uevent is not useful.
>>
>> In my box, conainer device has CPU and memory devices. In this case,
>> when hot adding container device, the following uevets are raised to
>> udev.
>>
>>    # udevadm monitor --kernel
>>    monitor will print the received events for:
>>    KERNEL - the kernel uevent
>>
>>    KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
>>    <snip>
>>    KERNEL[...] add      /devices/system/memory/memory2048 (memory)
>>    KERNEL[...] add      /devices/system/memory/memory2049 (memory)
>>    <snip>
>>    KERNEL[...] add      /devices/system/memory/memory2063 (memory)
>>    <snip>
>>    KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
>>    <snip>
>>    KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
>>
>> When udev catches the container add uevent in my box, udev executes
>> user land script for onlining all child's devices. But memory and CPU
>> devices have not been attached at this time. So user land script fails.
>>
>> One of solutions is that user land script waits for all child's devices
>> to attach. But user land script has no way to know all child's devices
>> were attached.
>>
>> So the patch adds container online uevent to acpi_bus_sttach(). By
>> applying
>> the patch, container online uevent is raised to udev after all child's
>> devices were attached as follows:
>>
>>    # udevadm monitor --kernel
>>    monitor will print the received events for:
>>    KERNEL - the kernel uevent
>>
>>    KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
>>    <snip>
>>    KERNEL[...] add      /devices/system/memory/memory2048 (memory)
>>    KERNEL[...] add      /devices/system/memory/memory2049 (memory)
>>    <snip>
>>    KERNEL[...] add      /devices/system/memory/memory2063 (memory)
>>    <snip>
>>    KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
>>    <snip>
>>    KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
>>    KERNEL[...] online   /devices/system/container/ACPI0004:01 (container)
>>
>> So if user land script is executed after raising the container online
>> uevent, it guarantees that all child's devices were attached.
>
> I see the problem, but I don't like the patch.
>
> For example, we don't need to match the container's name again, we can use
> the fact that we've already matched the container scan handler to it.
>
> Does the one below work too?

Hi Rafael,

Thank you for posting your patch. I confirmed that your patch fixed my issue
as folloes:

# udevadm monitor --kernel
monitor will print the received events for:
KERNEL - the kernel uevent

KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
<snip>
KERNEL[...] add      /devices/system/memory/memory2048 (memory)
<snip>
KERNEL[...] add      /devices/system/memory/memory2063 (memory)
<snip>
KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
<snip>
KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
KERNEL[...] online   /devices/system/container/ACPI0004:01 (container)

So feel free to  add "Tested-by : Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>"
to the patch.

Thanks,
Yasuaki Ishimatsu

>
> Rafael
>
>
> ---
>   drivers/acpi/container.c |    8 ++++++++
>   drivers/acpi/scan.c      |    3 +++
>   include/acpi/acpi_bus.h  |    1 +
>   3 files changed, 12 insertions(+)
>
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -118,6 +118,7 @@ struct acpi_device;
>   struct acpi_hotplug_profile {
>   	struct kobject kobj;
>   	int (*scan_dependent)(struct acpi_device *adev);
> +	void (*notify_online)(struct acpi_device *adev);
>   	bool enabled:1;
>   	bool demand_offline:1;
>   };
> Index: linux-pm/drivers/acpi/container.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/container.c
> +++ linux-pm/drivers/acpi/container.c
> @@ -99,6 +99,13 @@ static void container_device_detach(stru
>   		device_unregister(dev);
>   }
>
> +static void container_device_online(struct acpi_device *adev)
> +{
> +	struct device *dev = acpi_driver_data(adev);
> +
> +	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
> +}
> +
>   static struct acpi_scan_handler container_handler = {
>   	.ids = container_device_ids,
>   	.attach = container_device_attach,
> @@ -106,6 +113,7 @@ static struct acpi_scan_handler containe
>   	.hotplug = {
>   		.enabled = true,
>   		.demand_offline = true,
> +		.notify_online = container_device_online,
>   	},
>   };
>
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2190,6 +2190,9 @@ static void acpi_bus_attach(struct acpi_
>    ok:
>   	list_for_each_entry(child, &device->children, node)
>   		acpi_bus_attach(child);
> +
> +	if (device->handler && device->handler->hotplug.notify_online)
> +		device->handler->hotplug.notify_online(device);
>   }
>
>   /**
>


