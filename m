From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/6]physical CPU hot add
Date: Tue, 12 Apr 2005 13:31:12 +0800
Message-ID: <1113283863.27646.432.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Boot a CPU at runtime.

Signed-off-by: Li Shaohua<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c |  112 ++++++++++++++++++++-------
 linux-2.6.11-root/drivers/base/cpu.c         |    8 +
 linux-2.6.11-root/include/asm-i386/smp.h     |    2 
 3 files changed, 93 insertions(+), 29 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~warm_boot_cpu arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~warm_boot_cpu	2005-04-12 10:38:16.720411760 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-12 11:11:09.155556040 +0800
@@ -80,6 +80,12 @@ cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
+/* TSC's upper 32 bits can't be written in eariler CPU (before prescott), there
+ * is no way to resync one AP against BP. TBD: for prescott and above, we
+ * should use IA64's algorithm
+ */
+static int __devinitdata tsc_sync_disabled;
+
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
@@ -416,7 +422,7 @@ static void __devinit smp_callin(void)
 	/*
 	 *      Synchronize the TSC with the BP
 	 */
-	if (cpu_has_tsc && cpu_khz)
+	if (cpu_has_tsc && cpu_khz && !tsc_sync_disabled)
 		synchronize_tsc_ap();
 }
 
@@ -809,6 +815,31 @@ static inline int alloc_cpu_id(void)
 	return cpu;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static struct task_struct * __devinitdata cpu_idle_tasks[NR_CPUS];
+static inline struct task_struct * alloc_idle_task(int cpu)
+{
+	struct task_struct *idle;
+
+	if ((idle = cpu_idle_tasks[cpu]) != NULL) {
+		/* initialize thread_struct.  we really want to avoid destroy
+		 * idle tread
+		 */
+		idle->thread.esp = (unsigned long)(((struct pt_regs *)
+			(THREAD_SIZE + (unsigned long) idle->thread_info)) - 1);
+		init_idle(idle, cpu);
+		return idle;
+	}
+	idle = fork_idle(cpu);
+
+	if (!IS_ERR(idle))
+		cpu_idle_tasks[cpu] = idle;
+	return idle;
+}
+#else
+#define alloc_idle_task(cpu) fork_idle(cpu)
+#endif
+
 static int __devinit do_boot_cpu(int apicid, int cpu)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
@@ -828,7 +859,7 @@ static int __devinit do_boot_cpu(int api
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
 	 */
-	idle = fork_idle(cpu);
+	idle = alloc_idle_task(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
 	idle->thread.eip = (unsigned long) start_secondary;
@@ -931,6 +962,55 @@ void cpu_exit_clear(void)
 	cpu_clear(cpu, smp_commenced_mask);
 	unmap_cpu_to_logical_apicid(cpu);
 }
+
+struct warm_boot_cpu_info {
+	struct completion *complete;
+	int apicid;
+	int cpu;
+};
+
+static void __devinit do_warm_boot_cpu(void *p)
+{
+	struct warm_boot_cpu_info *info = p;
+	do_boot_cpu(info->apicid, info->cpu);
+	complete(info->complete);
+}
+
+int __devinit smp_prepare_cpu(int cpu)
+{
+	DECLARE_COMPLETION(done);
+	struct warm_boot_cpu_info info;
+	struct work_struct task;
+	int	apicid, ret;
+
+	lock_cpu_hotplug();
+	apicid = x86_cpu_to_apicid[cpu];
+	if (apicid == BAD_APICID) {
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	info.complete = &done;
+	info.apicid = apicid;
+	info.cpu = cpu;
+	INIT_WORK(&task, do_warm_boot_cpu, &info);
+
+	tsc_sync_disabled = 1;
+
+	/* init low mem mapping */
+	memcpy(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
+			sizeof(swapper_pg_dir[0]) * KERNEL_PGD_PTRS);
+	flush_tlb_all();
+	schedule_work(&task);
+	wait_for_completion(&done);
+
+	tsc_sync_disabled = 0;
+	zap_low_mappings();
+	ret = 0;
+exit:
+	unlock_cpu_hotplug();
+	return ret;
+}
 #endif
 
 static void smp_tune_scheduling (void)
@@ -1169,24 +1249,6 @@ void __devinit smp_prepare_boot_cpu(void
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-
-/* must be called with the cpucontrol mutex held */
-static int __devinit cpu_enable(unsigned int cpu)
-{
-	/* get the target out of its holding state */
-	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
-	wmb();
-
-	/* wait for the processor to ack it. timeout? */
-	while (!cpu_online(cpu))
-		cpu_relax();
-
-	fixup_irqs(cpu_online_map);
-	/* counter the disable in fixup_irqs() */
-	local_irq_enable();
-	return 0;
-}
-
 static void
 remove_siblinginfo(int cpu)
 {
@@ -1270,14 +1332,6 @@ int __devinit __cpu_up(unsigned int cpu)
 		return -EIO;
 	}
 
-#ifdef CONFIG_HOTPLUG_CPU
-	/* Already up, and in cpu_quiescent now? */
-	if (cpu_isset(cpu, smp_commenced_mask)) {
-		cpu_enable(cpu);
-		return 0;
-	}
-#endif
-
 	local_irq_enable();
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
@@ -1292,10 +1346,12 @@ void __init smp_cpus_done(unsigned int m
 	setup_ioapic_dest();
 #endif
 	zap_low_mappings();
+#ifndef CONFIG_HOTPLUG_CPU
 	/*
 	 * Disable executability of the SMP trampoline:
 	 */
 	set_kernel_exec((unsigned long)trampoline_base, trampoline_exec);
+#endif
 }
 
 void __init smp_intr_init(void)
diff -puN drivers/base/cpu.c~warm_boot_cpu drivers/base/cpu.c
--- linux-2.6.11/drivers/base/cpu.c~warm_boot_cpu	2005-04-12 10:38:16.721411608 +0800
+++ linux-2.6.11-root/drivers/base/cpu.c	2005-04-12 10:38:16.727410696 +0800
@@ -16,6 +16,11 @@ struct sysdev_class cpu_sysdev_class = {
 EXPORT_SYMBOL(cpu_sysdev_class);
 
 #ifdef CONFIG_HOTPLUG_CPU
+int __attribute__ ((weak)) smp_prepare_cpu(int cpu)
+{
+	return 0;
+}
+
 static ssize_t show_online(struct sys_device *dev, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
@@ -36,7 +41,8 @@ static ssize_t store_online(struct sys_d
 			kobject_hotplug(&dev->kobj, KOBJ_OFFLINE);
 		break;
 	case '1':
-		ret = cpu_up(cpu->sysdev.id);
+		if ((ret = smp_prepare_cpu(cpu->sysdev.id)) == 0)
+			ret = cpu_up(cpu->sysdev.id);
 		break;
 	default:
 		ret = -EINVAL;
diff -puN include/asm-i386/smp.h~warm_boot_cpu include/asm-i386/smp.h
--- linux-2.6.11/include/asm-i386/smp.h~warm_boot_cpu	2005-04-12 10:38:16.722411456 +0800
+++ linux-2.6.11-root/include/asm-i386/smp.h	2005-04-12 10:38:16.727410696 +0800
@@ -52,6 +52,8 @@ extern u8 x86_cpu_to_apicid[];
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);
+
+extern int smp_prepare_cpu(int cpu);
 #endif
 
 /*
_




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
