From: Len Brown <lenb@kernel.org>
Subject: [PATCH 159/171] ACPI: thinkpad-acpi: rate-limit CMOS/EC unsynced error messages
Date: Tue, 29 Apr 2008 04:44:24 -0400
Message-ID: <7d18880b652489413afbd3118df77cd305af0814.1209457072.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28120 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760840AbYD2Ipc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:32 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Joerg Platte <lists@naasa.net>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

If userspace applications mess with the CMOS NVRAM, or something causes
both the ACPI firmware and thinkpad-acpi to try to change the brightness at
the same time, it is possible to have the CMOS and EC registers for the
current brightness go out of sync.

Should that happen, thinkpad-acpi could be really obnoxious when using a
brightness_mode of 3 (both EC and CMOS).  Instead of complaining a massive
number of times, make sure to complain only once until EC and CMOS are back
in sync.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Joerg Platte <lists@naasa.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c8c1d6c..3513d99 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -239,6 +239,7 @@ static struct {
 
 static struct {
 	u16 hotkey_mask_ff:1;
+	u16 bright_cmos_ec_unsync:1;
 } tp_warned;
 
 struct thinkpad_id_data {
@@ -4322,13 +4323,20 @@ static int brightness_get(struct backlight_device *bd)
 		level = lcmos;
 	}
 
-	if (brightness_mode == 3 && lec != lcmos) {
-		printk(TPACPI_ERR
-			"CMOS NVRAM (%u) and EC (%u) do not agree "
-			"on display brightness level\n",
-			(unsigned int) lcmos,
-			(unsigned int) lec);
-		return -EIO;
+	if (brightness_mode == 3) {
+		if (lec == lcmos)
+			tp_warned.bright_cmos_ec_unsync = 0;
+		else {
+			if (!tp_warned.bright_cmos_ec_unsync) {
+				printk(TPACPI_ERR
+					"CMOS NVRAM (%u) and EC (%u) do not "
+					"agree on display brightness level\n",
+					(unsigned int) lcmos,
+					(unsigned int) lec);
+				tp_warned.bright_cmos_ec_unsync = 1;
+			}
+			return -EIO;
+		}
 	}
 
 	return level;
-- 
1.5.5.1.99.gf0ec4

