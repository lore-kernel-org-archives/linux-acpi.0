From: Len Brown <lenb@kernel.org>
Subject: [PATCH 007/103] ACPI: Notify the _PPC evaluation status to the platform
Date: Wed, 16 Dec 2009 03:35:18 -0500
Message-ID: <d81c45e1c9369855901420f79114852eba2ea16a.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:35010 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759037AbZLPIhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:37:04 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00FM8L9RE3C5@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:37:03 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

According to the ACPI spec(section 8.4.4.3) OSPM should convey the _PPC
evaluations status to the platform if there exists the _OST object.
The _OST contains two arguments:
	The first is the PERFORMANCE notificatin event.
	The second is the status of _PPC object.
OSPM will convey the _PPC evaluation status to the platform.
Of course when the module parameter of "ignore_ppc" is added, OSPM won't
evaluate the _PPC object. But it will call the _OST object.

At the same time the _OST object will be evaluated only when the PERFORMANCE
notification event is received.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c    |    6 ++--
 drivers/acpi/processor_perflib.c |   50 +++++++++++++++++++++++++++++++++++--
 include/acpi/processor.h         |    5 ++-
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index c567b46..773d7e7 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -722,7 +722,7 @@ static void acpi_processor_notify(struct acpi_device *device, u32 event)
 	switch (event) {
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
 		saved = pr->performance_platform_limit;
-		acpi_processor_ppc_has_changed(pr);
+		acpi_processor_ppc_has_changed(pr, 1);
 		if (saved == pr->performance_platform_limit)
 			break;
 		acpi_bus_generate_proc_event(device, event,
@@ -758,7 +758,7 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
 	if (action == CPU_ONLINE && pr) {
-		acpi_processor_ppc_has_changed(pr);
+		acpi_processor_ppc_has_changed(pr, 0);
 		acpi_processor_cst_has_changed(pr);
 		acpi_processor_tstate_has_changed(pr);
 	}
@@ -830,7 +830,7 @@ static int acpi_processor_add(struct acpi_device *device)
 	arch_acpi_processor_cleanup_pdc(pr);
 
 #ifdef CONFIG_CPU_FREQ
-	acpi_processor_ppc_has_changed(pr);
+	acpi_processor_ppc_has_changed(pr, 0);
 #endif
 	acpi_processor_get_throttling_info(pr);
 	acpi_processor_get_limit_info(pr);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 8ba0ed0..fc1f49b 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -152,15 +152,59 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 	return 0;
 }
 
-int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
+#define ACPI_PROCESSOR_NOTIFY_PERFORMANCE	0x80
+/*
+ * acpi_processor_ppc_ost: Notify firmware the _PPC evaluation status
+ * @handle: ACPI processor handle
+ * @status: the status code of _PPC evaluation
+ *	0: success. OSPM is now using the performance state specificed.
+ *	1: failure. OSPM has not changed the number of P-states in use
+ */
+static void acpi_processor_ppc_ost(acpi_handle handle, int status)
+{
+	union acpi_object params[2] = {
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+	};
+	struct acpi_object_list arg_list = {2, params};
+	acpi_handle temp;
+
+	params[0].integer.value = ACPI_PROCESSOR_NOTIFY_PERFORMANCE;
+	params[1].integer.value =  status;
+
+	/* when there is no _OST , skip it */
+	if (ACPI_FAILURE(acpi_get_handle(handle, "_OST", &temp)))
+		return;
+
+	acpi_evaluate_object(handle, "_OST", &arg_list, NULL);
+	return;
+}
+
+int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
 {
 	int ret;
 
-	if (ignore_ppc)
+	if (ignore_ppc) {
+		/*
+		 * Only when it is notification event, the _OST object
+		 * will be evaluated. Otherwise it is skipped.
+		 */
+		if (event_flag)
+			acpi_processor_ppc_ost(pr->handle, 1);
 		return 0;
+	}
 
 	ret = acpi_processor_get_platform_limit(pr);
-
+	/*
+	 * Only when it is notification event, the _OST object
+	 * will be evaluated. Otherwise it is skipped.
+	 */
+	if (event_flag) {
+		if (ret < 0)
+			acpi_processor_ppc_ost(pr->handle, 1);
+		else
+			acpi_processor_ppc_ost(pr->handle, 0);
+	}
 	if (ret < 0)
 		return (ret);
 	else
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 740ac3a..a920237 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -294,7 +294,7 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 #ifdef CONFIG_CPU_FREQ
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
-int acpi_processor_ppc_has_changed(struct acpi_processor *pr);
+int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 #else
 static inline void acpi_processor_ppc_init(void)
 {
@@ -304,7 +304,8 @@ static inline void acpi_processor_ppc_exit(void)
 {
 	return;
 }
-static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
+static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
+								int event_flag)
 {
 	static unsigned int printout = 1;
 	if (printout) {
-- 
1.6.0.6

