From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: Regression in v3.9-rc1 introduced by
 d5aaffa9dd531c978c6f3fea06a2972653bd7fc8..
Date: Wed, 6 Mar 2013 10:05:15 -0500
Message-ID: <20130306150515.GD10760@phenom.dumpdata.com>
References: <20130305183919.GA8006@phenom.dumpdata.com>
 <3193614.16DCcHFHVM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26768 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab3CFPFW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Mar 2013 10:05:22 -0500
Content-Disposition: inline
In-Reply-To: <3193614.16DCcHFHVM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, dirk.j.brandewie@intel.com

On Wed, Mar 06, 2013 at 01:29:49AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> Thanks for the report. ->
> 
> On Tuesday, March 05, 2013 01:39:19 PM Konrad Rzeszutek Wilk wrote:
> > In all fairness, the commit d5aaffa9dd531c978c6f3fea06a2972653bd7fc8
> > (cpufreq: handle cpufreq being disabled for all exported function.) is not
> > at fault - it just that it exposes an assumption that before v3.9-rc1
> > was not true. And git bisection points to it :-(
.. snip..
> > Thoughts?
> 
> Well, since your patch above seems to only affect Xen, I'm basically fine with
> it.

OK, here is the patch. Would you like to carry it in my tree for Linus or are
you comfortable taking it?

>From c705c78c0d0835a4aa5d0d9a3422e3218462030c Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Tue, 5 Mar 2013 13:42:54 -0500
Subject: [PATCH] acpi: Export the acpi_processor_get_performance_info

The git commit d5aaffa9dd531c978c6f3fea06a2972653bd7fc8
(cpufreq: handle cpufreq being disabled for all exported function)
tightens the cpufreq API by returning errors when disable_cpufreq()
had been called.

The problem we are hitting is that the module xen-acpi-processor which
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

The only reason the Xen code called that function was b/c it was
exported and the only way to gather the P-states. But we can also
just make acpi_processor_get_performance_info be exported and not
use acpi_processor_register_performance. This patch does so.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/acpi/processor_perflib.c | 4 ++--
 drivers/xen/xen-acpi-processor.c | 8 ++++----
 include/acpi/processor.h         | 3 +++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 53e7ac9..e854582 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -465,7 +465,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	return result;
 }
 
-static int acpi_processor_get_performance_info(struct acpi_processor *pr)
+int acpi_processor_get_performance_info(struct acpi_processor *pr)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
@@ -509,7 +509,7 @@ static int acpi_processor_get_performance_info(struct acpi_processor *pr)
 #endif
 	return result;
 }
-
+EXPORT_SYMBOL_GPL(acpi_processor_get_performance_info);
 int acpi_processor_notify_smm(struct module *calling_module)
 {
 	acpi_status status;
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index 316df65..f3278a6 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -500,16 +500,16 @@ static int __init xen_acpi_processor_init(void)
 	(void)acpi_processor_preregister_performance(acpi_perf_data);
 
 	for_each_possible_cpu(i) {
+		struct acpi_processor *pr;
 		struct acpi_processor_performance *perf;
 
+		pr = per_cpu(processors, i);
 		perf = per_cpu_ptr(acpi_perf_data, i);
-		rc = acpi_processor_register_performance(perf, i);
+		pr->performance = perf;
+		rc = acpi_processor_get_performance_info(pr);
 		if (rc)
 			goto err_out;
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
-- 
1.8.0.2

