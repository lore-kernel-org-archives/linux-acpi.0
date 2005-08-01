From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 and sigwait (was Re: 2.6.13-rc3: swsusp works (TP 600X))
Date: Mon, 1 Aug 2005 09:09:26 +0200
Message-ID: <20050801070926.GI27580@elf.ucw.cz>
References: <20050730103034.GC1942@elf.ucw.cz> <1122879094.3285.2.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1122879094.3285.2.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > If you think it is a linux bug, can you produce small test case doing 
> > just the sigwait, and post it on l-k with big title "sigwait() breaks 
> > when straced, and on suspend"?
> > 
> > That way it is going to get some attetion, and you'll get either 
> > documentation or kernel fixed. 
> Looks like a linux bug to me. The refrigerator fake signal waked the
> task up and without restart for the sigwait case. How about below
> patch:

Is there chance to fix strace case, too? sigwait() is broken in more
than one way it seems...
								Pavel


>  linux-2.6.13-rc4-root/kernel/signal.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff -puN kernel/signal.c~sigwait-suspend-resume kernel/signal.c
> --- linux-2.6.13-rc4/kernel/signal.c~sigwait-suspend-resume	2005-08-01 14:00:39.089460688 +0800
> +++ linux-2.6.13-rc4-root/kernel/signal.c	2005-08-01 14:30:13.821660384 +0800
> @@ -2188,6 +2188,7 @@ sys_rt_sigtimedwait(const sigset_t __use
>  	struct timespec ts;
>  	siginfo_t info;
>  	long timeout = 0;
> +	int recover = 0;
>  
>  	/* XXX: Don't preclude handling different sized sigset_t's.  */
>  	if (sigsetsize != sizeof(sigset_t))
> @@ -2225,15 +2226,23 @@ sys_rt_sigtimedwait(const sigset_t __use
>  			 * be awakened when they arrive.  */
>  			current->real_blocked = current->blocked;
>  			sigandsets(&current->blocked, &current->blocked, &these);
> +do_recover:
>  			recalc_sigpending();
>  			spin_unlock_irq(&current->sighand->siglock);
>  
>  			current->state = TASK_INTERRUPTIBLE;
>  			timeout = schedule_timeout(timeout);
>  
> -			try_to_freeze();
> +			if (try_to_freeze())
> +				recover = 1;

Can't you just goto do_recover here?

>  			spin_lock_irq(&current->sighand->siglock);
>  			sig = dequeue_signal(current, &these, &info);
> +			if (!sig && recover) {
> +				if (timeout == 0)
> +					timeout = MAX_SCHEDULE_TIMEOUT;
> +				recover = 0;
> +				goto do_recover;
> +			}
>  			current->blocked = current->real_blocked;
>  			siginitset(&current->real_blocked, 0);
>  			recalc_sigpending();
> _
> 

-- 
if you have sharp zaurus hardware you don't need... you know my address


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
