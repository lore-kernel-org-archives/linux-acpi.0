From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 2.6] remove unnecessary check in acpi-cpufreq driver
Date: Tue, 13 Jan 2004 10:19:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040113091951.GA15385@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

[re-sent as first try didn't reach the list]

The acpi cpufreq driver includes a test at startup which detects whether
ACPI P-States are supported on any CPU, and whether transitions work.
However, this test is faulty: it is only run _after_ the acpi driver is
registered, causing race situations. Also, it doesn't save anything _as_ the
driver is already registered. So, it can safely be removed.

 arch/i386/kernel/cpu/cpufreq/acpi.c |   74 ++++--------------------------------
 1 files changed, 10 insertions(+), 64 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-11 20:50:52.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-11 20:57:10.927599960 +0100
@@ -1,9 +1,9 @@
 /*
- * acpi_processor_perf.c - ACPI Processor P-States Driver ($Revision: 1.3 $)
+ * acpi-cpufreq-io.c - ACPI Processor P-States Driver ($Revision: 1.3 $)
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
- *  Copyright (C) 2002, 2003 Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
+ *  Copyright (C) 2002 - 2004 Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -641,7 +641,6 @@
 acpi_cpufreq_init (void)
 {
 	int                     result = 0;
-	int                     current_state = 0;
 	int                     i = 0;
 	struct acpi_processor   *pr = NULL;
 	struct acpi_processor_performance *perf = NULL;
@@ -649,9 +648,6 @@
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_init");
 
 	/* alloc memory */
-	if (performance)
-		return_VALUE(-EBUSY);
-
 	performance = kmalloc(NR_CPUS * sizeof(struct acpi_processor_performance), GFP_KERNEL);
 	if (!performance)
 		return_VALUE(-ENOMEM);
@@ -669,69 +665,19 @@
 			result = acpi_processor_get_performance_info(&performance[i]);
 	}
 
-	/* test it on one CPU */
-	for (i=0; i<NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-		pr = performance[i].pr;
-		if (pr && pr->flags.performance)
-			goto found_capable_cpu;
-	}
-	result = -ENODEV;
-	goto err0;
-
- found_capable_cpu:
-	
  	result = cpufreq_register_driver(&acpi_cpufreq_driver);
-	if (result) 
-		goto err0;
-	
-	perf = pr->performance;
-	current_state = perf->state;
-
-	if (current_state == pr->limit.state.px) {
-		result = acpi_processor_set_performance(perf, (perf->state_count - 1));
-		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
-			result = -ENODEV;
-			goto err1;
-		}
-	}
-
-	result = acpi_processor_set_performance(perf, pr->limit.state.px);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
-		result = -ENODEV;
-		goto err1;
-	}
-	
-	if (current_state != 0) {
-		result = acpi_processor_set_performance(perf, current_state);
-		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
-			result = -ENODEV;
-			goto err1;
+		/* unregister struct acpi_processor_performance performance */
+		for (i=0; i<NR_CPUS; i++) {
+			if (performance[i].pr) {
+				performance[i].pr->flags.performance = 0;
+				performance[i].pr->performance = NULL;
+				performance[i].pr = NULL;
+			}
 		}
+		kfree(performance);
 	}
-
-	return_VALUE(0);
-
-	/* error handling */
- err1:
-	cpufreq_unregister_driver(&acpi_cpufreq_driver);
-	
- err0:
-	/* unregister struct acpi_processor_performance performance */
-	for (i=0; i<NR_CPUS; i++) {
-		if (performance[i].pr) {
-			performance[i].pr->flags.performance = 0;
-			performance[i].pr->performance = NULL;
-			performance[i].pr = NULL;
-		}
-	}
-	kfree(performance);
 	
-	printk(KERN_INFO "cpufreq: No CPUs supporting ACPI performance management found.\n");
 	return_VALUE(result);
 }
 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
