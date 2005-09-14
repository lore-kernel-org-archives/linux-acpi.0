From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [ACPI][PATCH 1/4] (take 2) Software coordination of freq across CPUs sharing common P-state
Date: Tue, 13 Sep 2005 17:01:23 -0700
Message-ID: <20050913170123.B5968@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: cpufreq <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


[PATCH 1/4] Software coordination of freq across CPUs sharing common P-state

Changes to acpi/processor_perflib.c to invoke new (ACPI 3.0) _PSD methods.
This method has to be called early on all CPUs and P-state dependency domains
determined before the actual performance_register of P-states.

Also, a new field (shared_type) is added to cpufreq_policy. This is required to
support two kinds of CPU groups. One, where one logical CPU can change the
frequency of all the CPUs by writing into an MSR or IO port. Other, where all
CPUs in the dependency domain need to write to an MSR or IO port.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Index: linux-2.6.12/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.12.orig/drivers/acpi/processor_perflib.c	2005-08-31 14:46:39.311563456 -0700
+++ linux-2.6.12/drivers/acpi/processor_perflib.c	2005-09-06 15:44:19.707724344 -0700
@@ -304,6 +304,85 @@
 	return_VALUE(result);
 }
 
+static int acpi_processor_get_psd(struct acpi_processor	*pr)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
+	struct acpi_buffer state = {0, NULL};
+	union acpi_object  *psd = NULL;
+	struct acpi_psd_package *pdomain;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_get_psd");
+
+	status = acpi_evaluate_object(pr->handle, "_PSD", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PSD\n"));
+		return_VALUE(-ENODEV);
+	}
+
+	psd = (union acpi_object *) buffer.pointer;
+	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (psd->package.count != 1) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	pdomain = &(pr->performance->domain_info);
+
+	state.length = sizeof(struct acpi_psd_package);
+	state.pointer = pdomain;
+
+	status = acpi_extract_package(&(psd->package.elements[0]),
+		&format, &state);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:num_entries\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:revision\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+end:
+	acpi_os_free(buffer.pointer);
+	return_VALUE(result);
+}
+
+static int acpi_processor_performance_prepare(struct acpi_object_list *pdc,
+					      struct acpi_processor *pr)
+{
+	int result = 0;
+	
+	ACPI_FUNCTION_TRACE("acpi_processor_performance_prepare");
+
+	if (!pr || !pr->performance || !pr->handle)
+		return_VALUE(-EINVAL);
+
+	result = acpi_processor_set_pdc(pr, pdc);
+	if (result == 0)
+		/* Try Domains only if _PDC was successful */
+		result = acpi_processor_get_psd(pr);
+
+	return_VALUE(result);
+}
+
 static int acpi_processor_get_performance_info(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -315,8 +394,6 @@
 	if (!pr || !pr->performance || !pr->handle)
 		return_VALUE(-EINVAL);
 
-	acpi_processor_set_pdc(pr, pr->performance->pdc);
-
 	status = acpi_get_handle(pr->handle, "_PCT", &handle);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -555,6 +632,174 @@
 }
 #endif				/* CONFIG_X86_ACPI_CPUFREQ_PROC_INTF */
 
+int acpi_processor_preregister_performance(struct acpi_object_list *pdc,
+					   struct acpi_processor_performance 
+					   **performance)
+{
+	int count, count_target;
+	int retval = 0, skip_psd = 0;
+	unsigned int i, j;
+	cpumask_t covered_cpus;
+	struct acpi_processor *pr;
+	struct acpi_psd_package *pdomain;
+	struct acpi_processor *match_pr;
+	struct acpi_psd_package *match_pdomain;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_preregister_performance");
+
+	down(&performance_sem);
+
+	/* Call _PDC, _PSD from all CPUs */
+	retval = 0;
+	for_each_cpu(i) {
+		pr = processors[i];
+		if (!pr) {
+			/* Look only at processors in ACPI namespace */
+			continue;
+		}
+
+		if (pr->performance) {
+			retval = -EBUSY;
+			continue;
+		}
+
+		if (!performance || !performance[i]) {
+			retval = -EINVAL;
+			continue;
+		}
+
+		pr->performance = performance[i];
+		cpu_set(i, pr->performance->shared_cpu_map);
+
+		if (acpi_processor_performance_prepare(pdc, pr)) {
+			retval = 0;
+			skip_psd = 1;
+			continue;
+		}
+
+	}
+
+	if (retval || skip_psd)
+		goto err_ret;
+
+	/*
+	 * Now that we have _PSD data from all CPUs, lets setup P-state 
+	 * domain info.
+	 */
+	for_each_cpu(i) {
+		pr = processors[i];
+		if (!pr) {
+			/* Look only at processors in ACPI namespace */
+			continue;
+		}
+
+		pdomain = &(pr->performance->domain_info);
+		if ((pdomain->revision != ACPI_PSD_REV0_REVISION) ||
+		    (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES)) {
+			retval = -EINVAL;
+			goto err_ret;
+		}
+	}
+
+	cpus_clear(covered_cpus);
+	for_each_cpu(i) {
+		pr = processors[i];
+		if (!pr) {
+			/* Look only at processors in ACPI namespace */
+			continue;
+		}
+
+		if (cpu_isset(i, covered_cpus))
+			continue;
+
+		pdomain = &(pr->performance->domain_info);
+		cpu_set(i, pr->performance->shared_cpu_map);
+		cpu_set(i, covered_cpus);
+		if (pdomain->num_processors == 0)
+			continue;
+
+		/* Validate the Domain info */
+		count_target = pdomain->num_processors;
+		count = 1;
+		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL ||
+		    pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL) {
+			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+		} else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY) {
+			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+		}
+
+		for_each_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_pr = processors[j];
+			if (!match_pr) {
+				/* Look only at processors in ACPI namespace */
+				continue;
+			}
+
+			match_pr = processors[j];
+			match_pdomain = &(match_pr->performance->domain_info);
+			if (match_pdomain->domain != pdomain->domain)
+				continue;
+
+			/* Here i and j in the same domain */
+
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
+			cpu_set(j, pr->performance->shared_cpu_map);
+			count++;
+			cpus_clear(match_pr->performance->shared_cpu_map);
+		}
+
+		for_each_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_pr = processors[j];
+			if (!match_pr) {
+				/* Look only at processors in ACPI namespace */
+				continue;
+			}
+
+			match_pdomain = &(match_pr->performance->domain_info);
+			if (match_pdomain->domain != pdomain->domain)
+				continue;
+
+			match_pr->performance->shared_type = 
+					pr->performance->shared_type;
+			cpus_clear(match_pr->performance->shared_cpu_map);
+			cpus_or(match_pr->performance->shared_cpu_map,
+				match_pr->performance->shared_cpu_map,
+				pr->performance->shared_cpu_map);
+		}
+	}
+
+err_ret:
+	for_each_cpu(i) {
+		pr = processors[i];
+		if (!pr) {
+			/* Look only at processors in ACPI namespace */
+			continue;
+		}
+
+		pr->performance = NULL; /* Will be set for real in register */
+	}
+
+	up(&performance_sem);
+	return_VALUE(retval);
+}
+EXPORT_SYMBOL(acpi_processor_preregister_performance);
+
 int
 acpi_processor_register_performance(struct acpi_processor_performance
 				    *performance, unsigned int cpu)
