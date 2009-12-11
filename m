From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 1/2] ACPI: battery: Fix CONFIG_ACPI_SYSFS_POWER=n
Date: Fri, 11 Dec 2009 11:04:42 +0000
Message-ID: <4B22274A.1000003@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:47567 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803AbZLKLEo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 06:04:44 -0500
Received: by fxm21 with SMTP id 21so851872fxm.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2009 03:04:50 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Disabling CONFIG_ACPI_SYSFS_POWER changes the behaviour of
acpi_battery_update().  It will call acpi_battery_get_info()
even if the battery is not present.  I haven't noticed this
causing any problem, but it does look like a bad idea.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/battery.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3f4602b..ed4aeab 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -522,13 +522,13 @@ static int acpi_battery_update(struct acpi_battery *battery)
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
-- 
1.6.3.3



