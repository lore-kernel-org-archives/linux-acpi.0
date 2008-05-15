From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: Battery: Update info for inserted battery
Date: Thu, 15 May 2008 13:26:33 +0400
Message-ID: <20080515092633.1640.49831.stgit@thinkpad>
References: <200805141918.50286.neitzke@ias.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:45452 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755395AbYEOJZr (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 15 May 2008 05:25:47 -0400
In-Reply-To: <200805141918.50286.neitzke@ias.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Acked-by: Andy Neitzke <neitzke@ias.edu>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b1c723f..e5ca3a0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -472,7 +472,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 
 static int acpi_battery_update(struct acpi_battery *battery)
 {
-	int result;
+	int result, old_present = acpi_battery_present(battery);
 	result = acpi_battery_get_status(battery);
 	if (result)
 		return result;
@@ -483,7 +483,8 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		return 0;
 	}
 #endif
-	if (!battery->update_time) {
+	if (!battery->update_time ||
+	    old_present != acpi_battery_present(battery)) {
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;

