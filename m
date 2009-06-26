From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Sort the ACPI P-state table in descending order by
	cpufre
Date: Fri, 26 Jun 2009 10:06:41 +0800
Message-ID: <1245982001.7266.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39746 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbZFZCFc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jun 2009 22:05:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ming.m.lin@intel.com

From: Zhao Yakui <yakui.zhao@intel.com>

According to ACPI spec the the _PSS object indicates to OSPM the supported
processor performance states. And they should be sorted in descending order
by cpufreq.

But unfortunately on some boxes the cpufreq in _PSS object is sorted in
ascending order, which causes that cpufreq driver can't work well.

Sort the ACPI P-state table in descending order by cpufreq.

http://bugzilla.kernel.org/show_bug.cgi?id=13529

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
tested-by: Mukik182 <mukik182@gmail.com>
cc: Ling Ming <ming.m.lin@intel.com>
---
 drivers/acpi/processor_perflib.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_perflib.c	2009-06-25 09:00:40.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_perflib.c	2009-06-26 09:59:54.000000000 +0800
@@ -38,6 +38,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
+#include <linux/sort.h>
 
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
@@ -246,6 +247,25 @@
 	return result;
 }
 
+static int pss_cmp_func(const void *a, const void *b)
+{
+	struct acpi_processor_px *pxa, *pxb;
+	acpi_integer acpi_value;
+
+	pxa = (struct acpi_processor_px *)a;
+	pxb = (struct acpi_processor_px *)b;
+
+	acpi_value = pxb->core_frequency - pxa->core_frequency;
+	return (int) acpi_value;
+}
+static void pss_swap_func(void *a, void *b, int size)
+{
+	struct acpi_processor_px temp_px;
+
+	memcpy((void *)&temp_px, a, size);
+	memcpy(a, b, size);
+	memcpy(b, (void *)&temp_px, size);
+}
 static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 {
 	int result = 0;
@@ -323,7 +343,10 @@
 			goto end;
 		}
 	}
-
+	sort((void *)(pr->performance->states), pr->performance->state_count,
+			sizeof(struct acpi_processor_px),
+			pss_cmp_func,
+			pss_swap_func);
       end:
 	kfree(buffer.pointer);
 


