From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm] acpi/scan: handle kset/kobject errors
Date: Tue, 11 Jul 2006 23:08:11 -0700
Message-ID: <20060711230811.9e1167e5.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:43444 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932438AbWGLGFX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 02:05:23 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2006 23:05:21 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm <akpm@osdl.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle kset_register() and kobject_register() init errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/scan.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

--- linux-2618-rc1mm1.orig/drivers/acpi/scan.c
+++ linux-2618-rc1mm1/drivers/acpi/scan.c
@@ -4,6 +4,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/acpi.h>
 
 #include <acpi/acpi_drivers.h>
@@ -113,6 +114,8 @@ static struct kset acpi_namespace_kset =
 static void acpi_device_register(struct acpi_device *device,
 				 struct acpi_device *parent)
 {
+	int err;
+
 	/*
 	 * Linkage
 	 * -------
@@ -138,7 +141,10 @@ static void acpi_device_register(struct 
 		device->kobj.parent = &parent->kobj;
 	device->kobj.ktype = &ktype_acpi_ns;
 	device->kobj.kset = &acpi_namespace_kset;
-	kobject_register(&device->kobj);
+	err = kobject_register(&device->kobj);
+	if (err < 0)
+		printk(KERN_WARNING "%s: kobject_register error: %d\n",
+			__FUNCTION__, err);
 	create_sysfs_device_files(device);
 }
 
@@ -1450,7 +1456,9 @@ static int __init acpi_scan_init(void)
 	if (acpi_disabled)
 		return 0;
 
-	kset_register(&acpi_namespace_kset);
+	result = kset_register(&acpi_namespace_kset);
+	if (result < 0)
+		printk(KERN_ERR PREFIX "kset_register error: %d\n", result);
 
 	result = bus_register(&acpi_bus_type);
 	if (result) {


---
