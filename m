From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] ACPI/Button: Fix enable Button GPEs twice
Date: Fri,  6 Dec 2013 14:47:14 +0800
Message-ID: <1386312434-3476-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39645 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab3LFGrW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Dec 2013 01:47:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Button GPEs have been enabled in the acpi_wake_device_init() during
boot and Button driver enables these GPEs second time. This causes
disabling these gpes via sysfs interface requires twice "echo disable
> /sys/firmware/acpi/interrupts/gpeXXX". This patch is to remove
related code in the Button driver.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/button.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 9e3a6cb..6643f2d 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -406,15 +406,9 @@ static int acpi_button_add(struct acpi_device *device)
 		lid_device = device;
 	}
 
-	if (device->wakeup.flags.valid) {
-		/* Button's GPE is run-wake GPE */
-		acpi_enable_gpe(device->wakeup.gpe_device,
-				device->wakeup.gpe_number);
-		if (!device_may_wakeup(&device->dev)) {
-			device_set_wakeup_enable(&device->dev, true);
-			button->wakeup_enabled = true;
-		}
-	}
+	/* Button GPEs have been enalbed in the acpi_wakeup_device_list()*/
+	if (device->wakeup.flags.valid)
+		button->wakeup_enabled = true;
 
 	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
-- 
1.8.2.1

