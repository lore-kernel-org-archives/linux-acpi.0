From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] x86 ACPI: Fix breakage of resume on 64-bit UP systems with SMP kernel
Date: Fri, 17 Oct 2008 01:26:27 +0200
Message-ID: <200810170126.27890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60569 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756883AbYJPXWR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Oct 2008 19:22:17 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

x86 ACPI: Fix breakage of resume on 64-bit UP systems with SMP kernel

We are now using per CPU GDT tables in head_64.S and the original
early_gdt_descr.address is invalidated after boot by 
setup_per_cpu_areas().  This breaks resume from suspend to RAM on
x86_64 UP systems using SMP kernels, because this part of head_64.S
is also executed during the resume and the invalid GDT address
causes the system to crash.  It doesn't break on 'true' SMP systems,
because early_gdt_descr.address is modified every time
native_cpu_up() runs.  However, during resume it should point to the
GDT of the boot CPU rather than to another CPU's GDT.

For this reason, during suspend to RAM always make
early_gdt_descr.address point to the boot CPU's GDT.

This fixes http://bugzilla.kernel.org/show_bug.cgi?id=11568, which
is a regression from 2.6.26.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Andy Wettstein <ajw1980@gmail.com>
---
 arch/x86/kernel/acpi/sleep.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -10,6 +10,7 @@
 #include <linux/dmi.h>
 #include <linux/cpumask.h>
 #include <asm/segment.h>
+#include <asm/desc.h>
 
 #include "realmode/wakeup.h"
 #include "sleep.h"
@@ -100,6 +101,8 @@ int acpi_save_state_mem(void)
 	header->trampoline_segment = setup_trampoline() >> 4;
 #ifdef CONFIG_SMP
 	stack_start.sp = temp_stack + 4096;
+	early_gdt_descr.address =
+			(unsigned long)get_cpu_gdt_table(smp_processor_id());
 #endif
 	initial_code = (unsigned long)wakeup_long64;
 	saved_magic = 0x123456789abcdef0;
