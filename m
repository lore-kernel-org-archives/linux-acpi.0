From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Fri, 15 Oct 2004 09:48:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041015094852.642394bb.albeclemit@yahoo.it>
References: <88056F38E9E48644A0F562A38C64FB600318A0CF@scsmsx403.amr.corp.intel.com>
	<20041014102928.5bd2cbc5.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041014102928.5bd2cbc5.albeclemit-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 14 Oct 2004 10:29:28 +0200
Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org> wrote:

> On Wed, 13 Oct 2004 06:39:26 -0700
> "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > >> I suspected 'pushl $0' cause reboot a little. I can't find 
> > >any fault in
> > >> the line. Is it the precise line to cause reboot?
> > >
> > >Yes, i tryed placing an infinite loop immediately before and 
> > >after that line, and that line causes reboot.
> > >
> > 
> > From the comment in those lines, push and pop are not required for all
> > platforms. Can you just comment out that push and pop and see how far
> > you can go.

I know it's not the most the effective way to proceed, but at least i tryed ;)
I've been moving around the pushl $0 (that causes reboot) to check if the code was still executing. That's what i found.

Code from arch/i386/kernel/acpi/wakeup.S:
[...]
	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
	movw	$0x0e00 + 'S', %fs:(0x12)

	#pushl	$0	###THIS LINE CAUSES REBOOT!		# Kill any dangerous flags
	#popfl

	movl	real_magic - wakeup_code, %eax
	cmpl	$0x12345678, %eax
	jne	bogus_real_magic

	testl	$1, video_flags - wakeup_code
		### If I put pushl $0 here, it causes reboot. code is still alive.
 	jz	1f
		## pushl $0 here doesn't make reboot (hang on wakeup)
	
	lcall   $0xc000,$3
	
	movw	%cs, %ax
	movw	%ax, %ds					# Bios might have played with that
	movw	%ax, %ss
[...]

What happens with that jz 1f? is it supposed to enter the jmp?

Thanks,
Alberto


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
