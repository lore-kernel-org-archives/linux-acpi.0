From: Ducrot Bruno <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] acpi_wakeup fixes
Date: Tue, 17 Dec 2002 21:21:42 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021217202142.GB1012@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pavel.

This diff should be OK (I hope)

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00_acpi_wakeup.S.fix"

--- linux-2.5.52/arch/i386/kernel/acpi_wakeup.S	2002/12/17 19:15:12	1.1
+++ linux-2.5.52/arch/i386/kernel/acpi_wakeup.S	2002/12/17 20:03:40
@@ -41,7 +41,7 @@
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
-#if 1
+#if 0
 	lcall   $0xc000,$3
 #endif
 #if 0
@@ -69,8 +69,12 @@
 
 	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0
+
+	# flush the prefetch queue.
 	jmp 1f
+1:	jmp 1f
 1:
+
 	movw	$0x0e00 + 'n', %fs:(0x14)
 
 	movl	real_magic - wakeup_code, %eax
@@ -160,11 +164,12 @@
 	ALIGN
 
 
-.org	0x2000
+.org	0x800
 wakeup_stack:
-.org	0x3000
+.org	0x900
 ENTRY(wakeup_end)
-.org	0x4000
+# .org	0x1000
+	.align 4096
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax

--UugvWAfsgieZRqgk--
