From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Date: Tue, 5 Apr 2005 22:41:07 +0200
Message-ID: <20050405204107.GD1380@elf.ucw.cz>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050405181628.GB6879-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
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

> Dear Andrew, dear Pavel, dear developers!
> 
> WIth 2.6.12-rc2-mm1 I cannot resume, and the laptop not even freezes, it
> immediately goes into reboot when resuming (suspend did work, well it
> looks like).
> 
> I booted into single user mode, stopped all programs (I could), unloaded
> all modules (I could), and then suspended, with the same result. In this
> single user mode my lsmod looked like this:
> 
> Module                  Size  Used by
> yenta_socket           18952  1 
> rsrc_nonstatic         11264  1 yenta_socket
> pcmcia_core            34704  2 yenta_socket,rsrc_nonstatic
> intel_agp              18844  1 
> agpgart                28488  1 intel_agp
> 
> and my ps -ax:
>   PID TTY      STAT   TIME COMMAND
>     1 ?        S      0:00 init [S]          
>     2 ?        SN     0:00 [ksoftirqd/0]
>     3 ?        S      0:00 [watchdog/0]
>     4 ?        S<     0:00 [events/0]
>     5 ?        S<     0:00 [khelper]
>     6 ?        S<     0:00 [kthread]
>     8 ?        S<     0:00 [kacpid]
>    98 ?        S<     0:00 [kblockd/0]
>   153 ?        S      0:00 [pdflush]
>   154 ?        S      0:00 [pdflush]
>   156 ?        S<     0:00 [aio/0]
>   155 ?        S      0:00 [kswapd0]
>   231 ?        S      0:00 [kseriod]
>   301 ?        S      0:00 [kjournald]
>   379 ?        S<s    0:00 udevd
>  2623 ?        S      0:00 [pccardd]
>  2634 ?        S      0:00 [pccardd]
>  3511 tty1     Ss     0:00 init [S]          
>  3516 tty1     S      0:00 bash
>  4417 tty1     R+     0:00 ps ax
> 
> It is interesting that I cannot unload the agp stuff, although to my
> eyes there is nothing which really is using the agp stuff (or is it
> udevd?). For the yenta/pcmcia I couldn't stop pccardd.
> 
> I though about trying to weed out my config, but I don't know where to
> start. I attach my config file, please comment on what I should leave
> out of the kernel for further testing.

I do not know why you can't unload them, but what about simply not
loading them at all? :-).

Or just rm -f them, it is hard to load module that is not there
;^))). Or init=/bin/bash....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
