From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi : Add container online uevent to acpi_bus_attach
Date: Sun, 07 Sep 2014 23:34:27 +0200
Message-ID: <6346979.uGFiy3j9K2@vostro.rjw.lan>
References: <54095EE7.3080302@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62210 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751911AbaIGVPD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Sep 2014 17:15:03 -0400
In-Reply-To: <54095EE7.3080302@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org

On Friday, September 05, 2014 03:57:43 PM Yasuaki Ishimatsu wrote:
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

I see the problem, but I don't like the patch.

For example, we don't need to match the container's name again, we can use
the fact that we've already matched the container scan handler to it.

Does the one below work too?

Rafael


---
 drivers/acpi/container.c |    8 ++++++++
 drivers/acpi/scan.c      |    3 +++
 include/acpi/acpi_bus.h  |    1 +
 3 files changed, 12 insertions(+)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -118,6 +118,7 @@ struct acpi_device;
 struct acpi_hotplug_profile {
 	struct kobject kobj;
 	int (*scan_dependent)(struct acpi_device *adev);
+	void (*notify_online)(struct acpi_device *adev);
 	bool enabled:1;
 	bool demand_offline:1;
 };
Index: linux-pm/drivers/acpi/container.c
===================================================================
--- linux-pm.orig/drivers/acpi/container.c
+++ linux-pm/drivers/acpi/container.c
@@ -99,6 +99,13 @@ static void container_device_detach(stru
 		device_unregister(dev);
 }
 
+static void container_device_online(struct acpi_device *adev)
+{
+	struct device *dev = acpi_driver_data(adev);
+
+	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+}
+
 static struct acpi_scan_handler container_handler = {
 	.ids = container_device_ids,
 	.attach = container_device_attach,
@@ -106,6 +113,7 @@ static struct acpi_scan_handler containe
 	.hotplug = {
 		.enabled = true,
 		.demand_offline = true,
+		.notify_online = container_device_online,
 	},
 };
 
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2190,6 +2190,9 @@ static void acpi_bus_attach(struct acpi_
  ok:
 	list_for_each_entry(child, &device->children, node)
 		acpi_bus_attach(child);
+
+	if (device->handler && device->handler->hotplug.notify_online)
+		device->handler->hotplug.notify_online(device);
 }
 
 /**

