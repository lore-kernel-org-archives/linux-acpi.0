From: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Subject: Re: Resume from mem state == Reboot (Averatec)
Date: Tue, 22 Mar 2005 00:12:45 -0800
Message-ID: <87br9cxfnm.fsf@www.codersbase.com>
References: <87k6oaug4a.fsf@www.codersbase.com>
	<1110840337.8136.82.camel@tyrosine>
	<87eke94hul.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87eke94hul.fsf-mMfbam+mt929kzlf/Hu3QdBPR1lH4CV8@public.gmane.org> (Jason Dagit's message of
 "Sun, 20 Mar 2005 22:45:54 -0800")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org> writes:

> Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> writes:
>
>> This is likely to be the same problem as
>> http://bugzilla.kernel.org/show_bug.cgi?id=3691

I made a discovery today.  This bug says the following:
http://bugme.osdl.org/show_bug.cgi?id=3586

---- Begin Paste ----
Code from arch/i386/kernel/acpi/wakeup.S:
[...]
        mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
        movw    $0x0e00 + 'S', %fs:(0x12)

        pushl   $0      ###THIS LINE CAUSES REBOOT!             # Kill any dangerous flags
        popfl

        movl    real_magic - wakeup_code, %eax
[...]

Commenting out pushl $0 and popfl wakeup code goes on until another
issue blocks it later (more on this to be added as soon as we point
something out on the acpi-devel mailing list)
---- End Paste ----

I tried commenting out those lines (both the pushl and popfl) and my
laptop suspends and resumes!  The screen is blank when the machine
resumes, but I can toggle capslock and if I type "find /" the hard
drive light comes on.  So it would appear that the machine is setting
the firmware_wake_vector correctly, but something about that push and
pop is not good for this machine.  Now I'm off to debug the video
resume problems, which appears to be a pretty common problem with
suspend/resume.

I hope this is helpful to others.  Matthew can you try this on your
laptop?

Thanks,
Jason


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
