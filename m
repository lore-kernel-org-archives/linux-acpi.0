From: Alberto <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Tue, 12 Oct 2004 17:58:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041012175810.2920edf2.albeclemit@yahoo.it>
References: <20041004133340.76ba05ba.albeclemit@yahoo.it>
	<20041009130628.GA21781@elf.ucw.cz>
	<20041010105635.GA3362@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041010105635.GA3362-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Sat, Oct 09, 2004 at 03:06:28PM +0200, Pavel Machek wrote:
> > > How could i try to debug this to give you more info?
> > 
> > You basically need to fix this yourself. Add infinite loops to
> > wakeup.S to see where it breaks.
> > 								Pavel

I isolated the line were it breaks and reboots.

Code from arch/i386/kernel/acpi/wakeup.S

[...] 
	# setup data segment
	movw	%cs, %ax
	movw	%ax, %ds					# Make ds:0 point to wakeup_start
	movw	%ax, %ss
	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
	movw	$0x0e00 + 'S', %fs:(0x12)

	pushl	$0		###THIS LINE CAUSES REBOOT###			# Kill any dangerous flags
	popfl

	movl	real_magic - wakeup_code, %eax
	cmpl	$0x12345678, %eax
	jne	bogus_real_magic
[...]

placing a statement like
hole:	jmp hole
before pushl $0 (line 37) makes it loop, while immediatly after it reboots.

I don't have skills to fix it myself, but i can test patches... how can i help?

Thanks,
Alberto Piai


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
