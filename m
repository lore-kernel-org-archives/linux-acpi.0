From: "John H." <mistamaila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: compaq 2110us and suspend to ram
Date: Mon, 16 Jan 2006 19:17:52 -0600
Message-ID: <5b9417770601161717n6c50b004sac5efd4d3d027872@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

compaq 2110us and
fc4
athlon xp processor

EVEN with acpid not running, I get a power off when I try to resume
from suspend to ram by hitting an acpid button, which I am desperately
trying to get working.  It works fine in XP.

The only way I can prevent poweroff is using this modifcation to
wakeup.S which was provided by pavlov, but it obviously does not allow
correct resume.  It does, however, show something.

----------------
#define BEEP \
       inb     $97, %al;       \
       outb    %al, $0x80;     \
       movb    $3, %al;        \
       outb    %al, $97;       \
       outb    %al, $0x80;     \
       movb    $-74, %al;      \
       outb    %al, $67;       \
       outb    %al, $0x80;     \
       movb    $-119, %al;     \
       outb    %al, $66;       \
       outb    %al, $0x80;     \
       movb    $15, %al;       \
       outb    %al, $66;

ALIGN
	.align	4096
ENTRY(wakeup_start)
wakeup_code:
	wakeup_code_start = .
	.code16
BEEP
1:
        jmp 1b

 	movw	$0xb800, %ax
	movw	%ax,%fs
	movw	$0x0e00 + 'L', %fs:(0x10)

---------------------------


So what does this mean?  Obviously this patch is going to prevent a
successful resume, but when I use it, the all the lights return to
normal but I get no key usage nor video usage on resume.  If I do NOT
use these modifications, pressing any acpi button powers off the
computer, even if acpid is stopped.


Please advise, I am very anxious to get suspend to ram working.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
