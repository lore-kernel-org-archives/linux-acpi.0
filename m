From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/5] thinkpad-acpi: fix BEEP ACPI handler warnings
Date: Sat, 30 May 2009 13:25:07 -0300
Message-ID: <1243700709-25977-4-git-send-email-hmh@hmh.eng.br>
References: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40003 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758222AbZE3QZS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 May 2009 12:25:18 -0400
In-Reply-To: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some ThinkPads want two arguments for BEEP, while others want just
one, causing ACPICA to log warnings like this:

ACPI Warning (nseval-0177): Excess arguments - method [BEEP] needs 1,
found 2 [20080926]

Deal with it.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3981b06..da739d5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -264,6 +264,7 @@ static struct {
 	u32 wan:1;
 	u32 uwb:1;
 	u32 fan_ctrl_status_undef:1;
+	u32 beep_needs_two_args:1;
 	u32 input_device_registered:1;
 	u32 platform_drv_registered:1;
 	u32 platform_drv_attrs_registered:1;
@@ -5142,8 +5143,17 @@ static struct ibm_struct led_driver_data = {
 
 TPACPI_HANDLE(beep, ec, "BEEP");	/* all except R30, R31 */
 
+#define TPACPI_BEEP_Q1 0x0001
+
+static const struct tpacpi_quirk beep_quirk_table[] __initconst = {
+	TPACPI_Q_IBM('I', 'M', TPACPI_BEEP_Q1), /* 570 */
+	TPACPI_Q_IBM('I', 'U', TPACPI_BEEP_Q1), /* 570E - unverified */
+};
+
 static int __init beep_init(struct ibm_init_struct *iibm)
 {
+	unsigned long quirks;
+
 	vdbg_printk(TPACPI_DBG_INIT, "initializing beep subdriver\n");
 
 	TPACPI_ACPIHANDLE_INIT(beep);
@@ -5151,6 +5161,11 @@ static int __init beep_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "beep is %s\n",
 		str_supported(beep_handle != NULL));
 
+	quirks = tpacpi_check_quirks(beep_quirk_table,
+				     ARRAY_SIZE(beep_quirk_table));
+
+	tp_features.beep_needs_two_args = !!(quirks & TPACPI_BEEP_Q1);
+
 	return (beep_handle)? 0 : 1;
 }
 
@@ -5182,8 +5197,15 @@ static int beep_write(char *buf)
 			/* beep_cmd set */
 		} else
 			return -EINVAL;
-		if (!acpi_evalf(beep_handle, NULL, NULL, "vdd", beep_cmd, 0))
-			return -EIO;
+		if (tp_features.beep_needs_two_args) {
+			if (!acpi_evalf(beep_handle, NULL, NULL, "vdd",
+					beep_cmd, 0))
+				return -EIO;
+		} else {
+			if (!acpi_evalf(beep_handle, NULL, NULL, "vd",
+					beep_cmd))
+				return -EIO;
+		}
 	}
 
 	return 0;
-- 
1.6.2.4

