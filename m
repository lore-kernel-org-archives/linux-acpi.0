From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Enable C2/C3 on SMP systems
Date: Fri, 1 Apr 2005 17:41:15 -0800
Message-ID: <20050401174115.A5121@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Attached patch enables C2/C3 on SMP systems. Please review and let me know
your comments.

Thanks,
Venki


Currently, C2/C3 is supported on UP systems only. This patch adds support 
for C2/C3 on SMP systems.

http://bugme.osdl.org/show_bug.cgi?id=4401 
has some history on this.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

diff -purN linux-2.6.12-rc1-org/arch/i386/kernel/acpi/cstate.c linux-2.6.12-rc1-org-patch/arch/i386/kernel/acpi/cstate.c
--- linux-2.6.12-rc1-org/arch/i386/kernel/acpi/cstate.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/arch/i386/kernel/acpi/cstate.c	2005-04-01 13:30:43.000000000 -0800
@@ -0,0 +1,71 @@
+/*
+ * arch/i386/kernel/acpi/cstate.c
+ *
+ * Copyright (C) 2005 Intel Corporation
+ * 	Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * 	- Added _PDC for SMP C-states on Intel CPUs
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+
+#include <acpi/processor.h>
+#include <asm/acpi.h>
+
+static void acpi_processor_power_init_intel_pdc(
+		struct acpi_processor_power *pow)
+{
+	struct acpi_object_list *obj_list;
+	union acpi_object *obj;
+	u32 *buf;
+
+	/* allocate and initialize pdc. It will be used later. */
+	obj_list = kmalloc(sizeof(struct acpi_object_list), GFP_KERNEL);
+	if (!obj_list) {
+		printk(KERN_ERR "Memory allocation error\n");
+		return;
+	}
+
+	obj = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
+	if (!obj) {
+		printk(KERN_ERR "Memory allocation error\n");
+		kfree(obj_list);
+		return;
+	}
+
+	buf = kmalloc(12, GFP_KERNEL);
+	if (!buf) {
+		printk(KERN_ERR "Memory allocation error\n");
+		kfree(obj);
+		kfree(obj_list);
+		return;
+	}
+
+	buf[0] = ACPI_PDC_REVISION_ID;
+	buf[1] = 1;
+	buf[2] = ACPI_PDC_C_CAPABILITY_SMP;
+
+	obj->type = ACPI_TYPE_BUFFER;
+	obj->buffer.length = 12;
+	obj->buffer.pointer = (u8 *)buf;
+	obj_list->count = 1;
+	obj_list->pointer = obj;
+	pow->pdc = obj_list;
+
+	return;
+}
+
+void acpi_processor_power_init_pdc(struct acpi_processor_power *pow, 
+		unsigned int cpu)
+{
+	struct cpuinfo_x86 *c = cpu_data + cpu;
+
+	pow->pdc = NULL;
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		acpi_processor_power_init_intel_pdc(pow);
+
+	return;
+}
+EXPORT_SYMBOL(acpi_processor_power_init_pdc);
diff -purN linux-2.6.12-rc1-org/arch/i386/kernel/acpi/Makefile linux-2.6.12-rc1-org-patch/arch/i386/kernel/acpi/Makefile
--- linux-2.6.12-rc1-org/arch/i386/kernel/acpi/Makefile	2005-03-01 23:38:09.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/arch/i386/kernel/acpi/Makefile	2005-04-01 13:22:02.000000000 -0800
@@ -2,3 +2,7 @@ obj-$(CONFIG_ACPI_BOOT)		:= boot.o
 obj-$(CONFIG_X86_IO_APIC)	+= earlyquirk.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup.o
 
