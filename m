From: Shaohua Li <shaohua.li@intel.com>
Subject: RE: [PATCH] acpi cpuidle driver should handle max_cstate
Date: Tue, 03 Apr 2007 09:33:45 +0800
Message-ID: <1175564025.29499.1.camel@sli10-conroe.sh.intel.com>
References: <653FFBB4508B9042B5D43DC9E18836F52DFD10@scsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6107 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965404AbXDCBgt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Apr 2007 21:36:49 -0400
In-Reply-To: <653FFBB4508B9042B5D43DC9E18836F52DFD10@scsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Adam Belay <abelay@novell.com>

On Tue, 2007-04-03 at 00:44 +0800, Pallipadi, Venkatesh wrote:
>  
> >-----Original Message-----
> >From: Li, Shaohua 
> >Sent: Monday, April 02, 2007 1:38 AM
> >To: linux acpi
> >Cc: Brown, Len; Adam Belay; Pallipadi, Venkatesh
> >Subject: [PATCH] acpi cpuidle driver should handle max_cstate
> >
> >After switching to cpuidle framework, acpi driver ingorned max_cstate,
> >which will break ipw driver. Below patch fixed the issue. It's a little
> >complicated, but this really should be handled in the driver instead of
> >cpuidle core. If you have better fix, please speak.
> >
> >Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> >
> > 
> >-module_param(max_cstate, uint, 0644);
> >+void acpi_max_cstate_changed(void)
> >+{
> >+	/* Driver will reset devices' max cstate limit */
> >+	cpuidle_unregister_driver(&acpi_idle_driver);
> >+	cpuidle_register_driver(&acpi_idle_driver);
> >+}
> 
> Will a redetect work instead of unregister/register.
Ok, updated it.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: linux/drivers/acpi/osl.c
===================================================================
--- linux.orig/drivers/acpi/osl.c	2007-04-02 17:10:22.000000000 +0800
+++ linux/drivers/acpi/osl.c	2007-04-03 08:47:20.000000000 +0800
@@ -997,6 +997,16 @@ unsigned int max_cstate = ACPI_PROCESSOR
 
 EXPORT_SYMBOL(max_cstate);
 
+void (*acpi_do_set_cstate_limit)(void);
+EXPORT_SYMBOL(acpi_do_set_cstate_limit);
+
+void acpi_set_cstate_limit(unsigned int new_limit)
+{
+	max_cstate = new_limit;
+	if (acpi_do_set_cstate_limit)
+		acpi_do_set_cstate_limit();
+}
+
 /*
  * Acquire a spinlock.
  *
Index: linux/drivers/acpi/processor_core.c
===================================================================
--- linux.orig/drivers/acpi/processor_core.c	2007-04-03 08:47:05.000000000 +0800
+++ linux/drivers/acpi/processor_core.c	2007-04-03 08:47:20.000000000 +0800
@@ -1026,11 +1026,13 @@ static int __init acpi_processor_init(vo
 	acpi_processor_ppc_init();
 
 	cpuidle_register_driver(&acpi_idle_driver);
+	acpi_do_set_cstate_limit = acpi_max_cstate_changed;
 	return 0;
 }
 
 static void __exit acpi_processor_exit(void)
 {
+	acpi_do_set_cstate_limit = NULL;
 	cpuidle_unregister_driver(&acpi_idle_driver);
 
 	acpi_processor_ppc_exit();
Index: linux/drivers/acpi/processor_idle.c
===================================================================
--- linux.orig/drivers/acpi/processor_idle.c	2007-04-03 08:47:05.000000000 +0800
+++ linux/drivers/acpi/processor_idle.c	2007-04-03 08:50:50.000000000 +0800
@@ -75,7 +75,30 @@ ACPI_MODULE_NAME("processor_idle");
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */
 
-module_param(max_cstate, uint, 0644);
+void acpi_max_cstate_changed(void)
+{
+	int cpu;
+	/* Driver will reset devices' max cstate limit */
+	lock_cpu_hotplug();
+	for_each_online_cpu(cpu)
+		cpuidle_force_redetect(&per_cpu(cpuidle_devices, cpu));
+	unlock_cpu_hotplug();
+}
+
+static int change_max_cstate(const char *val, struct kernel_param *kp)
+{
+	int max;
+
+	max = simple_strtol(val, NULL, 0);
+	if (!max)
+		return -EINVAL;
+	max_cstate = max;
+	if (acpi_do_set_cstate_limit)
+		acpi_do_set_cstate_limit();
+	return 0;
+}
+
+module_param_call(max_cstate, change_max_cstate, param_get_uint, &max_cstate, 0644);
 
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
@@ -1054,7 +1077,7 @@ static int acpi_idle_init(struct cpuidle
 		return -EINVAL;
 	}
 
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
 		state = &dev->states[count];
 
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2007-04-02 17:10:22.000000000 +0800
+++ linux/include/linux/acpi.h	2007-04-03 08:47:20.000000000 +0800
@@ -205,11 +205,8 @@ static inline unsigned int acpi_get_csta
 {
 	return max_cstate;
 }
-static inline void acpi_set_cstate_limit(unsigned int new_limit)
-{
-	max_cstate = new_limit;
-	return;
-}
+extern void (*acpi_do_set_cstate_limit)(void);
+extern void acpi_set_cstate_limit(unsigned int new_limit);
 #else
 static inline unsigned int acpi_get_cstate_limit(void) { return 0; }
 static inline void acpi_set_cstate_limit(unsigned int new_limit) { return; }
