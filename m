From: ole.rohne-vJEk5272eHo@public.gmane.org
Subject: Radeon S3/resume: VGA ROM POST from kernel
Date: 19 Jul 2004 11:31:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yzoy8lggx6v.fsf_-_@localhost.localdomain>
References: <e1c05edd04070109394afd3332@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <e1c05edd04070109394afd3332-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: aman-e31a5gnSYeGubukWoKzokaxOck334EZe@public.gmane.org, stefandoesinger-RbZlAiThDcE@public.gmane.org, emmanuel.thome-/zGXu1G9BXs@public.gmane.org, software-v2/BnvaKusE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

I've implemented VGA POSTing using a real-mode tunnel from kernel
space. IMO, this has some advantages over user space methods:

1. It works with the aty/radeon_pm.c resume code. I don't see how to
   easily achieve this with user space methods.
2. Real mode seems faster than userspace vm86
3. It is the right way. Bringing up the hardware is clearly the
   responsibility of the kernel/drivers resume code.

Ole


--=-=-=
Content-Disposition: attachment; filename=patch-2.6.7-p2120
Content-Description: patch

diff -ru -X dontdiff linux-2.6.7/arch/i386/kernel/acpi/sleep.c linux-2.6.7-p2120/arch/i386/kernel/acpi/sleep.c
--- linux-2.6.7/arch/i386/kernel/acpi/sleep.c	2004-07-06 21:48:04.000000000 +0200
+++ linux-2.6.7-p2120/arch/i386/kernel/acpi/sleep.c	2004-07-19 10:53:48.000000000 +0200
@@ -5,6 +5,7 @@
  *  Copyright (C) 2001-2003 Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
  */
 
+#include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <asm/smp.h>
@@ -63,6 +64,31 @@
 	zap_low_mappings();
 }
 
+/*
+ * acpi_vgapost
+ */
+
+extern void do_vgapost_lowlevel (unsigned long);
+
+void acpi_vgapost (unsigned long slot)
+{
+  unsigned long flags, saved_video_flags = acpi_video_flags;
+  acpi_video_flags = (slot & 0xffff) << 16 | 1;
+  /* Map low memory and copy information */
+  init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
+  memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
+  acpi_copy_wakeup_routine(acpi_wakeup_address);
+  /* Tunnel thru real mode */
+  local_irq_save(flags);
+  do_vgapost_lowlevel(acpi_wakeup_address);
+  local_irq_restore(flags);
+  /* Restore mapping etc */
+  zap_low_mappings();
+  acpi_video_flags = saved_video_flags;
+}
+
+EXPORT_SYMBOL (acpi_vgapost);
+
 /**
  * acpi_reserve_bootmem - do _very_ early ACPI initialisation
  *
diff -ru -X dontdiff linux-2.6.7/arch/i386/kernel/acpi/wakeup.S linux-2.6.7-p2120/arch/i386/kernel/acpi/wakeup.S
--- linux-2.6.7/arch/i386/kernel/acpi/wakeup.S	2004-07-05 19:37:21.000000000 +0200
+++ linux-2.6.7-p2120/arch/i386/kernel/acpi/wakeup.S	2004-07-19 11:02:30.000000000 +0200
@@ -43,6 +43,7 @@
 
 	testl	$1, video_flags - wakeup_code
 	jz	1f
+	movw	video_flags - wakeup_code + 2, %ax
 	lcall   $0xc000,$3
 	movw	%cs, %ax
 	movw	%ax, %ds					# Bios might have played with that
@@ -159,6 +160,32 @@
 
 _setbad: jmp setbad
 
+#
+#	Real mode switch - verbatim from reboot.c
+#
+go_real:
+	movl	%cr0, %eax
+	andl	$0x00000011, %eax
+	orl	$0x60000000, %eax
+	movl	%eax, %cr0
+	movl	%eax, %cr3
+	movl	%cr0, %ebx
+	andl	$0x60000000, %ebx
+	jz	1f
+	wbinvd
+1:	andb	$0x10, %al
+	movl	%eax, %cr0
+go_real_jmp:		.byte	0xea
+go_real_jmp_off:	.word	0x0000
+go_real_jmp_seg:	.word	0x0000
+#
+# 	Real mode descriptor table
+#
+		.align	8
+go_real_desc:	.quad	0x0000000000000000
+go_real_cseg:	.quad	0x00009a000000ffff
+go_real_dseg:	.quad	0x000092000000ffff
+
 	.code32
 	ALIGN
 
@@ -284,6 +311,59 @@
 	call acpi_enter_sleep_state_s4bios
 	ret
 
+ENTRY(do_vgapost_lowlevel)
+	# Convert target offset to physical address
+	movl	%eax, %ecx
+	subl	$__PAGE_OFFSET, %ecx
+	# Fixup GDT pointer
+	movl	%ecx, %edx
+	addl	$go_real_desc - wakeup_start, %edx
+	movl	%edx, go_real_gdt + 2
+	# Fixup 16-bit CS descriptor
+	movl	%ecx, %edx
+	movw	%dx, go_real_cseg - wakeup_start + 2 (%eax)
+	shrl	$16, %edx
+	movb	%dl, go_real_cseg - wakeup_start + 4 (%eax)
+	movb	%dh, go_real_cseg - wakeup_start + 7 (%eax)
+	# Fixup 16-bit jump
+	movl	%ecx, %edx
+	shrl	$4, %edx
+	movw	%dx, go_real_jmp_seg - wakeup_start (%eax)
+	# Save state and registers
+	call	save_processor_state
+	call	save_registers
+	# Reload page table with low mapping
+	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
+	movl	%eax, %cr3
+	# Load IDTR and GDTR for real mode
+	lidt	go_real_idt
+	lgdt	go_real_gdt
+	# Load DS & al
+	movl	$0x0010, %eax
+	movl	%eax, %ss
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %fs
+	movl	%eax, %gs
+	# Load CS
+	call	$0x0008, $(go_real - wakeup_start)
+	# Phony return code
+	call	restore_registers
+	call	restore_processor_state
+	ret
+	
+	.align	4
+	.word	0
+go_real_idt:
+	.word	0x3ff
+	.long	0
+	
+	.align	4
+	.word	0
+go_real_gdt:
+	.word	3*8-1
+	.long	0
+
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
diff -ru -X dontdiff linux-2.6.7/drivers/video/aty/radeon_pm.c linux-2.6.7-p2120/drivers/video/aty/radeon_pm.c
--- linux-2.6.7/drivers/video/aty/radeon_pm.c	2004-07-19 10:56:15.000000000 +0200
+++ linux-2.6.7-p2120/drivers/video/aty/radeon_pm.c	2004-07-19 10:56:34.000000000 +0200
@@ -897,6 +897,10 @@
 	if (pdev->dev.power_state == 0)
 		return 0;
 
+	pci_restore_state (pdev, pdev->saved_config_space);
+
+	acpi_vgapost (pdev->devfn);
+
 	acquire_console_sem();
 
 	/* Wakeup chip */

--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
