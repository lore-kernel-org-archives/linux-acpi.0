From: raz ben yehuda <razb@bitband.com>
Subject: Subject: [PATCH 2/2] cpusets:  sos api
Date: Mon, 15 Sep 2008 13:49:42 +0200
Message-ID: <1221479382.9963.6.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw.bitband.com ([213.8.50.174]:42976 "EHLO mail.bitband.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753130AbYIOLtn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Sep 2008 07:49:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

From: Raz Ben Yehuda <razb@bitband.com>

SOS is a platform aimed to assign a service to an offloaded processor.
This patch is the facility for SOS (http://sos-linux.cvs.sourceforge.net/sos-linux/)

Signed-off-by: Raz Ben Yehuda <razb@bitband.com>
---
 arch/x86/kernel/process.c    |   27 +++++++++++++++++++++++++++
 arch/x86/kernel/process_32.c |    2 ++
 arch/x86/kernel/process_64.c |    2 ++
 arch/x86/kernel/smpboot.c    |    6 +++---
 include/linux/cpu.h          |   20 ++++++++++++++++++++
 kernel/cpu.c                 |    3 ++-
 6 files changed, 56 insertions(+), 4 deletions(-)

diff -uprN -X dontdiff linux-2.6.26-5-vanilla/arch/x86/kernel/process_32.c linux-2.6.26-5-SOS/arch/x86/kernel/process_32.c
--- linux-2.6.26-5-vanilla/arch/x86/kernel/process_32.c	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.26-5-SOS/arch/x86/kernel/process_32.c	2008-09-13 13:28:28.000000000 +0200
@@ -142,6 +142,8 @@ static inline void play_dead(void)
 	 * With physical CPU hotplug, we should halt the cpu
 	 */
 	local_irq_disable();
+	if (is_sossed())
+		run_sos();
 	while (1)
 		halt();
 }
diff -uprN -X dontdiff linux-2.6.26-5-vanilla/arch/x86/kernel/process_64.c linux-2.6.26-5-SOS/arch/x86/kernel/process_64.c
--- linux-2.6.26-5-vanilla/arch/x86/kernel/process_64.c	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.26-5-SOS/arch/x86/kernel/process_64.c	2008-09-13 13:28:28.000000000 +0200
@@ -127,6 +127,8 @@ static inline void play_dead(void)
 	__get_cpu_var(cpu_state) = CPU_DEAD;
 
 	local_irq_disable();
+	if (is_sossed())
+		run_sos();
 	while (1)
 		halt();
 }
diff -uprN -X dontdiff linux-2.6.26-5-vanilla/arch/x86/kernel/process.c linux-2.6.26-5-SOS/arch/x86/kernel/process.c
--- linux-2.6.26-5-vanilla/arch/x86/kernel/process.c	2008-09-13 13:30:49.000000000 +0200
+++ linux-2.6.26-5-SOS/arch/x86/kernel/process.c	2008-09-13 13:28:28.000000000 +0200
@@ -180,3 +180,30 @@ static int __init idle_setup(char *str)
 }
 early_param("idle", idle_setup);
 
+#ifdef CONFIG_HOTPLUG_CPU
+void (*hotplug_cpu_dead)(void);
+
+void unregister_sos(void)
+{
+	hotplug_cpu_dead = NULL;
+}
+EXPORT_SYMBOL_GPL(unregister_sos);
+
+int is_sossed(void)
+{
+	return hotplug_cpu_dead != NULL;
+}
+int register_sos(void (*hotplug_sos)(void))
+{
+	if (is_sossed())
+		return -1;
+	hotplug_cpu_dead = hotplug_sos;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_sos);
+
+void run_sos(void)
+{
+	hotplug_cpu_dead();
+}
+#endif
diff -uprN -X dontdiff linux-2.6.26-5-vanilla/arch/x86/kernel/smpboot.c linux-2.6.26-5-SOS/arch/x86/kernel/smpboot.c
--- linux-2.6.26-5-vanilla/arch/x86/kernel/smpboot.c	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.26-5-SOS/arch/x86/kernel/smpboot.c	2008-09-13 13:38:28.000000000 +0200
@@ -872,8 +872,8 @@ static int __cpuinit do_boot_cpu(int api
 				cpu, node);
 	}
 #endif
-
-	alternatives_smp_switch(1);
+	if (!is_sossed())
+		alternatives_smp_switch(1);
 
 	c_idle.idle = get_idle_for_cpu(cpu);
 
@@ -1423,7 +1423,7 @@ void __cpu_die(unsigned int cpu)
 		/* They ack this in play_dead by setting CPU_DEAD */
 		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
 			printk(KERN_INFO "CPU %d is now offline\n", cpu);
-			if (1 == num_online_cpus())
+			if (1 == num_online_cpus() && !is_sossed())
 				alternatives_smp_switch(0);
 			return;
 		}
diff -uprN -X dontdiff linux-2.6.26-5-vanilla/include/linux/cpu.h linux-2.6.26-5-SOS/include/linux/cpu.h
--- linux-2.6.26-5-vanilla/include/linux/cpu.h	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.26-5-SOS/include/linux/cpu.h	2008-09-13 13:28:28.000000000 +0200
@@ -44,6 +44,7 @@ extern int sched_create_sysfs_power_savi
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
+extern void unregister_sos(void);
 #endif
 struct notifier_block;
 
@@ -52,6 +53,9 @@ struct notifier_block;
 #ifdef CONFIG_HOTPLUG_CPU
 extern int register_cpu_notifier(struct notifier_block *nb);
 extern void unregister_cpu_notifier(struct notifier_block *nb);
+extern int register_sos(void (*hotplug_cpu_dead)(void));
+extern int is_sossed(void);
+extern void run_sos(void);
 #else
 
 #ifndef MODULE
@@ -61,11 +65,27 @@ static inline int register_cpu_notifier(
 {
 	return 0;
 }
+
+static inline int register_sos(void (*hotplug_cpu_dead)(void));
+{
+	return 0;
+}
 #endif
 
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
+
+static inline void unregister_sos(void)
+{
+}
+static inline int is_sossed(void)
+{
+	return 0;
+}
+static inline void run_sos(void)
+{
+}
 #endif
 
 int cpu_up(unsigned int cpu);
diff -uprN -X dontdiff linux-2.6.26-5-vanilla/kernel/cpu.c linux-2.6.26-5-SOS/kernel/cpu.c
--- linux-2.6.26-5-vanilla/kernel/cpu.c	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.26-5-SOS/kernel/cpu.c	2008-09-13 13:28:28.000000000 +0200
@@ -277,6 +277,7 @@ int __ref cpu_down(unsigned int cpu)
 	cpu_maps_update_done();
 	return err;
 }
+EXPORT_SYMBOL_GPL(cpu_down);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
 /* Requires cpu_add_remove_lock to be held */
@@ -340,7 +341,7 @@ int __cpuinit cpu_up(unsigned int cpu)
 	cpu_maps_update_done();
 	return err;
 }
-
+EXPORT_SYMBOL_GPL(cpu_up);
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_t frozen_cpus;
 

