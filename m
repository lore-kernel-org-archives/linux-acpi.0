From: mochel@linux.intel.com
Subject: [PATCH 20/24] Remove unneeded debugging macros in drivers/acpi/processor_perflib.c
Date: Mon, 17 Apr 2006 18:21:55 -0700
Message-ID: <11453233154124-git-send-email-mochel@linux.intel.com>
References: <11453233151054-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:64952 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932129AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PQlA026793
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:26 GMT
In-Reply-To: <11453233151054-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/processor_perflib.c |  105 ++++++++++++++------------------------
 1 files changed, 38 insertions(+), 67 deletions(-)

applies-to: c9fce8cafc46d108ef9d5e396a15447e82d53151
68dba1dee647266a54bddaff530d8b05aab558d6
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 3dd4284..6e22004 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -107,10 +107,8 @@ static int acpi_processor_get_platform_l
 	acpi_status status = 0;
 	unsigned long ppc = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_platform_limit");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/*
 	 * _PPC indicates the maximum state currently supported by the platform
@@ -123,12 +121,12 @@ static int acpi_processor_get_platform_l
 
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PPC"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	pr->performance_platform_limit = (int)ppc;
 
-	return_VALUE(0);
+	return 0;
 }
 
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
@@ -167,12 +165,10 @@ static int acpi_processor_get_performanc
 	union acpi_object *pct = NULL;
 	union acpi_object obj = { 0 };
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_control");
-
 	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PCT"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	pct = (union acpi_object *)buffer.pointer;
@@ -219,7 +215,7 @@ static int acpi_processor_get_performanc
       end:
 	acpi_os_free(buffer.pointer);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_processor_get_performance_states(struct acpi_processor *pr)
@@ -232,12 +228,10 @@ static int acpi_processor_get_performanc
 	union acpi_object *pss = NULL;
 	int i;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_states");
-
 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PSS"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	pss = (union acpi_object *)buffer.pointer;
@@ -298,7 +292,7 @@ static int acpi_processor_get_performanc
       end:
 	acpi_os_free(buffer.pointer);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_processor_get_performance_info(struct acpi_processor *pr)
@@ -307,31 +301,29 @@ static int acpi_processor_get_performanc
 	acpi_status status = AE_OK;
 	acpi_handle handle = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_info");
-
 	if (!pr || !pr->performance || !pr->handle)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	status = acpi_get_handle(pr->handle, "_PCT", &handle);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "ACPI-based processor performance control unavailable\n"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	result = acpi_processor_get_performance_control(pr);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	result = acpi_processor_get_performance_states(pr);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	result = acpi_processor_get_platform_limit(pr);
 	if (result)
-		return_VALUE(result);
+		return result;
 
-	return_VALUE(0);
+	return 0;
 }
 
 int acpi_processor_notify_smm(struct module *calling_module)
