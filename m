From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Tue, 12 Oct 2004 10:06:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <416C0F14.5000107@root.org>
References: <20041004133340.76ba05ba.albeclemit@yahoo.it>	<20041009130628.GA21781@elf.ucw.cz>	<20041010105635.GA3362@doc.ic.ac.uk> <20041012175810.2920edf2.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Alberto wrote:
>>On Sat, Oct 09, 2004 at 03:06:28PM +0200, Pavel Machek wrote:
>>
>>>>How could i try to debug this to give you more info?
>>>
>>>You basically need to fix this yourself. Add infinite loops to
>>>wakeup.S to see where it breaks.
> 
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

Hehe.  Look up above where the stack pointer is changed to point to the 
wakeup stack and then 0 is pushed on it.  It's likely there is some 
problem with the config or location of the wakeup stack.

-- 
Nate


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
