From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: ACPI source release updated (20020829)
Date: Thu, 29 Aug 2002 18:43:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020830104257.KHQQC0A82650.6C9EC293@mvf.biglobe.ne.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDF1@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------_3D6EC91E01360106F35C_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDF1-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--------_3D6EC91E01360106F35C_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi Andy,

I checked difference today's releases between 2.4 and 2.5.
Except Makefiles, Config.help and toshiba_acpi.c, I found
some important differences.

I made patches to add some missed changes for both 2.4 and 2.5.
If this seems reasonable, please apply.

For 2.4:
 * bus.c
   - blacklist Compaq Presario 711FR was missing
   - removed unused argument from arguments of acpi_device_remove()
     (Should we remove whole #ifdef CONFIG_LDM for 2.4?)
   - fix remove_proc_entry("ACPI", ...) ->
         remove_proc_entry(ACPI_BUS_FILE_ROOT, ...)
   - remove unnecessary memory clear for acpi_fadt
   - remove unnecessary version check
 ... and several whitespace changes

For 2.5:
 * acpi_ksyms.c
   - export acpi_walk_namespace
 * battery.c
   - use acpi_os_free instead of kfree for those allocated
     by ACPI_ALLOCATE_BUFFER
 * system.c
   - remove garbage (#define ACPI_C)
 * include/linux/acpi.h
   - remove #else/#endif comments (Pavel Machek)
 ... and several whitespace changes

With these patches applied and Config.help, Makefiles, toshiba_acpi.c
and $Revision header-only difference excluded,
the difference looks like as follows.
IMO, as to bus.c and pci_irq.c, i386-specific mp* stuff should be
ifdef'ed so that ia64 can use the common sources.

diff -x CVS -Nuar acpi-2.4/drivers/acpi/Config.in acpi-2.5/drivers/acpi/Config.in
--- acpi-2.4/drivers/acpi/Config.in	Thu Aug 29 17:27:11 2002
+++ acpi-2.5/drivers/acpi/Config.in	Thu Aug 29 16:30:14 2002
@@ -23,7 +23,7 @@
       if [ "$CONFIG_PCI" = "y" ]; then
         define_bool CONFIG_ACPI_PCI		y
       fi
-      define_bool CONFIG_ACPI_SLEEP		y
+      define_bool CONFIG_ACPI_SLEEP		$CONFIG_SOFTWARE_SUSPEND
       define_bool CONFIG_ACPI_SYSTEM		y
       tristate     '  AC Adapter'	CONFIG_ACPI_AC
       tristate     '  Battery'		CONFIG_ACPI_BATTERY
@@ -34,6 +34,7 @@
       if [ "$CONFIG_NUMA" = "y" ]; then
         bool       '  NUMA support'     CONFIG_ACPI_NUMA $CONFIG_NUMA
       fi
+      tristate     '  Toshiba Laptop Extras'	CONFIG_ACPI_TOSHIBA
       bool         '  Debug Statements'	CONFIG_ACPI_DEBUG
     fi
   fi
diff -x CVS -Nuar acpi-2.4/drivers/acpi/bus.c acpi-2.5/drivers/acpi/bus.c
--- acpi-2.4/drivers/acpi/bus.c	Thu Aug 29 18:04:04 2002
+++ acpi-2.5/drivers/acpi/bus.c	Thu Aug 29 16:30:14 2002
@@ -1,5 +1,5 @@
 /*
- *  acpi_bus.c - ACPI Bus Driver ($Revision: 77 $)
+ *  acpi_bus.c - ACPI Bus Driver ($Revision: 80 $)
  *
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *
@@ -32,6 +32,7 @@
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/proc_fs.h>
+#include <asm/mpspec.h>
 #include "acpi_bus.h"
 #include "acpi_drivers.h"
 #include "include/acinterp.h"	/* for acpi_ex_eisa_id_to_string() */
@@ -46,6 +47,8 @@
 
 #define	PREFIX			"ACPI: "
 
+extern void eisa_set_level_irq(unsigned int irq);
+
 extern int			acpi_disabled;
 
 FADT_DESCRIPTOR			acpi_fadt;
@@ -1964,6 +1967,12 @@
 		goto error1;
 	}
 
+	/* Ensure the SCI is set to level-triggered, active-low */
+	if (acpi_ioapic)
+		mp_override_legacy_irq(acpi_fadt.sci_int, 3, 3, acpi_fadt.sci_int);
+	else
+		eisa_set_level_irq(acpi_fadt.sci_int);
+
 	status = acpi_enable_subsystem(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to start the ACPI Interpreter\n");
@@ -2168,5 +2177,6 @@
 	return 1;
 }
 
+subsys_initcall(acpi_init);
 
 __setup("acpi=", acpi_setup);
diff -x CVS -Nuar acpi-2.4/drivers/acpi/osl.c acpi-2.5/drivers/acpi/osl.c
--- acpi-2.4/drivers/acpi/osl.c	Thu Aug 29 17:44:27 2002
+++ acpi-2.5/drivers/acpi/osl.c	Wed Aug 28 00:13:27 2002
@@ -1,5 +1,5 @@
 /*
- *  acpi_osl.c - OS-dependent functions ($Revision: 80 $)
+ *  acpi_osl.c - OS-dependent functions ($Revision: 83 $)
  *
  *  Copyright (C) 2000       Andrew Henroid
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
+#include <linux/tqueue.h>
 #include <asm/io.h>
 #include "acpi.h"
 
@@ -79,7 +80,6 @@
 	 * it while walking the namespace (bus 0 and root bridges w/ _BBNs).
 	 */
 #ifdef CONFIG_ACPI_PCI
-	pcibios_config_init();
 	if (!pci_config_read || !pci_config_write) {
 		printk(KERN_ERR PREFIX "Access to PCI configuration space unavailable\n");
 		return AE_NULL_ENTRY;
diff -x CVS -Nuar acpi-2.4/drivers/acpi/pci_irq.c acpi-2.5/drivers/acpi/pci_irq.c
--- acpi-2.4/drivers/acpi/pci_irq.c	Thu Aug 29 16:58:11 2002
+++ acpi-2.5/drivers/acpi/pci_irq.c	Thu Aug 29 17:45:07 2002
@@ -33,6 +33,7 @@
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <asm/mpspec.h>
 #include "acpi_bus.h"
 #include "acpi_drivers.h"
 
diff -x CVS -Nuar acpi-2.4/drivers/acpi/processor.c acpi-2.5/drivers/acpi/processor.c
--- acpi-2.4/drivers/acpi/processor.c	Thu Aug 29 16:58:11 2002
+++ acpi-2.5/drivers/acpi/processor.c	Wed Aug 28 00:13:27 2002
@@ -1,5 +1,5 @@
 /*
- * acpi_processor.c - ACPI Processor Driver ($Revision: 69 $)
+ * acpi_processor.c - ACPI Processor Driver ($Revision: 71 $)
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
@@ -416,7 +416,7 @@
 	 * Interrupts must be disabled during bus mastering calculations and
 	 * for C2/C3 transitions.
 	 */
-	__cli();
+	local_irq_disable();
 
 	cx = &(pr->power.states[pr->power.state]);
 
@@ -461,7 +461,7 @@
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
 		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
-			__sti();
+			local_irq_enable();
 			next_state = cx->demotion.state;
 			goto end;
 		}
@@ -497,7 +497,7 @@
 		/* Get end time (ticks) */
 		t2 = inl(acpi_fadt.Xpm_tmr_blk.address);
 		/* Re-enable interrupts */
-		__sti();
+		local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
 		break;
@@ -516,13 +516,13 @@
 		/* Enable bus master arbitration */
 		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
 		/* Re-enable interrupts */
-		__sti();
+		local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks = ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
 		break;
 
 	default:
-		__sti();
+		local_irq_enable();
 		return;
 	}
 
