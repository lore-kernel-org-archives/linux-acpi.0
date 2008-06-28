From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/84] acer-wmi: Blacklist backlight on Acer Aspire 1520 & 1360
 series
Date: Sat, 28 Jun 2008 01:43:21 -0400
Message-ID: <580fc6ba925889b3445a8ce432dc89edf34e21c7.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61855 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYF1Fo7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:59 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500HBMRYSJGJA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:53 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

A newer BIOS for these laptops adds ACPI-WMI support to them. However, it does
not add support for the backlight via the EC, and we have no way to detect
this on older machines, so blacklist it from them.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/acer-wmi.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index dd13a37..b82ff25 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -174,7 +174,7 @@ static struct wmi_interface *interface;
 struct quirk_entry {
 	u8 wireless;
 	u8 mailled;
-	u8 brightness;
+	s8 brightness;
 	u8 bluetooth;
 };
 
@@ -198,6 +198,10 @@ static int dmi_matched(const struct dmi_system_id *dmi)
 static struct quirk_entry quirk_unknown = {
 };
 
+static struct quirk_entry quirk_acer_aspire_1520 = {
+	.brightness = -1,
+};
+
 static struct quirk_entry quirk_acer_travelmate_2490 = {
 	.mailled = 1,
 };
@@ -210,6 +214,24 @@ static struct quirk_entry quirk_medion_md_98300 = {
 static struct dmi_system_id acer_quirks[] = {
 	{
 		.callback = dmi_matched,
+		.ident = "Acer Aspire 1360",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
+		},
+		.driver_data = &quirk_acer_aspire_1520,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire 1520",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1520"),
+		},
+		.driver_data = &quirk_acer_aspire_1520,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Acer Aspire 3100",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
@@ -552,7 +574,8 @@ static acpi_status AMW0_set_capabilities(void)
 	 * appear to use the same EC register for brightness, even if they
 	 * differ for wireless, etc
 	 */
-	interface->capability |= ACER_CAP_BRIGHTNESS;
+	if (quirks->brightness >= 0)
+		interface->capability |= ACER_CAP_BRIGHTNESS;
 
 	return AE_OK;
 }
@@ -1059,6 +1082,8 @@ static int __init acer_wmi_init(void)
 	printk(ACER_INFO "Acer Laptop ACPI-WMI Extras version %s\n",
 			ACER_WMI_VERSION);
 
+	find_quirks();
+
 	/*
 	 * Detect which ACPI-WMI interface we're using.
 	 */
@@ -1092,8 +1117,6 @@ static int __init acer_wmi_init(void)
 	if (wmi_has_guid(AMW0_GUID1))
 		AMW0_find_mailled();
 
-	find_quirks();
-
 	if (!interface) {
 		printk(ACER_ERR "No or unsupported WMI interface, unable to "
 				"load\n");
-- 
1.5.6.1.89.gd544

