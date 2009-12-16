From: Len Brown <lenb@kernel.org>
Subject: [PATCH 097/103] acerhdf: add new BIOS versions
Date: Wed, 16 Dec 2009 03:36:48 -0500
Message-ID: <360657463679dee44f0b167ffa61f563b4fee101.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762132AbZLPMGT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:19 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:06:02 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Peter Feuerer <peter@piie.net>, Borislav Petkov <petkovbb@gmail.com>, Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Peter Feuerer <peter@piie.net>

Added new BIOS versions for following netbooks: Acer 1410, Gateway LT31,
Packard Bell DOA150.  As the Gateway LT31 machines have different register
values for setting and checking the off-state, the "cmd_off" variable has
been splitted up to "cmd_off" and "chk_off".

Signed-off-by: Peter Feuerer <peter@piie.net>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/acerhdf.c |   63 +++++++++++++++++++++++----------------
 1 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index ab64522..d8b4229 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -52,7 +52,7 @@
  */
 #undef START_IN_KERNEL_MODE
 
-#define DRV_VER "0.5.18"
+#define DRV_VER "0.5.20"
 
 /*
  * According to the Atom N270 datasheet,
@@ -112,12 +112,14 @@ module_param_string(force_product, force_product, 16, 0);
 MODULE_PARM_DESC(force_product, "Force BIOS product and omit BIOS check");
 
 /*
- * cmd_off: to switch the fan completely off / to check if the fan is off
+ * cmd_off: to switch the fan completely off
+ * chk_off: to check if the fan is off
  *	cmd_auto: to set the BIOS in control of the fan. The BIOS regulates then
  *		the fan speed depending on the temperature
  */
 struct fancmd {
 	u8 cmd_off;
+	u8 chk_off;
 	u8 cmd_auto;
 };
 
@@ -134,32 +136,41 @@ struct bios_settings_t {
 /* Register addresses and values for different BIOS versions */
 static const struct bios_settings_t bios_tbl[] = {
 	/* AOA110 */
-	{"Acer", "AOA110", "v0.3109", 0x55, 0x58, {0x1f, 0x00} },
-	{"Acer", "AOA110", "v0.3114", 0x55, 0x58, {0x1f, 0x00} },
-	{"Acer", "AOA110", "v0.3301", 0x55, 0x58, {0xaf, 0x00} },
-	{"Acer", "AOA110", "v0.3304", 0x55, 0x58, {0xaf, 0x00} },
-	{"Acer", "AOA110", "v0.3305", 0x55, 0x58, {0xaf, 0x00} },
-	{"Acer", "AOA110", "v0.3307", 0x55, 0x58, {0xaf, 0x00} },
-	{"Acer", "AOA110", "v0.3308", 0x55, 0x58, {0x21, 0x00} },
-	{"Acer", "AOA110", "v0.3309", 0x55, 0x58, {0x21, 0x00} },
-	{"Acer", "AOA110", "v0.3310", 0x55, 0x58, {0x21, 0x00} },
+	{"Acer", "AOA110", "v0.3109", 0x55, 0x58, {0x1f, 0x1f, 0x00} },
+	{"Acer", "AOA110", "v0.3114", 0x55, 0x58, {0x1f, 0x1f, 0x00} },
+	{"Acer", "AOA110", "v0.3301", 0x55, 0x58, {0xaf, 0xaf, 0x00} },
+	{"Acer", "AOA110", "v0.3304", 0x55, 0x58, {0xaf, 0xaf, 0x00} },
+	{"Acer", "AOA110", "v0.3305", 0x55, 0x58, {0xaf, 0xaf, 0x00} },
+	{"Acer", "AOA110", "v0.3307", 0x55, 0x58, {0xaf, 0xaf, 0x00} },
+	{"Acer", "AOA110", "v0.3308", 0x55, 0x58, {0x21, 0x21, 0x00} },
+	{"Acer", "AOA110", "v0.3309", 0x55, 0x58, {0x21, 0x21, 0x00} },
+	{"Acer", "AOA110", "v0.3310", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	/* AOA150 */
-	{"Acer", "AOA150", "v0.3114", 0x55, 0x58, {0x20, 0x00} },
-	{"Acer", "AOA150", "v0.3301", 0x55, 0x58, {0x20, 0x00} },
-	{"Acer", "AOA150", "v0.3304", 0x55, 0x58, {0x20, 0x00} },
-	{"Acer", "AOA150", "v0.3305", 0x55, 0x58, {0x20, 0x00} },
-	{"Acer", "AOA150", "v0.3307", 0x55, 0x58, {0x20, 0x00} },
-	{"Acer", "AOA150", "v0.3308", 0x55, 0x58, {0x20, 0x00} },
-	{"Acer", "AOA150", "v0.3309", 0x55, 0x58, {0x20, 0x00} },
-	{"Acer", "AOA150", "v0.3310", 0x55, 0x58, {0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3114", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3301", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3304", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3305", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3307", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3308", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3309", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3310", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	/* Acer 1410 */
+	{"Acer", "Aspire 1410", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	/* special BIOS / other */
-	{"Gateway", "AOA110", "v0.3103", 0x55, 0x58, {0x21, 0x00} },
-	{"Gateway", "AOA150", "v0.3103", 0x55, 0x58, {0x20, 0x00} },
-	{"Packard Bell", "DOA150", "v0.3104", 0x55, 0x58, {0x21, 0x00} },
-	{"Packard Bell", "AOA110", "v0.3105", 0x55, 0x58, {0x21, 0x00} },
-	{"Packard Bell", "AOA150", "v0.3105", 0x55, 0x58, {0x20, 0x00} },
+	{"Gateway", "AOA110", "v0.3103", 0x55, 0x58, {0x21, 0x21, 0x00} },
+	{"Gateway", "AOA150", "v0.3103", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Gateway         ", "LT31            ", "v1.3103 ", 0x55, 0x58,
+		{0x10, 0x0f, 0x00} },
+	{"Gateway         ", "LT31            ", "v1.3201 ", 0x55, 0x58,
+		{0x10, 0x0f, 0x00} },
+	{"Gateway         ", "LT31            ", "v1.3302 ", 0x55, 0x58,
+		{0x10, 0x0f, 0x00} },
+	{"Packard Bell", "DOA150", "v0.3104", 0x55, 0x58, {0x21, 0x21, 0x00} },
+	{"Packard Bell", "DOA150", "v0.3105", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Packard Bell", "AOA110", "v0.3105", 0x55, 0x58, {0x21, 0x21, 0x00} },
+	{"Packard Bell", "AOA150", "v0.3105", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	/* pewpew-terminator */
-	{"", "", "", 0, 0, {0, 0} }
+	{"", "", "", 0, 0, {0, 0, 0} }
 };
 
 static const struct bios_settings_t *bios_cfg __read_mostly;
@@ -183,7 +194,7 @@ static int acerhdf_get_fanstate(int *state)
 	if (ec_read(bios_cfg->fanreg, &fan))
 		return -EINVAL;
 
-	if (fan != bios_cfg->cmd.cmd_off)
+	if (fan != bios_cfg->cmd.chk_off)
 		*state = ACERHDF_FAN_AUTO;
 	else
 		*state = ACERHDF_FAN_OFF;
-- 
1.6.0.6

