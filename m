From: Alberto <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Tue, 12 Oct 2004 23:17:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041012231737.62c5b99b.albeclemit@yahoo.it>
References: <20041004133340.76ba05ba.albeclemit@yahoo.it>
	<20041009130628.GA21781@elf.ucw.cz>
	<20041010105635.GA3362@doc.ic.ac.uk>
	<20041012175810.2920edf2.albeclemit@yahoo.it>
	<416C0F14.5000107@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <416C0F14.5000107-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: nate-Y6VGUYTwhu0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 12 Oct 2004 10:06:28 -0700
Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org> wrote:

> > Code from arch/i386/kernel/acpi/wakeup.S
> > 
> > [...] 
> > 	# setup data segment
> > 	movw	%cs, %ax
> > 	movw	%ax, %ds					# Make ds:0 point to wakeup_start
> > 	movw	%ax, %ss
> > 	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
> > 	movw	$0x0e00 + 'S', %fs:(0x12)
> > 
> > 	pushl	$0		###THIS LINE CAUSES REBOOT###			# Kill any dangerous flags
> > 	popfl
> 
> Hehe.  Look up above where the stack pointer is changed to point to the 
> wakeup stack and then 0 is pushed on it.  It's likely there is some 
> problem with the config or location of the wakeup stack.

Ok, so the question is: where should %sp point to?

from wakeup.S :

[...]
.org    0x800
wakeup_stack_begin:     # Stack grows down

.org    0xff0           # Just below end of page
wakeup_stack:
ENTRY(wakeup_end)

.org    0x1000
[...]

I noticed that dmesg shows the following lines:
# dmesg | grep BIOS
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d8000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)

maybe i'm just saying nonsense, but could this be useful?


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
