From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH 2/3] ACPI / battery: call ACPI notifier chain in acpi_battery_notify
Date: Wed, 12 Mar 2014 00:58:47 +0700
Message-ID: <1394560728-14048-2-git-send-email-mezin.alexander@gmail.com>
References: <1394560728-14048-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52755 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaCKSBm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2014 14:01:42 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so5945524lbg.11
        for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2014 11:01:40 -0700 (PDT)
In-Reply-To: <1394560728-14048-1-git-send-email-mezin.alexander@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexander Mezin <mezin.alexander@gmail.com>

Allow other drivers to subscribe to battery status notifications.
Just like AC driver does.

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 drivers/acpi/battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index bfec70f..9a2c63b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -734,6 +734,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
+	acpi_notifier_call_chain(device, event, acpi_battery_present(battery));
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat.dev)
 		power_supply_changed(&battery->bat);
-- 
1.9.0

