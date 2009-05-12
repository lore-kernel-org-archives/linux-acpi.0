From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 1/3] ACPI: battery: Fix CONFIG_ACPI_SYSFS_POWER=n
Date: Tue, 12 May 2009 15:50:12 +0100
Message-ID: <4A098CA4.40708@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:62837 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbZELOuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2009 10:50:16 -0400
Received: by ewy24 with SMTP id 24so25917ewy.37
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2009 07:50:15 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

Disabling CONFIG_ACPI_SYSFS_POWER changes the behaviour of
acpi_battery_update().  It will call acpi_battery_get_info()
even if the battery is not present.  I haven't noticed this
causing any problem, but it does look like a bad idea.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b0de631..2ccc87e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -501,13 +501,13 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	result = acpi_battery_get_status(battery);
 	if (result)
 		return result;
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (!acpi_battery_present(battery)) {
+#ifdef CONFIG_ACPI_SYSFS_POWER
 		sysfs_remove_battery(battery);
+#endif
 		battery->update_time = 0;
 		return 0;
 	}
-#endif
 	if (!battery->update_time ||
 	    old_present != acpi_battery_present(battery)) {
 		result = acpi_battery_get_info(battery);


