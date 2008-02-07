From: Len Brown <lenb@kernel.org>
Subject: [PATCH 066/112] ACPI : Update T-state coordination after getting _TSD info
Date: Thu,  7 Feb 2008 04:34:28 -0500
Message-ID: <1180509f6b3ec3ac2505375a78ccd72d270f2169.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757850AbYBGJgY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:24 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Accordint to ACPI spec, the _TSD object provides T-state control cross
logical processor dependency information to OSPM.
After the _TSD data for all cpus are obtained, OSPM will set up
the T-state coordination between CPUs.

Of course if the _TSD doesn't exist or _TSD data is incorrect , it is
assumed that there is no T-state coordination and T-state is changed
independently.

Now there is no proper solution to update T-state coordination after
one cpu is hotplugged. So this patch won't support hotplugged cpu very well.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c       |    2 +
 drivers/acpi/processor_throttling.c |  180 ++++++++++++++++++++++++++++++++++-
 include/acpi/processor.h            |    4 +-
 3 files changed, 184 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index e48ee4f..b3b5373 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -1061,6 +1061,8 @@ static int __init acpi_processor_init(void)
 
 	acpi_processor_ppc_init();
 
+	acpi_processor_throttling_init();
+
 	return 0;
 
 out_cpuidle:
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 5d2eae2..d6780f4 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -48,6 +48,154 @@ ACPI_MODULE_NAME("processor_throttling");
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 
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
+	 * coordination among all CPUs.
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
+		 * among all CPUs is thought as invalid.
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
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Assume no T-state coordination\n"));
+
+	return;
+}
+
 /*
  * _TPC - Throttling Present Capabilities
  */
@@ -293,6 +441,10 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 	struct acpi_buffer state = { 0, NULL };
 	union acpi_object *tsd = NULL;
 	struct acpi_tsd_package *pdomain;
+	struct acpi_processor_throttling *pthrottling;
+
+	pthrottling = &pr->throttling;
+	pthrottling->tsd_valid_flag = 0;
 
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -340,6 +492,22 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
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
@@ -772,6 +940,7 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
+	struct acpi_processor_throttling *pthrottling;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
@@ -803,7 +972,16 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
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
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 76411b1..d90ad0d 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -176,6 +176,8 @@ struct acpi_processor_throttling {
 	u32 address;
 	u8 duty_offset;
 	u8 duty_width;
+	u8 tsd_valid_flag;
+	unsigned int shared_type;
 	struct acpi_processor_tx states[ACPI_PROCESSOR_MAX_THROTTLING];
 };
 
@@ -316,7 +318,7 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 extern struct file_operations acpi_processor_throttling_fops;
-
+extern void acpi_processor_throttling_init(void);
 /* in processor_idle.c */
 int acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device);
-- 
1.5.4.23.gef5b9

