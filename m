From: Len Brown <lenb@kernel.org>
Subject: [PATCH 068/112] ACPI: Update the t-state for every affected cpu when t-state is changed
Date: Thu,  7 Feb 2008 04:34:30 -0500
Message-ID: <33a2a529f7a2fb481812b99737176628fda457b0.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758065AbYBGJg1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:27 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

According to ACPI spec, the _TSD object provides T-state control cross
logical processor dependency information to OSPM. So the t-state
coordination should be considered when T-state for one cpu is changed.

According to ACPI spec, three types of coordination are defined.
SW_ALL, SW_ANY and HW_ALL.

SW_ALL: it means that OSPM needs to initiate T-state transition on
all processors in the domain. It is necessary to call throttling set function
for all affected cpus.

SW_ANY: it means that OSPM may initiate T-state transition on any processor in
the domain.

HW_ALL: Spec only says that hardware will perform the coordination and doesn't
recommend how OSPM coordinate T-state among the affected cpus. So it is treated
as the type of SW_ALL. It means that OSPM needs to initiate t-state transition
on all the processors in the domain.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |   79 ++++++++++++++++++++++++++++++++--
 1 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 18a873a..86c790e 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -68,7 +68,7 @@ static int acpi_processor_update_tsd_coord(void)
 
 	/*
 	 * Now that we have _TSD data from all CPUs, lets setup T-state
-	 * coordination among all CPUs.
+	 * coordination between all CPUs.
 	 */
 	for_each_possible_cpu(i) {
 		pr = processors[i];
@@ -988,6 +988,11 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 {
 	cpumask_t saved_mask;
 	int ret;
+	unsigned int i;
+	struct acpi_processor *match_pr;
+	struct acpi_processor_throttling *p_throttling;
+	struct throttling_tstate t_state;
+	cpumask_t online_throttling_cpus;
 
 	if (!pr)
 		return -EINVAL;
@@ -998,12 +1003,76 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
 		return -EINVAL;
 
+	saved_mask = current->cpus_allowed;
+	t_state.target_state = state;
+	p_throttling = &(pr->throttling);
+	cpus_and(online_throttling_cpus, cpu_online_map,
+			p_throttling->shared_cpu_map);
 	/*
-	 * Migrate task to the cpu pointed by pr.
+	 * The throttling notifier will be called for every
+	 * affected cpu in order to get one proper T-state.
+	 * The notifier event is THROTTLING_PRECHANGE.
 	 */
-	saved_mask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(pr->id));
-	ret = pr->throttling.acpi_processor_set_throttling(pr, state);
+	for_each_cpu_mask(i, online_throttling_cpus) {
+		t_state.cpu = i;
+		acpi_processor_throttling_notifier(THROTTLING_PRECHANGE,
+							&t_state);
+	}
+	/*
+	 * The function of acpi_processor_set_throttling will be called
+	 * to switch T-state. If the coordination type is SW_ALL or HW_ALL,
+	 * it is necessary to call it for every affected cpu. Otherwise
+	 * it can be called only for the cpu pointed by pr.
+	 */
+	if (p_throttling->shared_type == DOMAIN_COORD_TYPE_SW_ANY) {
+		set_cpus_allowed(current, cpumask_of_cpu(pr->id));
+		ret = p_throttling->acpi_processor_set_throttling(pr,
+						t_state.target_state);
+	} else {
+		/*
+		 * When the T-state coordination is SW_ALL or HW_ALL,
+		 * it is necessary to set T-state for every affected
+		 * cpus.
+		 */
+		for_each_cpu_mask(i, online_throttling_cpus) {
+			match_pr = processors[i];
+			/*
+			 * If the pointer is invalid, we will report the
+			 * error message and continue.
+			 */
+			if (!match_pr) {
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					"Invalid Pointer for CPU %d\n", i));
+				continue;
+			}
+			/*
+			 * If the throttling control is unsupported on CPU i,
+			 * we will report the error message and continue.
+			 */
+			if (!match_pr->flags.throttling) {
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					"Throttling Controll is unsupported "
+					"on CPU %d\n", i));
+				continue;
+			}
+			t_state.cpu = i;
+			set_cpus_allowed(current, cpumask_of_cpu(i));
+			ret = match_pr->throttling.
+				acpi_processor_set_throttling(
+				match_pr, t_state.target_state);
+		}
+	}
+	/*
+	 * After the set_throttling is called, the
+	 * throttling notifier is called for every
+	 * affected cpu to update the T-states.
+	 * The notifier event is THROTTLING_POSTCHANGE
+	 */
+	for_each_cpu_mask(i, online_throttling_cpus) {
+		t_state.cpu = i;
+		acpi_processor_throttling_notifier(THROTTLING_POSTCHANGE,
+							&t_state);
+	}
 	/* restore the previous state */
 	set_cpus_allowed(current, saved_mask);
 	return ret;
-- 
1.5.4.23.gef5b9

