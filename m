From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Sleep fixes
Date: Tue, 11 Feb 2003 19:50:21 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030211185021.GA25067@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This fixes error conditions in sleep, and makes acpi ask for
suspend_disable. Please apply,
								Pavel



--- clean/arch/i386/kernel/acpi.c	2003-02-11 17:40:33.000000000 +0100
+++ linux/arch/i386/kernel/acpi.c	2003-02-11 17:43:30.000000000 +0100
@@ -480,6 +480,8 @@
 	panic("S3 and PAE do not like each other for now.");
 	return 1;
 #endif
+	if (!acpi_wakeup_address)
+		return 1;
 	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
 	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
@@ -507,17 +509,18 @@
 /**
  * acpi_reserve_bootmem - do _very_ early ACPI initialisation
  *
- * We allocate a page in low memory for the wakeup
+ * We allocate a page from the first 1MB of memory for the wakeup
  * routine for when we come back from a sleep state. The
- * runtime allocator allows specification of <16M pages, but not
- * <1M pages.
+ * runtime allocator allows specification of <16MB pages, but not
+ * <1MB pages.
  */
 void __init acpi_reserve_bootmem(void)
 {
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
+	if (!acpi_wakeup_address)
+		printk(KERN_ERR "ACPI: Cannot allocate lowmem. S3 disabled.\n");
 	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
 		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
-	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
 
 static int __init acpi_sleep_setup(char *str)
--- clean/drivers/acpi/sleep.c	2003-01-05 22:58:25.000000000 +0100
+++ linux/drivers/acpi/sleep.c	2003-02-10 18:17:00.000000000 +0100
@@ -143,6 +143,10 @@
 			return error;
 		}
 
+		error = device_suspend(state, SUSPEND_DISABLE);
+		if (error)
+			panic("Sorry, devices really should know how to disable\n");
+
 		/* flush caches */
 		ACPI_FLUSH_CPU_CACHE();
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
