From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: introduce kernel parameter
 acpi_sleep=sci_force_enable
Date: Wed, 30 Dec 2009 15:36:42 +0800
Message-ID: <1262158602.12263.1392.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42497 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbZL3HgL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Dec 2009 02:36:11 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Zhang, Rui" <rui.zhang@intel.com>


Introduce kernel parameter acpi_sleep=sci_force_enable

some laptop requires SCI_EN being set directly on resume,
or else they hung somewhere in the resume code path.

We already have a blacklist for these laptops but we still need
this option, especially when debugging some suspend/resume problems,
in case there are systems that need this workaround and are not yet
in the blacklist.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/kernel-parameters.txt |    5 ++++-
 arch/x86/kernel/acpi/sleep.c        |    2 ++
 drivers/acpi/sleep.c                |   29 +++++++++++++++++------------
 include/linux/acpi.h                |    1 +
 4 files changed, 24 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -81,6 +81,23 @@ static int acpi_sleep_prepare(u32 acpi_s
 #ifdef CONFIG_ACPI_SLEEP
 static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 /*
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
+void __init acpi_set_sci_en_on_resume(void)
+{
+	set_sci_en_on_resume = true;
+}
+
+/*
  * ACPI 1.0 wants us to execute _PTS before suspending devices, so we allow the
  * user to request that behavior by using the 'acpi_old_suspend_ordering'
  * kernel command line option that causes the following variable to be set.
@@ -170,18 +187,6 @@ static void acpi_pm_end(void)
 #endif /* CONFIG_ACPI_SLEEP */
 
 #ifdef CONFIG_SUSPEND
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
-
 extern void do_suspend_lowlevel(void);
 
 static u32 acpi_suspend_states[] = {
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -162,6 +162,8 @@ static int __init acpi_sleep_setup(char 
 #endif
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+		if (strncmp(str, "sci_force_enable", 16) == 0)
+			acpi_set_sci_en_on_resume();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -251,6 +251,7 @@ int acpi_check_mem_region(resource_size_
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
 void __init acpi_s4_no_nvs(void);
+void __init acpi_set_sci_en_on_resume(void);
 #endif /* CONFIG_PM_SLEEP */
 
 struct acpi_osc_context {
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -240,7 +240,7 @@ and is between 256 and 4096 characters. 
 
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
-				  old_ordering, s4_nonvs }
+				  old_ordering, s4_nonvs, sci_force_enable }
 			See Documentation/power/video.txt for information on
 			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
@@ -253,6 +253,9 @@ and is between 256 and 4096 characters. 
 			of _PTS is used by default).
 			s4_nonvs prevents the kernel from saving/restoring the
 			ACPI NVS memory during hibernation.
+			sci_force_enable causes the kernel to set SCI_EN directly
+			on resume from S1/S3 (which is against the ACPI spec,
+			but some broken systems don't work without it).
 
 	acpi_use_timer_override [HW,ACPI]
 			Use timer override. For some broken Nvidia NF5 boards


