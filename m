From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/84] x86 ACPI: normalize segment descriptor register on resume
Date: Sat, 28 Jun 2008 01:43:16 -0400
Message-ID: <60d40a50886415040888bde5133ccfeab40d945f.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:36217 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYF1FpB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:01 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500306RYOUQOE@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:49 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: H. Peter Anvin <hpa@zytor.com>

Some Dell laptops enter resume with apparent garbage in the segment
descriptor registers (almost certainly the result of a botched transition
from protected to real mode.) The only way to clean that up is to enter
protected mode ourselves and clean out the descriptor registers.

This fixes resume on Dell XPS M1210 and Dell D620.

http://bugzilla.kernel.org/show_bug.cgi?id=10927

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Tested-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/acpi/realmode/wakeup.S |   38 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/acpi/realmode/wakeup.h |    5 ++++
 arch/x86/kernel/acpi/sleep.c           |   16 ++++++++++++-
 drivers/acpi/sleep/main.c              |    5 +--
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/realmode/wakeup.S b/arch/x86/kernel/acpi/realmode/wakeup.S
index f9b77fb..3355973 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.S
+++ b/arch/x86/kernel/acpi/realmode/wakeup.S
@@ -5,6 +5,7 @@
 #include <asm/msr-index.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/processor-flags.h>
 
 	.code16
 	.section ".header", "a"
@@ -24,6 +25,11 @@ pmode_gdt:	.quad	0
 realmode_flags:	.long	0
 real_magic:	.long	0
 trampoline_segment:	.word 0
+_pad1:		.byte	0
+wakeup_jmp:	.byte	0xea	/* ljmpw */
+wakeup_jmp_off:	.word	3f
+wakeup_jmp_seg:	.word	0
+wakeup_gdt:	.quad	0, 0, 0
 signature:	.long	0x51ee1111
 
 	.text
@@ -34,11 +40,34 @@ _start:
 	cli
 	cld
 
+	/* Apparently some dimwit BIOS programmers don't know how to
+	   program a PM to RM transition, and we might end up here with
+	   junk in the data segment descriptor registers.  The only way
+	   to repair that is to go into PM and fix it ourselves... */
+	movw	$16, %cx
+	lgdtl	%cs:wakeup_gdt
+	movl	%cr0, %eax
+	orb	$X86_CR0_PE, %al
+	movl	%eax, %cr0
+	jmp	1f
+1:	ljmpw	$8, $2f
+2:
+	movw	%cx, %ds
+	movw	%cx, %es
+	movw	%cx, %ss
+	movw	%cx, %fs
+	movw	%cx, %gs
+
+	andb	$~X86_CR0_PE, %al
+	movl	%eax, %cr0
+	jmp	wakeup_jmp
+3:
 	/* Set up segments */
 	movw	%cs, %ax
 	movw	%ax, %ds
 	movw	%ax, %es
 	movw	%ax, %ss
+	lidtl	wakeup_idt
 
 	movl	$wakeup_stack_end, %esp
 
@@ -98,7 +127,14 @@ bogus_real_magic:
 	jmp	1b
 
 	.data
-	.balign	4
+	.balign	8
+
+	/* This is the standard real-mode IDT */
+wakeup_idt:
+	.word	0xffff		/* limit */
+	.long	0		/* address */
+	.word	0
+
 	.globl	HEAP, heap_end
 HEAP:
 	.long	wakeup_heap
diff --git a/arch/x86/kernel/acpi/realmode/wakeup.h b/arch/x86/kernel/acpi/realmode/wakeup.h
index ef8166f..69d38d0 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.h
+++ b/arch/x86/kernel/acpi/realmode/wakeup.h
@@ -24,6 +24,11 @@ struct wakeup_header {
 	u32 realmode_flags;
 	u32 real_magic;
 	u16 trampoline_segment;	/* segment with trampoline code, 64-bit only */
+	u8  _pad1;
+	u8  wakeup_jmp;
+	u16 wakeup_jmp_off;
+	u16 wakeup_jmp_seg;
+	u64 wakeup_gdt[3];
 	u32 signature;		/* To check we have correct structure */
 } __attribute__((__packed__));
 
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index afc25ee..36af01f 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -50,6 +50,20 @@ int acpi_save_state_mem(void)
 
 	header->video_mode = saved_video_mode;
 
+	header->wakeup_jmp_seg = acpi_wakeup_address >> 4;
+	/* GDT[0]: GDT self-pointer */
+	header->wakeup_gdt[0] =
+		(u64)(sizeof(header->wakeup_gdt) - 1) +
+		((u64)(acpi_wakeup_address +
+			((char *)&header->wakeup_gdt - (char *)acpi_realmode))
+				<< 16);
+	/* GDT[1]: real-mode-like code segment */
+	header->wakeup_gdt[1] = (0x009bULL << 40) +
+		((u64)acpi_wakeup_address << 16) + 0xffff;
+	/* GDT[2]: real-mode-like data segment */
+	header->wakeup_gdt[2] = (0x0093ULL << 40) +
+		((u64)acpi_wakeup_address << 16) + 0xffff;
+
 #ifndef CONFIG_64BIT
 	store_gdt((struct desc_ptr *)&header->pmode_gdt);
 
@@ -111,7 +125,7 @@ void __init acpi_reserve_bootmem(void)
 		return;
 	}
 
-	acpi_wakeup_address = acpi_realmode;
+	acpi_wakeup_address = virt_to_phys((void *)acpi_realmode);
 }
 
 
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index c3b0cd8..495c63a 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -36,9 +36,8 @@ static int acpi_sleep_prepare(u32 acpi_state)
 		if (!acpi_wakeup_address) {
 			return -EFAULT;
 		}
-		acpi_set_firmware_waking_vector((acpi_physical_address)
-						virt_to_phys((void *)
-							     acpi_wakeup_address));
+		acpi_set_firmware_waking_vector(
+				(acpi_physical_address)acpi_wakeup_address);
 
 	}
 	ACPI_FLUSH_CPU_CACHE();
-- 
1.5.6.1.89.gd544

