From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] ACPI fan: fix memleak on acpi_fan_add_fs() failure
Date: Sun, 13 Sep 2009 11:28:30 +0100
Message-ID: <4AACC94E.9040208@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:33728 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZIMK23 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Sep 2009 06:28:29 -0400
Received: by ewy2 with SMTP id 2so2202156ewy.17
        for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2009 03:28:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/acpi/fan.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 947556e..eb1511e 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -283,13 +283,17 @@ static int acpi_fan_add(struct acpi_device *device)
 
 	result = acpi_fan_add_fs(device);
 	if (result)
-		goto end;
+		goto unregister;
 
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       !device->power.state ? "on" : "off");
 
-      end:
+unregister:
+	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
+	sysfs_remove_link(&cdev->device.kobj, "device");
+	thermal_cooling_device_unregister(cdev);
+end:
 	return result;
 }
 

