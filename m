From: Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Date: Mon, 06 Jan 2003 03:44:23 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3E196C17.7D318CAF@digeo.com>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

"Grover, Andrew" wrote:
> 
> > From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]
> > Acpi seems to create short-lived kernel threads, and I don't quite
> > understand why.
> >
> > In thermal.c
> >
> >
> >                         tz->timer.data = (unsigned long) tz;
> >                         tz->timer.function = acpi_thermal_run;
> >                         tz->timer.expires = jiffies + (HZ *
> > sleep_time) / 1000;
> >                         add_timer(&(tz->timer));
> >
> > and acpi_thermal_run creates kernel therad that runs
> > acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> > don't like idea of thread being created every time thermal zone needs
> > to be polled...
> 
> Are we allowed to block in a timer callback? One of the things
> thermal_check does is call a control method, which in turn can be very
> slow, sleep, etc., so I'd guess that's why the code tries to execute
> things in its own thread.
> 

acpi_thermal_run is doing many sinful things.  Blocking memory
allocations as well as launching kernel threads from within a
timer handler.

Converting it to use schedule_work() or schedule_delayed_work()
would fix that up.
