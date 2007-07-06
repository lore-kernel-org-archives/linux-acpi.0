From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 01/16] ACPI: thinkpad-acpi: add DMI-based modalias
Date: Thu,  5 Jul 2007 23:42:13 -0300
Message-ID: <11836897482737-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35037 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758440AbXGFCmg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jul 2007 22:42:36 -0400
In-Reply-To: <11836897482509-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Lennart Poettering <mzxreary@0pointer.de>

Add DMI-based aliases to allow module autoloading on select thinkpads.

The aliases will do nothing unless the dmi-based-module-autoloading.patch
patch from Lennart Poettering <mzxreary@0pointer.de> is applied.  Lennart's
patch has been accepted by greghk and will be merged eventually.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Lennart Poettering <mzxreary@0pointer.de>
---
 drivers/misc/thinkpad_acpi.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 95c0b96..22a5f22 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -92,6 +92,29 @@ MODULE_LICENSE("GPL");
 /* Please remove this in year 2009 */
 MODULE_ALIAS("ibm_acpi");
 
+/*
+ * DMI matching for module autoloading
+ *
+ * See http://thinkwiki.org/wiki/List_of_DMI_IDs
+ * See http://thinkwiki.org/wiki/BIOS_Upgrade_Downloads
+ *
+ * Only models listed in thinkwiki will be supported, so add yours
+ * if it is not there yet.
+ */
+#define IBM_BIOS_MODULE_ALIAS(__type) \
+	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")
+
+/* Non-ancient thinkpads */
+MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
+MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");
+
+/* Ancient thinkpad BIOSes have to be identified by
+ * BIOS type or model number, and there are far less
+ * BIOS types than model numbers... */
+IBM_BIOS_MODULE_ALIAS("I[B,D,H,I,M,N,O,T,W,V,Y,Z]");
+IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
+IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
+
 #define __unused __attribute__ ((unused))
 
 /****************************************************************************
-- 
1.5.2.1

