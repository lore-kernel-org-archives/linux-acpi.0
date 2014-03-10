From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH 2/3] ACPI / battery: call ACPI notifier chain in acpi_battery_notify
Date: Mon, 10 Mar 2014 18:47:40 +0700
Message-ID: <1394452061-27777-2-git-send-email-mezin.alexander@gmail.com>
References: <1394452061-27777-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:43688 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbaCJLuE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 07:50:04 -0400
Received: by mail-lb0-f169.google.com with SMTP id l4so4617715lbv.0
        for <linux-acpi@vger.kernel.org>; Mon, 10 Mar 2014 04:50:03 -0700 (PDT)
In-Reply-To: <1394452061-27777-1-git-send-email-mezin.alexander@gmail.com>
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
index 0a19c8f..861e585 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -737,6 +737,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
+	acpi_notifier_call_chain(device, event, acpi_battery_present(battery));
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat.dev)
 		power_supply_changed(&battery->bat);
-- 
1.9.0

