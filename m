From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Fri, 15 Oct 2004 21:41:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041015214126.19df9b3c.albeclemit@yahoo.it>
References: <88056F38E9E48644A0F562A38C64FB60031D9885@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60031D9885-exJ48ZlmiLpQxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 15 Oct 2004 06:52:57 -0700
"Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> >> > From the comment in those lines, push and pop are not 
> >required for all
> >> > platforms. Can you just comment out that push and pop and 
> >see how far
> >> > you can go.
> >
> >I know it's not the most the effective way to proceed, but at 
> >least i tryed ;)
> >I've been moving around the pushl $0 (that causes reboot) to 
> >check if the code was still executing. That's what i found.

> >	testl	$1, video_flags - wakeup_code
> >		### If I put pushl $0 here, it causes reboot. 
> >code is still alive.
> > 	jz	1f
> >		## pushl $0 here doesn't make reboot (hang on wakeup)
> >	
> >	lcall   $0xc000,$3

> Jz is jump on zero. The instructions following jz here never gets
> executed unless you pass "acpi_sleep=s3_bios". You have to follow the
> code to where 1: is. 

I followed the code until the line that makes it hang:
[...]
wakeup_pmode_return:
	movw	$__KERNEL_DS, %ax
	movw	%ax, %ss			# THIS LINE MAKES IT HANG
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %fs
	movw	%ax, %gs
	movw	$0x0e00 + 'u', 0xb8016

	# reload the gdt, as we need the full 32 bit address
	lgdt	saved_gdt
	lidt	saved_idt
	lldt	saved_ldt
[...]

...what's happening now?
Thanks,
Alberto



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
