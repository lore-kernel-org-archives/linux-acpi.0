From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/5] thinkpad-acpi: store fw version with strict checking
Date: Sat, 30 May 2009 13:25:05 -0300
Message-ID: <1243700709-25977-2-git-send-email-hmh@hmh.eng.br>
References: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59680 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751815AbZE3QZR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 May 2009 12:25:17 -0400
In-Reply-To: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Extend the thinkpad model and firmware identification data with the
release serial number for the BIOS and firmware (when available), as
that is easier to parse and compare than the version strings.

We're going to greatly extend the use of the ThinkPad DMI data through
quirk lists, so it is best to be quite strict and make sure what we
get from DMI is exactly what we expect, otherwise quirk matching may
result in quite insane things.

IBM (and Lenovo, at least for the ThinkPad line) uses this schema for
firmware versioning and model:

Firmware model: Two digits, [0-9A-Z]

Firmware version: AABBCCDD, where
  AA = firmware model, see above
  BB = "ET" for BIOS, "HT" for EC
  CC = release version, two digits, [0-9A-Z],
       "00" < "09" < "0A" < "10" < "A0" < "ZZ"
  DD = "WW"

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   46 +++++++++++++++++++++++++++++++---
 1 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 912be65..d2a0ef8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -284,8 +284,10 @@ struct thinkpad_id_data {
 	char *bios_version_str;	/* Something like 1ZET51WW (1.03z) */
 	char *ec_version_str;	/* Something like 1ZHT51WW-1.04a */
 
-	u16 bios_model;		/* Big Endian, TP-1Y = 0x5931, 0 = unknown */
+	u16 bios_model;		/* 1Y = 0x5931, 0 = unknown */
 	u16 ec_model;
+	u16 bios_release;	/* 1ZETK1WW = 0x314b, 0 = unknown */
+	u16 ec_release;
 
 	char *model_str;	/* ThinkPad T43 */
 	char *nummodel_str;	/* 9384A9C for a 9384-A9C model */
@@ -7357,6 +7359,24 @@ err_out:
 
 /* Probing */
 
+static bool __pure __init tpacpi_is_fw_digit(const char c)
+{
+	return (c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z');
+}
+
+/* Most models: xxyTkkWW (#.##c); Ancient 570/600 and -SL lacks (#.##c) */
+static bool __pure __init tpacpi_is_valid_fw_id(const char* const s,
+						const char t)
+{
+	return s && strlen(s) >= 8 &&
+		tpacpi_is_fw_digit(s[0]) &&
+		tpacpi_is_fw_digit(s[1]) &&
+		s[2] == t && s[3] == 'T' &&
+		tpacpi_is_fw_digit(s[4]) &&
+		tpacpi_is_fw_digit(s[5]) &&
+		s[6] == 'W' && s[7] == 'W';
+}
+
 /* returns 0 - probe ok, or < 0 - probe error.
  * Probe ok doesn't mean thinkpad found.
  * On error, kfree() cleanup on tp->* is not performed, caller must do it */
@@ -7383,10 +7403,15 @@ static int __must_check __init get_thinkpad_model_data(
 	tp->bios_version_str = kstrdup(s, GFP_KERNEL);
 	if (s && !tp->bios_version_str)
 		return -ENOMEM;
-	if (!tp->bios_version_str)
+
+	/* Really ancient ThinkPad 240X will fail this, which is fine */
+	if (!tpacpi_is_valid_fw_id(tp->bios_version_str, 'E'))
 		return 0;
+
 	tp->bios_model = tp->bios_version_str[0]
 			 | (tp->bios_version_str[1] << 8);
+	tp->bios_release = (tp->bios_version_str[4] << 8)
+			 | tp->bios_version_str[5];
 
 	/*
 	 * ThinkPad T23 or newer, A31 or newer, R50e or newer,
@@ -7405,8 +7430,21 @@ static int __must_check __init get_thinkpad_model_data(
 			tp->ec_version_str = kstrdup(ec_fw_string, GFP_KERNEL);
 			if (!tp->ec_version_str)
 				return -ENOMEM;
-			tp->ec_model = ec_fw_string[0]
-					| (ec_fw_string[1] << 8);
+
+			if (tpacpi_is_valid_fw_id(ec_fw_string, 'H')) {
+				tp->ec_model = ec_fw_string[0]
+						| (ec_fw_string[1] << 8);
+				tp->ec_release = (ec_fw_string[4] << 8)
+						| ec_fw_string[5];
+			} else {
+				printk(TPACPI_NOTICE
+					"ThinkPad firmware release %s "
+					"doesn't match the known patterns\n",
+					ec_fw_string);
+				printk(TPACPI_NOTICE
+					"please report this to %s\n",
+					TPACPI_MAIL);
+			}
 			break;
 		}
 	}
-- 
1.6.2.4

