From: Len Brown <lenb@kernel.org>
Subject: [PATCH 067/112] ACPI : Add T-state event notifier function
Date: Thu,  7 Feb 2008 04:34:29 -0500
Message-ID: <e4aa5cb2138e7423a6edef6a76a3837b94c2f107.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:18844 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757697AbYBGJg1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:27 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The t-state coordination should be considered when T-state for one cpu
is changed.It means that OSPM should select one proper target T-state for
the all affected cpus before updating T-state.

So the function of acpi_processor_throttling_notifier is added.
Before updating T-state it can be called for all  the affected cpus to get
the proper target T-state, which can meet the requirement of thermal, user and
_TPC. After updating T-state, it can be called to update T-state flag.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |   72 +++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index d6780f4..18a873a 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
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
 
@@ -196,6 +204,70 @@ void acpi_processor_throttling_init(void)
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
-- 
1.5.4.23.gef5b9

