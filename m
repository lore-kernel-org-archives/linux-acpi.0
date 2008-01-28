From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 4/5] ACPI: Add T-state event notifier function
Date: Mon, 28 Jan 2008 13:54:46 +0800
Message-ID: <1201499686.17068.25.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24711 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbYA1GN3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 01:13:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Add T-state event notifier function
>From : Zhao Yakui <yakui.zhao@intel.com>

The t-state coordination should be considered when T-state for one cpu 
is changed.It means that OSPM should select one proper target T-state for
the all affected cpus before updating T-state. 

So the function of acpi_processor_throttling_notifier is added. 
Before updating T-state it can be called for all  the affected cpus to get 
the proper target T-state, which can meet the requirement of thermal, user and 
_TPC. After updating T-state, it can be called to update T-state flag.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_throttling.c |   72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

Index: linux-2.6/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6/drivers/acpi/processor_throttling.c
@@ -45,6 +45,14 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
+struct throttling_tstate {
+	unsigned int cpu;		/* cpu nr */
+	int target_state;		/* target T-state */
+};
+
+#define THROTTLING_PRECHANGE       (1)
+#define THROTTLING_POSTCHANGE      (2)
+
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 
@@ -196,6 +204,70 @@ void acpi_processor_throttling_init(void
 	return;
 }
 
+static int acpi_processor_throttling_notifier(unsigned long event, void *data)
+{
+	struct throttling_tstate *p_tstate = data;
+	struct acpi_processor *pr;
+	unsigned int cpu ;
+	int target_state;
+	struct acpi_processor_limit *p_limit;
+	struct acpi_processor_throttling *p_throttling;
+
+	cpu = p_tstate->cpu;
+	pr = processors[cpu];
+	if (!pr) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid pr pointer\n"));
+		return 0;
+	}
+	if (!pr->flags.throttling) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Throttling control is "
+				"unsupported on CPU %d\n", cpu));
+		return 0;
+	}
+	target_state = p_tstate->target_state;
+	p_throttling = &(pr->throttling);
+	switch (event) {
+	case THROTTLING_PRECHANGE:
+		/*
+		 * Prechange event is used to choose one proper t-state,
+		 * which meets the limits of thermal, user and _TPC.
+		 */
+		p_limit = &pr->limit;
+		if (p_limit->thermal.tx > target_state)
+			target_state = p_limit->thermal.tx;
+		if (p_limit->user.tx > target_state)
+			target_state = p_limit->user.tx;
+		if (pr->throttling_platform_limit > target_state)
+			target_state = pr->throttling_platform_limit;
+		if (target_state >= p_throttling->state_count) {
+			printk(KERN_WARNING
+				"Exceed the limit of T-state \n");
+			target_state = p_throttling->state_count - 1;
+		}
+		p_tstate->target_state = target_state;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PreChange Event:"
+				"target T-state of CPU %d is T%d\n",
+				cpu, target_state));
+		break;
+	case THROTTLING_POSTCHANGE:
+		/*
+		 * Postchange event is only used to update the
+		 * T-state flag of acpi_processor_throttling.
+		 */
+		p_throttling->state = target_state;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PostChange Event:"
+				"CPU %d is switched to T%d\n",
+				cpu, target_state));
+		break;
+	default:
+		printk(KERN_WARNING
+			"Unsupported Throttling notifier event\n");
+		break;
+	}
+
+	return 0;
+}
+
 /*
  * _TPC - Throttling Present Capabilities
  */


