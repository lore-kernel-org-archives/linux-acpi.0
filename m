From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: [PATCH 2.5.54] cpufreq: remove deprecated usage of CPUFREQ_ALL_CPUS in ACPI
Date: Thu, 2 Jan 2003 22:44:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030102214452.GF19479@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

As policy->cpu now only points to an existing CPU, some code can 
safely be removed from the ACPI P-States cpufreq driver.

	 Dominik

diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2003-01-02 20:56:57.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-01-02 21:17:34.000000000 +0100
@@ -1669,24 +1669,10 @@
 	if (!policy)
 		return_VALUE(-EINVAL);
 
-	/* get a present, initialized CPU */
-	if (policy->cpu == CPUFREQ_ALL_CPUS)
-	{
-		for (i=0; i<NR_CPUS; i++) {
-			if (processors[i] != NULL) {
-				cpu = i;
-				pr = processors[cpu];
-				break;
-			}
-		}
-	}
-	else
-	{
-		cpu = policy->cpu;
-		pr = processors[cpu];
-		if (!pr)
-			return_VALUE(-EINVAL);
-	}
+	cpu = policy->cpu;
+	pr = processors[cpu];
+	if (!pr)
+		return_VALUE(-EINVAL);
 
 	/* select appropriate P-State */
 	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
@@ -1715,19 +1701,9 @@
 	}
 
 	/* set one or all CPUs to the new state */
-	if (policy->cpu == CPUFREQ_ALL_CPUS) {
-		for (i=0; i<NR_CPUS; i++)
-		{
-			pr = processors[cpu];
-			if (!pr || !cpu_online(cpu))
-				continue;
-			result = acpi_processor_set_performance (pr, next_state);
-		}
-	} else {
-		result = acpi_processor_set_performance (pr, next_state);
-	}
+	result = acpi_processor_set_performance (pr, next_state);
 
-	return_VALUE(0);
+	return_VALUE(result);
 }
 
 
@@ -1746,24 +1722,10 @@
 	if (!policy)
 		return_VALUE(-EINVAL);
 
-	/* get a present, initialized CPU */
-	if (policy->cpu == CPUFREQ_ALL_CPUS)
-	{
-		for (i=0; i<NR_CPUS; i++) {
-			if (processors[i] != NULL) {
-				cpu = i;
-				pr = processors[cpu];
-				break;
-			}
-		}
-	}
-	else
-	{
-		cpu = policy->cpu;
-		pr = processors[cpu];
-		if (!pr)
-			return_VALUE(-EINVAL);
-	}
+	cpu = policy->cpu;
+	pr = processors[cpu];
+	if (!pr)
+		return_VALUE(-EINVAL);
 
 	/* first check if min and max are within valid limits */
 	cpufreq_verify_within_limits(
@@ -1787,6 +1749,11 @@
 		policy->max = pr->performance.states[next_larger_state].core_frequency * 1000;
 	}
 
+	cpufreq_verify_within_limits(
+		policy, 
+		pr->performance.states[pr->performance.state_count - 1].core_frequency * 1000,
+		pr->performance.states[pr->limit.state.px].core_frequency * 1000);
+
 	return_VALUE(0);
 }
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
