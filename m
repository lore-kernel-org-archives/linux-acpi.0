From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/94] ACPI hibernate: Introduce new kernel parameter
 acpi_sleep=s4_nonvs
Date: Fri, 09 Jan 2009 04:26:10 -0500
Message-ID: <ba84ed9546e91348fdf3ff2bff859b0ee53b407a.1231492607.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZAIJ2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:16 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700LUY6ACX1D7@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:49 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

On some machines it may be necessary to disable the saving/restoring
of the ACPI NVS memory region during hibernation/resume.  For this
purpose, introduce new ACPI kernel command line option
acpi_sleep=s4_nonvs.

Based on a patch by Zhang Rui.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    5 ++++-
 arch/x86/kernel/acpi/sleep.c        |    2 ++
 drivers/acpi/sleep/main.c           |   18 ++++++++++++++++--
 include/linux/acpi.h                |    1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e0f346d..1d089ee 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -149,7 +149,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			default: 0
 
 	acpi_sleep=	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig, old_ordering }
+			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
+				  old_ordering, s4_nonvs }
 			See Documentation/power/video.txt for s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
@@ -159,6 +160,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			control method, wrt putting devices into low power
 			states, to be enforced (the ACPI 2.0 ordering of _PTS is
 			used by default).
+			s4_nonvs prevents the kernel from saving/restoring the
+			ACPI NVS memory during hibernation.
 
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 806b4e9..707c1f6 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -159,6 +159,8 @@ static int __init acpi_sleep_setup(char *str)
 #endif
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+		if (strncmp(str, "s4_nonvs", 8) == 0)
+			acpi_s4_no_nvs();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 45a8015..bef41fd 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -101,6 +101,19 @@ void __init acpi_old_suspend_ordering(void)
  * cases.
  */
 static bool set_sci_en_on_resume;
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
 
 /**
  *	acpi_pm_disable_gpes - Disable the GPEs.
@@ -396,7 +409,7 @@ static int acpi_hibernation_begin(void)
 {
 	int error;
 
-	error = hibernate_nvs_alloc();
+	error = s4_no_nvs ? 0 : hibernate_nvs_alloc();
 	if (!error) {
 		acpi_target_sleep_state = ACPI_STATE_S4;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
@@ -494,7 +507,8 @@ static int acpi_hibernation_begin_old(void)
 	error = acpi_sleep_prepare(ACPI_STATE_S4);
 
 	if (!error) {
-		error = hibernate_nvs_alloc();
+		if (!s4_no_nvs)
+			error = hibernate_nvs_alloc();
 		if (!error)
 			acpi_target_sleep_state = ACPI_STATE_S4;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fba8051..dfa0a53 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -270,6 +270,7 @@ int acpi_check_mem_region(resource_size_t start, resource_size_t n,
 #ifdef CONFIG_PM_SLEEP
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
+void __init acpi_s4_no_nvs(void);
 #endif /* CONFIG_PM_SLEEP */
 #else	/* CONFIG_ACPI */
 
-- 
1.5.6.6

