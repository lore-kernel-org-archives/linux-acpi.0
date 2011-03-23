From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/42] ACPI / Button: Avoid disabling wakeup unnecessarily on
 remove
Date: Wed, 23 Mar 2011 02:42:22 -0400
Message-ID: <c19f9a84ec807da57fd75bbd9a3f2b8269611f79.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:32934 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab1CWGnU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 02:43:20 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII009VO006WYD1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 01:43:20 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

From: Rafael J. Wysocki <rjw@sisk.pl>

If a button device had already been enabled to wake up the system
from sleep states before the button driver saw it, the driver
shouldn't disable the device's wakeup capability when being detached
from the device.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/button.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index e643a09..12c28f4 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -98,6 +98,7 @@ struct acpi_button {
 	struct input_dev *input;
 	char phys[32];			/* for input device */
 	unsigned long pushed;
+	bool wakeup_enabled;
 };
 
 static const struct file_operations acpi_button_info_fops = {
@@ -430,7 +431,10 @@ static int acpi_button_add(struct acpi_device *device)
 		/* Button's GPE is run-wake GPE */
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
-		device_set_wakeup_enable(&device->dev, true);
+		if (!device_may_wakeup(&device->dev)) {
+			device_set_wakeup_enable(&device->dev, true);
+			button->wakeup_enabled = true;
+		}
 	}
 
 	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
@@ -452,7 +456,8 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 	if (device->wakeup.flags.valid) {
 		acpi_disable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
-		device_set_wakeup_enable(&device->dev, false);
+		if (button->wakeup_enabled)
+			device_set_wakeup_enable(&device->dev, false);
 	}
 
 	acpi_button_remove_fs(device);
-- 
1.7.4.1.343.ga91df

