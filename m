From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] Subject: [PATCH] ACPI: Battery: Update info for inserted
	battery
Date: Tue, 23 Dec 2008 02:44:54 +0300
Message-ID: <20081222234454.758.6653.stgit@thinkpad>
References: <alpine.LFD.2.00.0812221748020.20902@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39831 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755255AbYLVXo7 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 22 Dec 2008 18:44:59 -0500
In-Reply-To: <alpine.LFD.2.00.0812221748020.20902@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Newly inserted battery might differ from one just removed, so
update of battery info fields is required.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Acked-by: Andy Neitzke <neitzke@ias.edu>

Signed-off-by: Alexey Starikovskiy <astarikovskiy <at> suse.de>
---

 drivers/acpi/battery.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1423b0c..65132f9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -471,7 +471,7 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 
 static int acpi_battery_update(struct acpi_battery *battery)
 {
-	int result;
+	int result, old_present = acpi_battery_present(battery);
 	result = acpi_battery_get_status(battery);
 	if (result)
 		return result;
@@ -482,7 +482,8 @@ static int acpi_battery_update(struct acpi_battery *battery)
 		return 0;
 	}
 #endif
-	if (!battery->update_time) {
+	if (!battery->update_time ||
+	    old_present != acpi_battery_present(battery)) {
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;

