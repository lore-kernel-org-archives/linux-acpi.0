From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] Fix priority mistakes in acpi_battery_update()
Date: Fri, 26 Oct 2007 23:41:24 +0200
Message-ID: <47225F04.6080303@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out2.tiscali.nl ([195.241.79.177]:49212 "EHLO
	smtp-out2.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbXJZVl2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 17:41:28 -0400
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IlWvn-0005D1-99
	for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 23:41:27 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Fixes priority mistakes similar to '!x & y'
    
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9b2c0f7..3762ce2 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -420,8 +420,7 @@ static int acpi_battery_update(struct acpi_battery *battery,
 		result = acpi_battery_get_status(battery);
 		if (result)
 			goto end;
-		if ((!battery->flags.battery_present_prev & acpi_battery_present(battery))
-		    || (battery->flags.battery_present_prev & !acpi_battery_present(battery))) {
+		if (battery->flags.battery_present_prev != acpi_battery_present(battery)) {
 			result = acpi_battery_init_update(battery);
 			if (result)
 				goto end;
@@ -448,10 +447,7 @@ static void acpi_battery_notify_update(struct acpi_battery *battery)
 		return;
 	}
 
-	if ((!battery->flags.battery_present_prev &
-	     acpi_battery_present(battery)) ||
-	    (battery->flags.battery_present_prev &
-	     !acpi_battery_present(battery))) {
+	if (battery->flags.battery_present_prev != acpi_battery_present(battery)) {
 		battery->flags.init_update = 1;
 	} else {
 		battery->flags.update[ACPI_BATTERY_INFO] = 1;

