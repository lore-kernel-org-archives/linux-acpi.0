From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Sun, 30 Aug 2009 15:09:50 +0200
Message-ID: <200908301509.50855.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908282146550.9540-100000@netrider.rowland.org> <200908291449.57667.rjw@sisk.pl> <20090830064533.GA1417@ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090830064533.GA1417@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 30 August 2009, Pavel Machek wrote:
> Hi!
> 
> > > > > > > The same goes for the noirq versions.
> > > > > > 
> > > > > > I thought about that, but there are a few things to figure out:
> > > > > > - how many threads to start
> > > > > 
> > > > > That's a tough question.  Right now you start roughly as many threads
> > > > > as there are async devices.  That seems like overkill.
> > > > 
> > > > In fact they are substantially fewer than that, for the following reasons.
> > > > 
> > > > First, the async framework will not start more than MAX_THREADS threads,
> > > > which is 256 at the moment.  This number is less than the number of async
> > > > devices to handle on an average system.
> > > 
> > > Okay, but MAX_THREADS isn't under your control.  Remember also that 
> > > each thread takes up some memory, and during hibernation we are in a 
> > > memory-constrained situation.
> > 
> > We keep some extra free memory for things like this.  It's not likely to be
> > exhausted by the async threads alone.
> 
> What extra memory? You are creating quite a lot of threads. For 256 of
> them, it would take cca 2MB...

We never start that many threads and even if there's not enough memory to
start a new thread, the async framework will handle that for us.

> You recently removed code from s2disk that freed 4MB of extra memory,

That was removed from s2ram.  For STD we still have PAGES_FOR_IO and
SPARE_PAGES, nothing's changed there.

Thanks,
Rafael
