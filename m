From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: Disable _GTS and _BFS support by default
Date: Fri, 17 Apr 2009 23:51:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904172349110.985@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:49601 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbZDRDvq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2009 23:51:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIA00EOV2Q8DABZ@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Apr 2009 22:51:46 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, jm@lentin.co.uk

From: Len Brown <len.brown@intel.com>

Executing BIOS code paths not exercised by Windows
tends to get Linux into trouble.

However, if a system does benefit from _GTS or _BFS,
acpi.gts=1 an acpi.bfs=1 are now available to enable them.

http://bugzilla.kernel.org/show_bug.cgi?id=13041

Signed-off-by: Len Brown <len.brown@intel.com>
---

yeah, i know, i scribbled a linux modparam into an ACPICA file.
i did it because i wanted the flags to static to avoid namespace 
pollution.

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
1.6.3.rc0.1.gf800

