From: ykzhao <yakui.zhao@intel.com>
Subject: [Patch] ACPI: Notify the _PPC evaluation status to the platform
Date: Fri, 16 Oct 2009 09:20:41 +0800
Message-ID: <1255656041.3563.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50258 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755624AbZJPBWd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Oct 2009 21:22:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

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
---
 drivers/acpi/processor_core.c    |    6 ++--
 drivers/acpi/processor_perflib.c |   50 ++++++++++++++++++++++++++++++++++++---
 include/acpi/processor.h         |    5 ++-
 3 files changed, 53 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_perflib.c	2009-10-15 17:47:22.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_perflib.c	2009-10-15 17:48:12.000000000 +0800
@@ -152,15 +152,59 @@
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
Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c	2009-10-15 17:47:22.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_core.c	2009-10-15 17:48:12.000000000 +0800
@@ -722,7 +722,7 @@
 	switch (event) {
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
 		saved = pr->performance_platform_limit;
-		acpi_processor_ppc_has_changed(pr);
+		acpi_processor_ppc_has_changed(pr, 1);
 		if (saved == pr->performance_platform_limit)
 			break;
 		acpi_bus_generate_proc_event(device, event,
@@ -758,7 +758,7 @@
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
 	if (action == CPU_ONLINE && pr) {
-		acpi_processor_ppc_has_changed(pr);
+		acpi_processor_ppc_has_changed(pr, 0);
 		acpi_processor_cst_has_changed(pr);
 		acpi_processor_tstate_has_changed(pr);
 	}
@@ -830,7 +830,7 @@
 	arch_acpi_processor_cleanup_pdc(pr);
 
 #ifdef CONFIG_CPU_FREQ
-	acpi_processor_ppc_has_changed(pr);
+	acpi_processor_ppc_has_changed(pr, 0);
 #endif
 	acpi_processor_get_throttling_info(pr);
 	acpi_processor_get_limit_info(pr);
Index: linux-2.6/include/acpi/processor.h
===================================================================
--- linux-2.6.orig/include/acpi/processor.h	2009-09-09 09:38:31.000000000 +0800
+++ linux-2.6/include/acpi/processor.h	2009-10-15 17:48:12.000000000 +0800
@@ -294,7 +294,7 @@
 #ifdef CONFIG_CPU_FREQ
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
-int acpi_processor_ppc_has_changed(struct acpi_processor *pr);
+int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 #else
 static inline void acpi_processor_ppc_init(void)
 {
@@ -304,7 +304,8 @@
 {
 	return;
 }
-static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
+static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr,
+								int event_flag)
 {
 	static unsigned int printout = 1;
 	if (printout) {


