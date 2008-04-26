From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 04/14] ACPI: thinkpad-acpi: rate-limit CMOS/EC unsynced error messages
Date: Sat, 26 Apr 2008 01:02:20 -0300
Message-ID: <1209182550-32725-5-git-send-email-hmh@hmh.eng.br>
References: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55738 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124AbYDZECi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Apr 2008 00:02:38 -0400
In-Reply-To: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Joerg Platte <lists@naasa.net>

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
---
 drivers/misc/thinkpad_acpi.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 601dbe8..7dc6b73 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -239,6 +239,7 @@ static struct {
 
 static struct {
 	u16 hotkey_mask_ff:1;
+	u16 bright_cmos_ec_unsync:1;
 } tp_warned;
 
 struct thinkpad_id_data {
@@ -4323,13 +4324,20 @@ static int brightness_get(struct backlight_device *bd)
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
1.5.4.4

