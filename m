From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/30] PM: Fix compilation warning in kernel/power/main.c
Date: Sat, 07 Feb 2009 01:41:09 -0500
Message-ID: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:44614 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZBGGls (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:48 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00LW4NPAAFZ1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:36:47 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Reorder the code in kernel/power/main.c to fix compilation warning
triggered by unsetting CONFIG_SUSPEND.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/main.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 2399888..b4d2190 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -57,16 +57,6 @@ int pm_notifier_call_chain(unsigned long val)
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
-static int suspend_test(int level)
-{
-	if (pm_test_level == level) {
-		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
-		mdelay(5000);
-		return 1;
-	}
-	return 0;
-}
-
 static const char * const pm_tests[__TEST_AFTER_LAST] = {
 	[TEST_NONE] = "none",
 	[TEST_CORE] = "core",
@@ -125,14 +115,24 @@ static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 
 power_attr(pm_test);
-#else /* !CONFIG_PM_DEBUG */
-static inline int suspend_test(int level) { return 0; }
-#endif /* !CONFIG_PM_DEBUG */
+#endif /* CONFIG_PM_DEBUG */
 
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_SUSPEND
 
+static int suspend_test(int level)
+{
+#ifdef CONFIG_PM_DEBUG
+	if (pm_test_level == level) {
+		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		return 1;
+	}
+#endif /* !CONFIG_PM_DEBUG */
+	return 0;
+}
+
 #ifdef CONFIG_PM_TEST_SUSPEND
 
 /*
-- 
1.5.6.6