+ifneq ($(CONFIG_ACPI_PROCESSOR),)
+obj-y				+= cstate.o
+endif
+
diff -purN linux-2.6.12-rc1-org/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c linux-2.6.12-rc1-org-patch/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- linux-2.6.12-rc1-org/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-04-01 11:50:15.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-04-01 11:55:16.000000000 -0800
@@ -369,7 +369,7 @@ static int centrino_cpu_init_acpi(struct
 	arg0.buffer.pointer = (u8 *) arg0_buf;
 	arg0_buf[0] = ACPI_PDC_REVISION_ID;
 	arg0_buf[1] = 1;
-	arg0_buf[2] = ACPI_PDC_EST_CAPABILITY_SMP | ACPI_PDC_EST_CAPABILITY_MSR;
+	arg0_buf[2] = ACPI_PDC_EST_CAPABILITY_SMP_MSR;
 
 	p.pdc = &arg_list;
 
diff -purN linux-2.6.12-rc1-org/drivers/acpi/processor_core.c linux-2.6.12-rc1-org-patch/drivers/acpi/processor_core.c
--- linux-2.6.12-rc1-org/drivers/acpi/processor_core.c	2005-04-01 11:50:15.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/drivers/acpi/processor_core.c	2005-04-01 11:55:16.000000000 -0800
@@ -256,6 +256,43 @@ acpi_processor_errata (
 
 
 /* --------------------------------------------------------------------------
+                              Common ACPI processor fucntions
+   -------------------------------------------------------------------------- */
+
+/*
+ * _PDC is required for a BIOS-OS handshake for most of the newer 
+ * ACPI processor features.
+ */
+
+int acpi_processor_set_pdc(struct acpi_processor *pr,
+				struct acpi_object_list *pdc_in)
+{
+	acpi_status		status = AE_OK;
+	u32			arg0_buf[3];
+	union acpi_object	arg0 = {ACPI_TYPE_BUFFER};
+	struct acpi_object_list	no_object = {1, &arg0};
+	struct acpi_object_list	*pdc;
+
+	ACPI_FUNCTION_TRACE("acpi_processor_set_pdc");
+
+	arg0.buffer.length = 12;
+	arg0.buffer.pointer = (u8 *) arg0_buf;
+	arg0_buf[0] = ACPI_PDC_REVISION_ID;
+	arg0_buf[1] = 0;
+	arg0_buf[2] = 0;
+
+	pdc = (pdc_in) ? pdc_in : &no_object;
+
+	status = acpi_evaluate_object(pr->handle, "_PDC", pdc, NULL);
+
+	if ((ACPI_FAILURE(status)) && (pdc_in))
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Error evaluating _PDC, using legacy perf. control...\n"));
+
+	return_VALUE(status);
+}
+
+
+/* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
diff -purN linux-2.6.12-rc1-org/drivers/acpi/processor_idle.c linux-2.6.12-rc1-org-patch/drivers/acpi/processor_idle.c
--- linux-2.6.12-rc1-org/drivers/acpi/processor_idle.c	2005-04-01 11:50:15.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/drivers/acpi/processor_idle.c	2005-04-01 13:27:27.000000000 -0800
@@ -6,6 +6,8 @@
  *  Copyright (C) 2004       Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
  *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *  			- Added processor hotplug support
+ *  Copyright (C) 2005  Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *  			- Added support for C3 on SMP
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
@@ -142,7 +144,7 @@ acpi_processor_power_activate (
 		switch (old->type) {
 		case ACPI_STATE_C3:
 			/* Disable bus master reload */
-			if (new->type != ACPI_STATE_C3)
+			if (new->type != ACPI_STATE_C3 && pr->flags.bm_check)
 				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0, ACPI_MTX_DO_NOT_LOCK);
 			break;
 		}
@@ -152,7 +154,7 @@ acpi_processor_power_activate (
 	switch (new->type) {
 	case ACPI_STATE_C3:
 		/* Enable bus master reload */
-		if (old->type != ACPI_STATE_C3)
+		if (old->type != ACPI_STATE_C3 && pr->flags.bm_check)
 			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1, ACPI_MTX_DO_NOT_LOCK);
 		break;
 	}
@@ -297,8 +299,16 @@ static void acpi_processor_idle (void)
 		break;
 
 	case ACPI_STATE_C3:
-		/* Disable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1, ACPI_MTX_DO_NOT_LOCK);
+		
+		if (pr->flags.bm_check) {
+			/* Disable bus master arbitration */
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1, 
+					ACPI_MTX_DO_NOT_LOCK);
+		} else {
+			/* SMP case. Flush caches before C3. */
+			ACPI_FLUSH_CPU_CACHE();
+		}
+		
 		/* Get start time (ticks) */
 		t1 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Invoke C3 */
@@ -307,8 +317,11 @@ static void acpi_processor_idle (void)
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
-		/* Enable bus master arbitration */
-		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
+		if (pr->flags.bm_check) {
+			/* Enable bus master arbitration */
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
+		}
+
 		/* Re-enable interrupts */
 		local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
