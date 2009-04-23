From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/29] thinkpad-acpi: simplify module autoloading
Date: Thu, 23 Apr 2009 02:23:42 -0400
Message-ID: <922fe097b1e8f2f2f23dbed61cfe6e0316fecff1.1240467665.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbZDWGYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:15 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ002H6J4600LG@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:08 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Simplify the module autoloading a great deal, by keying to the HID for
the HKEY interface.

Only _really_ ancient IBM ThinkPad models like the 240, 240x and 570
lack the HKEY interface, and they're getting their own trimmed-down
driver one of these days.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

