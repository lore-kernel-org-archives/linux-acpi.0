From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] acpi cpuidle driver should handle max_cstate
Date: Mon, 02 Apr 2007 16:37:44 +0800
Message-ID: <1175503064.22290.5.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42500 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbXDBIkm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Apr 2007 04:40:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, Adam Belay <abelay@novell.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

After switching to cpuidle framework, acpi driver ingorned max_cstate,
which will break ipw driver. Below patch fixed the issue. It's a little
complicated, but this really should be handled in the driver instead of
cpuidle core. If you have better fix, please speak.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: linux/drivers/acpi/osl.c
===================================================================
--- linux.orig/drivers/acpi/osl.c	2007-04-02 16:21:10.000000000 +0800
+++ linux/drivers/acpi/osl.c	2007-04-02 16:21:57.000000000 +0800
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
--- linux.orig/drivers/acpi/processor_core.c	2007-04-02 16:21:10.000000000 +0800
+++ linux/drivers/acpi/processor_core.c	2007-04-02 16:21:37.000000000 +0800
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
--- linux.orig/drivers/acpi/processor_idle.c	2007-04-02 16:21:10.000000000 +0800
+++ linux/drivers/acpi/processor_idle.c	2007-04-02 16:22:40.000000000 +0800
@@ -75,7 +75,27 @@ ACPI_MODULE_NAME("processor_idle");
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */
 
-module_param(max_cstate, uint, 0644);
+void acpi_max_cstate_changed(void)
+{
+	/* Driver will reset devices' max cstate limit */
+	cpuidle_unregister_driver(&acpi_idle_driver);
+	cpuidle_register_driver(&acpi_idle_driver);
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
@@ -1054,7 +1074,7 @@ static int acpi_idle_init(struct cpuidle
 		return -EINVAL;
 	}
 
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
 		state = &dev->states[count];
 
Index: linux/include/linux/acpi.h
===================================================================
--- linux.orig/include/linux/acpi.h	2007-04-02 16:21:10.000000000 +0800
+++ linux/include/linux/acpi.h	2007-04-02 16:21:37.000000000 +0800
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
