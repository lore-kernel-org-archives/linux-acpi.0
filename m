From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/84] acer-wmi: Add EC quirk for Fujitsu Siemens Amilo Li 1718
Date: Sat, 28 Jun 2008 01:43:23 -0400
Message-ID: <9c392500ce76e7b1c58837f7c69c5fba42e06197.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:36217 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYF1FpE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:04 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500377RYTV4XD@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:54 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

This laptop needs a different EC quirk from the standard Acer one to read
the wireless status.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.5.6.1.89.gd544

