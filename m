From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/7] acer-wmi: Blacklist backlight on Acer Aspire 1520 & 1360
	series
Date: Sat, 21 Jun 2008 09:09:22 +0100
Message-ID: <20080621080920.26920.62205.stgit@pacifica>
References: <20080621080903.26920.14225.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:38509 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755163AbYFUIgP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jun 2008 04:36:15 -0400
In-Reply-To: <20080621080903.26920.14225.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

A newer BIOS for these laptops adds ACPI-WMI support to them. However, it does
not add support for the backlight via the EC, and we have no way to detect
this on older machines, so blacklist it from them.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
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

