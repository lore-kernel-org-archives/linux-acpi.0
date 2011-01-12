From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/48] ACPI: Check the returned value of set_cpus_allowed_ptr
 before T-state operation
Date: Wed, 12 Jan 2011 05:19:19 -0500
Message-ID: <daef1f35ea1e2cca125eecd5f078f40b55eb9105.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49151 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab1ALSAS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:18 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:18 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Now before it executes the T-state operation on one CPU, it will try to
migrate to the target CPU. Especially this is required on the system that
uses the MSR_IA32_THERMAL_CONTROL register to switch T-state.
But unfortunately it doesn't check whether the migration is successful or not.
In such case we will get/set the incorrect T-state on the offline CPU as
it fails in the migration to the offline CPU.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.4.rc1.7.g2cf08

