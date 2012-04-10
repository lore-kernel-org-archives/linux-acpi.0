From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 2/2] ACPI: Pass u8 flag to acpi_enter_sleep_state from lowlevel assembler.
Date: Mon,  9 Apr 2012 22:34:06 -0400
Message-ID: <1334025246-8811-3-git-send-email-konrad.wilk@oracle.com>
References: <1334025246-8811-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:28784 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2DJCi7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2012 22:38:59 -0400
In-Reply-To: <1334025246-8811-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ming.m.lin@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, konrad.r.wilk@gmail.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

 With commit a2ef5c4fd44ce3922435139393b89f2cce47f576
"ACPI: Move module parameter gts and bfs to sleep.c" the wake_sleep_flags
is required when calling acpi_enter_sleep_state. But the change
to do that in the x86_acpi_suspend_lowlevel' do_suspend_lowlevel()
was not done. So the call in do_suspend_lowlevel() assembler to
acpi_enter_sleep_state would provide a potentially corrupted wakeup_flag.

This fixes it by passing the paramter.
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/kernel/acpi/wakeup_32.S |    5 ++++-
 arch/x86/kernel/acpi/wakeup_64.S |    3 +++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 13ab720..9e9260c 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -74,9 +74,12 @@ restore_registers:
 ENTRY(do_suspend_lowlevel)
 	call	save_processor_state
 	call	save_registers
+	movzbl  wake_sleep_flags, %eax
+	movzbl  %al, %eax
+	pushl	%eax
 	pushl	$3
 	call	acpi_enter_sleep_state
-	addl	$4, %esp
+	addl	$4*2, %esp
 
 #	In case of S3 failure, we'll emerge here.  Jump
 # 	to ret_point to recover
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 8ea5164..66cc2ab 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -72,6 +72,9 @@ ENTRY(do_suspend_lowlevel)
 
 	addq	$8, %rsp
 	movl	$3, %edi
+	movzbl	wake_sleep_flags, %eax
+	movzbl	%al, %eax
+	mov	%eax,%esi
 	xorl	%eax, %eax
 	call	acpi_enter_sleep_state
 	/* in case something went wrong, restore the machine status and go on */
-- 
1.7.7.5

