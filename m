From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/6]sep initializing rework
Date: Tue, 12 Apr 2005 13:30:46 +0800
Message-ID: <1113283845.27646.424.camel@sli10-desk.sh.intel.com>
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

Hi,
These patches (together with 5 patches followed this one) are updated
suspend/resume SMP patches. The patches fixed some bugs and do clean up
as suggested. Now they work for both suspend-to-ram and suspend-to-disk.
Patches are against 2.6.12-rc2-mm3.

Thanks,
Shaohua

---
Make SEP init per-cpu, so it is hotplug safed.

Signed-off-by: Li Shaohua<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    6 ++++++
 linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   12 +++++++-----
 linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    4 ++++
 linux-2.6.11-root/arch/i386/power/cpu.c                |    4 +---
 linux-2.6.11-root/include/asm-i386/smp.h               |    3 +++
 5 files changed, 21 insertions(+), 8 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~sep_init_cleanup arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~sep_init_cleanup	2005-04-12 10:36:00.164171464 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-12 10:36:00.174169944 +0800
@@ -443,6 +443,9 @@ static void __init start_secondary(void 
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
+
+	/* Note: this must be done before __cpu_up finish */
+	enable_sep_cpu();
 	cpu_set(smp_processor_id(), cpu_online_map);
 
 	/* We can take interrupts now: we're officially "up". */
@@ -920,6 +923,9 @@ static void __init smp_boot_cpus(unsigne
 	cpus_clear(cpu_core_map[0]);
 	cpu_set(0, cpu_core_map[0]);
 
+	sysenter_setup();
+	enable_sep_cpu();
+
 	/*
 	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
--- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-04-12 10:36:00.165171312 +0800
+++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-04-12 10:36:00.174169944 +0800
@@ -21,11 +21,16 @@
 
 extern asmlinkage void sysenter_entry(void);
 
-void enable_sep_cpu(void *info)
+void enable_sep_cpu(void)
 {
 	int cpu = get_cpu();
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
+	if (!boot_cpu_has(X86_FEATURE_SEP)) {
+		put_cpu();
+		return;
+	}
+
 	tss->ss1 = __KERNEL_CS;
 	tss->esp1 = sizeof(struct tss_struct) + (unsigned long) tss;
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
@@ -41,7 +46,7 @@ void enable_sep_cpu(void *info)
 extern const char vsyscall_int80_start, vsyscall_int80_end;
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
 
-static int __init sysenter_setup(void)
+int __init sysenter_setup(void)
 {
 	void *page = (void *)get_zeroed_page(GFP_ATOMIC);
 
@@ -58,8 +63,5 @@ static int __init sysenter_setup(void)
 	       &vsyscall_sysenter_start,
 	       &vsyscall_sysenter_end - &vsyscall_sysenter_start);
 
-	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
 	return 0;
 }
-
-__initcall(sysenter_setup);
diff -puN arch/i386/mach-voyager/voyager_smp.c~sep_init_cleanup arch/i386/mach-voyager/voyager_smp.c
--- linux-2.6.11/arch/i386/mach-voyager/voyager_smp.c~sep_init_cleanup	2005-04-12 10:36:00.167171008 +0800
+++ linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c	2005-04-12 10:36:00.175169792 +0800
@@ -499,6 +499,7 @@ start_secondary(void *unused)
 	while (!cpu_isset(cpuid, smp_commenced_mask))
 		rep_nop();
 	local_irq_enable();
+	enable_sep_cpu();
 
 	local_flush_tlb();
 
@@ -696,6 +697,9 @@ smp_boot_cpus(void)
 	printk("CPU%d: ", boot_cpu_id);
 	print_cpu_info(&cpu_data[boot_cpu_id]);
 
+	sysenter_setup();
+	enable_sep_cpu();
+
 	if(is_cpu_quad()) {
 		/* booting on a Quad CPU */
 		printk("VOYAGER SMP: Boot CPU is Quad\n");
diff -puN arch/i386/power/cpu.c~sep_init_cleanup arch/i386/power/cpu.c
--- linux-2.6.11/arch/i386/power/cpu.c~sep_init_cleanup	2005-04-12 10:36:00.168170856 +0800
+++ linux-2.6.11-root/arch/i386/power/cpu.c	2005-04-12 10:36:00.175169792 +0800
@@ -33,8 +33,6 @@ unsigned long saved_context_esp, saved_c
 unsigned long saved_context_esi, saved_context_edi;
 unsigned long saved_context_eflags;
 
-extern void enable_sep_cpu(void *);
-
 void __save_processor_state(struct saved_context *ctxt)
 {
 	kernel_fpu_begin();
@@ -136,7 +134,7 @@ void __restore_processor_state(struct sa
 	 * sysenter MSRs
 	 */
 	if (boot_cpu_has(X86_FEATURE_SEP))
-		enable_sep_cpu(NULL);
+		enable_sep_cpu();
 
 	fix_processor_context();
 	do_fpu_end();
diff -puN include/asm-i386/smp.h~sep_init_cleanup include/asm-i386/smp.h
--- linux-2.6.11/include/asm-i386/smp.h~sep_init_cleanup	2005-04-12 10:36:00.170170552 +0800
+++ linux-2.6.11-root/include/asm-i386/smp.h	2005-04-12 10:36:00.176169640 +0800
@@ -37,6 +37,9 @@ extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 
+extern int sysenter_setup(void);
+extern void enable_sep_cpu(void);
+
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
_




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