@@ -339,13 +331,11 @@ int acpi_processor_notify_smm(struct mod
 	acpi_status status;
 	static int is_done = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_notify_smm");
-
 	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
-		return_VALUE(-EBUSY);
+		return -EBUSY;
 
 	if (!try_module_get(calling_module))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* is_done is set to negative if an error occured,
 	 * and to postitive if _no_ error occured, but SMM
@@ -354,10 +344,10 @@ int acpi_processor_notify_smm(struct mod
 	 */
 	if (is_done > 0) {
 		module_put(calling_module);
-		return_VALUE(0);
+		return 0;
 	} else if (is_done < 0) {
 		module_put(calling_module);
-		return_VALUE(is_done);
+		return is_done;
 	}
 
 	is_done = -EIO;
@@ -366,7 +356,7 @@ int acpi_processor_notify_smm(struct mod
 	if ((!acpi_fadt.smi_cmd) || (!acpi_fadt.pstate_cnt)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No SMI port or pstate_cnt\n"));
 		module_put(calling_module);
-		return_VALUE(0);
+		return 0;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -388,7 +378,7 @@ int acpi_processor_notify_smm(struct mod
 				"smi_cmd [0x%x]", acpi_fadt.pstate_cnt,
 				acpi_fadt.smi_cmd));
 		module_put(calling_module);
-		return_VALUE(status);
+		return status;
 	}
 
 	/* Success. If there's no _PPC, we need to fear nothing, so
@@ -398,7 +388,7 @@ int acpi_processor_notify_smm(struct mod
 	if (!(acpi_processor_ppc_status & PPC_IN_USE))
 		module_put(calling_module);
 
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_processor_notify_smm);
@@ -419,8 +409,6 @@ static int acpi_processor_perf_seq_show(
 	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
 	int i;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_perf_seq_show");
-
 	if (!pr)
 		goto end;
 
@@ -443,7 +431,7 @@ static int acpi_processor_perf_seq_show(
 			   (u32) pr->performance->states[i].transition_latency);
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file)
@@ -465,23 +453,21 @@ acpi_processor_write_performance(struct 
 	unsigned int new_state = 0;
 	struct cpufreq_policy policy;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_write_performance");
-
 	if (!pr || (count > sizeof(state_string) - 1))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	perf = pr->performance;
 	if (!perf)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (copy_from_user(state_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	state_string[count] = '\0';
 	new_state = simple_strtoul(state_string, NULL, 0);
 
 	if (new_state >= perf->state_count)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	cpufreq_get_policy(&policy, pr->id);
 
@@ -491,9 +477,9 @@ acpi_processor_write_performance(struct 
 
 	result = cpufreq_set_policy(&policy);
 	if (result)
-		return_VALUE(result);
+		return result;
 
-	return_VALUE(count);
+	return count;
 }
 
 static void acpi_cpufreq_add_file(struct acpi_processor *pr)
@@ -501,10 +487,8 @@ static void acpi_cpufreq_add_file(struct
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_cpufreq_addfile");
-
 	if (acpi_bus_get_device(pr->handle, &device))
-		return_VOID;
+		return;
 
 	/* add file 'performance' [R/W] */
 	entry = create_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
@@ -516,23 +500,19 @@ static void acpi_cpufreq_add_file(struct
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
-	return_VOID;
 }
 
 static void acpi_cpufreq_remove_file(struct acpi_processor *pr)
 {
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_cpufreq_addfile");
-
 	if (acpi_bus_get_device(pr->handle, &device))
-		return_VOID;
+		return;
 
 	/* remove file 'performance' */
 	remove_proc_entry(ACPI_PROCESSOR_FILE_PERFORMANCE,
 			  acpi_device_dir(device));
 
-	return_VOID;
 }
 
 #else
@@ -556,11 +536,9 @@ static int acpi_processor_get_psd(struct
 	union acpi_object  *psd = NULL;
 	struct acpi_psd_package *pdomain;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_psd");
-
 	status = acpi_evaluate_object(pr->handle, "_PSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	psd = (union acpi_object *) buffer.pointer;
@@ -603,7 +581,7 @@ static int acpi_processor_get_psd(struct
 
 end:
 	acpi_os_free(buffer.pointer);
-	return_VALUE(result);
+	return result;
 }
 
 int acpi_processor_preregister_performance(
@@ -618,8 +596,6 @@ int acpi_processor_preregister_performan
 	struct acpi_processor *match_pr;
 	struct acpi_psd_package *match_pdomain;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_preregister_performance");
-
 	down(&performance_sem);
 
 	retval = 0;
@@ -769,7 +745,7 @@ err_ret:
 	}
 
 	up(&performance_sem);
-	return_VALUE(retval);
+	return retval;
 }
 EXPORT_SYMBOL(acpi_processor_preregister_performance);
 
@@ -780,22 +756,20 @@ acpi_processor_register_performance(stru
 {
 	struct acpi_processor *pr;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_register_performance");
-
 	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	down(&performance_sem);
 
 	pr = processors[cpu];
 	if (!pr) {
 		up(&performance_sem);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	if (pr->performance) {
 		up(&performance_sem);
-		return_VALUE(-EBUSY);
+		return -EBUSY;
 	}
 
 	pr->performance = performance;
@@ -803,13 +777,13 @@ acpi_processor_register_performance(stru
 	if (acpi_processor_get_performance_info(pr)) {
 		pr->performance = NULL;
 		up(&performance_sem);
-		return_VALUE(-EIO);
+		return -EIO;
 	}
 
 	acpi_cpufreq_add_file(pr);
 
 	up(&performance_sem);
-	return_VALUE(0);
+	return 0;
 }
 
 EXPORT_SYMBOL(acpi_processor_register_performance);
@@ -820,14 +794,12 @@ acpi_processor_unregister_performance(st
 {
 	struct acpi_processor *pr;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_unregister_performance");
-
 	down(&performance_sem);
 
 	pr = processors[cpu];
 	if (!pr) {
 		up(&performance_sem);
-		return_VOID;
+		return;
 	}
 
 	kfree(pr->performance->states);
@@ -837,7 +809,6 @@ acpi_processor_unregister_performance(st
 
 	up(&performance_sem);
 
-	return_VOID;
 }
 
 EXPORT_SYMBOL(acpi_processor_unregister_performance);
---
0.99.9.GIT