@@ -1170,7 +1170,7 @@
 
 	pr->throttling.state = 0;
 
-	__cli();
+	local_irq_disable();
 
 	duty_mask = pr->throttling.state_count - 1;
 
@@ -1192,7 +1192,7 @@
 
 	pr->throttling.state = state;
 
-	__sti();
+	local_irq_enable();
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Throttling state is T%d (%d%% throttling applied)\n",
@@ -1225,7 +1225,7 @@
 	if (state == pr->throttling.state)
 		return_VALUE(0);
 
-	__cli();
+	local_irq_disable();
 
 	/*
 	 * Calculate the duty_value and duty_mask.
@@ -1267,7 +1267,7 @@
 
 	pr->throttling.state = state;
 
-	__sti();
+	local_irq_enable();
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Throttling state set to T%d (%d%%)\n", state, 
@@ -2066,10 +2066,8 @@
 	if (!pr)
 		return_VALUE(-EINVAL);
 
-#ifdef CONFIG_SMP
-	if (smp_num_cpus > 1)
-		errata.smp = smp_num_cpus;
-#endif
+	if (num_online_cpus() > 1)
+		errata.smp = TRUE;
 
 	acpi_processor_errata(pr);
 
diff -x CVS -Nuar acpi-2.4/drivers/acpi/system.c acpi-2.5/drivers/acpi/system.c
--- acpi-2.4/drivers/acpi/system.c	Thu Aug 29 16:58:11 2002
+++ acpi-2.5/drivers/acpi/system.c	Thu Aug 29 17:50:08 2002
@@ -1,5 +1,5 @@
 /*
- *  acpi_system.c - ACPI System Driver ($Revision: 57 $)
+ *  acpi_system.c - ACPI System Driver ($Revision: 63 $)
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
@@ -32,9 +32,12 @@
 #include <linux/poll.h>
 #include <linux/delay.h>
 #include <linux/sysrq.h>
-#include <linux/pm.h>
 #include <linux/compatmac.h>
 #include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
 #include "acpi_bus.h"
@@ -99,6 +102,179 @@
 #ifdef CONFIG_ACPI_SLEEP
 
 /**
+ * acpi_system_restore_state - OS-specific restoration of state
+ * @state:	sleep state we're exiting
+ *
+ * Note that if we're coming back from S4, the memory image should have already
+ * been loaded from the disk and is already in place. (Otherwise how else would we
+ * be here?).
+ */
+acpi_status
+acpi_system_restore_state (
+	u32			state)
+{
+	/* restore processor state
+	 * We should only be here if we're coming back from STR or STD.
+	 * And, in the case of the latter, the memory image should have already
+	 * been loaded from disk.
+	 */
+	if (state > ACPI_STATE_S1)
+		acpi_restore_state_mem();
+
+	/* wait for power to come back */
+	mdelay(10);
+
+	/* turn all the devices back on */
+	device_resume(RESUME_POWER_ON);
+
+	/* enable interrupts once again */
+	ACPI_ENABLE_IRQS();
+
+	/* restore device context */
+	device_resume(RESUME_RESTORE_STATE);
+
+	if (dmi_broken & BROKEN_INIT_AFTER_S1) {
+		printk("Broken toshiba laptop -> kicking interrupts\n");
+		init_8259A(0);
+	}
+
+	return AE_OK;
+}
+
+/**
+ * acpi_system_save_state - save OS specific state and power down devices
+ * @state:	sleep state we're entering.
+ *
+ * This handles saving all context to memory, and possibly disk.
+ * First, we call to the device driver layer to save device state.
+ * Once we have that, we save whatevery processor and kernel state we
+ * need to memory.
+ * If we're entering S4, we then write the memory image to disk.
+ *
+ * Only then is it safe for us to power down devices, since we may need
+ * the disks and upstream buses to write to.
+ */
+acpi_status
+acpi_system_save_state(
+	u32			state)
+{
+	int			error = 0;
+
+	/* Send notification to devices that they will be suspended.
+	 * If any device or driver cannot make the transition, either up
+	 * or down, we'll get an error back.
+	 */
+	error = device_suspend(state, SUSPEND_NOTIFY);
+	if (error)
+		return AE_ERROR;
+
+	if (state < ACPI_STATE_S5) {
+
+		/* Tell devices to stop I/O and actually save their state.
+		 * It is theoretically possible that something could fail,
+		 * so handle that gracefully..
+		 */
+		error = device_suspend(state, SUSPEND_SAVE_STATE);
+		if (error) {
+			/* tell devices to restore state if they have
+			 * it saved and to start taking I/O requests.
+			 */
+			device_resume(RESUME_RESTORE_STATE);
+			return error;
+		}
+
+		/* flush caches */
+		ACPI_FLUSH_CPU_CACHE();
+
+		/* Do arch specific saving of state. */
+		if (state > ACPI_STATE_S1) {
+			error = acpi_save_state_mem();
+
+			if (!error && (state == ACPI_STATE_S4))
+				error = acpi_save_state_disk();
+
+			if (error) {
+				device_resume(RESUME_RESTORE_STATE);
+				return error;
+			}
+		}
+	}
+
+	/* disable interrupts
+	 * Note that acpi_suspend -- our caller -- will do this once we return.
+	 * But, we want it done early, so we don't get any suprises during
+	 * the device suspend sequence.
+	 */
+	ACPI_DISABLE_IRQS();
+
+	/* Unconditionally turn off devices.
+	 * Obvious if we enter a sleep state.
+	 * If entering S5 (soft off), this should put devices in a
+	 * quiescent state.
+	 */
+	error = device_suspend(state, SUSPEND_POWER_DOWN);
+
+	/* We're pretty screwed if we got an error from this.
+	 * We try to recover by simply calling our own restore_state
+	 * function; see above for definition.
+	 *
+	 * If it's S5 though, go through with it anyway..
+	 */
+	if (error && state != ACPI_STATE_S5)
+		acpi_system_restore_state(state);
+
+	return error ? AE_ERROR : AE_OK;
+}
+
+
+/****************************************************************************
+ *
+ * FUNCTION:    acpi_system_suspend
+ *
+ * PARAMETERS:  %state: Sleep state to enter.
+ *
+ * RETURN:      acpi_status, whether or not we successfully entered and
+ *              exited sleep.
+ *
+ * DESCRIPTION: Perform OS-specific action to enter sleep state.
+ *              This is the final step in going to sleep, per spec.  If we
+ *              know we're coming back (i.e. not entering S5), we save the
+ *              processor flags. [ We'll have to save and restore them anyway,
+ *              so we use the arch-agnostic save_flags and restore_flags
+ *              here.]  We then set the place to return to in arch-specific
+ *              globals using arch_set_return_point. Finally, we call the
+ *              ACPI function to write the proper values to I/O ports.
+ *
+ ****************************************************************************/
+
+acpi_status
+acpi_system_suspend(
+	u32			state)
+{
+	acpi_status		status = AE_ERROR;
+	unsigned long		flags = 0;
+
+	local_irq_save(flags);
+	
+	switch (state)
+	{
+	case ACPI_STATE_S1:
+		barrier();
+		status = acpi_enter_sleep_state(state);
+		break;
+
+	case ACPI_STATE_S2:
+	case ACPI_STATE_S3:
+		do_suspend_lowlevel(0);
+		break;
+	}
+	local_irq_restore(flags);
+
+	return status;
+}
+
+
+/**
  * acpi_suspend - OS-agnostic system suspend/resume support (S? states)
  * @state:	state we're entering
  *
@@ -109,28 +285,46 @@
 {
 	acpi_status status;
 
-	/* only support S1 and S5 on kernel 2.4 */
-	if (state != ACPI_STATE_S1 && state != ACPI_STATE_S5)
+	/* get out if state is invalid */
+	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
 		return AE_ERROR;
 
