From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Regression in v3.9-rc1 introduced by
 d5aaffa9dd531c978c6f3fea06a2972653bd7fc8..
Date: Tue, 5 Mar 2013 13:39:19 -0500
Message-ID: <20130305183919.GA8006@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42542 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758553Ab3CESj0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Mar 2013 13:39:26 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, dirk.j.brandewie@intel.com

In all fairness, the commit d5aaffa9dd531c978c6f3fea06a2972653bd7fc8
(cpufreq: handle cpufreq being disabled for all exported function.) is not
at fault - it just that it exposes an assumption that before v3.9-rc1
was not true. And git bisection points to it :-(

The problem I am hitting is that the module xen-acpi-processor which
uses the ACPI's functions: acpi_processor_register_performance,
acpi_processor_preregister_performance, and acpi_processor_notify_smm
fails at acpi_processor_register_performance with -22.

Note that earlier during bootup in arch/x86/xen/setup.c there is also
an call to cpufreq's API: disable_cpufreq().

This is b/c we want the Linux kernel to parse the ACPI data, but leave
the cpufreq decisions to the hypervisor.

In v3.9 all the checks that d5aaffa9dd531c978c6f3fea06a2972653bd7fc8
added are now hit and the calls to cpufreq_register_notifier will now
fail. This means that acpi_processor_ppc_init ends up printing:

"Warning: Processor Platform Limit not supported"

and the acpi_processor_ppc_status is not set.

The repercussions of that is that the call to
acpi_processor_register_performance fails right away at:

	if (!(acpi_processor_ppc_status & PPC_REGISTERED))

and we don't progress any further on parsing and extracting the _P*
objects.


I am not really sure how to solve this. One thought I had was to write
a quick and dirty nop-cpufreq driver, but then I run in the problems
of having it being installed all the others and also to make sure it
is the one by default when booting under Xen. I think I explored that
idea a year ago and Dave Jones at that point suggested to just bypass
cpufreq API altogether and just use the ACPI API by itself. That is
where the disable_cpufreq() came from.

The other idea would be to make acpi_processor_get_performance_info
be exported and not use acpi_processor_register_performance, like so:

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 7672c37..9aecad2 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -472,7 +472,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	return result;
 }
 
-static int acpi_processor_get_performance_info(struct acpi_processor *pr)
+int acpi_processor_get_performance_info(struct acpi_processor *pr)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
@@ -524,7 +524,7 @@ static int acpi_processor_get_performance_info(struct acpi_processor *pr)
 	pr_info("%s:%d: RC:%d\n", __func__, __LINE__, result);
 	return result;
 }
-
+EXPORT_SYMBOL_GPL(acpi_processor_get_performance_info);
 int acpi_processor_notify_smm(struct module *calling_module)
 {
 	acpi_status status;
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index f4b7270..8c85d33 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -502,18 +502,18 @@ static int __init xen_acpi_processor_init(void)
 	pr_debug(DRV_NAME "pre-register: %d\n", rc);
 
 	for_each_possible_cpu(i) {
+		struct acpi_processor *pr;
 		struct acpi_processor_performance *perf;
 
+		pr = per_cpu(processors, i);
 		perf = per_cpu_ptr(acpi_perf_data, i);
-		rc = acpi_processor_register_performance(perf, i);
+		pr->performance = perf;
+		rc = acpi_processor_get_performance_info(pr);
 		if (rc) {
 			pr_debug(DRV_NAME "register_perf: %d, got %d\n", i, rc);
 			goto err_out;
 		}
 	}
-	rc = acpi_processor_notify_smm(THIS_MODULE);
-	if (rc)
-		goto err_unregister;
 
 	for_each_possible_cpu(i) {
 		struct acpi_processor *_pr;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 555d033..b327b5a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -235,6 +235,9 @@ extern void acpi_processor_unregister_performance(struct
          if a _PPC object exists, rmmod is disallowed then */
 int acpi_processor_notify_smm(struct module *calling_module);
 
+/* parsing the _P* objects. */
+extern int acpi_processor_get_performance_info(struct acpi_processor *pr);
+
 /* for communication between multiple parts of the processor kernel module */
 DECLARE_PER_CPU(struct acpi_processor *, processors);
 extern struct acpi_processor_errata errata;


(which works BTW).

The third option is to restrict the usage of acpi_processor_ppc_status or
export the acpi_processor_ppc_status. But that sounds hacky to me.

Thoughts?
