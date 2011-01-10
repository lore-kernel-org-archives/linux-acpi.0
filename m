From: yakui.zhao@intel.com
Subject: [PATCH 2/2] ACPI: Reevaluate whether the T-state is supported or not after cpu is online/offline
Date: Mon, 10 Jan 2011 16:35:45 +0800
Message-ID: <1294648545-32193-2-git-send-email-yakui.zhao@intel.com>
References: <1294648545-32193-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45855 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab1AJIeI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jan 2011 03:34:08 -0500
In-Reply-To: <1294648545-32193-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

After one CPU is offlined, it is unnecessary to switch T-state for it. 
So it will be better that the throttling is disabled after the cpu
is offline. 
At the same time after one cpu is online, we should check whether
the T-state is supported and then set the corresponding T-state
flag.


Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_driver.c     |    5 +++
 drivers/acpi/processor_throttling.c |   52 +++++++++++++++++++++++++++++++++++
 include/acpi/processor.h            |    6 ++++
 3 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 85e4804..c8a0ca2 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -478,8 +478,13 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	if (action == CPU_ONLINE && pr) {
 		acpi_processor_ppc_has_changed(pr, 0);
 		acpi_processor_cst_has_changed(pr);
+		acpi_processor_reevaluate_tstate(pr, action);
 		acpi_processor_tstate_has_changed(pr);
 	}
+	if (action == CPU_DEAD && pr) {
+		/* invalidate the flag.throttling after one CPU is offline */
+		acpi_processor_reevaluate_tstate(pr, action);
+	}
 	return NOTIFY_OK;
 }
 
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index ffc859c..4305d56 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -370,6 +370,58 @@ int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
 }
 
 /*
+ * This function is used to reevaluate whether the T-state is valid
+ * after one CPU is onlined/offlined.
+ * It is noted that it won't reevaluate the following properties for
+ * the T-state.
+ *	1. Control method.
+ *	2. the number of supported T-state
+ *	3. TSD domain
+ */
+void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
+					unsigned long action)
+{
+	int result = 0;
+
+	if (action == CPU_DEAD) {
+		/* When one CPU is offline, the T-state throttling
+		 * will be invalidated.
+		 */
+		pr->flags.throttling = 0;
+		return;
+	}
+	/* the following is to recheck whether the T-state is valid for
+	 * the online CPU
+	 */
+	if (!pr->throttling.state_count) {
+		/* If the number of T-state is invalid, it is
+		 * invalidated.
+		 */
+		pr->flags.throttling = 0;
+		return;
+	}
+	pr->flags.throttling = 1;
+
+	/* Disable throttling (if enabled).  We'll let subsequent
+	 * policy (e.g.thermal) decide to lower performance if it
+	 * so chooses, but for now we'll crank up the speed.
+	 */
+
+	result = acpi_processor_get_throttling(pr);
+	if (result)
+		goto end;
+
+	if (pr->throttling.state) {
+		result = acpi_processor_set_throttling(pr, 0, false);
+		if (result)
+			goto end;
+	}
+
+end:
+	if (result)
+		pr->flags.throttling = 0;
+}
+/*
  * _PTC - Processor Throttling Control (and status) register location
  */
 static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 1b62102..55192ac 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -324,6 +324,12 @@ int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr,
 					 int state, bool force);
+/*
+ * Reevaluate whether the T-state is invalid after one cpu is
+ * onlined/offlined. In such case the flags.throttling will be updated.
+ */
+extern void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
+			unsigned long action);
 extern const struct file_operations acpi_processor_throttling_fops;
 extern void acpi_processor_throttling_init(void);
 /* in processor_idle.c */
-- 
1.5.4.5

