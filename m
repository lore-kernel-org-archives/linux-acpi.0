From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [RESEND] [PATCH 1/3] ACPI: battery: Fix CONFIG_ACPI_SYSFS_POWER=n
Date: Tue, 30 Jun 2009 15:35:05 +0100
Message-ID: <4A4A2299.8060401@tuffmail.co.uk>
References: <4A4A219C.2020802@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:56709 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbZF3OfF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2009 10:35:05 -0400
Received: by ewy6 with SMTP id 6so228703ewy.37
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2009 07:35:07 -0700 (PDT)
In-Reply-To: <4A4A219C.2020802@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

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
index 58b4517..908edce 100644
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
-- 
1.6.3.2



