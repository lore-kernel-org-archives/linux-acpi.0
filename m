From: Dave Young <hidave.darkstar@gmail.com>
Subject: [PATCH] thinkpad acpi module_exit fix
Date: Wed, 8 Aug 2007 16:43:34 +0000
Message-ID: <20070808164334.GA2732@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:63204 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbXHHImb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Aug 2007 04:42:31 -0400
Received: by ug-out-1314.google.com with SMTP id j3so161514ugf
        for <linux-acpi@vger.kernel.org>; Wed, 08 Aug 2007 01:42:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hmh@hmh.eng.br
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

[This fix is not very good for the global variable, any comments are
welcome.]

The thinkpad_acpi module_init fail out entrace is not very properly. if
failing before register driver or before create sysfs file, the
module_exit will try to remove nonexist sysfs files, the kernel will
oops.

Signed-off-by: Dave Young <hidave.darkstar@gmail.com>

---
drivers/misc/thinkpad_acpi.c |   19 +++++++++++++------
1 file changed, 13 insertions(+), 6 deletions(-)

diff -upr linux/drivers/misc/thinkpad_acpi.c linux.new/drivers/misc/thinkpad_acpi.c
--- linux/drivers/misc/thinkpad_acpi.c	2007-08-08 16:28:19.000000000 +0000
+++ linux.new/drivers/misc/thinkpad_acpi.c	2007-08-08 16:35:11.000000000 +0000
@@ -91,6 +91,8 @@ MODULE_LICENSE("GPL");
 
 /* Please remove this in year 2009 */
 MODULE_ALIAS("ibm_acpi");
+static int sysfs_ret = 1;
+static int driver_ret = 1;
 
 /*
  * DMI matching for module autoloading
@@ -4662,14 +4664,14 @@ static int __init thinkpad_acpi_module_i
 	}
 	proc_dir->owner = THIS_MODULE;
 
-	ret = platform_driver_register(&tpacpi_pdriver);
-	if (ret) {
+	driver_ret = platform_driver_register(&tpacpi_pdriver);
+	if (driver_ret) {
 		printk(IBM_ERR "unable to register platform driver\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
-	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
-	if (ret) {
+	sysfs_ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
+	if (sysfs_ret) {
 		printk(IBM_ERR "unable to create sysfs driver attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
@@ -4756,8 +4758,13 @@ static void thinkpad_acpi_module_exit(vo
 	if (tpacpi_pdev)
 		platform_device_unregister(tpacpi_pdev);
 
-	tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
-	platform_driver_unregister(&tpacpi_pdriver);
+	if(!sysfs_ret){
+		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
+	}
+
+	if(!driver_ret){
+		platform_driver_unregister(&tpacpi_pdriver);
+	}
 
 	if (proc_dir)
 		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
