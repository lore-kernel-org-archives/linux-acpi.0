From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/34] acerhdf: add new BIOS versions
Date: Thu, 24 Dec 2009 01:23:59 -0500
Message-ID: <94219d798e65dff1dac5f8f36f03a9bdb3105f91.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953AbZLXTb3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:29 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:08 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Peter Feuerer <peter@piie.net>, Borislav Petkov <petkovbb@gmail.com>, Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Peter Feuerer <peter@piie.net>

Add new BIOS versions for following netbooks: Aspire 1810xx, Packard Bell
DOTMU.

Signed-off-by: Peter Feuerer <peter@piie.net>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/acerhdf.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 007bc55..a97fc4a 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -52,7 +52,7 @@
  */
 #undef START_IN_KERNEL_MODE
 
-#define DRV_VER "0.5.20"
+#define DRV_VER "0.5.21"
 
 /*
  * According to the Atom N270 datasheet,
@@ -156,7 +156,13 @@ static const struct bios_settings_t bios_tbl[] = {
 	{"Acer", "AOA150", "v0.3310", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	/* Acer 1410 */
 	{"Acer", "Aspire 1410", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
-	/* special BIOS / other */
+	{"Acer", "Aspire 1410", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	/* Acer 1810xx */
+	{"Acer", "Aspire 1810TZ", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810T", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810T", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810TZ", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	/* Gateway */
 	{"Gateway", "AOA110", "v0.3103", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	{"Gateway", "AOA150", "v0.3103", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	{"Gateway         ", "LT31            ", "v1.3103 ", 0x55, 0x58,
@@ -165,10 +171,13 @@ static const struct bios_settings_t bios_tbl[] = {
 		{0x10, 0x0f, 0x00} },
 	{"Gateway         ", "LT31            ", "v1.3302 ", 0x55, 0x58,
 		{0x10, 0x0f, 0x00} },
+	/* Packard Bell */
 	{"Packard Bell", "DOA150", "v0.3104", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	{"Packard Bell", "DOA150", "v0.3105", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	{"Packard Bell", "AOA110", "v0.3105", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	{"Packard Bell", "AOA150", "v0.3105", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Packard Bell", "DOTMU", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Packard Bell", "DOTMU", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	/* pewpew-terminator */
 	{"", "", "", 0, 0, {0, 0, 0} }
 };
@@ -641,9 +650,13 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Peter Feuerer");
 MODULE_DESCRIPTION("Aspire One temperature and fan driver");
 MODULE_ALIAS("dmi:*:*Acer*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Acer*:pnAspire 1410*:");
+MODULE_ALIAS("dmi:*:*Acer*:pnAspire 1810*:");
 MODULE_ALIAS("dmi:*:*Gateway*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Gateway*:pnLT31*:");
 MODULE_ALIAS("dmi:*:*Packard Bell*:pnAOA*:");
 MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOA*:");
+MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOTMU*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
-- 
1.6.0.6

