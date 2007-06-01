From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH]: ACPI: preserve the ebx value in acpi_copy_wakeup_routine
Date: Fri, 01 Jun 2007 18:09:13 +0800
Message-ID: <1180692553.7707.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56885 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757785AbXFAKJr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jun 2007 06:09:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, pavel@ucw.cz, kevin.tian@intel.com

From: Tian Kevin <kevin.tian@intel.com>

Register %ebx serves as the "global offset table base register"
for position-independent code. For absolute code, %ebx serves
as a local register and has no specified role in the function
calling sequence. In either case, a function must preserve the
register value for the caller.

acpi_copy_wakeup_routine overrides %ebx without saving it,
this may corrupt the called data.

Kevin found that most time the value of Sx is saved in %esi,
however sometimes compiler also uses %ebx. When this happens,
suspends fails since sleep value in ebx is changed by
acpi_copy_wakeup_routine.

The same funtion in X86_64 doesn't have this problem.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/i386/kernel/acpi/wakeup.S |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.22-rc3/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux-2.6.22-rc3.orig/arch/i386/kernel/acpi/wakeup.S	2007-05-31 17:23:56.000000000 +0800
+++ linux-2.6.22-rc3/arch/i386/kernel/acpi/wakeup.S	2007-05-31 17:24:08.000000000 +0800
@@ -230,6 +230,7 @@ bogus_magic:
 #
 ENTRY(acpi_copy_wakeup_routine)
 
+	pushl	%ebx
 	sgdt	saved_gdt
 	sidt	saved_idt
 	sldt	saved_ldt
@@ -263,6 +264,7 @@ ENTRY(acpi_copy_wakeup_routine)
 	movl	%edx, video_flags - wakeup_start (%eax)
 	movl	$0x12345678, real_magic - wakeup_start (%eax)
 	movl	$0x12345678, saved_magic
+	popl	%ebx
 	ret
 
 save_registers:
