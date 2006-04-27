From: akpm@osdl.org
Subject: [patch 08/16] for_each_possible_cpu: under drivers/acpi
Date: Thu, 27 Apr 2006 02:25:07 -0700
Message-ID: <200604270926.k3R9QZnR025093@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:43469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965008AbWD0J0j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 05:26:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, kamezawa.hiroyu@jp.fujitsu.com


From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

for_each_cpu() actually iterates across all possible CPUs.  We've had mistakes
in the past where people were using for_each_cpu() where they should have been
iterating across only online or present CPUs.  This is inefficient and
possibly buggy.

We're renaming for_each_cpu() to for_each_possible_cpu() to avoid this in the
future.

This patch replaces for_each_cpu with for_each_possible_cpu.
under drivers/acpi/

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_perflib.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/acpi/processor_perflib.c~for_each_possible_cpu-under-drivers-acpi drivers/acpi/processor_perflib.c
--- devel/drivers/acpi/processor_perflib.c~for_each_possible_cpu-under-drivers-acpi	2006-04-10 23:16:23.000000000 -0700
+++ devel-akpm/drivers/acpi/processor_perflib.c	2006-04-10 23:16:23.000000000 -0700
@@ -626,7 +626,7 @@ int acpi_processor_preregister_performan
 	retval = 0;
 
 	/* Call _PSD for all CPUs */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr) {
 			/* Look only at processors in ACPI namespace */
@@ -657,7 +657,7 @@ int acpi_processor_preregister_performan
 	 * Now that we have _PSD data from all CPUs, lets setup P-state 
 	 * domain info.
 	 */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr)
 			continue;
@@ -678,7 +678,7 @@ int acpi_processor_preregister_performan
 	}
 
 	cpus_clear(covered_cpus);
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr)
 			continue;
@@ -702,7 +702,7 @@ int acpi_processor_preregister_performan
 			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 		}
 
-		for_each_cpu(j) {
+		for_each_possible_cpu(j) {
 			if (i == j)
 				continue;
 
@@ -731,7 +731,7 @@ int acpi_processor_preregister_performan
 			count++;
 		}
 
-		for_each_cpu(j) {
+		for_each_possible_cpu(j) {
 			if (i == j)
 				continue;
 
@@ -755,7 +755,7 @@ err_ret:
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error while parsing _PSD domain information. Assuming no coordination\n"));
 	}
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr || !pr->performance)
 			continue;
_
