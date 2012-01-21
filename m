From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] ACPI / PM: Add Sony Vaio VPCCW29FX to nonvs blacklist.
Date: Sat, 21 Jan 2012 09:23:56 +0800
Message-ID: <1327109036-27162-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54475 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab2AUBXE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2012 20:23:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, rjw@sisk.pl
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org

Sony Vaio VPCCW29FX does not resume correctly without
acpi_sleep=nonvs, so add it to the ACPI sleep blacklist.

https://bugzilla.kernel.org/show_bug.cgi?id=34722

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 0a7ed69..2703d61 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -436,6 +436,14 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "VGN-NW130D"),
 		},
 	},
+ 	{
+ 	.callback = init_nvs_nosave,
+	.ident = "Sony Vaio VPCCW29FX",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCCW29FX"),
+		},
+	},
 	{
 	.callback = init_nvs_nosave,
 	.ident = "Averatec AV1020-ED2",
-- 
1.7.6.rc2.8.g28eb

