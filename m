From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/10] ACPI hibernate: Introduce new kernel parameter
 acpi_sleep=s4_nonvs
Date: Thu, 06 Nov 2008 23:45:30 -0500
Message-ID: <db0ab8581ea2f8dfd297c98d953c88aa70a2d499.1226032943.git.len.brown@intel.com>
References: <1226033132-16034-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:42489 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYKGEpj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:45:39 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00K8156G3PU1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:44:40 -0600 (CST)
In-reply-to: <1226033132-16034-1-git-send-email-lenb@kernel.org>
In-reply-to: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
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
 drivers/acpi/sleep/main.c           |   19 +++++++++++++++++--
 include/linux/acpi.h                |    1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1bbcaa8..65bc2bc 100644
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
index f861b73..63bff78 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -90,6 +90,20 @@ void __init acpi_old_suspend_ordering(void)
 	old_suspend_ordering = true;
 }
 
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
 /**
  *	acpi_pm_disable_gpes - Disable the GPEs.
  */
@@ -358,7 +372,7 @@ static int acpi_hibernation_begin(void)
 {
 	int error;
 
-	error = hibernate_nvs_alloc();
+	error = s4_no_nvs ? 0 : hibernate_nvs_alloc();
 	if (!error) {
 		acpi_target_sleep_state = ACPI_STATE_S4;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
@@ -456,7 +470,8 @@ static int acpi_hibernation_begin_old(void)
 	error = acpi_sleep_prepare(ACPI_STATE_S4);
 
 	if (!error) {
-		error = hibernate_nvs_alloc();
+		if (!s4_no_nvs)
+			error = hibernate_nvs_alloc();
 		if (!error)
 			acpi_target_sleep_state = ACPI_STATE_S4;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fd6a452..4008f61 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -230,6 +230,7 @@ int acpi_check_mem_region(resource_size_t start, resource_size_t n,
 #ifdef CONFIG_PM_SLEEP
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
+void __init acpi_s4_no_nvs(void);
 #endif /* CONFIG_PM_SLEEP */
 #else	/* CONFIG_ACPI */
 
-- 
1.5.6.5