+	freeze_processes();		/* device_suspend needs processes to be stopped */
+
+	/* do we have a wakeup address for S2 and S3? */
+	if (state == ACPI_STATE_S2 || state == ACPI_STATE_S3) {
+		if (!acpi_wakeup_address)
+			return AE_ERROR;
+		acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) acpi_wakeup_address);
+	}
+
 	acpi_enter_sleep_state_prep(state);
 
+	status = acpi_system_save_state(state);
+	if (!ACPI_SUCCESS(status))
+		return status;
+
 	/* disable interrupts and flush caches */
 	ACPI_DISABLE_IRQS();
 	ACPI_FLUSH_CPU_CACHE();
 
 	/* perform OS-specific sleep actions */
-	status = acpi_enter_sleep_state(state);
+	status = acpi_system_suspend(state);
 
 	/* Even if we failed to go to sleep, all of the devices are in an suspended
 	 * mode. So, we run these unconditionaly to make sure we have a usable system
 	 * no matter what.
 	 */
+	acpi_system_restore_state(state);
 	acpi_leave_sleep_state(state);
 
 	/* make sure interrupts are enabled */
 	ACPI_ENABLE_IRQS();
 
+	/* reset firmware waking vector */
+	acpi_set_firmware_waking_vector((ACPI_PHYSICAL_ADDRESS) 0);
+	thaw_processes();
+
 	return status;
 }
 
