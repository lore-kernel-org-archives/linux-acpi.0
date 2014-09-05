From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [PATCH] acpi : Add container online uevent to acpi_bus_attach
Date: Fri, 5 Sep 2014 15:57:43 +0900
Message-ID: <54095EE7.3080302@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:33754 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaIEG6b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2014 02:58:31 -0400
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1D4D23EE1D5
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2014 15:58:30 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1ECA7AC09B8
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2014 15:58:29 +0900 (JST)
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B9C681DB803C
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2014 15:58:28 +0900 (JST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: mika.westerberg@linux.intel.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

Container online uevent was deleted by "46394fd01 : ACPI / hotplug:
Move container-specific code out of the core" because container-
specific uevent is raised to udev by attaching container device.
But the container-specific uevent is not useful.

In my box, conainer device has CPU and memory devices. In this case,
when hot adding container device, the following uevets are raised to
udev.

  # udevadm monitor --kernel
  monitor will print the received events for:
  KERNEL - the kernel uevent

  KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
  <snip>
  KERNEL[...] add      /devices/system/memory/memory2048 (memory)
  KERNEL[...] add      /devices/system/memory/memory2049 (memory)
  <snip>
  KERNEL[...] add      /devices/system/memory/memory2063 (memory)
  <snip>
  KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
  <snip>
  KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)

When udev catches the container add uevent in my box, udev executes
user land script for onlining all child's devices. But memory and CPU
devices have not been attached at this time. So user land script fails.

One of solutions is that user land script waits for all child's devices
to attach. But user land script has no way to know all child's devices
were attached.

So the patch adds container online uevent to acpi_bus_sttach(). By
applying
the patch, container online uevent is raised to udev after all child's
devices were attached as follows:

  # udevadm monitor --kernel
  monitor will print the received events for:
  KERNEL - the kernel uevent

  KERNEL[...] add      /devices/system/container/ACPI0004:01 (container)
  <snip>
  KERNEL[...] add      /devices/system/memory/memory2048 (memory)
  KERNEL[...] add      /devices/system/memory/memory2049 (memory)
  <snip>
  KERNEL[...] add      /devices/system/memory/memory2063 (memory)
  <snip>
  KERNEL[...] add      /devices/system/cpu/cpu60 (cpu)
  <snip>
  KERNEL[...] add      /devices/system/cpu/cpu119 (cpu)
  KERNEL[...] online   /devices/system/container/ACPI0004:01 (container)

So if user land script is executed after raising the container online
uevent, it guarantees that all child's devices were attached.

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
---
 drivers/acpi/container.c | 15 +++++++++++++++
 drivers/acpi/internal.h  |  7 +++++++
 drivers/acpi/scan.c      |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 76f7cff..eba5746 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -43,6 +43,21 @@ static const struct acpi_device_id container_device_ids[] = {

 #ifdef CONFIG_ACPI_CONTAINER

+void notify_container_device(struct acpi_device *adev)
+{
+	struct device *dev = acpi_driver_data(adev);
+
+	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
+}
+
+int is_container_device(struct acpi_device *adev)
+{
+	if (acpi_match_device_ids(adev, container_device_ids))
+		return 0;
+
+	return 1;
+}
+
 static int acpi_container_offline(struct container_dev *cdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&cdev->dev);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 4c5cf77..12dd89b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -45,6 +45,13 @@ static inline void register_dock_dependent_device(struct acpi_device *adev,
 static inline int dock_notify(struct acpi_device *adev, u32 event) { return -ENODEV; }
 static inline void acpi_dock_add(struct acpi_device *adev) {}
 #endif
+#if CONFIG_ACPI_CONTAINER
+int is_container_device(struct acpi_device *adev);
+void notify_container_device(struct acpi_device *adev);
+#else
+static inline int is_container_device(struct acpi_device *adev) { return 0; }
+static inline void notify_container_device(struct acpi_device *adev) {}
+#endif
 #ifdef CONFIG_X86
 void acpi_cmos_rtc_init(void);
 #else
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a92989..faa3d11 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2188,6 +2188,9 @@ static void acpi_bus_attach(struct acpi_device *device)
  ok:
 	list_for_each_entry(child, &device->children, node)
 		acpi_bus_attach(child);
+
+	if (is_container_device(device))
+		notify_container_device(device);
 }

 /**
-- 
1.8.3.1


