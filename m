From: Shen Canquan <shencanquan@huawei.com>
Subject: [Patch 1/1] Hot cpu remove patch
Date: Mon, 25 Jul 2011 03:01:36 +0000
Message-ID: <F1F5DF04259F1B4A82BD6BDE1C479F7452C78F@szxeml527-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:60313 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1GYDBt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Jul 2011 23:01:49 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0LOV00HUKCEPYR@szxga03-in.huawei.com> for
 linux-acpi@vger.kernel.org; Mon, 25 Jul 2011 11:01:38 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0LOV005EACEEDP@szxga03-in.huawei.com> for
 linux-acpi@vger.kernel.org; Mon, 25 Jul 2011 11:01:37 +0800 (CST)
Content-language: zh-CN
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hello，
   Recently, I test the cpu hot add and remove function. It is ok for cpu hot add. but it is failure on cpu hot remove . If I modify the source code(Please see the following patch content). It is successful on cpu hot remove.
patch content:
 
--- linux-2.6.39.3_modify/drivers/acpi/processor_driver.c       2011-07-25 09:11:51.000000000 +0800
+++ linux-2.6.39.3/drivers/acpi/processor_driver.c      2011-07-09 14:16:06.000000000 +0800
@@ -677,11 +677,6 @@
                                    "Driver data is NULL, dropping EJECT\n");
                        return;
                }
-               /*The alternative way of modify is add the following code:
-                       kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
-               */
-               /*async execute the acip_bus_hot_remove_device*/
-               acpi_os_hotplug_execute(acpi_bus_hot_remove_device, handle);
                break;
        default:
                ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff -u -r linux-2.6.39.3_modify/drivers/acpi/scan.c linux-2.6.39.3/drivers/acpi/scan.c
--- linux-2.6.39.3_modify/drivers/acpi/scan.c   2011-07-20 15:28:52.000000000 +0800
+++ linux-2.6.39.3/drivers/acpi/scan.c  2011-07-09 14:16:06.000000000 +0800
@@ -83,7 +83,7 @@
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
- void acpi_bus_hot_remove_device(void *context)
+static void acpi_bus_hot_remove_device(void *context)
 {
        struct acpi_device *device;
        acpi_handle handle = context;
diff -u -r linux-2.6.39.3_modify/include/acpi/acpi_bus.h linux-2.6.39.3/include/acpi/acpi_bus.h
--- linux-2.6.39.3_modify/include/acpi/acpi_bus.h       2011-07-20 15:30:04.000000000 +0800
+++ linux-2.6.39.3/include/acpi/acpi_bus.h      2011-07-09 14:16:06.000000000 +0800
@@ -342,7 +342,7 @@
                          const struct acpi_device_id *ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
-void acpi_bus_hot_remove_device(void *context);
+
 /*
  * Bind physical devices with ACPI devices
                                               
 */
 
 
Jason.shen
2011-07-25
