From: Ingo Oeser <ingo.oeser-jNDFPZUTrfQ+B2oLq8eQJv4efur1V5z/s0AfqQuZ5sE@public.gmane.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Date: Sun, 5 Jan 2003 13:23:54 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030105132354.G628@nightmaster.csn.tu-chemnitz.de>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A107-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>; from andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Fri, Jan 03, 2003 at 11:00:04AM -0800
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andrew,

On Fri, Jan 03, 2003 at 11:00:04AM -0800, Grover, Andrew wrote:
> > From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
> > Acpi seems to create short-lived kernel threads, and I don't quite
> > understand why. 
[...]
> > and acpi_thermal_run creates kernel therad that runs
> > acpi_thermal_check. Why is not acpi_thermal_check called directly? I
> > don't like idea of thread being created every time thermal zone needs
> > to be polled...
> 
> Are we allowed to block in a timer callback? One of the things
> thermal_check does is call a control method, which in turn can be very
> slow, sleep, etc., so I'd guess that's why the code tries to execute
> things in its own thread.

No you just have to switch completely to schedule_work() as you
do for calls from interrupts. The limitations you mention in
osl.c for this function are lifted (look at linux/kernel/workqueue.c) and
we have per CPU workqueues now.

So no need for this uglification and less code to maintain for
you ;-)

The short lived threads are not necessary anymore. If this
thermal check will happen often an extra permanent thread for
this, which is kicked by a timer might be more apropriate here.

That thread could be started, once the thermal control is loaded.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
