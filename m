From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Mon, 30 Jun 2008 23:54:27 -0700
Message-ID: <4869D4A3.3020000@zytor.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070500060104090401000105"
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080701063133.GC16642-X9Un+BFzKDI@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070500060104090401000105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> 
>> Hi,
>>
>> The appended patch fixes a regression and is considered as 2.6.26 
>> material. Everyone having a box with working suspend to RAM is gently 
>> requested to test it and verify if it doesn't break things.
>>
>> The patch applies to the current -git.
> 
> it's been under testing in tip/out-of-tree for about a week:
> 
> | commit ee901dc1b9ab94a37ba2efc296fe9ba72bc75adf
> | Author:     H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
> | AuthorDate: Tue Jun 24 23:03:48 2008 +0200
> | Commit:     Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
> | CommitDate: Wed Jun 25 18:48:13 2008 +0200
> |
> |     x86 ACPI: normalize segment descriptor register on resume
> 
> no problems caused by it so far.
> 

Here is the incremental patch which should stick "strictly to the 
script" of ljmp immediately after writing CR0.PE.  This should be done 
to the boot code as well; I'm waiting for confirmation from the Elan 
original reporter before submitting that patch.

I decided to make this an incremental patch to make it bisectable versus 
the other one, however, it should probably be considered the right thing.

Note: I have not tested this beyond compilation, I'm afraid.

	-hpa

--------------070500060104090401000105
Content-Type: text/x-patch;
 name="0002-x86-acpi-on-wakeup-ljmp-directly-after-writing-CR0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-x86-acpi-on-wakeup-ljmp-directly-after-writing-CR0.patc";
 filename*1="h"

>From 220cb3b652abcf6a68b20c4bda4cfd426703d3c1 Mon Sep 17 00:00:00 2001
From: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Date: Mon, 30 Jun 2008 23:48:35 -0700
Subject: [PATCH] x86 acpi: on wakeup, ljmp directly after writing CR0.PE

Impact: possible resume failures on AMD Elan, others?

Intel documents that writing cr0 should be immediately followed by a
ljmp, and that "failures are readily seen" if the processor enters SMM
at this point.  We believe this has been observed on the AMD Elan, so
stick strictly to the script and do an ljmp immediately after a change
to CR0.PE in all circumstances.

Signed-off-by: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/kernel/acpi/realmode/wakeup.S |   13 +++++--------
 arch/x86/kernel/acpi/realmode/wakeup.h |    6 ++----
 arch/x86/kernel/acpi/sleep.c           |    4 +++-
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/acpi/realmode/wakeup.S b/arch/x86/kernel/acpi/realmode/wakeup.S
index f2c16d2..7e54e40 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.S
+++ b/arch/x86/kernel/acpi/realmode/wakeup.S
@@ -25,10 +25,8 @@ pmode_gdt:	.quad	0
 realmode_flags:	.long	0
 real_magic:	.long	0
 trampoline_segment:	.word 0
-_pad1:		.byte	0
-wakeup_jmp:	.byte	0xea	/* ljmpw */
-wakeup_jmp_off:	.word	3f
-wakeup_jmp_seg:	.word	0
+wakeup_seg_ptr:	.word	3f-2	/* the segment in the ljmpw */
+_pad:		.long	0
 wakeup_gdt:	.quad	0, 0, 0
 signature:	.long	0x51ee1111
 
@@ -49,8 +47,7 @@ _start:
 	movl	%cr0, %eax
 	orb	$X86_CR0_PE, %al
 	movl	%eax, %cr0
-	jmp	1f
-1:	ljmpw	$8, $2f
+	ljmpw	$8, $2f
 2:
 	movw	%cx, %ds
 	movw	%cx, %es
@@ -60,7 +57,7 @@ _start:
 
 	andb	$~X86_CR0_PE, %al
 	movl	%eax, %cr0
-	jmp	wakeup_jmp
+	ljmpw	$0, $3f
 3:
 	/* Set up segments */
 	movw	%cs, %ax
@@ -134,7 +131,7 @@ wakeup_idt:
 	.word	0xffff		/* limit */
 	.long	0		/* address */
 	.word	0
-	
+
 	.globl	HEAP, heap_end
 HEAP:
 	.long	wakeup_heap
diff --git a/arch/x86/kernel/acpi/realmode/wakeup.h b/arch/x86/kernel/acpi/realmode/wakeup.h
index 69d38d0..0dcdbc7 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.h
+++ b/arch/x86/kernel/acpi/realmode/wakeup.h
@@ -24,10 +24,8 @@ struct wakeup_header {
 	u32 realmode_flags;
 	u32 real_magic;
 	u16 trampoline_segment;	/* segment with trampoline code, 64-bit only */
-	u8  _pad1;
-	u8  wakeup_jmp;
-	u16 wakeup_jmp_off;
-	u16 wakeup_jmp_seg;
+	u16 wakeup_seg_ptr;
+	u32 _pad;
 	u64 wakeup_gdt[3];
 	u32 signature;		/* To check we have correct structure */
 } __attribute__((__packed__));
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index c8c7e7a..08698ca 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -34,6 +34,7 @@ static char temp_stack[10240];
 int acpi_save_state_mem(void)
 {
 	struct wakeup_header *header;
+	u16 *wakeup_seg;
 
 	if (!acpi_realmode) {
 		printk(KERN_ERR "Could not allocate memory during boot, "
@@ -43,6 +44,7 @@ int acpi_save_state_mem(void)
 	memcpy((void *)acpi_realmode, &wakeup_code_start, WAKEUP_SIZE);
 
 	header = (struct wakeup_header *)(acpi_realmode + HEADER_OFFSET);
+	wakeup_seg = (u16 *)(acpi_realmode + header->wakeup_seg_ptr);
 	if (header->signature != 0x51ee1111) {
 		printk(KERN_ERR "wakeup header does not match\n");
 		return -EINVAL;
@@ -50,7 +52,7 @@ int acpi_save_state_mem(void)
 
 	header->video_mode = saved_video_mode;
 
-	header->wakeup_jmp_seg = acpi_wakeup_address >> 4;
+	*wakeup_seg = acpi_wakeup_address >> 4;
 	/* GDT[0]: GDT self-pointer */
 	header->wakeup_gdt[0]  =
 		(sizeof header->wakeup_gdt - 1) +
-- 
1.5.4.1


--------------070500060104090401000105--
