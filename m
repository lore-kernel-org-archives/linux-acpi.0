From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH 1/2] ACPI / battery: call ACPI notifier chain in acpi_battery_notify
Date: Mon, 10 Mar 2014 05:37:31 +0700
Message-ID: <1394404652-5873-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:42133 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaCIWjk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Mar 2014 18:39:40 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so4215273lbj.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Mar 2014 15:39:38 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Alexander Mezin <mezin.alexander@gmail.com>

Allow other drivers to subscribe to battery status notifications.
Just like AC driver does.

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 drivers/acpi/battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 797a693..8c98fd6 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -736,6 +736,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
+	acpi_notifier_call_chain(device, event, acpi_battery_present(battery));
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat.dev)
 		power_supply_changed(&battery->bat);
-- 
1.9.0

