From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Fri, 28 Aug 2009 15:59:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908281548140.2865-100000@iolanthe.rowland.org>
References: <200908282138.14602.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200908282138.14602.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 28 Aug 2009, Rafael J. Wysocki wrote:

> > Given this design, why bother to invoke device_resume() for the async 
> > devices?  Why not just start up a bunch of async threads, each of which 
> > calls async_resume() repeatedly until everything is finished?  (And 
> > rearrange async_resume() to scan the list first and do the actual 
> > resume second.)
> > 
> > The same goes for the noirq versions.
> 
> I thought about that, but there are a few things to figure out:
> - how many threads to start

That's a tough question.  Right now you start roughly as many threads
as there are async devices.  That seems like overkill.

I would expect that a reasonably small number of threads would suffice 
to achieve most of the possible time savings.  Something on the order 
of 10 should work well.  If the majority of the time is spent 
handling N devices then N+1 threads would be enough.  Judging from some 
of the comments posted earlier, even 4 threads would give a big 
advantage.

> - when to start them

You might as well start them at the beginning of dpm_resume and 
dpm_resume_noirq.  That way they can overlap with the synchronous 
operations.

> - stop condition

When an error occurs or when op_started has been set for every 
remaining async device.

> I had a few ideas, but then I thought it would be simpler to start an async
> thread when we know there's some async work to do (ie. there's an async
> device to handle) and make each async thread browse the list just once (the
> rationale is that we've just handled a device, so there's a chance there are
> some devices with satisfied dependencies down the list).

It comes down to this: Should there be many threads, each of which 
browses the list only once, or should there be a few threads, each of 
which browses the list many times?

Alan Stern
