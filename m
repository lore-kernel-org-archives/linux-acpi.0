From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 3/8] thinkpad-acpi: be more strict when detecting a ThinkPad
Date: Sat, 12 Sep 2009 15:22:13 -0300
Message-ID: <1252779738-7459-4-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54949 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754543AbZILSWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:22 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Use stricter checks to decide that we're running on a supported ThinkPad.
This should remove some possible false positives, although nobody ever
bothered to report any.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index cc4155c..d69ab3f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1621,6 +1621,9 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv)
  *
  *  Sources: IBM ThinkPad Public Web Documents (update changelogs),
  *  Information from users in ThinkWiki
+ *
+ *  WARNING: we use this table also to detect that the machine is
+ *  a ThinkPad in some cases, so don't remove entries lightly.
  */
 
 #define TPV_Q(__v, __id1, __id2, __bv1, __bv2)		\
@@ -1782,6 +1785,12 @@ static void __init tpacpi_check_outdated_fw(void)
 	}
 }
 
+static bool __init tpacpi_is_fw_known(void)
+{
+	return tpacpi_check_quirks(tpacpi_bios_version_qtable,
+			ARRAY_SIZE(tpacpi_bios_version_qtable)) != 0;
+}
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -7706,9 +7715,11 @@ static int __init probe_for_thinkpad(void)
 
 	/*
 	 * Non-ancient models have better DMI tagging, but very old models
-	 * don't.
+	 * don't.  tpacpi_is_fw_known() is a cheat to help in that case.
 	 */
-	is_thinkpad = (thinkpad_id.model_str != NULL);
+	is_thinkpad = (thinkpad_id.model_str != NULL) ||
+		      (thinkpad_id.ec_model != 0) ||
+		      tpacpi_is_fw_known();
 
 	/* ec is required because many other handles are relative to it */
 	TPACPI_ACPIHANDLE_INIT(ec);
@@ -7719,13 +7730,6 @@ static int __init probe_for_thinkpad(void)
 		return -ENODEV;
 	}
 
-	/*
-	 * Risks a regression on very old machines, but reduces potential
-	 * false positives a damn great deal
-	 */
-	if (!is_thinkpad)
-		is_thinkpad = (thinkpad_id.vendor == PCI_VENDOR_ID_IBM);
-
 	if (!is_thinkpad && !force_load)
 		return -ENODEV;
 
-- 
1.6.3.3