@@ -509,8 +703,16 @@
 	
 	if (!system->states[state])
 		return_VALUE(-ENODEV);
+
 	
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	if (state == 4) {
+		software_suspend();
+		return_VALUE(count);
+	}
+#endif
 	status = acpi_suspend(state);
+
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);
 	
@@ -961,7 +1163,7 @@
 
 /* Simple wrapper calling power down function. */
 static void acpi_sysrq_power_off(int key, struct pt_regs *pt_regs,
-	struct kbd_struct *kbd, struct tty_struct *tty)
+	struct tty_struct *tty)
 {
 	acpi_power_off();
 }
@@ -1019,6 +1221,11 @@
 	if (system->states[ACPI_STATE_S5]) {
 		pm_power_off = acpi_power_off;
 		register_sysrq_key('o', &sysrq_acpi_poweroff_op);
+
+		/* workaround: some systems don't claim S4 support, but they
+                   do support S5 (power-down). That is all we need, so
+		   indicate support. */
+		system->states[ACPI_STATE_S4] = 1;
 	}
 #endif
 


Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>

--------_3D6EC91E01360106F35C_MULTIPART_MIXED_
Content-Type: application/octet-stream; name="for-2.4-20020829.diff"
Content-Disposition: attachment;
 filename="for-2.4-20020829.diff"
Content-Transfer-Encoding: base64

