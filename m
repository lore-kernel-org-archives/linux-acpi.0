From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH]  Avoid wiping out pr->performance during preregistering
Date: Tue, 24 Mar 2009 13:41:59 +0100
Message-ID: <20090324134159.4c83b445@dhcp-lab-109.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:58408 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461AbZCXMrx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Mar 2009 08:47:53 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n2OClp02024546
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2009 08:47:51 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n2OClkvC030960
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2009 08:47:46 -0400
Received: from dhcp-lab-109.englab.brq.redhat.com (dhcp-lab-109.englab.brq.redhat.com [10.34.33.109])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n2OCloUc008355
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2009 08:47:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

When cpufreq driver call acpi_processor_preregister_performance() , function
will clean up pr->performance even if there is possibly already registered
other cpufreq driver. The patch fix this potential problem. It also remove 
double checks in P domain basic validity code and move these checks to function
where _PSD data is captured.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
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
