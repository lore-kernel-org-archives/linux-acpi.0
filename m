From: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH 2.4.22-pre3] Export 'acpi_disabled' symbol to modules...
Date: Mon, 7 Jul 2003 11:56:12 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030707095612.GA1507@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

'acpi_disabled' is not exported by the current 2.4-pre kernel, but
is used by at least the sonypi module.

I have submitted a similar patch for 2.5 some weeks ago (and it got
applied) but for some reason the 2.4 ACPI branch don't have it.

Andy, Marcelo, please apply.

(Alan, a similar change is needed for -ac, but the current patch will
not apply on top of the ac tree. Do you want me to send you a patch
correcting this or you'll do the change by hand ?)

Thanks,

Stelian.

===== arch/i386/kernel/setup.c 1.68 vs edited =====
--- 1.68/arch/i386/kernel/setup.c	Mon Jun 23 08:41:25 2003
+++ edited/arch/i386/kernel/setup.c	Mon Jul  7 09:28:46 2003
@@ -107,6 +107,7 @@
 #include <linux/seq_file.h>
 #include <asm/processor.h>
 #include <linux/console.h>
+#include <linux/module.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -175,10 +176,11 @@
 static u32 disabled_x86_caps[NCAPINTS] __initdata = { 0 };
 
 #ifdef CONFIG_ACPI_HT_ONLY
-int acpi_disabled __initdata = 1;
+int acpi_disabled = 1;
 #else
-int acpi_disabled __initdata = 0;
+int acpi_disabled = 0;
 #endif
+EXPORT_SYMBOL(acpi_disabled);
 
 extern int blk_nohighio;
 
===== arch/i386/kernel/Makefile 1.6 vs edited =====
--- 1.6/arch/i386/kernel/Makefile	Fri Jun 13 09:01:12 2003
+++ edited/arch/i386/kernel/Makefile	Mon Jul  7 09:28:57 2003
@@ -14,7 +14,7 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o setup.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-- 
Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>
