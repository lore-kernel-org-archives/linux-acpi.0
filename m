From: akpm@linux-foundation.org
Subject: [patch 2/2] acerhdf: add new BIOS versions
Date: Thu, 11 Mar 2010 13:59:04 -0800
Message-ID: <201003112159.o2BLx4jq012833@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37513 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757330Ab0CKV7T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Mar 2010 16:59:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, peter@piie.net, andi@lisas.de, petkovbb@gmail.com

From: Peter Feuerer <peter@piie.net>

Add new BIOS versions for Acer 1410 and 1810xx and Packard Bell netbooks.

Fixed registers of Acer AOA150 BIOS version v0.3114: Old registers caused
Fan to spin up at every temperature check.

Signed-off-by: Peter Feuerer <peter@piie.net>
Cc: Borislav Petkov <petkovbb@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-add-new-bios-versions drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-add-new-bios-versions
+++ a/drivers/platform/x86/acerhdf.c
@@ -52,7 +52,7 @@
  */
 #undef START_IN_KERNEL_MODE
 
-#define DRV_VER "0.5.22"
+#define DRV_VER "0.5.23"
 
 /*
  * According to the Atom N270 datasheet,
@@ -146,7 +146,7 @@ static const struct bios_settings_t bios
 	{"Acer", "AOA110", "v0.3309", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	{"Acer", "AOA110", "v0.3310", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	/* AOA150 */
-	{"Acer", "AOA150", "v0.3114", 0x55, 0x58, {0x20, 0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3114", 0x55, 0x58, {0x1f, 0x1f, 0x00} },
 	{"Acer", "AOA150", "v0.3301", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3304", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3305", 0x55, 0x58, {0x20, 0x20, 0x00} },
@@ -155,13 +155,20 @@ static const struct bios_settings_t bios
 	{"Acer", "AOA150", "v0.3309", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3310", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	/* Acer 1410 */
+	{"Acer", "Aspire 1410", "v0.3115", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	{"Acer", "Aspire 1410", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	{"Acer", "Aspire 1410", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	/* Acer 1810xx */
+	{"Acer", "Aspire 1810TZ", "v0.3115", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810T", "v0.3115", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810TZ", "v0.3119", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810T", "v0.3119", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	{"Acer", "Aspire 1810TZ", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	{"Acer", "Aspire 1810T", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
-	{"Acer", "Aspire 1810T", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810TZ", "v1.3204", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810T", "v1.3204", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	{"Acer", "Aspire 1810TZ", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Acer", "Aspire 1810T", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	/* Gateway */
 	{"Gateway", "AOA110", "v0.3103", 0x55, 0x58, {0x21, 0x21, 0x00} },
 	{"Gateway", "AOA150", "v0.3103", 0x55, 0x58, {0x20, 0x20, 0x00} },
@@ -175,6 +182,7 @@ static const struct bios_settings_t bios
 	{"Packard Bell", "AOA150", "v0.3105", 0x55, 0x58, {0x20, 0x20, 0x00} },
 	{"Packard Bell", "DOTMU", "v1.3303", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	{"Packard Bell", "DOTMU", "v0.3120", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
+	{"Packard Bell", "DOTMA", "v1.3201", 0x55, 0x58, {0x9e, 0x9e, 0x00} },
 	/* pewpew-terminator */
 	{"", "", "", 0, 0, {0, 0, 0} }
 };
@@ -667,6 +675,7 @@ MODULE_ALIAS("dmi:*:*Gateway*:pnLT31*:")
 MODULE_ALIAS("dmi:*:*Packard Bell*:pnAOA*:");
 MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOA*:");
 MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOTMU*:");
+MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOTMA*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
_
