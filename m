From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI S3 resume only reboots
Date: Wed, 13 Oct 2004 17:32:58 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305754FDC72@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto <albeclemit-whZMOeQn8C0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: nate-Y6VGUYTwhu0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> Alberto wrote:
>> > On Tue, 12 Oct 2004 10:06:28 -0700
>> > Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org> wrote:
>> >
>> >
>> >>>Code from arch/i386/kernel/acpi/wakeup.S
>> >>>
>> >>>[...]
>> >>>	# setup data segment
>> >>>	movw	%cs, %ax
>> >>>	movw	%ax, %ds					# Make
ds:0 point to
>wakeup_start
>> >>>	movw	%ax, %ss
>> >>>	mov	$(wakeup_stack - wakeup_code), %sp		#
Private stack is
>needed for ASUS board
>> >>>	movw	$0x0e00 + 'S', %fs:(0x12)
>> >>>
>> >>>	pushl	$0		###THIS LINE CAUSES REBOOT###
# Kill
>any dangerous flags
>> >>>	popfl
>> >>
>> >>Hehe.  Look up above where the stack pointer is changed to point to
the
>> >>wakeup stack and then 0 is pushed on it.  It's likely there is some
>> >>problem with the config or location of the wakeup stack.
>> >
>> >
>> > Ok, so the question is: where should %sp point to?
>>
>> Dunno, we don't use a stack for the wake code.
>
>...mmmh, the problem is that i'm not a programmer, i have no chance to
work
>this out alone. Anybody can help? :)
I suspected 'pushl $0' cause reboot a little. I can't find any fault in
the line. Is it the precise line to cause reboot?

Thanks,
Shaohua


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