@@ -529,9 +542,6 @@ static int acpi_processor_get_power_info
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_power_info_cst");
 
-	if (errata.smp)
-		return_VALUE(-ENODEV);
-
 	if (nocst)
 		return_VALUE(-ENODEV);
 
@@ -664,13 +674,6 @@ static void acpi_processor_power_verify_
 		return_VOID;
 	}
 
-	/* We're (currently) only supporting C2 on UP */
-	else if (errata.smp) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "C2 not supported in SMP mode\n"));
-		return_VOID;
-	}
-
 	/*
 	 * Otherwise we've met all of our C2 requirements.
 	 * Normalize the C2 latency to expidite policy
@@ -692,6 +695,17 @@ static void acpi_processor_power_verify_
 		return_VOID;
 
 	/*
+	 * WBINVD should be set in fadt, for C3 state to be supported on
+	 * SMP system.
+	 */
+	else if ((num_online_cpus() > 1) && (acpi_fadt.wb_invd != 1)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Cache invalidation should work properly"
+				  " for C3 to be enabled on SMP systems\n"));
+		return_VOID;
+	}
+
+	/*
 	 * C3 latency must be less than or equal to 1000
 	 * microseconds.
 	 */
@@ -703,19 +717,12 @@ static void acpi_processor_power_verify_
 	}
 
 	/* bus mastering control is necessary */
-	else if (!pr->flags.bm_control) {
+	else if ((num_online_cpus() == 1) && !pr->flags.bm_control) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "C3 support requires bus mastering control\n"));
 		return_VOID;
 	}
 
-	/* We're (currently) only supporting C2 on UP */
-	else if (errata.smp) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "C3 not supported in SMP mode\n"));
-		return_VOID;
-	}
-
 	/*
 	 * PIIX4 Erratum #18: We don't support C3 when Type-F (fast)
 	 * DMA transfers are used by any ISA device to avoid livelock.
@@ -737,7 +744,17 @@ static void acpi_processor_power_verify_
 	 */
 	cx->valid = 1;
 	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
-	pr->flags.bm_check = 1;
+
+	/*
+	 * bm_check is only needed for C3 on UP.
+	 * On SMP we invalidate cache before entering C3.
+	 */
+	if (num_online_cpus() == 1) {
+		pr->flags.bm_check = 1;
+	} else {
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 
+				0, ACPI_MTX_DO_NOT_LOCK);
+	}
 
 	return_VOID;
 }
