From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Date: Tue, 5 Apr 2005 23:13:41 +0200
Message-ID: <20050405211340.GF1380@elf.ucw.cz>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at> <20050405204107.GD1380@elf.ucw.cz> <20050405210041.GA16263@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050405210041.GA16263-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I do not know why you can't unload them, but what about simply not
> > loading them at all? :-).
> 
> hotplug.
> 
> 
> Whatever, booting with init=/bin/sh I get these processes running
>   PID TTY      STAT   TIME COMMAND
>     1 ?        R      0:00 /bin/bash
>     2 ?        SN     0:00 [ksoftirqd/0]
>     3 ?        S      0:00 [watchdog/0]
>     4 ?        S<     0:00 [events/0]
>     5 ?        S<     0:00 [khelper]
>     6 ?        S<     0:00 [kthread]
>     8 ?        S<     0:00 [kacpid]
>    98 ?        S<     0:00 [kblockd/0]
>   153 ?        S      0:00 [pdflush]
>   154 ?        S      0:00 [pdflush]
>   155 ?        S      0:00 [kswapd0]
>   156 ?        S<     0:00 [aio/0]
>   231 ?        S      0:00 [kseriod]
>   301 ?        S      0:00 [kjournald]
>   309 ?        S<s    0:00 udevd
>   553 ?        R      0:00 ps ax
> 
> and the same happens. Instant reboot.
> 
> So who could be the culprit from the compiled in stuff:
> cpufreq
> netfilter
> input stuff
> serio stuff
> snd stuff (but not the actual driver snd_interl8x0 which is modular)
> 
> well that's it. Strange.

Well, I do not have working suspend-to-RAM setup close to me... Could
you try 2.6.12-rc1 to see if reboot problem is -mm specific or not?

input is known for some funky behaviour, especially with
synaptics. Disabling cpufreq might be good idea, too...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
