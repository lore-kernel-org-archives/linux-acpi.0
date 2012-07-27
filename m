From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI/x86: revert 'x86, acpi: Call acpi_enter_sleep_state via an asmlinkage C function from assembler'
Date: Thu, 26 Jul 2012 20:34:48 -0400
Message-ID: <b435faf9f7f1d5b39c65fb4531875c970f1cc6f0.1343349012.git.len.brown@intel.com>
References: <1343349289-31179-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64504 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab2G0AfB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jul 2012 20:35:01 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so2252729vbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2012 17:35:00 -0700 (PDT)
In-Reply-To: <1343349289-31179-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, x86@kernel.org
Cc: Len Brown <len.brown@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>

From: Len Brown <len.brown@intel.com>

cd74257b974d6d26442c97891c4d05772748b177
patched up GTS/BFS -- a feature we want to remove.
So revert it (by hand, due to conflict in sleep.h)
to prepare for GTS/BFS removal.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/kernel/acpi/sleep.c     | 4 ----
 arch/x86/kernel/acpi/sleep.h     | 2 --
 arch/x86/kernel/acpi/wakeup_32.S | 4 +++-
 arch/x86/kernel/acpi/wakeup_64.S | 4 +++-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 95bf99d..1b8e5a0 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -25,10 +25,6 @@ unsigned long acpi_realmode_flags;
 static char temp_stack[4096];
 #endif
 
-asmlinkage void acpi_enter_s3(void)
-{
-	acpi_enter_sleep_state(3, wake_sleep_flags);
-}
 /**
  * acpi_suspend_lowlevel - save kernel state
  *
diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
index 5653a57..67f59f8 100644
--- a/arch/x86/kernel/acpi/sleep.h
+++ b/arch/x86/kernel/acpi/sleep.h
@@ -2,7 +2,6 @@
  *	Variables and functions used by the code in sleep.c
  */
 
-#include <linux/linkage.h>
 #include <asm/realmode.h>
 
 extern unsigned long saved_video_mode;
@@ -11,7 +10,6 @@ extern long saved_magic;
 extern int wakeup_pmode_return;
 
 extern u8 wake_sleep_flags;
-extern asmlinkage void acpi_enter_s3(void);
 
 extern unsigned long acpi_copy_wakeup_routine(unsigned long);
 extern void wakeup_long64(void);
diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 7261083..13ab720 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -74,7 +74,9 @@ restore_registers:
 ENTRY(do_suspend_lowlevel)
 	call	save_processor_state
 	call	save_registers
-	call	acpi_enter_s3
+	pushl	$3
+	call	acpi_enter_sleep_state
+	addl	$4, %esp
 
 #	In case of S3 failure, we'll emerge here.  Jump
 # 	to ret_point to recover
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 014d1d2..8ea5164 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -71,7 +71,9 @@ ENTRY(do_suspend_lowlevel)
 	movq	%rsi, saved_rsi
 
 	addq	$8, %rsp
-	call	acpi_enter_s3
+	movl	$3, %edi
+	xorl	%eax, %eax
+	call	acpi_enter_sleep_state
 	/* in case something went wrong, restore the machine status and go on */
 	jmp	resume_point
 
-- 
1.7.12.rc0

