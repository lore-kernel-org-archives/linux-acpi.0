From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/5] thinkpad-acpi: silence hotkey enable warning for module parameter
Date: Mon, 13 Apr 2009 23:44:10 -0300
Message-ID: <1239677054-3221-2-git-send-email-hmh@hmh.eng.br>
References: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37118 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752014AbZDNCoV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 22:44:21 -0400
In-Reply-To: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Avoid the WARN() when the procfs handler for hotkey enable is used by
a module parameter.  Instead, urge the user to stop doing that.

Reported-by: Niel Lambrechts <niel.lambrechts@gmail.com>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a40b075..a186c5b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2946,12 +2946,18 @@ static int hotkey_read(char *p)
 	return len;
 }
 
-static void hotkey_enabledisable_warn(void)
+static void hotkey_enabledisable_warn(bool enable)
 {
 	tpacpi_log_usertask("procfs hotkey enable/disable");
-	WARN(1, TPACPI_WARN
-	     "hotkey enable/disable functionality has been "
-	     "removed from the driver. Hotkeys are always enabled.\n");
+	if (!WARN((tpacpi_lifecycle == TPACPI_LIFE_RUNNING || !enable),
+			TPACPI_WARN
+			"hotkey enable/disable functionality has been "
+			"removed from the driver.  Hotkeys are always "
+			"enabled\n"))
+		printk(TPACPI_ERR
+			"Please remove the hotkey=enable module "
+			"parameter, it is deprecated.  Hotkeys are always "
+			"enabled\n");
 }
 
 static int hotkey_write(char *buf)
@@ -2971,9 +2977,9 @@ static int hotkey_write(char *buf)
 	res = 0;
 	while ((cmd = next_cmd(&buf))) {
 		if (strlencmp(cmd, "enable") == 0) {
-			hotkey_enabledisable_warn();
+			hotkey_enabledisable_warn(1);
 		} else if (strlencmp(cmd, "disable") == 0) {
-			hotkey_enabledisable_warn();
+			hotkey_enabledisable_warn(0);
 			res = -EPERM;
 		} else if (strlencmp(cmd, "reset") == 0) {
 			mask = hotkey_orig_mask;
-- 
1.6.2.1

