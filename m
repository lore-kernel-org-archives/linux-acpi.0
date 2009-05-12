From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] ACPI: battery drivers should call power_supply_changed()
Date: Tue, 12 May 2009 15:50:58 +0100
Message-ID: <4A098CD2.2030608@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:43172 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbZELOvB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2009 10:51:01 -0400
Received: by ewy24 with SMTP id 24so26527ewy.37
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2009 07:51:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

Calling kobject_uevent() directly is a layering violation.  In
particular, it means we'll miss updating the generic LED trigger.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2ccc87e..9208e97 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -812,7 +812,7 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_batter_update could remove power_supply object */
 	if (battery->bat.dev)
-		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
+		power_supply_changed(&battery->bat);
 #endif
 }
 
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 4b214b7..dfa9455 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -890,7 +890,7 @@ static void acpi_sbs_callback(void *context)
 					      sbs->charger_present);
 #endif
 #ifdef CONFIG_ACPI_SYSFS_POWER
-		kobject_uevent(&sbs->charger.dev->kobj, KOBJ_CHANGE);
+		power_supply_changed(&sbs->charger);
 #endif
 	}
 	if (sbs->manager_present) {
@@ -909,7 +909,7 @@ static void acpi_sbs_callback(void *context)
 						      bat->present);
 #endif
 #ifdef CONFIG_ACPI_SYSFS_POWER
-			kobject_uevent(&bat->bat.dev->kobj, KOBJ_CHANGE);
+			power_supply_changed(&bat->bat);
 #endif
 		}
 	}


