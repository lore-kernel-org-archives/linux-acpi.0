From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: acpi_os_queue_for_execution()
Date: Sat, 28 Dec 2002 15:27:16 -0500
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021228202716.GA28570@gtf.org>
References: <20021223181747.GA10363@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021223181747.GA10363-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 23, 2002 at 07:17:48PM +0100, Pavel Machek wrote:
> Hi!
> 
> Acpi seems to create short-lived kernel threads, and I don't quite
> understand why. 
> 
> In thermal.c
> 
> 
>                         tz->timer.data = (unsigned long) tz;
>                         tz->timer.function = acpi_thermal_run;
>                         tz->timer.expires = jiffies + (HZ * sleep_time) / 1000;
>                         add_timer(&(tz->timer));
> 
> and acpi_thermal_run creates kernel therad that runs
> acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> don't like idea of thread being created every time thermal zone needs
> to be polled...

This is the standard way to get process context [i.e. somewhere where
you can sleep].  The new delayed-work workqueue code in 2.5.x does
something almost exactly like that under the covers.

That said, it sounds like you found something to fix in ACPI:

In 2.4.x ACPI, it should be using schedule_task(), and in 2.5.x it should
be using schedule_work(), if this is truly the intention of the ACPI
subsystem.

There shouldn't be much reason to continually spawn single-run threads
when there is already an API for doing so.

	Jeff
