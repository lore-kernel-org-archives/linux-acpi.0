From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] acpi: add acpi_sleep=nonvs_s3 parameter
Date: Mon, 15 Oct 2012 16:55:19 -0700
Message-ID: <1350345319-14262-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26466 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2JOXzK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2012 19:55:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The ACPI specificiation would like us to save NVS at hibernation time,
but makes no mention of saving NVS over S3.  Not all versions of
Windows do this either, and it is clear that not all machines need NVS
saved/restored over S3.  Allow the user to improve their suspend/resume
time by disabling the NVS save/restore at S3 time, but continue to do
the NVS save/restore for S4 as specified.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/kernel/acpi/sleep.c |  2 ++
 drivers/acpi/sleep.c         | 17 ++++++++++++++++-
 include/linux/acpi.h         |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 11676cf..d5e0d71 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -101,6 +101,8 @@ static int __init acpi_sleep_setup(char *str)
 #endif
 		if (strncmp(str, "nonvs", 5) == 0)
 			acpi_nvs_nosave();
+		if (strncmp(str, "nonvs_s3", 8) == 0)
+			acpi_nvs_nosave_s3();
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
 		str = strchr(str, ',');
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index fdcdbb6..8640782 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -98,6 +98,21 @@ void __init acpi_nvs_nosave(void)
 }
 
 /*
+ * The ACPI specification wants us to save NVS memory regions during hibernation
+ * but says nothing about saving NVS during S3.  Not all versions of Windows
+ * save NVS on S3 suspend either, and it is clear that not all systems need
+ * NVS to be saved at S3 time.  To improve suspend/resume time, allow the
+ * user to disable saving NVS on S3 if their system does not require it, but
+ * continue to save/restore NVS for S4 as specified.
+ */
+static bool nvs_nosave_s3;
+
+void __init acpi_nvs_nosave_s3(void)
+{
+	nvs_nosave_s3 = true;
+}
+
+/*
  * ACPI 1.0 wants us to execute _PTS before suspending devices, so we allow the
  * user to request that behavior by using the 'acpi_old_suspend_ordering'
  * kernel command line option that causes the following variable to be set.
@@ -243,7 +258,7 @@ static int acpi_suspend_begin(suspend_state_t pm_state)
 	u32 acpi_state = acpi_suspend_states[pm_state];
 	int error = 0;
 
-	error = nvs_nosave ? 0 : suspend_nvs_alloc();
+	error = (nvs_nosave || nvs_nosave_s3) ? 0 : suspend_nvs_alloc();
 	if (error)
 		return error;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 90be989..3cf9349 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -261,6 +261,7 @@ int acpi_resources_are_enforced(void);
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
 void __init acpi_nvs_nosave(void);
+void __init acpi_nvs_nosave_s3(void);
 #endif /* CONFIG_PM_SLEEP */
 
 struct acpi_osc_context {
-- 
1.7.11.4