SW5kZXg6IGFjcGktMi40L2RyaXZlcnMvYWNwaS9Db25maWcuaW4KZGlmZiAtdSBhY3BpLTIuNC9k
cml2ZXJzL2FjcGkvQ29uZmlnLmluOjEuMS4xLjEgYWNwaS0yLjQvZHJpdmVycy9hY3BpL0NvbmZp
Zy5pbjoxLjEuMS4xLjIuMQotLS0gYWNwaS0yLjQvZHJpdmVycy9hY3BpL0NvbmZpZy5pbjoxLjEu
MS4xCVRodSBBdWcgMjkgMTY6NTg6MTEgMjAwMgorKysgYWNwaS0yLjQvZHJpdmVycy9hY3BpL0Nv
bmZpZy5pbglUaHUgQXVnIDI5IDE4OjAxOjQ5IDIwMDIKQEAgLTMwLDEwICszMCwxMCBAQAogICAg
ICAgdHJpc3RhdGUgICAgICcgIEJ1dHRvbicJCUNPTkZJR19BQ1BJX0JVVFRPTgogICAgICAgdHJp
c3RhdGUgICAgICcgIEZhbicJCUNPTkZJR19BQ1BJX0ZBTgogICAgICAgdHJpc3RhdGUgICAgICcg
IFByb2Nlc3NvcicJQ09ORklHX0FDUElfUFJPQ0VTU09SCisgICAgICBkZXBfdHJpc3RhdGUgJyAg
VGhlcm1hbCBab25lJyAJQ09ORklHX0FDUElfVEhFUk1BTCAkQ09ORklHX0FDUElfUFJPQ0VTU09S
CiAgICAgICBpZiBbICIkQ09ORklHX05VTUEiID0gInkiIF07IHRoZW4KICAgICAgICAgYm9vbCAg
ICAgICAnICBOVU1BIHN1cHBvcnQnICAgICBDT05GSUdfQUNQSV9OVU1BICRDT05GSUdfTlVNQQog
ICAgICAgZmkKLSAgICAgIGRlcF90cmlzdGF0ZSAnICBUaGVybWFsIFpvbmUnIAlDT05GSUdfQUNQ
SV9USEVSTUFMICRDT05GSUdfQUNQSV9QUk9DRVNTT1IKICAgICAgIGJvb2wgICAgICAgICAnICBE
ZWJ1ZyBTdGF0ZW1lbnRzJwlDT05GSUdfQUNQSV9ERUJVRwogICAgIGZpCiAgIGZpCkluZGV4OiBh
Y3BpLTIuNC9kcml2ZXJzL2FjcGkvYnVzLmMKZGlmZiAtdSBhY3BpLTIuNC9kcml2ZXJzL2FjcGkv
YnVzLmM6MS4xLjEuMSBhY3BpLTIuNC9kcml2ZXJzL2FjcGkvYnVzLmM6MS4xLjEuMS4yLjIKLS0t
IGFjcGktMi40L2RyaXZlcnMvYWNwaS9idXMuYzoxLjEuMS4xCVRodSBBdWcgMjkgMTY6NTg6MTEg
MjAwMgorKysgYWNwaS0yLjQvZHJpdmVycy9hY3BpL2J1cy5jCVRodSBBdWcgMjkgMTg6MDQ6MjEg
MjAwMgpAQCAtNzIsNiArNzIsOCBAQAogCXsiQVNVUyAgIiwgIks3TSAgICAgIiwgMHgwMDAwMTAw
MCwgQUNQSV9UQUJMRV9EU0RULCBsZXNzX3RoYW5fb3JfZXF1YWwsICJGaWVsZCBiZXlvbmQgZW5k
IG9mIHJlZ2lvbiIsIDB9LAogCS8qIEludGVsIDgxMCBNb3RoZXJib2FyZD8gKi8KIAl7Ik1OVFJB
TCIsICJNTzgxMDEwQSIsIDB4MDAwMDAwMTIsIEFDUElfVEFCTEVfRFNEVCwgbGVzc190aGFuX29y
X2VxdWFsLCAiRmllbGQgYmV5b25kIGVuZCBvZiByZWdpb24iLCAwfSwKKwkvKiBDb21wYXEgUHJl
c2FyaW8gNzExRlIgKi8KKwl7IkNPTUFQUSIsICJFQUdMRVMiLCAweDA2MDQwMDAwLCBBQ1BJX1RB
QkxFX0RTRFQsIGxlc3NfdGhhbl9vcl9lcXVhbCwgIlNDSSBpc3N1ZXMgKEMyIGRpc2FibGVkKSIs
IDB9LAogCS8qIENvbXBhcSBQcmVzYXJpbyAxNzAwICovCiAJeyJQVExURCAiLCAiICBEU0RUICAi
LCAweDA2MDQwMDAwLCBBQ1BJX1RBQkxFX0RTRFQsIGxlc3NfdGhhbl9vcl9lcXVhbCwgIk11bHRp
cGxlIHByb2JsZW1zIiwgMX0sCiAJLyogU29ueSBGWDEyMCwgRlgxNDAsIEZYMTUwPyAqLwpAQCAt
OTEsNyArOTMsNyBAQAogI2lmZGVmIENPTkZJR19MRE0KIAogc3RhdGljIGludCBhY3BpX2Rldmlj
ZV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpOwotc3RhdGljIGludCBhY3BpX2RldmljZV9yZW1v
dmUoc3RydWN0IGRldmljZSAqZGV2LCB1MzIgZmxhZ3MpOworc3RhdGljIGludCBhY3BpX2Rldmlj
ZV9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KTsKIHN0YXRpYyBpbnQgYWNwaV9kZXZpY2Vfc3Vz
cGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBzdGF0ZSwgdTMyIHN0YWdlKTsKIHN0YXRpYyBp
bnQgYWNwaV9kZXZpY2VfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyIHN0YWdlKTsKIApA
QCAtMTIwLDggKzEyMiw3IEBACiAKIHN0YXRpYyBpbnQKIGFjcGlfZGV2aWNlX3JlbW92ZSAoCi0J
c3RydWN0IGRldmljZQkJKmRldiwKLQl1MzIJCQlmbGFncykKKwlzdHJ1Y3QgZGV2aWNlCQkqZGV2
KQogewogCUFDUElfRlVOQ1RJT05fVFJBQ0UoImFjcGlfZGV2aWNlX3JlbW92ZSIpOwogCkBAIC0y
MDUyLDcgKzIwNTMsNyBAQAogCiAJLyogTWltaWMgc3RydWN0dXJlZCBleGNlcHRpb24gaGFuZGxp
bmcgKi8KIGVycm9yNDoKLQlyZW1vdmVfcHJvY19lbnRyeSgiQUNQSSIsIE5VTEwpOworCXJlbW92
ZV9wcm9jX2VudHJ5KEFDUElfQlVTX0ZJTEVfUk9PVCwgTlVMTCk7CiBlcnJvcjM6CiAJYWNwaV9i
dXNfcmVtb3ZlKGFjcGlfcm9vdCwgQUNQSV9CVVNfUkVNT1ZBTF9OT1JNQUwpOwogZXJyb3IyOgpA
QCAtMjEwOSw4ICsyMTEwLDYgQEAKIAogCUFDUElfRlVOQ1RJT05fVFJBQ0UoImFjcGlfaW5pdCIp
OwogCi0JbWVtc2V0KCZhY3BpX2ZhZHQsIDAsIHNpemVvZihGQURUX0RFU0NSSVBUT1IpKTsKLQog
CXByaW50ayhLRVJOX0lORk8gUFJFRklYICJTdWJzeXN0ZW0gcmV2aXNpb24gJTA4eFxuIiwKIAkJ
QUNQSV9DQV9WRVJTSU9OKTsKIApAQCAtMjE3MCw5ICsyMTY5LDQgQEAKIH0KIAogCi0jaWYgTElO
VVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDIsNSwwKQotc3Vic3lzX2luaXRjYWxs
KGFjcGlfaW5pdCk7Ci0jZW5kaWYKLQogX19zZXR1cCgiYWNwaT0iLCBhY3BpX3NldHVwKTsKLQpJ
bmRleDogYWNwaS0yLjQvZHJpdmVycy9hY3BpL29zbC5jCmRpZmYgLXUgYWNwaS0yLjQvZHJpdmVy
cy9hY3BpL29zbC5jOjEuMS4xLjEgYWNwaS0yLjQvZHJpdmVycy9hY3BpL29zbC5jOjEuMS4xLjEu
Mi4xCi0tLSBhY3BpLTIuNC9kcml2ZXJzL2FjcGkvb3NsLmM6MS4xLjEuMQlUaHUgQXVnIDI5IDE2
OjU4OjExIDIwMDIKKysrIGFjcGktMi40L2RyaXZlcnMvYWNwaS9vc2wuYwlUaHUgQXVnIDI5IDE4
OjAxOjQ5IDIwMDIKQEAgLTY1OCw3ICs2NTgsNiBAQAogCQl9CiAJfQogCWJyZWFrOwotCiAJZGVm
YXVsdDoKIAkJLyoKIAkJICogQWxsb2NhdGUvaW5pdGlhbGl6ZSBEUEMgc3RydWN0dXJlLiAgTm90
ZSB0aGF0IHRoaXMgbWVtb3J5IHdpbGwgYmUK

--------_3D6EC91E01360106F35C_MULTIPART_MIXED_
Content-Type: application/octet-stream; name="for-2.5-20020829.diff"
Content-Disposition: attachment;
 filename="for-2.5-20020829.diff"
Content-Transfer-Encoding: base64

SW5kZXg6IGFjcGktMi41L2RyaXZlcnMvYWNwaS9hYy5jCmRpZmYgLXUgYWNwaS0yLjUvZHJpdmVy
cy9hY3BpL2FjLmM6MS4xLjEuMSBhY3BpLTIuNS9kcml2ZXJzL2FjcGkvYWMuYzoxLjEuMS4xLjQu
MQotLS0gYWNwaS0yLjUvZHJpdmVycy9hY3BpL2FjLmM6MS4xLjEuMQlXZWQgQXVnIDI4IDAwOjEz
OjI3IDIwMDIKKysrIGFjcGktMi41L2RyaXZlcnMvYWNwaS9hYy5jCVRodSBBdWcgMjkgMTg6MDE6
MjMgMjAwMgpAQCAtNTEsNyArNTEsNyBAQAogCS5jbGFzcyA9CUFDUElfQUNfQ0xBU1MsCiAJLmlk
cyA9CQlBQ1BJX0FDX0hJRCwKIAkub3BzID0JCXsKLQkJCQkuYWRkID0JYWNwaV9hY19hZGQsCisJ
CQkJLmFkZCA9CQlhY3BpX2FjX2FkZCwKIAkJCQkucmVtb3ZlID0JYWNwaV9hY19yZW1vdmUsCiAJ
CQl9LAogfTsKSW5kZXg6IGFjcGktMi41L2RyaXZlcnMvYWNwaS9hY3BpX2tzeW1zLmMKZGlmZiAt
dSBhY3BpLTIuNS9kcml2ZXJzL2FjcGkvYWNwaV9rc3ltcy5jOjEuMS4xLjEgYWNwaS0yLjUvZHJp
dmVycy9hY3BpL2FjcGlfa3N5bXMuYzoxLjEuMS4xLjQuMQotLS0gYWNwaS0yLjUvZHJpdmVycy9h
Y3BpL2FjcGlfa3N5bXMuYzoxLjEuMS4xCVdlZCBBdWcgMjggMDA6MTM6MjcgMjAwMgorKysgYWNw
aS0yLjUvZHJpdmVycy9hY3BpL2FjcGlfa3N5bXMuYwlUaHUgQXVnIDI5IDE4OjAxOjIzIDIwMDIK
QEAgLTExNCw2ICsxMTQsNyBAQAogI2lmZGVmIENPTkZJR19BQ1BJX0JVUwogCiBFWFBPUlRfU1lN
Qk9MKGFjcGlfZmFkdCk7CitFWFBPUlRfU1lNQk9MKGFjcGlfd2Fsa19uYW1lc3BhY2UpOwogRVhQ
T1JUX1NZTUJPTChhY3BpX3Jvb3RfZGlyKTsKIEVYUE9SVF9TWU1CT0woYWNwaV9idXNfZ2V0X2Rl
dmljZSk7CiBFWFBPUlRfU1lNQk9MKGFjcGlfYnVzX2dldF9zdGF0dXMpOwpAQCAtMTI3LDQgKzEy
OCwzIEBACiBFWFBPUlRfU1lNQk9MKGFjcGlfaW5pdCk7CiAKICNlbmRpZiAvKkNPTkZJR19BQ1BJ
X0JVUyovCi0KSW5kZXg6IGFjcGktMi41L2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmMKZGlmZiAtdSBh
Y3BpLTIuNS9kcml2ZXJzL2FjcGkvYmF0dGVyeS5jOjEuMS4xLjEgYWNwaS0yLjUvZHJpdmVycy9h
Y3BpL2JhdHRlcnkuYzoxLjEuMS4xLjQuMQotLS0gYWNwaS0yLjUvZHJpdmVycy9hY3BpL2JhdHRl
cnkuYzoxLjEuMS4xCVdlZCBBdWcgMjggMDA6MTM6MjcgMjAwMgorKysgYWNwaS0yLjUvZHJpdmVy
cy9hY3BpL2JhdHRlcnkuYwlUaHUgQXVnIDI5IDE4OjAxOjIzIDIwMDIKQEAgLTE2Miw3ICsxNjIs
NyBAQAogCX0KIAogZW5kOgotCWtmcmVlKGJ1ZmZlci5wb2ludGVyKTsKKwlhY3BpX29zX2ZyZWUo
YnVmZmVyLnBvaW50ZXIpOwogCiAJaWYgKCFyZXN1bHQpCiAJCSgqYmlmKSA9IChzdHJ1Y3QgYWNw
aV9iYXR0ZXJ5X2luZm8gKikgZGF0YS5wb2ludGVyOwpAQCAtMjIzLDcgKzIyMyw3IEBACiAJfQog
CiBlbmQ6Ci0Ja2ZyZWUoYnVmZmVyLnBvaW50ZXIpOworCWFjcGlfb3NfZnJlZShidWZmZXIucG9p
bnRlcik7CiAKIAlpZiAoIXJlc3VsdCkKIAkJKCpic3QpID0gKHN0cnVjdCBhY3BpX2JhdHRlcnlf
c3RhdHVzICopIGRhdGEucG9pbnRlcjsKSW5kZXg6IGFjcGktMi41L2RyaXZlcnMvYWNwaS9idXR0
b24uYwpkaWZmIC11IGFjcGktMi41L2RyaXZlcnMvYWNwaS9idXR0b24uYzoxLjEuMS4xIGFjcGkt
Mi41L2RyaXZlcnMvYWNwaS9idXR0b24uYzoxLjEuMS4xLjQuMQotLS0gYWNwaS0yLjUvZHJpdmVy
cy9hY3BpL2J1dHRvbi5jOjEuMS4xLjEJV2VkIEF1ZyAyOCAwMDoxMzoyNyAyMDAyCisrKyBhY3Bp
LTIuNS9kcml2ZXJzL2FjcGkvYnV0dG9uLmMJVGh1IEF1ZyAyOSAxODowMToyMyAyMDAyCkBAIC03
MCw3ICs3MCw2IEBACiAKIHN0YXRpYyBzdHJ1Y3QgcHJvY19kaXJfZW50cnkJKmFjcGlfYnV0dG9u
X2RpciA9IE5VTEw7CiAKLQogc3RhdGljIGludAogYWNwaV9idXR0b25fcmVhZF9pbmZvICgKIAlj
aGFyCQkJKnBhZ2UsCkluZGV4OiBhY3BpLTIuNS9kcml2ZXJzL2FjcGkvcGNpX2lycS5jCmRpZmYg
LXUgYWNwaS0yLjUvZHJpdmVycy9hY3BpL3BjaV9pcnEuYzoxLjEuMS4xIGFjcGktMi41L2RyaXZl
cnMvYWNwaS9wY2lfaXJxLmM6MS4xLjEuMS40LjEKLS0tIGFjcGktMi41L2RyaXZlcnMvYWNwaS9w
Y2lfaXJxLmM6MS4xLjEuMQlXZWQgQXVnIDI4IDAwOjEzOjI3IDIwMDIKKysrIGFjcGktMi41L2Ry
aXZlcnMvYWNwaS9wY2lfaXJxLmMJVGh1IEF1ZyAyOSAxODowMToyMyAyMDAyCkBAIC0yODgsNyAr
Mjg4LDcgQEAKIAl3aGlsZSAoIWlycSAmJiAoYnJpZGdlID0gYnJpZGdlLT5idXMtPnNlbGYpKSB7
CiAJCXBpbiA9IChwaW4gKyBQQ0lfU0xPVChicmlkZ2UtPmRldmZuKSkgJSA0OwogCQlpcnEgPSBh
Y3BpX3BjaV9pcnFfbG9va3VwKDAsIGJyaWRnZS0+YnVzLT5udW1iZXIsIFBDSV9TTE9UKGJyaWRn
ZS0+ZGV2Zm4pLCBwaW4pOwotCX07CisJfQogCiAJaWYgKCFpcnEpIHsKIAkJQUNQSV9ERUJVR19Q
UklOVCgoQUNQSV9EQl9XQVJOLCAiVW5hYmxlIHRvIGRlcml2ZSBJUlEgZm9yIGRldmljZSAlc1xu
IiwgZGV2LT5zbG90X25hbWUpKTsKSW5kZXg6IGFjcGktMi41L2RyaXZlcnMvYWNwaS9wY2lfbGlu
ay5jCmRpZmYgLXUgYWNwaS0yLjUvZHJpdmVycy9hY3BpL3BjaV9saW5rLmM6MS4xLjEuMSBhY3Bp
LTIuNS9kcml2ZXJzL2FjcGkvcGNpX2xpbmsuYzoxLjEuMS4xLjQuMQotLS0gYWNwaS0yLjUvZHJp
dmVycy9hY3BpL3BjaV9saW5rLmM6MS4xLjEuMQlXZWQgQXVnIDI4IDAwOjEzOjI3IDIwMDIKKysr
IGFjcGktMi41L2RyaXZlcnMvYWNwaS9wY2lfbGluay5jCVRodSBBdWcgMjkgMTg6MDE6MjMgMjAw
MgpAQCAtNTQsMTIgKzU0LDEyIEBACiBzdGF0aWMgaW50IGFjcGlfcGNpX2xpbmtfcmVtb3ZlIChz
dHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHR5cGUpOwogCiBzdGF0aWMgc3RydWN0IGFj
cGlfZHJpdmVyIGFjcGlfcGNpX2xpbmtfZHJpdmVyID0gewotICAgICAgICAubmFtZSA9CQlBQ1BJ
X1BDSV9MSU5LX0RSSVZFUl9OQU1FLAotICAgICAgICAuY2xhc3MgPQlBQ1BJX1BDSV9MSU5LX0NM
QVNTLAotICAgICAgICAuaWRzID0JCUFDUElfUENJX0xJTktfSElELAotICAgICAgICAub3BzID0J
CXsKLQkJCQkuYWRkID0JCWFjcGlfcGNpX2xpbmtfYWRkLAotCQkJCS5yZW1vdmUgPQlhY3BpX3Bj
aV9saW5rX3JlbW92ZSwKKwkubmFtZSA9CQlBQ1BJX1BDSV9MSU5LX0RSSVZFUl9OQU1FLAorCS5j
bGFzcyA9CUFDUElfUENJX0xJTktfQ0xBU1MsCisJLmlkcyA9CQlBQ1BJX1BDSV9MSU5LX0hJRCwK
Kwkub3BzID0JCXsKKwkJCQkuYWRkID0gICAgYWNwaV9wY2lfbGlua19hZGQsCisJCQkJLnJlbW92
ZSA9IGFjcGlfcGNpX2xpbmtfcmVtb3ZlLAogCQkJfSwKIH07CiAKSW5kZXg6IGFjcGktMi41L2Ry
aXZlcnMvYWNwaS9wY2lfcm9vdC5jCmRpZmYgLXUgYWNwaS0yLjUvZHJpdmVycy9hY3BpL3BjaV9y
b290LmM6MS4xLjEuMSBhY3BpLTIuNS9kcml2ZXJzL2FjcGkvcGNpX3Jvb3QuYzoxLjEuMS4xLjQu
MQotLS0gYWNwaS0yLjUvZHJpdmVycy9hY3BpL3BjaV9yb290LmM6MS4xLjEuMQlXZWQgQXVnIDI4
IDAwOjEzOjI3IDIwMDIKKysrIGFjcGktMi41L2RyaXZlcnMvYWNwaS9wY2lfcm9vdC5jCVRodSBB
dWcgMjkgMTg6MDE6MjMgMjAwMgpAQCAtNTEsOCArNTEsOCBAQAogCS5jbGFzcyA9CUFDUElfUENJ
X1JPT1RfQ0xBU1MsCiAJLmlkcyA9CQlBQ1BJX1BDSV9ST09UX0hJRCwKIAkub3BzID0JCXsKLQkJ
CQkuYWRkID0JCWFjcGlfcGNpX3Jvb3RfYWRkLAotCQkJCS5yZW1vdmUgPQlhY3BpX3BjaV9yb290
X3JlbW92ZSwKKwkJCQkuYWRkID0gICAgYWNwaV9wY2lfcm9vdF9hZGQsCisJCQkJLnJlbW92ZSA9
IGFjcGlfcGNpX3Jvb3RfcmVtb3ZlLAogCQkJfSwKIH07CiAKSW5kZXg6IGFjcGktMi41L2RyaXZl
cnMvYWNwaS9zeXN0ZW0uYwpkaWZmIC11IGFjcGktMi41L2RyaXZlcnMvYWNwaS9zeXN0ZW0uYzox
LjEuMS4yIGFjcGktMi41L2RyaXZlcnMvYWNwaS9zeXN0ZW0uYzoxLjEuMS4yLjIuMQotLS0gYWNw
aS0yLjUvZHJpdmVycy9hY3BpL3N5c3RlbS5jOjEuMS4xLjIJVGh1IEF1ZyAyOSAxNjozMDoxNCAy
MDAyCisrKyBhY3BpLTIuNS9kcml2ZXJzL2FjcGkvc3lzdGVtLmMJVGh1IEF1ZyAyOSAxODowMToy
MyAyMDAyCkBAIC0yMyw4ICsyMyw2IEBACiAgKiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogICovCiAKLSNk
ZWZpbmUgQUNQSV9DCi0KICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KICNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KSW5kZXg6IGFjcGktMi41L2lu
Y2x1ZGUvbGludXgvYWNwaS5oCmRpZmYgLXUgYWNwaS0yLjUvaW5jbHVkZS9saW51eC9hY3BpLmg6
MS4xLjEuMiBhY3BpLTIuNS9pbmNsdWRlL2xpbnV4L2FjcGkuaDoxLjEuMS4yLjIuMQotLS0gYWNw
aS0yLjUvaW5jbHVkZS9saW51eC9hY3BpLmg6MS4xLjEuMglUaHUgQXVnIDI5IDE2OjMyOjMwIDIw
MDIKKysrIGFjcGktMi41L2luY2x1ZGUvbGludXgvYWNwaS5oCVRodSBBdWcgMjkgMTg6MDE6MjMg
MjAwMgpAQCAtMzU0LDExICszNTQsMTEgQEAKIAogZXh0ZXJuIGludCBhY3BpX21wX2NvbmZpZzsK
IAotI2Vsc2UgLyohQ09ORklHX0FDUElfQk9PVCovCisjZWxzZQogCiAjZGVmaW5lIGFjcGlfbXBf
Y29uZmlnCTAKIAotI2VuZGlmIC8qQ09ORklHX0FDUElfQk9PVCovCisjZW5kaWYKIAogCiAjaWZk
ZWYgQ09ORklHX0FDUElfUENJCg==

--------_3D6EC91E01360106F35C_MULTIPART_MIXED_--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