Index: linux-2.6.12/include/acpi/processor.h
===================================================================
--- linux-2.6.12.orig/include/acpi/processor.h	2005-08-31 14:46:39.457541264 -0700
+++ linux-2.6.12/include/acpi/processor.h	2005-09-06 11:23:06.610397304 -0700
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/config.h>
+#include <linux/cpu.h>
 
 #include <asm/acpi.h>
 
@@ -18,6 +19,17 @@
 
 #define ACPI_PDC_REVISION_ID		0x1
 
+#define ACPI_PSD_REV0_REVISION		0 /* Support for _PSD as in ACPI 3.0 */
+#define ACPI_PSD_REV0_ENTRIES		5
+
+/* 
+ * Types of coordination defined in ACPI 3.0. Same macros can be used across
+ * P, C and T states
+ */
+#define DOMAIN_COORD_TYPE_SW_ALL	0xfc
+#define DOMAIN_COORD_TYPE_SW_ANY	0xfd
+#define DOMAIN_COORD_TYPE_HW_ALL	0xfe
+
 /* Power Management */
 
 struct acpi_processor_cx;
@@ -69,6 +81,14 @@
 
 /* Performance Management */
 
+struct acpi_psd_package {
+	acpi_integer num_entries;
+	acpi_integer revision;
+	acpi_integer domain;
+	acpi_integer coord_type;
+	acpi_integer num_processors;
+} __attribute__ ((packed));
+
 struct acpi_pct_register {
 	u8 descriptor;
 	u16 length;
@@ -95,6 +115,9 @@
 	struct acpi_pct_register status_register;
 	unsigned int state_count;
 	struct acpi_processor_px *states;
+	struct acpi_psd_package domain_info;
+	cpumask_t shared_cpu_map;
+	unsigned int shared_type;
 
 	/* the _PDC objects passed by the driver, if any */
 	struct acpi_object_list *pdc;
@@ -163,6 +186,10 @@
 	} piix4;
 };
 
+extern int acpi_processor_preregister_performance(struct acpi_object_list *pdc,
+						  struct 
+						  acpi_processor_performance 
+						  **performance);
 extern int acpi_processor_register_performance(struct acpi_processor_performance
 					       *performance, unsigned int cpu);
 extern void acpi_processor_unregister_performance(struct
Index: linux-2.6.12/include/linux/cpufreq.h
===================================================================
--- linux-2.6.12.orig/include/linux/cpufreq.h	2005-08-31 14:38:34.226307624 -0700
+++ linux-2.6.12/include/linux/cpufreq.h	2005-09-06 11:25:04.974403240 -0700
@@ -71,6 +71,8 @@
 
 struct cpufreq_policy {
 	cpumask_t		cpus;	/* affected CPUs */
+	unsigned int		shared_type; /* ANY or ALL affected CPUs
+						should set cpufreq */
 	unsigned int		cpu;    /* cpu nr of registered CPU */
 	struct cpufreq_cpuinfo	cpuinfo;/* see above */
 
@@ -97,6 +99,8 @@
 #define CPUFREQ_INCOMPATIBLE	(1)
 #define CPUFREQ_NOTIFY		(2)
 
+#define CPUFREQ_SHARED_TYPE_ALL	(0) /* All dependent CPUs should set freq */
+#define CPUFREQ_SHARED_TYPE_ANY	(1) /* Freq can be set from any dpeendent CPU */
 
 /******************** cpufreq transition notifiers *******************/
 


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
