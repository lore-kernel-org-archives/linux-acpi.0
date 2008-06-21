From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 4/7] acer-wmi: Add EC quirk for Fujitsu Siemens Amilo Li 1718
Date: Sat, 21 Jun 2008 09:09:38 +0100
Message-ID: <20080621080937.26920.93257.stgit@pacifica>
References: <20080621080903.26920.14225.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:38509 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755148AbYFUIgM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jun 2008 04:36:12 -0400
In-Reply-To: <20080621080903.26920.14225.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

This laptop needs a different EC quirk from the standard Acer one to read
the wireless status.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index e35825f..5b7c5fc 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -212,6 +212,10 @@ static struct quirk_entry quirk_medion_md_98300 = {
 	.wireless = 1,
 };
 
+static struct quirk_entry quirk_fujitsu_amilo_li_1718 = {
+	.wireless = 2,
+};
+
 static struct dmi_system_id acer_quirks[] = {
 	{
 		.callback = dmi_matched,
@@ -323,6 +327,15 @@ static struct dmi_system_id acer_quirks[] = {
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Fujitsu Siemens Amilo Li 1718",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Li 1718"),
+		},
+		.driver_data = &quirk_fujitsu_amilo_li_1718,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Medion MD 98300",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
@@ -416,6 +429,12 @@ struct wmi_interface *iface)
 				return AE_ERROR;
 			*value = result & 0x1;
 			return AE_OK;
+		case 2:
+			err = ec_read(0x71, &result);
+			if (err)
+				return AE_ERROR;
+			*value = result & 0x1;
+			return AE_OK;
 		default:
 			err = ec_read(0xA, &result);
 			if (err)

