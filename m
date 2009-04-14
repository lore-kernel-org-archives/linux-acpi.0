From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/5] thinkpad-acpi: simplify module autoloading
Date: Mon, 13 Apr 2009 23:44:13 -0300
Message-ID: <1239677054-3221-5-git-send-email-hmh@hmh.eng.br>
References: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38951 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752261AbZDNCoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 22:44:23 -0400
In-Reply-To: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Simplify the module autoloading a great deal, by keying to the HID for
the HKEY interface.

Only _really_ ancient IBM ThinkPad models like the 240, 240x and 570
lack the HKEY interface, and they're getting their own trimmed-down
driver one of these days.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 7a7cac2..caa774a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7861,6 +7861,15 @@ static int __init thinkpad_acpi_module_init(void)
 MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
 
 /*
+ * This will autoload the driver in almost every ThinkPad
+ * in widespread use.
+ *
+ * Only _VERY_ old models, like the 240, 240x and 570 lack
+ * the HKEY event interface.
+ */
+MODULE_DEVICE_TABLE(acpi, ibm_htk_device_ids);
+
+/*
  * DMI matching for module autoloading
  *
  * See http://thinkwiki.org/wiki/List_of_DMI_IDs
@@ -7872,16 +7881,10 @@ MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
 #define IBM_BIOS_MODULE_ALIAS(__type) \
 	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW*")
 
-/* Non-ancient thinkpads */
-MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
-MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");
-
 /* Ancient thinkpad BIOSes have to be identified by
  * BIOS type or model number, and there are far less
  * BIOS types than model numbers... */
-IBM_BIOS_MODULE_ALIAS("I[BDHIMNOTWVYZ]");
-IBM_BIOS_MODULE_ALIAS("1[0368A-GIKM-PST]");
-IBM_BIOS_MODULE_ALIAS("K[UX-Z]");
+IBM_BIOS_MODULE_ALIAS("I[MU]");		/* 570, 570e */
 
 MODULE_AUTHOR("Borislav Deianov <borislav@users.sf.net>");
 MODULE_AUTHOR("Henrique de Moraes Holschuh <hmh@hmh.eng.br>");
-- 
1.6.2.1

