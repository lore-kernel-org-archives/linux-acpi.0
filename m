From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Sun, 17 Oct 2004 21:48:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041017194809.GD7476@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60031D9885@scsmsx403.amr.corp.intel.com> <20041015214126.19df9b3c.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041015214126.19df9b3c.albeclemit-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!


> > >> > From the comment in those lines, push and pop are not 
> > >required for all
> > >> > platforms. Can you just comment out that push and pop and 
> > >see how far
> > >> > you can go.
> > >
> > >I know it's not the most the effective way to proceed, but at 
> > >least i tryed ;)
> > >I've been moving around the pushl $0 (that causes reboot) to 
> > >check if the code was still executing. That's what i found.
> 
> > >	testl	$1, video_flags - wakeup_code
> > >		### If I put pushl $0 here, it causes reboot. 
> > >code is still alive.
> > > 	jz	1f
> > >		## pushl $0 here doesn't make reboot (hang on wakeup)
> > >	
> > >	lcall   $0xc000,$3
> 
> > Jz is jump on zero. The instructions following jz here never gets
> > executed unless you pass "acpi_sleep=s3_bios". You have to follow the
> > code to where 1: is. 
> 
> I followed the code until the line that makes it hang:
> [...]
> wakeup_pmode_return:
> 	movw	$__KERNEL_DS, %ax
> 	movw	%ax, %ss			# THIS LINE MAKES IT HANG
> 	movw	%ax, %ds
> 	movw	%ax, %es
> 	movw	%ax, %fs
> 	movw	%ax, %gs
> 	movw	$0x0e00 + 'u', 0xb8016
> 
> 	# reload the gdt, as we need the full 32 bit address
> 	lgdt	saved_gdt
> 	lidt	saved_idt
> 	lldt	saved_ldt
> [...]
> 
> ...what's happening now?

You commented out pushl / popfl, right? That looks like workaround. We
need some stack. Can you try commenting this instead

        movw    %ax, %ss
        mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board

? Maybe bios left us with some usefull stack. (Not all biosen do, but
you might be lucky).

Ouch and also try what happens if you do 

	pushl %eax
	popl %eax

before

	pushl $0
	popfl

If my theory is correct (stack problem) pushl %eax should kill the
machine same way pushl $0 does.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
