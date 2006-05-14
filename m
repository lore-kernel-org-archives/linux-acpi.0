From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 01/16] sem2mutex: drivers/acpi/
Date: Sat, 13 May 2006 23:13:41 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F333@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61374 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932318AbWENDNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 23:13:44 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, arjan@infradead.org, mingo@elte.hu

applied. (though I simply deleted the unused lock in scan.c
rather than updating it)

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>arjan@infradead.org; mingo@elte.hu
>Subject: [patch 01/16] sem2mutex: drivers/acpi/
>
>
>From: Arjan van de Ven <arjan@infradead.org>
>
>Semaphore to mutex conversion.
>
>The conversion was generated via scripts, and the result was validated
>automatically via a script as well.
>
>Signed-off-by: Arjan van de Ven <arjan@infradead.org>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/processor_perflib.c |   27 ++++++++++++++-------------
> drivers/acpi/scan.c              |    3 ++-
> 2 files changed, 16 insertions(+), 14 deletions(-)
>
>diff -puN 
>drivers/acpi/processor_perflib.c~sem2mutex-drivers-acpi 
>drivers/acpi/processor_perflib.c
>--- 
>devel/drivers/acpi/processor_perflib.c~sem2mutex-drivers-acpi	
>2006-04-10 23:16:18.000000000 -0700
>+++ devel-akpm/drivers/acpi/processor_perflib.c	
>2006-04-10 23:16:18.000000000 -0700
>@@ -34,6 +34,7 @@
> #ifdef CONFIG_X86_ACPI_CPUFREQ_PROC_INTF
> #include <linux/proc_fs.h>
> #include <linux/seq_file.h>
>+#include <linux/mutex.h>
> 
> #include <asm/uaccess.h>
> #endif
>@@ -48,7 +49,7 @@
> #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
> ACPI_MODULE_NAME("acpi_processor")
> 
>-static DECLARE_MUTEX(performance_sem);
>+static DEFINE_MUTEX(performance_mutex);
> 
> /*
>  * _PPC support is implemented as a CPUfreq policy notifier:
>@@ -72,7 +73,7 @@ static int acpi_processor_ppc_notifier(s
> 	struct acpi_processor *pr;
> 	unsigned int ppc = 0;
> 
>-	down(&performance_sem);
>+	mutex_lock(&performance_mutex);
> 
> 	if (event != CPUFREQ_INCOMPATIBLE)
> 		goto out;
>@@ -93,7 +94,7 @@ static int acpi_processor_ppc_notifier(s
> 				     core_frequency * 1000);
> 
>       out:
>-	up(&performance_sem);
>+	mutex_unlock(&performance_mutex);
> 
> 	return 0;
> }
>@@ -620,7 +621,7 @@ int acpi_processor_preregister_performan
> 
> 	ACPI_FUNCTION_TRACE("acpi_processor_preregister_performance");
> 
>-	down(&performance_sem);
>+	mutex_lock(&performance_mutex);
> 
> 	retval = 0;
> 
>@@ -768,7 +769,7 @@ err_ret:
> 		pr->performance = NULL; /* Will be set for real 
>in register */
> 	}
> 
>-	up(&performance_sem);
>+	mutex_unlock(&performance_mutex);
> 	return_VALUE(retval);
> }
> EXPORT_SYMBOL(acpi_processor_preregister_performance);
>@@ -785,16 +786,16 @@ acpi_processor_register_performance(stru
> 	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
> 		return_VALUE(-EINVAL);
> 
>-	down(&performance_sem);
>+	mutex_lock(&performance_mutex);
> 
> 	pr = processors[cpu];
> 	if (!pr) {
>-		up(&performance_sem);
>+		mutex_unlock(&performance_mutex);
> 		return_VALUE(-ENODEV);
> 	}
> 
> 	if (pr->performance) {
>-		up(&performance_sem);
>+		mutex_unlock(&performance_mutex);
> 		return_VALUE(-EBUSY);
> 	}
> 
>@@ -802,13 +803,13 @@ acpi_processor_register_performance(stru
> 
> 	if (acpi_processor_get_performance_info(pr)) {
> 		pr->performance = NULL;
>-		up(&performance_sem);
>+		mutex_unlock(&performance_mutex);
> 		return_VALUE(-EIO);
> 	}
> 
> 	acpi_cpufreq_add_file(pr);
> 
>-	up(&performance_sem);
>+	mutex_unlock(&performance_mutex);
> 	return_VALUE(0);
> }
> 
>@@ -822,11 +823,11 @@ acpi_processor_unregister_performance(st
> 
> 	ACPI_FUNCTION_TRACE("acpi_processor_unregister_performance");
> 
>-	down(&performance_sem);
>+	mutex_lock(&performance_mutex);
> 
> 	pr = processors[cpu];
> 	if (!pr) {
>-		up(&performance_sem);
>+		mutex_unlock(&performance_mutex);
> 		return_VOID;
> 	}
> 
>@@ -835,7 +836,7 @@ acpi_processor_unregister_performance(st
> 
> 	acpi_cpufreq_remove_file(pr);
> 
>-	up(&performance_sem);
>+	mutex_unlock(&performance_mutex);
> 
> 	return_VOID;
> }
>diff -puN drivers/acpi/scan.c~sem2mutex-drivers-acpi 
>drivers/acpi/scan.c
>--- devel/drivers/acpi/scan.c~sem2mutex-drivers-acpi	
>2006-04-10 23:16:18.000000000 -0700
>+++ devel-akpm/drivers/acpi/scan.c	2006-04-10 
>23:16:18.000000000 -0700
>@@ -5,6 +5,7 @@
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/acpi.h>
>+#include <linux/mutex.h>
> 
> #include <acpi/acpi_drivers.h>
> #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
>@@ -459,7 +460,7 @@ static int acpi_bus_get_perf_flags(struc
>    
>---------------------------------------------------------------
>----------- */
> 
> static LIST_HEAD(acpi_bus_drivers);
>-static DECLARE_MUTEX(acpi_bus_drivers_lock);
>+static DEFINE_MUTEX(acpi_bus_drivers_lock);
> 
> /**
>  * acpi_bus_match - match device IDs to driver's supported IDs
>_
>
