From: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>
Subject: S3 Resume - System Timer Tick fix
Date: Tue, 15 Oct 2002 17:17:37 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1DD88DDBBB83D6119C8C00096BB0408FEC5449@USAMCMS5>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-return: allowed
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


 I found that upon S3 resume the System Clock Tick wasn't being re-enabled,
thus a lot of things didn't work correctly afterwards :) I have attached a
patch against 2.5.42 which seems to fix the clock. 

 Details:  I added a new routine in arch/i386/kernel/acpi.c called
acpi_restore_sys_timer(), which is code borrowed from apm.c reinit_timer().
The driver/acpi/sleep.c acpi_system_restore_state() routine was modified to
call the acpi_restore_sys_timer() function.  This works properly on an a PC
motherboard with an Intel 810 chipset.

 Also, in driver/acpi/sleep.c acpi_system_save_state() I added a call to
pm_send_all(PM_SUSPEND) to inform any driver registered with pm_register()
that an S3 suspend event is happening.  Then I added a call to
pm_send_all(PM_RESUME) in acpi_system_restore_state() to get devices to
restore themselves.

 Please take a look at the patch and let me know if you have any questions,

   Mike Faraoni



-------------------------


diff -urN -X dontdiff linux-2.5.42/arch/i386/kernel/acpi.c
linux-2.5.42_update/arch/i386/kernel/acpi.c
--- linux-2.5.42/arch/i386/kernel/acpi.c	Sat Oct 12 00:22:18 2002
+++ linux-2.5.42_update/arch/i386/kernel/acpi.c	Mon Oct 14 14:19:29 2002
@@ -559,4 +559,23 @@
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n",
acpi_wakeup_address);
 }
 
+/**
+ * acpi_restore_sys_timer - 
+ *
+ *  After resume from sleep S2 or S3, resume the System Timer interrupt.
+ *  Should be called before enabling interrupts
+ *
+ *  Code borrowed from apm.c - reinit_timer()
+ */
+void acpi_restore_sys_timer(void)
+{
+	/* set the clock to 100 Hz */
+	outb_p(0x34,0x43);              /* binary, mode 2, LSB/MSB, ch 0 */
+	udelay(10);
+	outb_p(LATCH & 0xff , 0x40);    /* LSB */
+	udelay(10);
+	outb(LATCH >> 8 , 0x40);        /* MSB */
+	udelay(10);
+}
+
 #endif /*CONFIG_ACPI_SLEEP*/
diff -urN -X dontdiff linux-2.5.42/drivers/acpi/sleep.c
linux-2.5.42_update/drivers/acpi/sleep.c
--- linux-2.5.42/drivers/acpi/sleep.c	Sat Oct 12 00:21:03 2002
+++ linux-2.5.42_update/drivers/acpi/sleep.c	Mon Oct 14 14:21:23 2002
@@ -68,12 +68,18 @@
 	/* turn all the devices back on */
 	device_resume(RESUME_POWER_ON);
 
+	/* enable the system timer interrupt */
+	acpi_restore_sys_timer();
+
 	/* enable interrupts once again */
 	ACPI_ENABLE_IRQS();
 
 	/* restore device context */
 	device_resume(RESUME_RESTORE_STATE);
 
+	/* resume drivers registered with PM subsystem */
+	pm_send_all(PM_RESUME, (void *) 0);
+        
 	if (dmi_broken & BROKEN_INIT_AFTER_S1) {
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
@@ -124,6 +130,17 @@
 			return error;
 		}
 
+		/* inform drivers registered with PM subsystem 
+		 * to SUSPEND */
+		error = pm_send_all(PM_SUSPEND, (void*)3);
+		if (error) {
+			/* tell devices to restore state if they have
+			 * it saved and to start taking I/O requests.
+			 */
+			device_resume(RESUME_RESTORE_STATE);
+			return error;
+		}
+			
 		/* flush caches */
 		ACPI_FLUSH_CPU_CACHE();
 
@@ -136,6 +153,7 @@
 
 			if (error) {
 				device_resume(RESUME_RESTORE_STATE);
+				pm_send_all(PM_RESUME, (void *) 0);
 				return error;
 			}
 		}
diff -urN -X dontdiff linux-2.5.42/include/linux/acpi.h
linux-2.5.42_update/include/linux/acpi.h
--- linux-2.5.42/include/linux/acpi.h	Sat Oct 12 00:21:02 2002
+++ linux-2.5.42_update/include/linux/acpi.h	Mon Oct 14 14:20:13 2002
@@ -382,6 +382,7 @@
 void acpi_numa_processor_affinity_init (struct
acpi_table_processor_affinity *pa);
 void acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity
*ma);
 void acpi_numa_arch_fixup(void);
+void acpi_restore_sys_timer(void);
 
 extern int acpi_mp_config;
 


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?http://www.viaverio.com/
consolidator/osdn.cfm
