From: Len Brown <lenb@kernel.org>
Subject: [PATCH 68/94] ACPI: main.c: use new public GPE group enable/disable
 interfaces
Date: Fri, 09 Jan 2009 04:27:10 -0500
Message-ID: <3d97e426aa97d60b3dac1b72923b90b491fbac20.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbZAIJ3H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:29:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD7000V76BCQ6DD@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:25 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Avoid using internal functions: acpi_hw_disable_all_gpes and acpi_hw_enable_all_runtime_gpes
Use new public GPE group enable/disable interfaces: acpi_disable_all_gpes and acpi_enable_all_runtime_gpes

Also avoid using internal symbol ACPI_TABLE_INDEX_FACS, call acpi_get_table.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/main.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 28a691c..d824277 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -107,7 +107,7 @@ static bool set_sci_en_on_resume;
  */
 static int acpi_pm_disable_gpes(void)
 {
-	acpi_hw_disable_all_gpes();
+	acpi_disable_all_gpes();
 	return 0;
 }
 
@@ -135,7 +135,7 @@ static int acpi_pm_prepare(void)
 	int error = __acpi_pm_prepare();
 
 	if (!error)
-		acpi_hw_disable_all_gpes();
+		acpi_disable_all_gpes();
 	return error;
 }
 
@@ -267,7 +267,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
 	 * acpi_leave_sleep_state will reenable specific GPEs later
 	 */
-	acpi_hw_disable_all_gpes();
+	acpi_disable_all_gpes();
 
 	local_irq_restore(flags);
 	printk(KERN_DEBUG "Back to C!\n");
@@ -436,7 +436,7 @@ static void acpi_hibernation_leave(void)
 
 static void acpi_pm_enable_gpes(void)
 {
-	acpi_hw_enable_all_runtime_gpes();
+	acpi_enable_all_runtime_gpes();
 }
 
 static struct platform_hibernation_ops acpi_hibernation_ops = {
@@ -622,7 +622,7 @@ static void acpi_power_off_prepare(void)
 {
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
-	acpi_hw_disable_all_gpes();
+	acpi_disable_all_gpes();
 }
 
 static void acpi_power_off(void)
@@ -671,7 +671,7 @@ int __init acpi_sleep_init(void)
 		sleep_states[ACPI_STATE_S4] = 1;
 		printk(" S4");
 		if (!nosigcheck) {
-			acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+			acpi_get_table(ACPI_SIG_FACS, 1,
 				(struct acpi_table_header **)&facs);
 			if (facs)
 				s4_hardware_signature =
-- 
1.5.6.6

