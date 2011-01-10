From: yakui.zhao@intel.com
Subject: [PATCH 1/2] ACPI: Check the returned value of set_cpus_allowed_ptr before T-state operation
Date: Mon, 10 Jan 2011 16:35:44 +0800
Message-ID: <1294648545-32193-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45855 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab1AJIeH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jan 2011 03:34:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Now before it executes the T-state operation on one CPU, it will try to
migrate to the target CPU. Especially this is required on the system that
uses the MSR_IA32_THERMAL_CONTROL register to switch T-state.
But unfortunately it doesn't check whether the migration is successful or not.
In such case we will get/set the incorrect T-state on the offline CPU as
it fails in the migration to the offline CPU.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_throttling.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index ff36327..ffc859c 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -876,7 +876,11 @@ static int acpi_processor_get_throttling(struct acpi_processor *pr)
 	 */
 	cpumask_copy(saved_mask, &current->cpus_allowed);
 	/* FIXME: use work_on_cpu() */
-	set_cpus_allowed_ptr(current, cpumask_of(pr->id));
+	if (set_cpus_allowed_ptr(current, cpumask_of(pr->id))) {
+		/* Can't migrate to the target pr->id CPU. Exit */
+		free_cpumask_var(saved_mask);
+		return -ENODEV;
+	}
 	ret = pr->throttling.acpi_processor_get_throttling(pr);
 	/* restore the previous state */
 	set_cpus_allowed_ptr(current, saved_mask);
@@ -1051,6 +1055,14 @@ int acpi_processor_set_throttling(struct acpi_processor *pr,
 		return -ENOMEM;
 	}
 
+	if (cpu_is_offline(pr->id)) {
+		/*
+		 * the cpu pointed by pr->id is offline. Unnecessary to change
+		 * the throttling state any more.
+		 */
+		return -ENODEV;
+	}
+
 	cpumask_copy(saved_mask, &current->cpus_allowed);
 	t_state.target_state = state;
 	p_throttling = &(pr->throttling);
@@ -1074,7 +1086,11 @@ int acpi_processor_set_throttling(struct acpi_processor *pr,
 	 */
 	if (p_throttling->shared_type == DOMAIN_COORD_TYPE_SW_ANY) {
 		/* FIXME: use work_on_cpu() */
-		set_cpus_allowed_ptr(current, cpumask_of(pr->id));
+		if (set_cpus_allowed_ptr(current, cpumask_of(pr->id))) {
+			/* Can't migrate to the pr->id CPU. Exit */
+			ret = -ENODEV;
+			goto exit;
+		}
 		ret = p_throttling->acpi_processor_set_throttling(pr,
 						t_state.target_state, force);
 	} else {
@@ -1106,7 +1122,8 @@ int acpi_processor_set_throttling(struct acpi_processor *pr,
 			}
 			t_state.cpu = i;
 			/* FIXME: use work_on_cpu() */
-			set_cpus_allowed_ptr(current, cpumask_of(i));
+			if (set_cpus_allowed_ptr(current, cpumask_of(i)))
+				continue;
 			ret = match_pr->throttling.
 				acpi_processor_set_throttling(
 				match_pr, t_state.target_state, force);
@@ -1126,6 +1143,7 @@ int acpi_processor_set_throttling(struct acpi_processor *pr,
 	/* restore the previous state */
 	/* FIXME: use work_on_cpu() */
 	set_cpus_allowed_ptr(current, saved_mask);
+exit:
 	free_cpumask_var(online_throttling_cpus);
 	free_cpumask_var(saved_mask);
 	return ret;
-- 
1.5.4.5

