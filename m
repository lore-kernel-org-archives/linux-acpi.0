From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Sun, 17 Oct 2004 21:36:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041017193623.GB7476@elf.ucw.cz>
References: <20041004133340.76ba05ba.albeclemit@yahoo.it> <20041009130628.GA21781@elf.ucw.cz> <20041010105635.GA3362@doc.ic.ac.uk> <20041012175810.2920edf2.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041012175810.2920edf2.albeclemit-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > How could i try to debug this to give you more info?
> > > 
> > > You basically need to fix this yourself. Add infinite loops to
> > > wakeup.S to see where it breaks.

[BTW good. I expected you to just forget it at this point.]

> I isolated the line were it breaks and reboots.
> 
> Code from arch/i386/kernel/acpi/wakeup.S
> 
> [...] 
> 	# setup data segment
> 	movw	%cs, %ax
> 	movw	%ax, %ds					# Make ds:0 point to wakeup_start
> 	movw	%ax, %ss
> 	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
> 	movw	$0x0e00 + 'S', %fs:(0x12)
> 
> 	pushl	$0		###THIS LINE CAUSES REBOOT###			# Kill any dangerous flags
> 	popfl
> 
> 	movl	real_magic - wakeup_code, %eax
> 	cmpl	$0x12345678, %eax
> 	jne	bogus_real_magic
> [...]
> 
> placing a statement like
> hole:	jmp hole
> before pushl $0 (line 37) makes it loop, while immediatly after it reboots.
> 
> I don't have skills to fix it myself, but i can test patches... how can i help?

Well, you'll have the skills when we are done with this. Try this one
(with some suitable loop). Can you hear the tone?

We can make several variants of these to produce different tones
(changing -74 and -119 to some other numbers should do the
trick). That should speed your testing a tiny bit.

									Pavel

--- clean/arch/i386/kernel/acpi/wakeup.S	2004-06-22 12:35:47.000000000 +0200
+++ linux/arch/i386/kernel/acpi/wakeup.S	2004-10-02 18:38:53.000000000 +0200
@@ -11,8 +11,23 @@
 #
 # If physical address of wakeup_code is 0x12345, BIOS should call us with
 # cs = 0x1234, eip = 0x05
-# 
+#
 
+#define BEEP \
+	inb	$97, %al; 	\
+	outb	%al, $0x80; 	\
+	movb	$3, %al; 	\
+	outb	%al, $97; 	\
+	outb	%al, $0x80; 	\
+	movb	$-74, %al; 	\
+	outb	%al, $67; 	\
+	outb	%al, $0x80; 	\
+	movb	$-119, %al; 	\
+	outb	%al, $66; 	\
+	outb	%al, $0x80; 	\
+	movb	$15, %al; 	\
+	outb	%al, $66; 
+	
 ALIGN
 	.align	4096
 ENTRY(wakeup_start)
@@ -20,6 +35,7 @@
 	wakeup_code_start = .
 	.code16
 
+	BEEP
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
