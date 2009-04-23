From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/29] ACPI: Disable _GTS and _BFS support by default
Date: Thu, 23 Apr 2009 02:23:31 -0400
Message-ID: <96f15efcea94545987715f453a8c2b8ea592d000.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbZDWGYN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:13 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00EF4J3XK60J@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:03 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Executing BIOS code paths not exercised by Windows
tends to get Linux into trouble.

However, if a system does benefit from _GTS or _BFS,
acpi.gts=1 an acpi.bfs=1 are now available to enable them.

http://bugzilla.kernel.org/show_bug.cgi?id=13041

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwsleep.c |   43 ++++++++++++++++++++++++----------------
 drivers/acpi/sleep.c          |   27 +++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index baa5fc0..db307a3 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -211,6 +211,12 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
 
+static unsigned int gts, bfs;
+module_param(gts, uint, 0644);
+module_param(bfs, uint, 0644);
+MODULE_PARM_DESC(gts, "Enable evaluation of _GTS on suspend.");
+MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state
@@ -278,16 +284,18 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Execute the _GTS method */
+	if (gts) {
+		/* Execute the _GTS method */
 
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = sleep_state;
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = sleep_state;
 
-	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		return_ACPI_STATUS(status);
+		status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
+		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+			return_ACPI_STATUS(status);
+		}
 	}
 
 	/* Get current value of PM1A control */
@@ -513,18 +521,19 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 		}
 	}
 
-	/* Execute the _BFS method */
+	if (bfs) {
+		/* Execute the _BFS method */
 
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = sleep_state;
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = sleep_state;
 
-	status = acpi_evaluate_object(NULL, METHOD_NAME__BFS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
+		status = acpi_evaluate_object(NULL, METHOD_NAME__BFS, &arg_list, NULL);
+		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+			ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
+		}
 	}
-
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 779e4e5..9042875 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -713,6 +713,32 @@ static void acpi_power_off(void)
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 
+/*
+ * ACPI 2.0 created the optional _GTS and _BFS,
+ * but industry adoption has been neither rapid nor broad.
+ *
+ * Linux gets into trouble when it executes poorly validated
+ * paths through the BIOS, so disable _GTS and _BFS by default,
+ * but do speak up and offer the option to enable them.
+ */
+void __init acpi_gts_bfs_check(void)
+{
+	acpi_handle dummy;
+
+	if (ACPI_SUCCESS(acpi_get_handle(ACPI_ROOT_OBJECT, METHOD_NAME__GTS, &dummy)))
+	{
+		printk(KERN_NOTICE PREFIX "BIOS offers _GTS\n");
+		printk(KERN_NOTICE PREFIX "If \"acpi.gts=1\" improves suspend, "
+			"please notify linux-acpi@vger.kernel.org\n");
+	}
+	if (ACPI_SUCCESS(acpi_get_handle(ACPI_ROOT_OBJECT, METHOD_NAME__BFS, &dummy)))
+	{
+		printk(KERN_NOTICE PREFIX "BIOS offers _BFS\n");
+		printk(KERN_NOTICE PREFIX "If \"acpi.bfs=1\" improves resume, "
+			"please notify linux-acpi@vger.kernel.org\n");
+	}
+}
+
 int __init acpi_sleep_init(void)
 {
 	acpi_status status;
@@ -771,5 +797,6 @@ int __init acpi_sleep_init(void)
 	 * object can also be evaluated when the system enters S5.
 	 */
 	register_reboot_notifier(&tts_notifier);
+	acpi_gts_bfs_check();
 	return 0;
 }
-- 
1.6.0.6

