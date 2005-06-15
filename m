From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: Resume from Suspend to RAM))
Date: Wed, 15 Jun 2005 20:41:38 +0200
Message-ID: <20050615184138.GA2308@elf.ucw.cz>
References: <1118125410.3828.12.camel@linux-hp.sh.intel.com> <87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz> <87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz> <87u0k061jx.fsf@www.codersbase.com> <20050614220911.GD2172@elf.ucw.cz> <87oea860rl.fsf@www.codersbase.com> <20050614231115.GE2172@elf.ucw.cz> <87ekb45u5a.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ekb45u5a.fsf-mMfbam+mt929kzlf/Hu3QdBPR1lH4CV8@public.gmane.org>
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

> >> >> What should we try next?
> >> >
> >> > ??? You wanted it to reboot? If not, something is wrong with
> >> > stack. Not sure whats next.
> >> 
> >> I don't want it to reboot, I guess I got confused.  As you say, maybe
> >> something is wrong with the stack.  It's weird that something would be
> >> wrong with the stack, because the other test to check the
> >> suspend/resume code path works like a charm, the machine will do the
> >> fake suspend/resume just fine.
> >
> > Well, we set up stack few instructions before that. But we do it in
> > quite a complicated way; could you just put stack at 0x00:0x200 or
> > something like that? Also test if push alone is enough to kill it.
> 
> Could you send me the code you want me to test, I'd don't know enough
> asm to move the stack.  I tried replacing the line with the comment
> about the ASUS board private stack with a line like, "mov $0x200,
> %sp", but I don't understand it.

mov 0x200, %sp was good idea, but try to zero %ss, too. (xor %eax,
%eax; mov %eax, %ss).
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
