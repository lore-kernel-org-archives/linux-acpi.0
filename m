From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [RFC] ACPI battery driver: odd usage of generic power supply class
 on battery removal
Date: Sun, 10 May 2009 18:57:46 +0100
Message-ID: <4A07159A.9010006@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:42640 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbZEJR6J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 May 2009 13:58:09 -0400
Received: by ewy24 with SMTP id 24so2978619ewy.37
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2009 10:58:09 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Hi,

The ACPI battery driver does something strange with the generic power 
supply class, when the battery is removed from my laptop.  Instead of 
clearing the "present" attribute of the class device, it removes the 
entire class device.

Can this be corrected, or is there a specific reason for it?

Patch follows for illustration purposes.

If this can be changed, I'd also try to cleanup acpi_battery_update().  
I don't think it's right that CONFIG_ACPI_SYSFS_POWER affects the 
control flow.  When it's disabled, acpi_battery_present() is not tested 
before calling acpi_battery_get_state().  It might not cause any 
problems, but it is evil.

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 69cbc57..050444a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -482,6 +482,11 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 	return device_create_file(battery->bat.dev, &alarm_attr);
 }
 
+static void sysfs_update_battery(struct acpi_battery *battery)
+{
+	power_supply_changed(&battery->bat);
+}
+
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
 	if (!battery->bat.dev)
@@ -500,7 +505,7 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		return result;
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	if (!acpi_battery_present(battery)) {
-		sysfs_remove_battery(battery);
+		sysfs_update_battery(battery);
 		battery->update_time = 0;
 		return 0;
 	}
@@ -513,8 +518,7 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		acpi_battery_init_alarm(battery);
 	}
 #ifdef CONFIG_ACPI_SYSFS_POWER
-	if (!battery->bat.dev)
-		sysfs_add_battery(battery);
+	sysfs_update_battery(battery);
 #endif
 	return acpi_battery_get_state(battery);
 }


