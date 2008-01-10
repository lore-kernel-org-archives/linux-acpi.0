From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]  ACPI : Add T-state coordination when updating T-state
Date: Thu, 10 Jan 2008 16:39:41 +0800
Message-ID: <1199954381.3948.10.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1960 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbYAJIng (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jan 2008 03:43:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Add T-state coordination when updating T-state
>From : Zhao Yakui <yakui.zhao@intel.com>

Accordint to ACPI spec, the _TSD object provides T-state control cross 
logical processor dependency information to OSPM. So the t-state 
coordination should be considered when T-state for one cpu is changed.

After the _TSD data for all cpus are obtained, OSPM will set up 
the T-state coordination. When T-state for one cpu is changed, OSPM
should consider the coordination and update the T-state for other 
affected CPUs. 

Of course if the _TSD doesn't exist or _TSD data is uncorrect , it is  
assumed that there is no T-state coordination and T-state is changed
independently.

Now there is no proper solution to update T-state coordination after
one cpu is hotplugged. So this patch can't support hotplugged cpu very well.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>

---
 drivers/acpi/processor_core.c       |    2 
 drivers/acpi/processor_throttling.c |  313 +++++++++++++++++++++++++++++++++++-
 include/acpi/processor.h            |    5 
 3 files changed, 314 insertions(+), 6 deletions(-)

Index: linux-2.6.24-rc7/include/acpi/processor.h
===================================================================
--- linux-2.6.24-rc7.orig/include/acpi/processor.h
+++ linux-2.6.24-rc7/include/acpi/processor.h
@@ -168,7 +168,6 @@ struct acpi_processor_throttling {
 	unsigned int state_count;
 	struct acpi_processor_tx_tss *states_tss;
 	struct acpi_tsd_package domain_info;
-	cpumask_t shared_cpu_map;
 	int (*acpi_processor_get_throttling) (struct acpi_processor * pr);
 	int (*acpi_processor_set_throttling) (struct acpi_processor * pr,
 					      int state);
@@ -176,6 +175,9 @@ struct acpi_processor_throttling {
 	u32 address;
 	u8 duty_offset;
 	u8 duty_width;
+	u8 tsd_valid_flag;
+	cpumask_t shared_cpu_map;
+	unsigned int shared_type;
 	struct acpi_processor_tx states[ACPI_PROCESSOR_MAX_THROTTLING];
 };
 
@@ -316,6 +318,7 @@ static inline int acpi_processor_ppc_has
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 extern struct file_operations acpi_processor_throttling_fops;
+extern void acpi_processor_throttling_init(void);
 
 /* in processor_idle.c */
 int acpi_processor_power_init(struct acpi_processor *pr,
Index: linux-2.6.24-rc7/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.24-rc7/drivers/acpi/processor_throttling.c
@@ -45,9 +45,222 @@
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
+
+
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 
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
+	target_state = p_tstate->target_state;
+	p_throttling = &(pr->throttling);
+	switch (event) {
+	case THROTTLING_PRECHANGE:
+		/*
+		 * Prechange event is used to choose One T-state,
+		 * which meets the limits of thermal, user and
+		 * _TPC.
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
+static int acpi_processor_update_tsd_coord(void)
+{
+	int count, count_target;
+	int retval = 0;
+	unsigned int i, j;
+	cpumask_t covered_cpus;
+	struct acpi_processor *pr, *match_pr;
+	struct acpi_tsd_package *pdomain, *match_pdomain;
+	struct acpi_processor_throttling *pthrottling, *match_pthrottling;
+
+	/*
+	 * Now that we have _TSD data from all CPUs, lets setup T-state
+	 * coordination between all CPUs.
+	 */
+	for_each_possible_cpu(i) {
+		pr = processors[i];
+		if (!pr)
+			continue;
+
+		/* Basic validity check for domain info */
+		pthrottling = &(pr->throttling);
+
+		/*
+		 * If tsd package for one cpu is invalid, the coordination
+		 * between all CPUs are thought as invalid.
+		 * Maybe it is ugly.
+		 */
+		if (!pthrottling->tsd_valid_flag) {
+			retval = -EINVAL;
+			break;
+		}
+	}
+	if (retval)
+		goto err_ret;
+
+	cpus_clear(covered_cpus);
+	for_each_possible_cpu(i) {
+		pr = processors[i];
+		if (!pr)
+			continue;
+
+		if (cpu_isset(i, covered_cpus))
+			continue;
+		pthrottling = &pr->throttling;
+
+		pdomain = &(pthrottling->domain_info);
+		cpu_set(i, pthrottling->shared_cpu_map);
+		cpu_set(i, covered_cpus);
+		/*
+		 * If the number of processor in the TSD domain is 1, it is
+		 * unnecessary to parse the coordination for this CPU.
+		 */
+		if (pdomain->num_processors <= 1)
+			continue;
+
+		/* Validate the Domain info */
+		count_target = pdomain->num_processors;
+		count = 1;
+
+		for_each_possible_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_pr = processors[j];
+			if (!match_pr)
+				continue;
+
+			match_pthrottling = &(match_pr->throttling);
+			match_pdomain = &(match_pthrottling->domain_info);
+			if (match_pdomain->domain != pdomain->domain)
+				continue;
+
+			/* Here i and j are in the same domain.
+			 * If two TSD packages have the same domain, they
+			 * should have the same num_porcessors and
+			 * coordination type. Otherwise it will be regarded
+			 * as illegal.
+			 */
+			if (match_pdomain->num_processors != count_target) {
+				retval = -EINVAL;
+				goto err_ret;
+			}
+
+			if (pdomain->coord_type != match_pdomain->coord_type) {
+				retval = -EINVAL;
+				goto err_ret;
+			}
+
+			cpu_set(j, covered_cpus);
+			cpu_set(j, pthrottling->shared_cpu_map);
+			count++;
+		}
+		for_each_possible_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_pr = processors[j];
+			if (!match_pr)
+				continue;
+
+			match_pthrottling = &(match_pr->throttling);
+			match_pdomain = &(match_pthrottling->domain_info);
+			if (match_pdomain->domain != pdomain->domain)
+				continue;
+
+			/*
+			 * If some CPUS have the same domain, they
+			 * will have the same shared_cpu_map.
+			 */
+			match_pthrottling->shared_cpu_map =
+				pthrottling->shared_cpu_map;
+		}
+	}
+
+err_ret:
+	for_each_possible_cpu(i) {
+		pr = processors[i];
+		if (!pr)
+			continue;
+
+		/*
+		 * Assume no coordination on any error parsing domain info.
+		 * The coordination type will be forced as SW_ALL.
+		 */
+		if (retval) {
+			pthrottling = &(pr->throttling);
+			cpus_clear(pthrottling->shared_cpu_map);
+			cpu_set(i, pthrottling->shared_cpu_map);
+			pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
+		}
+	}
+
+	return retval;
+}
+
+/*
+ * Update the T-state coordination after the _TSD
+ * data for all cpus is obtained.
+ */
+void acpi_processor_throttling_init(void)
+{
+	if (acpi_processor_update_tsd_coord())
+		ACPI_WARNING((AE_INFO, "Assume no T-state coordination"));
+
+	return;
+}
+
 /*
  * _TPC - Throttling Present Capabilities
  */
@@ -293,6 +506,10 @@ static int acpi_processor_get_tsd(struct
 	struct acpi_buffer state = { 0, NULL };
 	union acpi_object *tsd = NULL;
 	struct acpi_tsd_package *pdomain;
+	struct acpi_processor_throttling *pthrottling;
+
+	pthrottling = &pr->throttling;
+	pthrottling->tsd_valid_flag = 0;
 
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -340,6 +557,22 @@ static int acpi_processor_get_tsd(struct
 		goto end;
 	}
 
+	pthrottling = &pr->throttling;
+	pthrottling->tsd_valid_flag = 1;
+	pthrottling->shared_type = pdomain->coord_type;
+	cpu_set(pr->id, pthrottling->shared_cpu_map);
+	/*
+	 * If the coordination type is not defined in ACPI spec,
+	 * the tsd_valid_flag will be clear and coordination type
+	 * will be forecd as DOMAIN_COORD_TYPE_SW_ALL.
+	 */
+	if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
+		pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
+		pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
+		pthrottling->tsd_valid_flag = 0;
+		pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
+	}
+
       end:
 	kfree(buffer.pointer);
 	return result;
@@ -743,12 +976,72 @@ int acpi_processor_set_throttling(struct
 {
 	cpumask_t saved_mask;
 	int ret;
+	unsigned int i;
+	struct acpi_processor *match_pr;
+	struct acpi_processor_throttling *p_throttling;
+	struct throttling_tstate t_state;
+	cpumask_t online_throttling_cpus;
+
+	if (!pr)
+		return -EINVAL;
+
+	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
+		return -EINVAL;
+
+	if (!pr->flags.throttling)
+		return -ENODEV;
+
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
@@ -757,6 +1050,7 @@ int acpi_processor_set_throttling(struct
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
+	struct acpi_processor_throttling *pthrottling;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
@@ -788,7 +1082,16 @@ int acpi_processor_get_throttling_info(s
 		    &acpi_processor_set_throttling_ptc;
 	}
 
-	acpi_processor_get_tsd(pr);
+	/*
+	 * If TSD package for one CPU can't be parsed successfully, it means
+	 * that this CPU will have no coordination with other CPUs.
+	 */
+	if (acpi_processor_get_tsd(pr)) {
+		pthrottling = &pr->throttling;
+		pthrottling->tsd_valid_flag = 0;
+		cpu_set(pr->id, pthrottling->shared_cpu_map);
+		pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
+	}
 
 	/*
 	 * PIIX4 Errata: We don't support throttling on the original PIIX4.
Index: linux-2.6.24-rc7/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/acpi/processor_core.c
+++ linux-2.6.24-rc7/drivers/acpi/processor_core.c
@@ -1061,6 +1061,8 @@ static int __init acpi_processor_init(vo
 
 	acpi_processor_ppc_init();
 
+	acpi_processor_throttling_init();
+
 	return 0;
 
 out_cpuidle:


