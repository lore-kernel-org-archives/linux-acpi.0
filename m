From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] S4Bios support for 2.4.20 + acpi-20021205
Date: Fri, 13 Dec 2002 16:53:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213155309.GG4327@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch for 2.4.20 and acpi-20021205 for adding s4bios feature.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s4bios-2.4.20-acpi-20021205.diff"

 arch/i386/kernel/acpi.c         |   17 ++
 drivers/acpi/hardware/hwsleep.c |   52 ++++++++
 drivers/acpi/system.c           |  235 ++++++++++++++++++++++++++++++++++++++--
 include/asm-i386/acpi.h         |   24 +++-
 include/asm-i386/save_state.h   |  219 +++++++++++++++++++++++++++++++++++++
 5 files changed, 537 insertions(+), 10 deletions(-)



--- linux-2.4.20/include/asm-i386/acpi.h	2002/12/11 15:15:42	1.1
+++ linux-2.4.20/include/asm-i386/acpi.h	2002/12/11 19:50:08
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *  Copyright (C) 2001 Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
-  *
+ *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -128,12 +128,34 @@
 
 #ifdef CONFIG_ACPI_SLEEP
 
+extern unsigned long saved_eip;
+extern unsigned long saved_esp;
+extern unsigned long saved_ebp;
+extern unsigned long saved_ebx;
+extern unsigned long saved_esi;
+extern unsigned long saved_edi;
+
+static inline void acpi_save_register_state(unsigned long return_point)
+{
+	saved_eip = return_point;
+	asm volatile ("movl %%esp,(%0)" : "=m" (saved_esp));
+	asm volatile ("movl %%ebp,(%0)" : "=m" (saved_ebp));
+	asm volatile ("movl %%ebx,(%0)" : "=m" (saved_ebx));
+	asm volatile ("movl %%edi,(%0)" : "=m" (saved_edi));
+	asm volatile ("movl %%esi,(%0)" : "=m" (saved_esi));
+}
+
+#define acpi_restore_register_state()   do {} while (0)
+
+
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
 extern int acpi_save_state_disk(void);
 extern void acpi_restore_state_mem(void);
 
 extern unsigned long acpi_wakeup_address;
+
+extern void do_suspend_lowlevel_s4bios(int resume);
 
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
--- /dev/null	Thu Jan  1 01:00:00 1970
+++ linux-2.4.20/include/asm-i386/save_state.h	Wed Dec 11 20:59:39 2002
@@ -0,0 +1,219 @@
+#ifndef __ASM_I386_SAVE_STATE_H
+#define __ASM_I386_SAVE_STATE_H
+
+/*
+ * Copyright 2001-2002 Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
+ * Based on code
+ * Copyright 2001 Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
+ */
+#include <asm/desc.h>
+#include <asm/i387.h>
+
+/* image of the saved processor state */
+struct saved_context {
+	u32 eax, ebx, ecx, edx;
+	u32 esp, ebp, esi, edi;
+	u16 es, fs, gs, ss;
+	u32 cr0, cr2, cr3, cr4;
+	u16 gdt_pad;
+	u16 gdt_limit;
+	u32 gdt_base;
+	u16 idt_pad;
+	u16 idt_limit;
+	u32 idt_base;
+	u16 ldt;
+	u16 tss;
+	u32 tr;
+	u32 safety;
+	u32 return_address;
+	u32 eflags;
+} __attribute__((packed));
+
+static struct saved_context saved_context;
+
+#define loaddebug(thread,register) \
+               __asm__("movl %0,%%db" #register  \
+                       : /* no output */ \
+                       :"r" ((thread)->debugreg[register]))
+
+
+/*
+ * save_processor_context
+ * 
+ * Save the state of the processor before we go to sleep.
+ *
+ * return_stack is the value of the stack pointer (%esp) as the caller sees it.
+ * A good way could not be found to obtain it from here (don't want to make _too_
+ * many assumptions about the layout of the stack this far down.) Also, the 
+ * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
+ * buggy - it returns the value of the stack at the proper location, not the 
+ * location, like it should (as of gcc 2.91.66)
+ * 
+ * Note that the context and timing of this function is pretty critical.
+ * With a minimal amount of things going on in the caller and in here, gcc
+ * does a good job of being just a dumb compiler.  Watch the assembly output
+ * if anything changes, though, and make sure everything is going in the right
+ * place. 
+ */
+static inline void save_processor_context (void)
+{
+	/*
+	 * descriptor tables
+	 */
+	asm volatile ("sgdt (%0)" : "=m" (saved_context.gdt_limit));
+	asm volatile ("sidt (%0)" : "=m" (saved_context.idt_limit));
+	asm volatile ("sldt (%0)" : "=m" (saved_context.ldt));
+	asm volatile ("str (%0)"  : "=m" (saved_context.tr));
+
+	/*
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%esp, (%0)" : "=m" (saved_context.esp));
+	asm volatile ("movl %%eax, (%0)" : "=m" (saved_context.eax));
+	asm volatile ("movl %%ebx, (%0)" : "=m" (saved_context.ebx));
+	asm volatile ("movl %%ecx, (%0)" : "=m" (saved_context.ecx));
+	asm volatile ("movl %%edx, (%0)" : "=m" (saved_context.edx));
+	asm volatile ("movl %%ebp, (%0)" : "=m" (saved_context.ebp));
+	asm volatile ("movl %%esi, (%0)" : "=m" (saved_context.esi));
+	asm volatile ("movl %%edi, (%0)" : "=m" (saved_context.edi));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %%es, %0" : "=r" (saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=r" (saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=r" (saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=r" (saved_context.ss));
+
+	/*
+	 * control registers 
+	 */
+	asm volatile ("movl %%cr0, %0" : "=r" (saved_context.cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl (%0)" : "=m" (saved_context.eflags));
+}
+
+static void fix_processor_context(void)
+{
+	int nr = smp_processor_id();
+	struct tss_struct * t = &init_tss[nr];
+
+	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+        gdt_table[__TSS(nr)].b &= 0xfffffdff;
+
+	load_TR(nr);		/* This does ltr */
+
+	load_LDT(&current->mm->context);	/* This does lldt */
+
+	/*
+	 * Now maybe reload the debug registers
+	 */
+	if (current->thread.debugreg[7]){
+                loaddebug(&current->thread, 0);
+                loaddebug(&current->thread, 1);
+                loaddebug(&current->thread, 2);
+                loaddebug(&current->thread, 3);
+                /* no 4 and 5 */
+                loaddebug(&current->thread, 6);
+                loaddebug(&current->thread, 7);
+	}
+
+}
+
+static void
+do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+        kernel_fpu_end();
+}
+
+/*
+ * restore_processor_context
+ * 
+ * Restore the processor context as it was before we went to sleep
+ * - descriptor tables
+ * - control registers
+ * - segment registers
+ * - flags
+ * 
+ * Note that it is critical that this function is declared inline.  
+ * It was separated out from restore_state to make that function
+ * a little clearer, but it needs to be inlined because we won't have a
+ * stack when we get here (so we can't push a return address).
+ */
+static inline void restore_processor_context (void)
+{
+	/*
+	 * first restore %ds, so we can access our data properly
+	 */
+	asm volatile (".align 4");
+	asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
+
+
+	/*
+	 * control registers
+	 */
+	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
+	
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
+	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
+	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
+	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
+
+	/*
+	 * the other general registers
+	 *
+	 * note that even though gcc has constructs to specify memory 
+	 * input into certain registers, it will try to be too smart
+	 * and save them at the beginning of the function.  This is esp.
+	 * bad since we don't have a stack set up when we enter, and we 
+	 * want to preserve the values on exit. So, we set them manually.
+	 */
+	asm volatile ("movl %0, %%esp" :: "m" (saved_context.esp));
+	asm volatile ("movl %0, %%ebp" :: "m" (saved_context.ebp));
+	asm volatile ("movl %0, %%eax" :: "m" (saved_context.eax));
+	asm volatile ("movl %0, %%ebx" :: "m" (saved_context.ebx));
+	asm volatile ("movl %0, %%ecx" :: "m" (saved_context.ecx));
+	asm volatile ("movl %0, %%edx" :: "m" (saved_context.edx));
+	asm volatile ("movl %0, %%esi" :: "m" (saved_context.esi));
+	asm volatile ("movl %0, %%edi" :: "m" (saved_context.edi));
+
+	/*
+	 * now restore the descriptor tables to their proper values
+	 */
+	asm volatile ("lgdt (%0)" :: "m" (saved_context.gdt_limit));
+	asm volatile ("lidt (%0)" :: "m" (saved_context.idt_limit));
+	asm volatile ("lldt (%0)" :: "m" (saved_context.ldt));
+
+#if 0
+	asm volatile ("ltr (%0)"  :: "m" (saved_context.tr));
+#endif
+
+	fix_processor_context();
+
+	/*
+	 * the flags
+	 */
+	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
+}
+
+#endif 
+
--- linux-2.4.20/drivers/acpi/hardware/hwsleep.c	2002/12/11 13:47:03	1.1
+++ linux-2.4.20/drivers/acpi/hardware/hwsleep.c	2002/12/11 19:48:55
@@ -319,6 +319,53 @@
 
 /******************************************************************************
  *
+ * FUNCTION:    Acpi_enter_sleep_state_s4bios
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Perform a s4 bios request.
+ *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_enter_sleep_state_s4bios (
+	void)
+{
+	u32                     in_value;
+	acpi_status             status;
+
+
+	ACPI_FUNCTION_TRACE ("Acpi_enter_sleep_state_s4bios");
+
+
+	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
+	acpi_hw_clear_acpi_status();
+
+	acpi_hw_disable_non_wakeup_gpes();
+
+	ACPI_FLUSH_CPU_CACHE();
+
+	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
+
+	do {
+		acpi_os_stall(1000);
+		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
+		if (ACPI_FAILURE (status)) {
+			return_ACPI_STATUS (status);
+		}
+	} while (!in_value);
+
+	printk(KERN_DEBUG "acpi: s4bios coming to live\n");
+
+	return_ACPI_STATUS (AE_OK);
+}
+
+
+/******************************************************************************
+ *
  * FUNCTION:    Acpi_leave_sleep_state
  *
  * PARAMETERS:  Sleep_state         - Which sleep state we just exited
@@ -340,6 +387,8 @@
 
 	ACPI_FUNCTION_TRACE ("Acpi_leave_sleep_state");
 
+	/* Be sure to have BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	/* Ensure Enter_sleep_state_prep -> Enter_sleep_state ordering */
 
@@ -371,9 +420,6 @@
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
-
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	return_ACPI_STATUS (status);
 }
--- linux-2.4.20/drivers/acpi/system.c	2002/12/11 13:55:11	1.1
+++ linux-2.4.20/drivers/acpi/system.c	2002/12/11 19:54:51
@@ -35,6 +35,7 @@
 #include <linux/pm.h>
 #include <linux/compatmac.h>
 #include <linux/proc_fs.h>
+#include <linux/pm.h>
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
 #include "acpi_bus.h"
@@ -99,6 +100,189 @@
 #ifdef CONFIG_ACPI_SLEEP
 
 /**
+ * acpi_system_restore_state - OS-specific restoration of state
+ * @state:	sleep state we're exiting
+ *
+ * Note that if we're coming back from S4, the memory image should have
+ * already been loaded from the disk and is already in place.  (Otherwise how
+ * else would we be here?).
+ */
+acpi_status
+acpi_system_restore_state(
+	u32			state)
+{
+	/* 
+	 * We should only be here if we're coming back from STR or STD.
+	 * And, in the case of the latter, the memory image should have already
+	 * been loaded from disk.
+	 */
+	if (state > ACPI_STATE_S1) {
+		acpi_restore_state_mem();
+
+		/* wait for power to come back */
+		mdelay(1000);
+
+		/* turn all the devices back on */
+		pm_send_all(PM_RESUME, (void *)0);
+
+		/* Be really sure that irqs are disabled. */
+		ACPI_DISABLE_IRQS();
+
+		/* Wait a little again, just in case... */
+		mdelay(1000);
+
+		/* enable interrupts once again */
+		ACPI_ENABLE_IRQS();
+
+	}
+
+	return AE_OK;
+}
+
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
+ * Only then it is safe for us to power down devices, since we may need
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
+	if (state > ACPI_STATE_S1) {
+		error = pm_send_all(PM_SAVE_STATE, (void *)3);
+		if (error)
+			return AE_ERROR;
+	}
+
+	if (state < ACPI_STATE_S5) {
+		/* Tell devices to stop I/O and actually save their state.
+		 * It is theoretically possible that something could fail,
+		 * so handle that gracefully..
+		 */
+		if (state > ACPI_STATE_S1) {
+			error = pm_send_all(PM_SUSPEND, (void *)3);
+			if (error) {
+				/* Tell devices to restore state if they have
+				 * it saved and to start taking I/O requests.
+				 */
+				pm_send_all(PM_RESUME, (void *)0);
+				return error;
+			}
+		}
+		
+		/* flush caches */
+		ACPI_FLUSH_CPU_CACHE();
+
+		/* Do arch specific saving of state. */
+		if (state > ACPI_STATE_S1) {
+			error = acpi_save_state_mem();
+
+			/* TBD: if no s4bios, write codes for
+			 * acpi_save_state_disk()...
+			 */
+#if 0
+			if (!error && (state == ACPI_STATE_S4))
+				error = acpi_save_state_disk();
+#endif
+			if (error) {
+				pm_send_all(PM_RESUME, (void *)0);
+				return error;
+			}
+		}
+	}
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
+
+	if (state > ACPI_STATE_S1) {
+		error = pm_send_all(PM_SUSPEND, (void *)3);
+
+		/* We're pretty screwed if we got an error from this.
+		 * We try to recover by simply calling our own restore_state
+		 * function; see above for definition.
+		 *
+		 * If it's S5 though, go through with it anyway..
+		 */
+		if (error && state != ACPI_STATE_S5)
+			acpi_system_restore_state(state);
+	}
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
+	u32		state)
+{
+	acpi_status		status = AE_ERROR;
+	unsigned long		flags = 0;
+
+	local_irq_save(flags);
+	/* kernel_fpu_begin(); */
+
+	switch (state) {
+	case ACPI_STATE_S1:
+		barrier();
+		status = acpi_enter_sleep_state(state);
+		break;
+	case ACPI_STATE_S4:
+		do_suspend_lowlevel_s4bios(0);
+		break;
+	}
+
+	/* kernel_fpu_end(); */
+	local_irq_restore(flags);
+
+	return status;
+}
+
+
+
+/**
  * acpi_suspend - OS-agnostic system suspend/resume support (S? states)
  * @state:	state we're entering
  *
@@ -110,27 +294,45 @@
 	acpi_status status;
 
 	/* only support S1 and S5 on kernel 2.4 */
-	if (state != ACPI_STATE_S1 && state != ACPI_STATE_S5)
+	printk(KERN_DEBUG "acpi: acpi_suspend call %d\n", state);
+	if (state != ACPI_STATE_S1 && state != ACPI_STATE_S4
+	    && state != ACPI_STATE_S5)
 		return AE_ERROR;
 
+
+	/* For s4bios, we need a wakeup address. */
+	if (state == ACPI_STATE_S4) {
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
+
 	return status;
 }
 
@@ -465,8 +667,12 @@
 		goto end;
 
 	for (i = 0; i <= ACPI_STATE_S5; i++) {
-		if (system->states[i])
+		if (system->states[i]) {
 			p += sprintf(p,"S%d ", i);
+			if (i == ACPI_STATE_S4 && acpi_gbl_FACS->S4bios_f &&
+			    acpi_gbl_FADT->smi_cmd != 0)
+				p += sprintf(p, "S4bios ");
+		}
 	}
 
 	p += sprintf(p, "\n");
@@ -507,9 +713,17 @@
 	
 	state = simple_strtoul(state_string, NULL, 0);
 	
+	printk(KERN_DEBUG "acpi: sleep %d\n", state);
 	if (!system->states[state])
 		return_VALUE(-ENODEV);
+	printk(KERN_DEBUG "acpi: GO!\n", state);
 	
+	/*
+	 * If S4 is supported by the OS, then we should assume that
+	 * echo 4b > /proc/acpi/sleep is for s4bios.
+	 * Since we have only s4bios, we assume that acpi_suspend failed
+	 * if no s4bios support.
+	 */
 	status = acpi_suspend(state);
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);
@@ -1007,9 +1221,18 @@
 	for (i=0; i<ACPI_S_STATE_COUNT; i++) {
 		u8 type_a, type_b;
 		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
-		if (ACPI_SUCCESS(status)) {
-			system->states[i] = 1;
-			printk(" S%d", i);
+		switch (i) {
+		case ACPI_STATE_S4:
+			if (acpi_gbl_FACS->S4bios_f && 0 != acpi_gbl_FADT->smi_cmd) {
+				printk(" S4bios");
+				system->states[i] = 1;
+			}
+			/* no break */
+		default: 
+			if (ACPI_SUCCESS(status)) {
+				system->states[i] = 1;
+				printk(" S%d", i);
+			}
 		}
 	}
 	printk(")\n");
--- linux-2.4.20/arch/i386/kernel/acpi.c	2002/12/11 22:01:51	1.1
+++ linux-2.4.20/arch/i386/kernel/acpi.c	2002/12/11 21:02:33
@@ -42,6 +42,8 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
+#include <asm/acpi.h>
+#include <asm/save_state.h>
 
 
 #define PREFIX			"ACPI: "
@@ -559,6 +561,21 @@
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
+
+void do_suspend_lowlevel_s4bios(int resume)
+{
+	if (!resume) {
+		printk("Saving CPU context...\n");
+		save_processor_context();
+		acpi_save_register_state((unsigned long)&&acpi_sleep_done);
+		acpi_enter_sleep_state_s4bios();
+		return;
+	}
+acpi_sleep_done:
+	restore_processor_context();
+	printk("CPU context restored...\n");
+}
+
 
 #endif /*CONFIG_ACPI_SLEEP*/
 

--VS++wcV0S1rZb1Fb--


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
