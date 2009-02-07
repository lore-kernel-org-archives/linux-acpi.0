From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/30] ACPI suspend: Fix compilation warnings in
 drivers/acpi/sleep.c
Date: Sat, 07 Feb 2009 01:41:10 -0500
Message-ID: <5d8b532af9e52ea89208f5ef31889f646e67ba28.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:55296 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbZBGGmn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:43 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO009JSNXKYD71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:44 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix two compilation warnings in drivers/acpi/sleep.c, one triggered
by unsetting CONFIG_SUSPEND and the other triggered by unsetting
CONFIG_HIBERNATION, by moving some code under the appropriate
#ifdefs .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/sleep.c |    4 +-
 drivers/acpi/sleep.c         |   51 +++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 707c1f6..a60c1f3 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -156,11 +156,11 @@ static int __init acpi_sleep_setup(char *str)
 #ifdef CONFIG_HIBERNATION
 		if (strncmp(str, "s4_nohwsig", 10) == 0)
 			acpi_no_s4_hw_signature();
+		if (strncmp(str, "s4_nonvs", 8) == 0)
+			acpi_s4_no_nvs();
 #endif
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
-		if (strncmp(str, "s4_nonvs", 8) == 0)
-			acpi_s4_no_nvs();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7e3c609..af85f5b 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -90,31 +90,6 @@ void __init acpi_old_suspend_ordering(void)
 	old_suspend_ordering = true;
 }
 
-/*
- * According to the ACPI specification the BIOS should make sure that ACPI is
- * enabled and SCI_EN bit is set on wake-up from S1 - S3 sleep states.  Still,
- * some BIOSes don't do that and therefore we use acpi_enable() to enable ACPI
- * on such systems during resume.  Unfortunately that doesn't help in
- * particularly pathological cases in which SCI_EN has to be set directly on
- * resume, although the specification states very clearly that this flag is
- * owned by the hardware.  The set_sci_en_on_resume variable will be set in such
- * cases.
- */
-static bool set_sci_en_on_resume;
-/*
- * The ACPI specification wants us to save NVS memory regions during hibernation
- * and to restore them during the subsequent resume.  However, it is not certain
- * if this mechanism is going to work on all machines, so we allow the user to
- * disable this mechanism using the 'acpi_sleep=s4_nonvs' kernel command line
- * option.
- */
-static bool s4_no_nvs;
-
-void __init acpi_s4_no_nvs(void)
-{
-	s4_no_nvs = true;
-}
-
 /**
  *	acpi_pm_disable_gpes - Disable the GPEs.
  */
@@ -193,6 +168,18 @@ static void acpi_pm_end(void)
 #endif /* CONFIG_ACPI_SLEEP */
 
 #ifdef CONFIG_SUSPEND
+/*
+ * According to the ACPI specification the BIOS should make sure that ACPI is
+ * enabled and SCI_EN bit is set on wake-up from S1 - S3 sleep states.  Still,
+ * some BIOSes don't do that and therefore we use acpi_enable() to enable ACPI
+ * on such systems during resume.  Unfortunately that doesn't help in
+ * particularly pathological cases in which SCI_EN has to be set directly on
+ * resume, although the specification states very clearly that this flag is
+ * owned by the hardware.  The set_sci_en_on_resume variable will be set in such
+ * cases.
+ */
+static bool set_sci_en_on_resume;
+
 extern void do_suspend_lowlevel(void);
 
 static u32 acpi_suspend_states[] = {
@@ -396,6 +383,20 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
+/*
+ * The ACPI specification wants us to save NVS memory regions during hibernation
+ * and to restore them during the subsequent resume.  However, it is not certain
+ * if this mechanism is going to work on all machines, so we allow the user to
+ * disable this mechanism using the 'acpi_sleep=s4_nonvs' kernel command line
+ * option.
+ */
+static bool s4_no_nvs;
+
+void __init acpi_s4_no_nvs(void)
+{
+	s4_no_nvs = true;
+}
+
 static unsigned long s4_hardware_signature;
 static struct acpi_table_facs *facs;
 static bool nosigcheck;
-- 
1.5.6.6

