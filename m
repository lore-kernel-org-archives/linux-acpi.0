From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Interesting S3 resume behaviour.
Date: 14 Feb 2003 16:08:16 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045238896.22719.92.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm playing with 2.5.60-BK and Pavel's recent swsusp patches on a 
MSI 'KTV4L' board, and seeing very bizarre behaviour w.r.t. resuming
from S3.

Firstly, if I attempt S3 suspend/resume without first booting Windows
once, it just doesn't come back at all -- it seems to reboot immediately
on resume. Ignoring that for the moment though, when it _does_ come back
I see strange behaviour.

The kernel puts its resume code at physical address 0x1000. The BIOS
reinitialises the video card and then jumps to 0100:0000. We transfer
%cs into %ax, and then into %ds and %ss.

At this point, I read from %ds:0000, print the value, and write it back.
Then I read from %ss:0000, print the value and write it back. Except I
don't, because the box spontaneously reboots when I _write_ to %ss:0000,
even though we've just read correct data from that address, and written
to that address via %ds too.

Given that we're supposed to be in real mode (and %cr0 and %cr4
apparently tell us we really are in real mode), I really don't
comprehend how this can happen -- any ideas? :)

My workaround for this, for now, is to avoid the 'pushl $0' by simply
having an explicit '.long 0' after the wakeup_stack label. We do
actually get back to Linux if we don't write to anywhere in the stack
segment. But I'm still confused, and I suspect the answer to this might
have some bearing on the question of why we see a similar spontaneous
reboot before even reaching our own code, if Windows hasn't been booted
since the last hard reset.

Code attached below -- this is its output:

 hwsleep-0238 [03] acpi_enter_sleep_state: Entering sleep state [S3]
cr0:00000010
cr4:00000000
ss:sp:0100:0FF0
wc(0100,FCFA): OK
wd(0100,FCFA): OK
ws(0100,FCFA):
   < at this point, the box reboots >

---------------- My wakeup code, for reference: ----------------


ALIGN
	.align	4096
ENTRY(wakeup_start)

.macro serial_out, val, port
       movb \val, %al
       movw \port, %dx
       outb %al, %dx
.endm	

.macro pchar_al
               movw $0x3f8, %dx
               outb %al, %dx
               addw $5, %dx
1:
               inb %dx, %al
               testb $0x40, %al
               jz 1b
.endm

.macro pchar, c
               movb \c, %al
               pchar_al
.endm
.macro phnybble
               addb $'0', %al
               cmpb $'9', %al
               jle 1f
               addb $7, %al
1:             pchar_al
.endm

.macro phbyte
               movb %al, %ah
               shrb $4, %al
               phnybble
               movb %ah, %al
               andb $0xf, %al
               phnybble
.endm

.macro phword, w
               movw \w, %ax
               movb %ah, %al
               phbyte
               movw \w, %ax
               phbyte
.endm

	
wakeup_code:
	wakeup_code_start = .
	.code16

	cli
	cld

	serial_out	$0x80, $0x3f8+3
	serial_out      $1, $0x3f8
	serial_out      $0, $0x3f8+1
	serial_out      $0x03, $0x3f8+3
	serial_out      $0x01, $0x3f8+2
	serial_out      $0x00, $0x3f8+1

 	movw	$0xb800, %ax
	movw	%ax,%fs
	movw	$0x0e00 + 'L', %fs:(0x10)

	pchar $'c'
	pchar $'r'
	pchar $'0'
	pchar $':'
	movl %cr0, %ebx
	shrl $16, %ebx
	phword %bx
	movl %cr0, %ebx
	phword %bx
	pchar $13
	pchar $10

#if 0
	# We die when we use %ss, wherever it points. 
	pchar $'e'
	movw %fs, %ax
	movw %ax, %ss
	pchar $'f'
	movw $0x200, %sp
	pchar $'l'
	pushfl
	pchar $'a'
	popl %ebx
	pchar $'g'
	pushl %ebx
	pchar $'s'
	shrl $16, %ebx
	pchar $':'
	phword %bx
	popl %ebx
	phword %bx
#endif	
	pchar $'c'
	pchar $'r'
	pchar $'4'
	pchar $':'
	movl %cr4, %ebx
	shrl $16, %ebx
	phword %bx
	movl %cr4, %ebx
	phword %bx
	pchar $13
	pchar $10
	

	# setup data segment
	movw	%cs, %ax
	movw	%ax, %ds					# Make ds:0 point to wakeup_start
	movw	%ax, %ss
	
	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
	movw	$0x0e00 + 'S', %fs:(0x12)

	pchar $'s'
	pchar $'s'
	pchar $':'
	pchar $'s'
	pchar $'p'
	pchar $':'
	phword %ss
	pchar $':'
	phword %sp
	pchar $13
	pchar $10
	
	pchar $'w'
	pchar $'c'
	movw %cs:(0), %bx
	pchar $'('
	phword %cs
	pchar $','
	phword %bx
	pchar $')'
	pchar $':'
	pchar $' '
	movw %bx, %cs:(0)
	pchar $'O'
	pchar $'K'
	pchar $13
	pchar $10

	pchar $'w'
	pchar $'d'
	movw %ds:(0), %bx
	pchar $'('
	phword %ds
	pchar $','
	phword %bx
	pchar $')'
	pchar $':'
	pchar $' '
	movw %bx, %ds:(0)
	pchar $'O'
	pchar $'K'
	pchar $13
	pchar $10

	pchar $'w'
	pchar $'s'
	movw %ss:(0), %bx
	pchar $'('
	phword %ss
	pchar $','
	phword %bx
	pchar $')'
	pchar $':'
	pchar $' '
	movw %bx, %ss:(0)
	pchar $'O'
	pchar $'K'
	pchar $13
	pchar $10

	pchar $'p'
	pchar $'u'
	pchar $'s'
	pchar $'h'
	pchar $':'
	pushl $0
	pchar $' '
	pchar $'O'
	pchar $'K'
	pchar $13
	pchar $10



-- 
dwmw2


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
