From: Vlad Yasevich <vladislav.yasevich-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Processor is almost never in C1 state
Date: Tue, 07 Dec 2004 15:04:06 -0500
Message-ID: <1102449846.8525.151.camel@galen.zko.hp.com>
References: <fe1d56f504120608102afbf39b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fe1d56f504120608102afbf39b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dogshu <dogshu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have somewhat similar numbers (C1 is has a larger
value, but is almost never used) on a Compaq Evo N620c.

I found, just by playing around, that by removing
USB modules, I can make my system go into C1 much
faster when doing CPU intensive operations.

See if that works for you.

-vlad

On Mon, 2004-12-06 at 11:10 -0500, dogshu wrote:
> Hello,
> 
> I have a Toshiba Portege laptop with a 500 mhz pentium-3 mobile CPU. 
> The processor is almost never is in the C1 state, and spends 99.9% of
> the time in the C2 state, even when doing heavy processing.
> 
> After a night of compiling KDE, and while running the "burnP6" program
> included in the "cpuburn 1.4" package, this is the output of
> /proc/acpi/processor/CPU0/power:
> 
> active state:            C2
> default state:           C1
> bus master activity:     00000000
> states:
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00009710]
>    *C2:                  promotion[--] demotion[C1] latency[001] usage[12232108]
>     C3:                  <not supported>
> 
> As you can see, even though the processor is being maxed out by
> burnP6, it remains in the C2 state and doesn't really use the C1 state
> at all.
> 
> I don't mind having the CPU in this lower power/lower performance
> state most of the time... however I occassionally like to play DVDs on
> this laptop, and I need all the CPU power I can get when playing DVDs,
> or else  I will get lots of dropped frames.
> 
> I am running kernel 2.6.10-rc2-mm4.  I noticed that in the kernel
> parameters I can disable the C2 state altogether, but I'd rather not
> have to reboot whenever I play a DVD.  Is there a way to tweak ACPI so
> that the processor spends more time in the C1 state, without giving up
> the C2 state entirely?
> 
> thanks for any help,
> Jim Faulkner




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
