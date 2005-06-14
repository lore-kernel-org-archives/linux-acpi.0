From: dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: Resume from Suspend to RAM))
Date: Tue, 14 Jun 2005 15:18:06 -0700
Message-ID: <87oea860rl.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz>
	<87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz>
	<87u0k061jx.fsf@www.codersbase.com> <20050614220911.GD2172@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050614220911.GD2172-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> (Pavel Machek's message of
 "Wed, 15 Jun 2005 00:09:11 +0200")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> writes:

> Hi!
>
>> >> > You got this wrong. It is three illegal instructions but
>> >> > *nested*. Like error, error in fault handler, error in doublefault
>> >> > handler.
>> >> 
>> >> Ah.  Yeah, this isn't an area I know much about :)  Thanks for the
>> >> correction. 
>> >> 
>> >> > Try replacing flags manipulation with any stack manipulation to see
>> >> > what is wrong.
>> >> 
>> >> Do you mean try something like this? Replace the push 0 with push
>> >> 0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
>> >> causes the reboot?
>> >
>> > Yep, try pushl $0, popl %eax; if that causes problems, something is
>> > seriously wrong with stack, otherwise changing flags hurts.
>> 
>> pushl $0, popl %eax gets the reboot.  So it's changing the flags that
>> is bad?
>> 
>> What should we try next?
>
> ??? You wanted it to reboot? If not, something is wrong with
> stack. Not sure whats next.

I don't want it to reboot, I guess I got confused.  As you say, maybe
something is wrong with the stack.  It's weird that something would be
wrong with the stack, because the other test to check the
suspend/resume code path works like a charm, the machine will do the
fake suspend/resume just fine.

So the bios must be messing up the stack right?  Is there a way to
examine or dump the stack so that we can compare the stack when
windows does the suspend/resume compared to when linux does it?

thanks,
Jason



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
