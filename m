From: Len Brown <lenb@kernel.org>
Subject: [PATCH 85/98] ACPI: Avoid wiping out pr->performance during
 preregistering
Date: Sat, 28 Mar 2009 00:32:00 -0400
Message-ID: <e1eb47797ac0773cb3efe7495e14fc26e18a23c2.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50093 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774AbZC1Edr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700BGE8O79AXN@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:45 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stanislaw Gruszka <sgruszka@redhat.com>, Len Brown <len.brown@intel.com>

From: Stanislaw Gruszka <sgruszka@redhat.com>

When cpufreq driver call acpi_processor_preregister_performance() , function
will clean up pr->performance even if there is possibly already registered
other cpufreq driver. The patch fix this potential problem. It also remove
double checks in P domain basic validity code and move these checks to function
where _PSD data is captured.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_perflib.c |   46 +++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 9cc769b..215f1bf 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -479,6 +479,13 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 		goto end;
 	}
 
+	if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
+		printk(KERN_ERR PREFIX "Invalid _PSD:coord_type\n");
+		result = -EFAULT;
+		goto end;
+	}
 end:
 	kfree(buffer.pointer);
 	return result;
@@ -501,9 +508,10 @@ int acpi_processor_preregister_performance(
 
 	mutex_lock(&performance_mutex);
 
-	retval = 0;
-
-	/* Call _PSD for all CPUs */
+	/*
+	 * Check if another driver has already registered, and abort before
+	 * changing pr->performance if it has. Check input data as well.
+	 */
 	for_each_possible_cpu(i) {
 		pr = per_cpu(processors, i);
 		if (!pr) {
@@ -513,13 +521,20 @@ int acpi_processor_preregister_performance(
 
 		if (pr->performance) {
 			retval = -EBUSY;
-			continue;
+			goto err_out;
 		}
 
 		if (!performance || !percpu_ptr(performance, i)) {
 			retval = -EINVAL;
-			continue;
+			goto err_out;
 		}
+	}
+
+	/* Call _PSD for all CPUs */
+	for_each_possible_cpu(i) {
+		pr = per_cpu(processors, i);
+		if (!pr)
+			continue;
 
 		pr->performance = percpu_ptr(performance, i);
 		cpumask_set_cpu(i, pr->performance->shared_cpu_map);
@@ -535,26 +550,6 @@ int acpi_processor_preregister_performance(
 	 * Now that we have _PSD data from all CPUs, lets setup P-state 
 	 * domain info.
 	 */
-	for_each_possible_cpu(i) {
-		pr = per_cpu(processors, i);
-		if (!pr)
-			continue;
-
-		/* Basic validity check for domain info */
-		pdomain = &(pr->performance->domain_info);
-		if ((pdomain->revision != ACPI_PSD_REV0_REVISION) ||
-		    (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES)) {
-			retval = -EINVAL;
-			goto err_ret;
-		}
-		if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
-		    pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
-		    pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
-			retval = -EINVAL;
-			goto err_ret;
-		}
-	}
-
 	cpumask_clear(covered_cpus);
 	for_each_possible_cpu(i) {
 		pr = per_cpu(processors, i);
@@ -643,6 +638,7 @@ err_ret:
 		pr->performance = NULL; /* Will be set for real in register */
 	}
 
+err_out:
 	mutex_unlock(&performance_mutex);
 	free_cpumask_var(covered_cpus);
 	return retval;
-- 
1.6.0.6

