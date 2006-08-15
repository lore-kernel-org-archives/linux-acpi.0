From: akpm@osdl.org
Subject: [patch 06/14] acpi/scan: handle kset/kobject errors
Date: Mon, 14 Aug 2006 22:37:24 -0700
Message-ID: <200608150537.k7F5bOdJ011545@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:39817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965086AbWHOFh1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Aug 2006 01:37:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, rdunlap@xenotime.net

From: Randy Dunlap <rdunlap@xenotime.net>

Check and handle kset_register() and kobject_register() init errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/scan.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/scan.c~acpi-scan-handle-kset-kobject-errors drivers/acpi/scan.c
--- a/drivers/acpi/scan.c~acpi-scan-handle-kset-kobject-errors
+++ a/drivers/acpi/scan.c
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
_
