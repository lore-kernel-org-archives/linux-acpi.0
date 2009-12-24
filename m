From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/34] drivers/platform/x86/acerhdf.c: check BIOS information
 whether it begins with string of table
Date: Thu, 24 Dec 2009 01:24:00 -0500
Message-ID: <dcbfb8156a2149fd6358a377aa9400e28ef43800.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbZLXTbc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:32 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:14 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Peter Feuerer <peter@piie.net>, Borislav Petkov <petkovbb@gmail.com>, Andreas Mohr <andi@lisas.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Peter Feuerer <peter@piie.net>

BIOS information is now checked whether it begins with the strings stored
in the BIOS table.  Previous method did a strcmp, what lead to problems if
BIOS information has appended whitespaces.

Signed-off-by: Peter Feuerer <peter@piie.net>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/acerhdf.c |   46 ++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index a97fc4a..7b2384d 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -52,7 +52,7 @@
  */
 #undef START_IN_KERNEL_MODE
 
-#define DRV_VER "0.5.21"
+#define DRV_VER "0.5.22"
 
 /*
  * According to the Atom N270 datasheet,
@@ -165,12 +165,9 @@ static const struct bios_settings_t bios_tbl[] = {
 	/* Gateway */
 	{"Gateway", "AOA110", "v0.3103", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	{"Gateway", "AOA150", "v0.3103", 0x55, 0x58, {0x20, 0x20, 0x00} },
-	{"Gateway         ", "LT31            ", "v1.3103 ", 0x55, 0x58,
-		{0x10, 0x0f, 0x00} },
-	{"Gateway         ", "LT31            ", "v1.3201 ", 0x55, 0x58,
-		{0x10, 0x0f, 0x00} },
-	{"Gateway         ", "LT31            ", "v1.3302 ", 0x55, 0x58,
-		{0x10, 0x0f, 0x00} },
+	{"Gateway", "LT31", "v1.3103", 0x55, 0x58, {0x10, 0x0f, 0x00} },
+	{"Gateway", "LT31", "v1.3201", 0x55, 0x58, {0x10, 0x0f, 0x00} },
+	{"Gateway", "LT31", "v1.3302", 0x55, 0x58, {0x10, 0x0f, 0x00} },
 	/* Packard Bell */
 	{"Packard Bell", "DOA150", "v0.3104", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	{"Packard Bell", "DOA150", "v0.3105", 0x55, 0x58, {0x20, 0x20, 0x00} },
@@ -495,13 +492,26 @@ static struct platform_driver acerhdf_driver = {
 	.remove = acerhdf_remove,
 };
 
+/* checks if str begins with start */
+static int str_starts_with(const char *str, const char *start)
+{
+	unsigned long str_len = 0, start_len = 0;
+
+	str_len = strlen(str);
+	start_len = strlen(start);
+
+	if (str_len >= start_len &&
+			!strncmp(str, start, start_len))
+		return 1;
+
+	return 0;
+}
 
 /* check hardware */
 static int acerhdf_check_hardware(void)
 {
 	char const *vendor, *version, *product;
-	int i;
-	unsigned long prod_len = 0;
+	const struct bios_settings_t *bt = NULL;
 
 	/* get BIOS data */
 	vendor  = dmi_get_system_info(DMI_SYS_VENDOR);
@@ -523,20 +533,20 @@ static int acerhdf_check_hardware(void)
 		kernelmode = 0;
 	}
 
-	prod_len = strlen(product);
-
 	if (verbose)
 		pr_info("BIOS info: %s %s, product: %s\n",
 			vendor, version, product);
 
 	/* search BIOS version and vendor in BIOS settings table */
-	for (i = 0; bios_tbl[i].version[0]; i++) {
-		if (strlen(bios_tbl[i].product) >= prod_len &&
-		    !strncmp(bios_tbl[i].product, product,
-			   strlen(bios_tbl[i].product)) &&
-		    !strcmp(bios_tbl[i].vendor, vendor) &&
-		    !strcmp(bios_tbl[i].version, version)) {
-			bios_cfg = &bios_tbl[i];
+	for (bt = bios_tbl; bt->vendor[0]; bt++) {
+		/*
+		 * check if actual hardware BIOS vendor, product and version
+		 * IDs start with the strings of BIOS table entry
+		 */
+		if (str_starts_with(vendor, bt->vendor) &&
+				str_starts_with(product, bt->product) &&
+				str_starts_with(version, bt->version)) {
+			bios_cfg = bt;
 			break;
 		}
 	}
-- 
1.6.0.6

