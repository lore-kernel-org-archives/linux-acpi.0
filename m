From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 03/15] ACPICA: move common private headers under
	kernel/acpi/acpica/
Date: Fri, 2 Jan 2009 20:14:51 +0100
Message-ID: <20090102191451.GB14249@elte.hu>
References: <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com> <c6b6f68232ab6da57e764c64b23b4649c4e7c463.1230719801.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:48886 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757698AbZABTPM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 Jan 2009 14:15:12 -0500
Content-Disposition: inline
In-Reply-To: <c6b6f68232ab6da57e764c64b23b4649c4e7c463.1230719801.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---

>  kernel/acpi/acpica/dsfield.c                    |    2 +-
>  kernel/acpi/acpica/dsinit.c                     |    2 +-
>  kernel/acpi/acpica/dsmethod.c                   |    2 +-
>  kernel/acpi/acpica/dsmthdat.c                   |    2 +-
>  kernel/acpi/acpica/dsobject.c                   |    2 +-
>  kernel/acpi/acpica/dsopcode.c                   |    2 +-
>  kernel/acpi/acpica/dsutils.c                    |    2 +-
>  kernel/acpi/acpica/dswexec.c                    |    2 +-
>  kernel/acpi/acpica/dswload.c                    |    2 +-
>  kernel/acpi/acpica/dswscope.c                   |    2 +-
>  kernel/acpi/acpica/dswstate.c                   |    2 +-
>  kernel/acpi/acpica/evevent.c                    |    2 +-
>  kernel/acpi/acpica/evgpe.c                      |    2 +-
>  kernel/acpi/acpica/evgpeblk.c                   |    2 +-
>  kernel/acpi/acpica/evmisc.c                     |    2 +-
>  kernel/acpi/acpica/evregion.c                   |    2 +-
>  kernel/acpi/acpica/evrgnini.c                   |    2 +-
>  kernel/acpi/acpica/evsci.c                      |    2 +-
>  kernel/acpi/acpica/evxface.c                    |    2 +-
>  kernel/acpi/acpica/evxfevnt.c                   |    2 +-
>  kernel/acpi/acpica/evxfregn.c                   |    2 +-
>  kernel/acpi/acpica/exconfig.c                   |    2 +-
>  kernel/acpi/acpica/exconvrt.c                   |    2 +-
>  kernel/acpi/acpica/excreate.c                   |    2 +-
>  kernel/acpi/acpica/exdump.c                     |    2 +-
>  kernel/acpi/acpica/exfield.c                    |    2 +-
>
>  [... etc ...]

hm, dunno. Do we really want to introduce 'driver/platform' space items 
like this in the core kernel/* ?

If it goes there then IMHO the ACPI code needs to be cleaned up 
_significantly_ to not wrap native Linux calls like spinlocks, allocators, 
etc.

Random example - i dont think stuff like this is readable [in to-be 
kernel/acpi/utilities/utcache.c]:

        if (cache->current_depth >= cache->max_depth) {
                ACPI_FREE(object);
                ACPI_MEM_TRACKING(cache->total_freed++);
        }

        /* Otherwise put this object back into the cache */

        else {
                status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);
                if (ACPI_FAILURE(status)) {
                        return (status);
                }

acpi_ut_acquire_mutex() under [to-be] kernel/acpi/utilities/utmutex.c 
looks absolutely horrible, redirected after some debugging layer to its 
final destination:

./include/acpi/acpiosxf.h:#define acpi_os_acquire_mutex(handle,time) 
acpi_os_wait_semaphore (handle, 1, time), which does [kernel/acpi/osl.c]:

/*
 * TODO: Support for units > 1?
 */
acpi_status acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 timeout)
{
	acpi_status status = AE_OK;
	struct semaphore *sem = (struct semaphore *)handle;
	long jiffies;
	int ret = 0;

	if (!sem || (units < 1))
		return AE_BAD_PARAMETER;

	if (units > 1)
		return AE_SUPPORT;

	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n",
			  handle, units, timeout));

	if (timeout == ACPI_WAIT_FOREVER)
		jiffies = MAX_SCHEDULE_TIMEOUT;
	else
		jiffies = msecs_to_jiffies(timeout);
	
	ret = down_timeout(sem, jiffies);
	if (ret)
		status = AE_TIME;

	if (ACPI_FAILURE(status)) {
		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
				  "Failed to acquire semaphore[%p|%d|%d], %s",
				  handle, units, timeout,
				  acpi_format_exception(status)));
	} else {
		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
				  "Acquired semaphore[%p|%d|%d]", handle,
				  units, timeout));
	}

	return status;
}

so it's a glorified down_timeout(). While we have mutex_timeout(). What's 
the plan here?

	Ingo
