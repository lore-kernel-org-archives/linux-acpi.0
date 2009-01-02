From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/15] ACPICA: move common private headers under
 kernel/acpi/acpica/
Date: Fri, 02 Jan 2009 15:48:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901021438060.3590@localhost.localdomain>
References: <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
 <c6b6f68232ab6da57e764c64b23b4649c4e7c463.1230719801.git.len.brown@intel.com>
 <20090102191451.GB14249@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:54625 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757129AbZABUsb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2009 15:48:31 -0500
In-reply-to: <20090102191451.GB14249@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

> hm, dunno. Do we really want to introduce 'driver/platform' space items 
> like this in the core kernel/* ?

This patch series applies only to the non-driver code.
The ACPI drivers remain in drivers/acpi/.

The code being moved here statically builds into the kernel
on multiple architectures, x86 and ia64.
If you can recommend a more  logical home
for it in the source tree, I'm all ears.

> If it goes there then IMHO the ACPI code needs to be cleaned up 
> _significantly_ to not wrap native Linux calls like spinlocks, allocators, 
> etc.

Are there different style guidelines for the src/kernel/
directory versus other parts of the source tree?

The acpi/acpica/ sub-directory is a processed version of code that
we share with BSD, opensolaris, and every ACPI-capable OS on Earth
besides Microsoft's.  There is a huge commmon benefit
to that sharing, and the Linux community's tolerance of wrappers,
shims, and other unconventional things allows that sharing to
work without an infinite amount of additional make-work.

Indeed, consolidating the ACPICA code under a single acpica/
sub-directory to better identify it is one of the main
benefits of this patch.  Before the split between
Linux code and ACPICA code was less clear.
Maybe I should add a README.txt to that directory to clarify?

> Random example - i dont think stuff like this is readable [in to-be 
> kernel/acpi/utilities/utcache.c]:
> 
>         if (cache->current_depth >= cache->max_depth) {
>                 ACPI_FREE(object);
>                 ACPI_MEM_TRACKING(cache->total_freed++);
>         }
> 
>         /* Otherwise put this object back into the cache */
> 
>         else {
>                 status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);
>                 if (ACPI_FAILURE(status)) {
>                         return (status);
>                 }
> 
> acpi_ut_acquire_mutex() under [to-be] kernel/acpi/utilities/utmutex.c 
> looks absolutely horrible, redirected after some debugging layer to its 
> final destination:
> 
> ./include/acpi/acpiosxf.h:#define acpi_os_acquire_mutex(handle,time) 
> acpi_os_wait_semaphore (handle, 1, time), which does [kernel/acpi/osl.c]:
> 
> /*
>  * TODO: Support for units > 1?
>  */
> acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
> {
> 	acpi_status status = AE_OK;
> 	struct semaphore *sem = (struct semaphore *)handle;
> 	long jiffies;
> 	int ret = 0;
> 
> 	if (!sem || (units < 1))
> 		return AE_BAD_PARAMETER;
> 
> 	if (units > 1)
> 		return AE_SUPPORT;
> 
> 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n",
> 			  handle, units, timeout));
> 
> 	if (timeout == ACPI_WAIT_FOREVER)
> 		jiffies = MAX_SCHEDULE_TIMEOUT;
> 	else
> 		jiffies = msecs_to_jiffies(timeout);
> 	
> 	ret = down_timeout(sem, jiffies);
> 	if (ret)
> 		status = AE_TIME;
> 
> 	if (ACPI_FAILURE(status)) {
> 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
> 				  "Failed to acquire semaphore[%p|%d|%d], %s",
> 				  handle, units, timeout,
> 				  acpi_format_exception(status)));
> 	} else {
> 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
> 				  "Acquired semaphore[%p|%d|%d]", handle,
> 				  units, timeout));
> 	}
> 
> 	return status;
> }
> 
> so it's a glorified down_timeout(). While we have mutex_timeout(). What's 
> the plan here?

ACPICA has required the OS to supply acpi_os_wait_semaphore()
for 10 years.  The timeout in the original Linux implementation
would make you vomit.

We were delighted when Matt gaive us down_timeout() in Linux
starting in 2.6.26.

We went out of our way to give ACPICA the ability to take advantage
of spinlock vs. mutex. vs semaphore if the OS provides them.
However, when mutexes were added to Linux in 2.6.15, we
didn't cut over to them.  I don't recall why at the moment,
the question has come up recently in other conversations.
Perhaps it was that we didn't have a mutex_timeout().
We have one now?

There are plenty of places where we can polish the Linux/ACPI code,
the Linux/ACPI drivers, and the ACPICA code, and I'm all for it.
However, I don't think that should gate moving forward with
a logical source tree layout.

thanks
Len Brown, Intel Open Source Technology Center