@@ -829,7 +846,7 @@ int acpi_processor_cst_has_changed (stru
 	if (!pr)
  		return_VALUE(-EINVAL);
 
-	if (errata.smp || nocst) {
+	if ( nocst) {
 		return_VALUE(-ENODEV);
 	}
 
@@ -929,7 +946,6 @@ static struct file_operations acpi_proce
 	.release	= single_release,
 };
 
-
 int acpi_processor_power_init(struct acpi_processor *pr, struct acpi_device *device)
 {
 	acpi_status		status = 0;
@@ -946,7 +962,10 @@ int acpi_processor_power_init(struct acp
 		first_run++;
 	}
 
-	if (!errata.smp && (pr->id == 0) && acpi_fadt.cst_cnt && !nocst) {
+	if (!pr)
+		return_VALUE(-EINVAL);
+
+	if (acpi_fadt.cst_cnt && !nocst) {
 		status = acpi_os_write_port(acpi_fadt.smi_cmd, acpi_fadt.cst_cnt, 8);
 		if (ACPI_FAILURE(status)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
@@ -954,6 +973,8 @@ int acpi_processor_power_init(struct acp
 		}
 	}
 
+	acpi_processor_power_init_pdc(&(pr->power), pr->id);
+	acpi_processor_set_pdc(pr, pr->power.pdc);
 	acpi_processor_get_power_info(pr);
 
 	/*
diff -purN linux-2.6.12-rc1-org/drivers/acpi/processor_perflib.c linux-2.6.12-rc1-org-patch/drivers/acpi/processor_perflib.c
--- linux-2.6.12-rc1-org/drivers/acpi/processor_perflib.c	2005-04-01 11:50:15.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/drivers/acpi/processor_perflib.c	2005-04-01 11:55:16.000000000 -0800
@@ -165,37 +165,6 @@ void acpi_processor_ppc_exit(void) {
 	acpi_processor_ppc_status &= ~PPC_REGISTERED;
 }
 
-/*
- * when registering a cpufreq driver with this ACPI processor driver, the
- * _PCT and _PSS structures are read out and written into struct
- * acpi_processor_performance.
- */
-static int acpi_processor_set_pdc (struct acpi_processor *pr)
-{
-	acpi_status             status = AE_OK;
-	u32			arg0_buf[3];
-	union acpi_object	arg0 = {ACPI_TYPE_BUFFER};
-	struct acpi_object_list no_object = {1, &arg0};
-	struct acpi_object_list *pdc;
-
-	ACPI_FUNCTION_TRACE("acpi_processor_set_pdc");
-
-	arg0.buffer.length = 12;
-	arg0.buffer.pointer = (u8 *) arg0_buf;
-	arg0_buf[0] = ACPI_PDC_REVISION_ID;
-	arg0_buf[1] = 0;
-	arg0_buf[2] = 0;
-
-	pdc = (pr->performance->pdc) ? pr->performance->pdc : &no_object;
-
-	status = acpi_evaluate_object(pr->handle, "_PDC", pdc, NULL);
-
-	if ((ACPI_FAILURE(status)) && (pr->performance->pdc))
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Error evaluating _PDC, using legacy perf. control...\n"));
-
-	return_VALUE(status);
-}
-
 
 static int
 acpi_processor_get_performance_control (
@@ -357,7 +326,7 @@ acpi_processor_get_performance_info (
 	if (!pr || !pr->performance || !pr->handle)
 		return_VALUE(-EINVAL);
 
-	acpi_processor_set_pdc(pr);
+	acpi_processor_set_pdc(pr, pr->performance->pdc);
 
 	status = acpi_get_handle(pr->handle, "_PCT", &handle);
 	if (ACPI_FAILURE(status)) {
diff -purN linux-2.6.12-rc1-org/include/acpi/pdc_intel.h linux-2.6.12-rc1-org-patch/include/acpi/pdc_intel.h
--- linux-2.6.12-rc1-org/include/acpi/pdc_intel.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/include/acpi/pdc_intel.h	2005-04-01 12:17:29.000000000 -0800
@@ -0,0 +1,29 @@
+
+/* _PDC bit definition for Intel processors */
+
+#ifndef __PDC_INTEL_H__
+#define __PDC_INTEL_H__
+
+#define ACPI_PDC_P_FFH			(0x0001)
+#define ACPI_PDC_C_C1_HALT		(0x0002)
+#define ACPI_PDC_T_FFH			(0x0004)
+#define ACPI_PDC_SMP_C1PT		(0x0008)
+#define ACPI_PDC_SMP_C2C3		(0x0010)
+#define ACPI_PDC_SMP_P_SWCOORD		(0x0020)
+#define ACPI_PDC_SMP_C_SWCOORD		(0x0040)
+#define ACPI_PDC_SMP_T_SWCOORD		(0x0080)
+#define ACPI_PDC_C_C1_FFH		(0x0100)
+
+
+#define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
+					 ACPI_PDC_C_C1_HALT)
+
+#define ACPI_PDC_EST_CAPABILITY_SMP_MSR	(ACPI_PDC_EST_CAPABILITY_SMP | \
+					 ACPI_PDC_P_FFH)
+
+#define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3 | \
+					 ACPI_PDC_SMP_C1PT | \
+					 ACPI_PDC_C_C1_HALT)
+
+#endif /* __PDC_INTEL_H__ */
+
diff -purN linux-2.6.12-rc1-org/include/acpi/processor.h linux-2.6.12-rc1-org-patch/include/acpi/processor.h
--- linux-2.6.12-rc1-org/include/acpi/processor.h	2005-04-01 11:50:15.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/include/acpi/processor.h	2005-04-01 13:26:59.000000000 -0800
@@ -4,6 +4,8 @@
 #include <linux/kernel.h>
 #include <linux/config.h>
 
+#include <asm/acpi.h>
+
 #define ACPI_PROCESSOR_BUSY_METRIC	10
 
 #define ACPI_PROCESSOR_MAX_POWER	8
@@ -14,6 +16,8 @@
 #define ACPI_PROCESSOR_MAX_THROTTLE	250	/* 25% */
 #define ACPI_PROCESSOR_MAX_DUTY_WIDTH	4
 
+#define ACPI_PDC_REVISION_ID		0x1
+
 /* Power Management */
 
 struct acpi_processor_cx;
@@ -59,6 +63,9 @@ struct acpi_processor_power {
 	u32			bm_activity;
 	int			count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
+
+	/* the _PDC objects passed by the driver, if any */
+	struct acpi_object_list *pdc;
 };
 
 /* Performance Management */
@@ -82,8 +89,6 @@ struct acpi_processor_px {
 	acpi_integer		status;			/* success indicator */
 };
 
-#define ACPI_PDC_REVISION_ID                   0x1
-
 struct acpi_processor_performance {
 	unsigned int		 state;
 	unsigned int		 platform_limit;
@@ -179,7 +184,23 @@ int acpi_processor_notify_smm(struct mod
 extern struct acpi_processor	*processors[NR_CPUS];
 extern struct acpi_processor_errata errata;
 
+int acpi_processor_set_pdc(struct acpi_processor *pr, 
+		struct acpi_object_list *pdc_in);
+
+#ifdef ARCH_HAS_POWER_PDC_INIT
+void acpi_processor_power_init_pdc(struct acpi_processor_power *pow, 
+		unsigned int cpu);
+#else
+static inline void acpi_processor_power_init_pdc(
+		struct acpi_processor_power *pow, unsigned int cpu)
+{
+	pow->pdc = NULL;
+	return;
+}
+#endif
+
 /* in processor_perflib.c */
+
 #ifdef CONFIG_CPU_FREQ
 void acpi_processor_ppc_init(void);
 void acpi_processor_ppc_exit(void);
diff -purN linux-2.6.12-rc1-org/include/asm-i386/acpi.h linux-2.6.12-rc1-org-patch/include/asm-i386/acpi.h
--- linux-2.6.12-rc1-org/include/asm-i386/acpi.h	2005-04-01 11:50:15.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/include/asm-i386/acpi.h	2005-04-01 12:23:55.000000000 -0800
@@ -28,6 +28,8 @@
 
 #ifdef __KERNEL__
 
+#include <acpi/pdc_intel.h>
+
 #include <asm/system.h>		/* defines cmpxchg */
 
 #define COMPILER_DEPENDENT_INT64   long long
@@ -101,12 +103,6 @@ __acpi_release_global_lock (unsigned int
         :"=r"(n_hi), "=r"(n_lo)     \
         :"0"(n_hi), "1"(n_lo))
 
-/*
- * Refer Intel ACPI _PDC support document for bit definitions
- */
-#define ACPI_PDC_EST_CAPABILITY_SMP 	0xa
-#define ACPI_PDC_EST_CAPABILITY_MSR	0x1
-
 #ifdef CONFIG_ACPI_BOOT 
 extern int acpi_lapic;
 extern int acpi_ioapic;
@@ -185,6 +181,8 @@ extern void acpi_reserve_bootmem(void);
 
 extern u8 x86_acpiid_to_apicid[];
 
+#define ARCH_HAS_POWER_PDC_INIT	1
+
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/
diff -purN linux-2.6.12-rc1-org/include/asm-x86_64/acpi.h linux-2.6.12-rc1-org-patch/include/asm-x86_64/acpi.h
--- linux-2.6.12-rc1-org/include/asm-x86_64/acpi.h	2005-04-01 11:50:15.000000000 -0800
+++ linux-2.6.12-rc1-org-patch/include/asm-x86_64/acpi.h	2005-04-01 12:22:57.000000000 -0800
@@ -28,6 +28,8 @@
 
 #ifdef __KERNEL__
 
+#include <acpi/pdc_intel.h>
+
 #define COMPILER_DEPENDENT_INT64   long long
 #define COMPILER_DEPENDENT_UINT64  unsigned long long
 
@@ -99,12 +101,6 @@ __acpi_release_global_lock (unsigned int
         :"=r"(n_hi), "=r"(n_lo)     \
         :"0"(n_hi), "1"(n_lo))
 
-/*
- * Refer Intel ACPI _PDC support document for bit definitions
- */
-#define ACPI_PDC_EST_CAPABILITY_SMP 	0xa
-#define ACPI_PDC_EST_CAPABILITY_MSR	0x1
-
 #ifdef CONFIG_ACPI_BOOT
 extern int acpi_lapic;
 extern int acpi_ioapic;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
