From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH]Make processor module unloading safe
Date: Tue, 06 Sep 2005 16:08:24 +0800
Message-ID: <1125994104.4644.13.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: linux-JhLEnvuH02M@public.gmane.org, Venki <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
pm_idle isn=E2=80=99t a per-cpu data. In MP case, it is possible one CPU (e=
g.
the boot CPU) changed pm_idle, but other CPUs it=E2=80=99s not ready for it=
. The
ACPI module is such a case, CPU 0 changed pm_idle, which caused all CPUs
start using pm_idle, but other CPUs actually aren=E2=80=99t ready (their id=
le
information isn't initialized). The worse case is unloading ACPI module.
If non-boot CPU first freed their idle information, current code doesn=E2=
=80=99t
know it, and the CPUs possibly will use the freed memory again till boot
cpu restore pm_idle. This patch tries to fix the gaps.

Makes pm_idle a per-cpu data might be a better idea, but it=E2=80=99s platf=
orm
independent, so I didn't touch it but just fix the ACPI issue.

Thanks,
Shaohua


Signed-off-by: Shaohua Li<shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 linux-2.6.13-root/arch/i386/kernel/apm.c        |    2 -
 linux-2.6.13-root/arch/i386/kernel/process.c    |    4 +--
 linux-2.6.13-root/arch/ia64/kernel/process.c    |    4 +--
 linux-2.6.13-root/arch/x86_64/kernel/process.c  |    4 +--
 linux-2.6.13-root/drivers/acpi/processor_idle.c |   26 +++++++++++++++++++=
-----
 linux-2.6.13-root/include/asm-i386/system.h     |    3 +-
 linux-2.6.13-root/include/asm-ia64/system.h     |    3 +-
 linux-2.6.13-root/include/asm-x86_64/system.h   |    3 +-
 linux-2.6.13-root/kernel/sched.c                |    1=20
 9 files changed, 35 insertions(+), 15 deletions(-)

diff -puN drivers/acpi/processor_idle.c~remove_cpu_idle_save drivers/acpi/p=
rocessor_idle.c
--- linux-2.6.13/drivers/acpi/processor_idle.c~remove_cpu_idle_save	2005-09=
-05 09:30:34.595622176 +0800
+++ linux-2.6.13-root/drivers/acpi/processor_idle.c	2005-09-05 09:32:47.556=
409064 +0800
@@ -75,6 +75,8 @@ module_param(bm_history, uint, 0644);
                                 Power Management
    -----------------------------------------------------------------------=
--- */
=20
+static void acpi_processor_idle(void);
+static DEFINE_PER_CPU(void (*)(void), acpi_cpu_idle);
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
@@ -170,7 +172,7 @@ acpi_processor_power_activate (
 static atomic_t 	c3_cpu_count;
=20
=20
-static void acpi_processor_idle (void)
+static void __acpi_processor_idle (void)
 {
 	struct acpi_processor	*pr =3D NULL;
 	struct acpi_processor_cx *cx =3D NULL;
@@ -891,13 +893,13 @@ int acpi_processor_cst_has_changed (stru
 		return_VALUE(-ENODEV);
=20
 	/* Fall back to the default idle loop */
-	pm_idle =3D pm_idle_save;
-	synchronize_sched();  /* Relies on interrupts forcing exit from idle. */
+	per_cpu(acpi_cpu_idle, pr->id) =3D NULL;
+	cpu_idle_wait(cpumask_of_cpu(pr->id));
=20
 	pr->flags.power =3D 0;
 	result =3D acpi_processor_get_power_info(pr);
 	if ((pr->flags.power =3D=3D 1) && (pr->flags.power_setup_done))
-		pm_idle =3D acpi_processor_idle;
+		per_cpu(acpi_cpu_idle, pr->id) =3D __acpi_processor_idle;
=20
 	return_VALUE(result);
 }
@@ -983,6 +985,17 @@ static struct file_operations acpi_proce
 	.release	=3D single_release,
 };
=20
+static void acpi_processor_idle(void)
+{
+	int cpu =3D raw_smp_processor_id();
+	if (per_cpu(acpi_cpu_idle, cpu))
+		per_cpu(acpi_cpu_idle, cpu)();
+	else if (pm_idle_save)
+		pm_idle_save();
+	else
+		safe_halt();
+}
+
 int acpi_processor_power_init(struct acpi_processor *pr, struct acpi_devic=
e *device)
 {
 	acpi_status		status =3D 0;
@@ -1046,6 +1059,7 @@ int acpi_processor_power_init(struct acp
 	}
=20
 	pr->flags.power_setup_done =3D 1;
+	per_cpu(acpi_cpu_idle, pr->id) =3D __acpi_processor_idle;
=20
 	return_VALUE(0);
 }
@@ -1055,6 +1069,8 @@ int acpi_processor_power_exit(struct acp
 	ACPI_FUNCTION_TRACE("acpi_processor_power_exit");
=20
 	pr->flags.power_setup_done =3D 0;
+	per_cpu(acpi_cpu_idle, pr->id) =3D NULL;
+	cpu_idle_wait(cpumask_of_cpu(pr->id));
=20
 	if (acpi_device_dir(device))
 		remove_proc_entry(ACPI_PROCESSOR_FILE_POWER,acpi_device_dir(device));
@@ -1068,7 +1084,7 @@ int acpi_processor_power_exit(struct acp
 		 * (pm_idle), Wait for all processors to update cached/local
 		 * copies of pm_idle before proceeding.
 		 */
-		cpu_idle_wait();
+		cpu_idle_wait(cpu_online_map);
 	}
=20
 	return_VALUE(0);
diff -puN arch/i386/kernel/process.c~remove_cpu_idle_save arch/i386/kernel/=
process.c
--- linux-2.6.13/arch/i386/kernel/process.c~remove_cpu_idle_save	2005-09-05=
 09:30:34.618618680 +0800
+++ linux-2.6.13-root/arch/i386/kernel/process.c	2005-09-05 09:30:34.669610=
928 +0800
@@ -207,7 +207,7 @@ void cpu_idle(void)
 	}
 }
=20
-void cpu_idle_wait(void)
+void cpu_idle_wait(cpumask_t wait)
 {
 	unsigned int cpu, this_cpu =3D get_cpu();
 	cpumask_t map;
@@ -216,7 +216,7 @@ void cpu_idle_wait(void)
 	put_cpu();
=20
 	cpus_clear(map);
-	for_each_online_cpu(cpu) {
+	for_each_cpu_mask(cpu, wait) {
 		per_cpu(cpu_idle_state, cpu) =3D 1;
 		cpu_set(cpu, map);
 	}
diff -puN arch/x86_64/kernel/process.c~remove_cpu_idle_save arch/x86_64/ker=
nel/process.c
--- linux-2.6.13/arch/x86_64/kernel/process.c~remove_cpu_idle_save	2005-09-=
05 09:30:34.629617008 +0800
+++ linux-2.6.13-root/arch/x86_64/kernel/process.c	2005-09-05 09:30:34.6706=
10776 +0800
@@ -128,7 +128,7 @@ static void poll_idle (void)
 	}
 }
=20
-void cpu_idle_wait(void)
+void cpu_idle_wait(cpumask_t wait)
 {
 	unsigned int cpu, this_cpu =3D get_cpu();
 	cpumask_t map;
@@ -137,7 +137,7 @@ void cpu_idle_wait(void)
 	put_cpu();
=20
 	cpus_clear(map);
-	for_each_online_cpu(cpu) {
+	for_each_cpu_mask(cpu, wait) {
 		per_cpu(cpu_idle_state, cpu) =3D 1;
 		cpu_set(cpu, map);
 	}
diff -puN arch/ia64/kernel/process.c~remove_cpu_idle_save arch/ia64/kernel/=
process.c
--- linux-2.6.13/arch/ia64/kernel/process.c~remove_cpu_idle_save	2005-09-05=
 09:30:34.637615792 +0800
+++ linux-2.6.13-root/arch/ia64/kernel/process.c	2005-09-05 09:30:34.670610=
776 +0800
@@ -231,7 +231,7 @@ static inline void play_dead(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
=20
-void cpu_idle_wait(void)
+void cpu_idle_wait(cpumask_t wait)
 {
 	unsigned int cpu, this_cpu =3D get_cpu();
 	cpumask_t map;
@@ -240,7 +240,7 @@ void cpu_idle_wait(void)
 	put_cpu();
=20
 	cpus_clear(map);
-	for_each_online_cpu(cpu) {
+	for_each_cpu_mask(cpu, wait) {
 		per_cpu(cpu_idle_state, cpu) =3D 1;
 		cpu_set(cpu, map);
 	}
diff -puN include/asm-x86_64/system.h~remove_cpu_idle_save include/asm-x86_=
64/system.h
--- linux-2.6.13/include/asm-x86_64/system.h~remove_cpu_idle_save	2005-09-0=
5 09:30:34.638615640 +0800
+++ linux-2.6.13-root/include/asm-x86_64/system.h	2005-09-05 09:30:34.67161=
0624 +0800
@@ -326,7 +326,8 @@ static inline unsigned long __cmpxchg(vo
 /* For spinlocks etc */
 #define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__=
("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=3Dg" (x): /* no input */ =
:"memory"); } while (0)
=20
-void cpu_idle_wait(void);
+#include <linux/cpumask.h>
+void cpu_idle_wait(cpumask_t wait);
=20
 /*
  * disable hlt during certain critical i/o operations
diff -puN include/asm-i386/system.h~remove_cpu_idle_save include/asm-i386/s=
ystem.h
--- linux-2.6.13/include/asm-i386/system.h~remove_cpu_idle_save	2005-09-05 =
09:30:34.646614424 +0800
+++ linux-2.6.13-root/include/asm-i386/system.h	2005-09-05 09:30:34.6716106=
24 +0800
@@ -466,7 +466,8 @@ void disable_hlt(void);
 void enable_hlt(void);
=20
 extern int es7000_plat;
-void cpu_idle_wait(void);
+#include <linux/cpumask.h>
+void cpu_idle_wait(cpumask_t wait);
=20
 extern unsigned long arch_align_stack(unsigned long sp);
=20
diff -puN include/asm-ia64/system.h~remove_cpu_idle_save include/asm-ia64/s=
ystem.h
--- linux-2.6.13/include/asm-ia64/system.h~remove_cpu_idle_save	2005-09-05 =
09:30:34.647614272 +0800
+++ linux-2.6.13-root/include/asm-ia64/system.h	2005-09-05 09:30:34.6716106=
24 +0800
@@ -276,7 +276,8 @@ extern void ia64_load_extra (struct task
=20
 #define ia64_platform_is(x) (strcmp(x, platform_name) =3D=3D 0)
=20
-void cpu_idle_wait(void);
+#include <linux/cpumask.h>
+void cpu_idle_wait(cpumask_t wait);
=20
 #define arch_align_stack(x) (x)
=20
diff -puN arch/i386/kernel/apm.c~remove_cpu_idle_save arch/i386/kernel/apm.=
c
--- linux-2.6.13/arch/i386/kernel/apm.c~remove_cpu_idle_save	2005-09-05 09:=
30:34.655613056 +0800
+++ linux-2.6.13-root/arch/i386/kernel/apm.c	2005-09-05 09:30:34.673610320 =
+0800
@@ -2370,7 +2370,7 @@ static void __exit apm_exit(void)
 		 * (pm_idle), Wait for all processors to update cached/local
 		 * copies of pm_idle before proceeding.
 		 */
-		cpu_idle_wait();
+		cpu_idle_wait(cpu_online_map);
 	}
 	if (((apm_info.bios.flags & APM_BIOS_DISENGAGED) =3D=3D 0)
 	    && (apm_info.connection_version > 0x0100)) {
diff -puN kernel/sched.c~remove_cpu_idle_save kernel/sched.c
--- linux-2.6.13/kernel/sched.c~remove_cpu_idle_save	2005-09-05 09:30:34.66=
3611840 +0800
+++ linux-2.6.13-root/kernel/sched.c	2005-09-05 09:30:34.675610016 +0800
@@ -3771,6 +3771,7 @@ EXPORT_SYMBOL(cpu_present_map);
=20
 #ifndef CONFIG_SMP
 cpumask_t cpu_online_map =3D CPU_MASK_ALL;
+EXPORT_SYMBOL(cpu_online_map);
 cpumask_t cpu_possible_map =3D CPU_MASK_ALL;
 #endif
=20
_




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
