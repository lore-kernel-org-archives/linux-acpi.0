From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/29] thinkpad-acpi: silence hotkey enable warning for module
 parameter
Date: Thu, 23 Apr 2009 02:23:39 -0400
Message-ID: <406e988bef742aa74cdc1f5fafc812ecebf7c02b.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:23380 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZDWGYG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:06 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00BC9J45HW89@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:06 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Avoid the WARN() when the procfs handler for hotkey enable is used by
a module parameter.  Instead, urge the user to stop doing that.

Reported-by: Niel Lambrechts <niel.lambrechts@gmail.com>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

