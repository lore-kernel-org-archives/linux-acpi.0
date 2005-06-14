From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Wed, 15 Jun 2005 01:11:15 +0200
Message-ID: <20050614231115.GE2172@elf.ucw.cz>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118125410.3828.12.camel@linux-hp.sh.intel.com> <87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz> <87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz> <87u0k061jx.fsf@www.codersbase.com> <20050614220911.GD2172@elf.ucw.cz> <87oea860rl.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87oea860rl.fsf-mMfbam+mt929kzlf/Hu3QdBPR1lH4CV8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> >> Do you mean try something like this? Replace the push 0 with push
> >> >> 0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
> >> >> causes the reboot?
> >> >
> >> > Yep, try pushl $0, popl %eax; if that causes problems, something is
> >> > seriously wrong with stack, otherwise changing flags hurts.
> >> 
> >> pushl $0, popl %eax gets the reboot.  So it's changing the flags that
> >> is bad?
> >> 
> >> What should we try next?
> >
> > ??? You wanted it to reboot? If not, something is wrong with
> > stack. Not sure whats next.
> 
> I don't want it to reboot, I guess I got confused.  As you say, maybe
> something is wrong with the stack.  It's weird that something would be
> wrong with the stack, because the other test to check the
> suspend/resume code path works like a charm, the machine will do the
> fake suspend/resume just fine.

Well, we set up stack few instructions before that. But we do it in
quite a complicated way; could you just put stack at 0x00:0x200 or
something like that? Also test if push alone is enough to kill it.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
