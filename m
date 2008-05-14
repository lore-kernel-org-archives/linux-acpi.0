From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: /proc/acpi/battery/BAT0/info stale when battery changed on Thinkpad
 X60t
Date: Wed, 14 May 2008 21:10:41 +0400
Message-ID: <482B1D11.3000600@gmail.com>
References: <200805141105.02277.neitzke@ias.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:35343 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbYENRKF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 13:10:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so6942fgg.17
        for <linux-acpi@vger.kernel.org>; Wed, 14 May 2008 10:10:00 -0700 (PDT)
In-Reply-To: <200805141105.02277.neitzke@ias.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Neitzke <neitzke@ias.edu>
Cc: linux-acpi@vger.kernel.org

Please check if following patch helps:

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b1c723f..e5ca3a0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -472,7 +472,7 @@ static void sysfs_remove_battery(struct acpi_battery 
*battery)
 
 static int acpi_battery_update(struct acpi_battery *battery)
 {
-    int result;
+    int result, old_present = acpi_battery_present(battery);
     result = acpi_battery_get_status(battery);
     if (result)
         return result;
@@ -483,7 +483,8 @@ static int acpi_battery_update(struct acpi_battery 
*battery)
         return 0;
     }
 #endif
-    if (!battery->update_time) {
+    if (!battery->update_time ||
+        old_present != acpi_battery_present(battery)) {
         result = acpi_battery_get_info(battery);
         if (result)
             return result;

