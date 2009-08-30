From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Sat, 29 Aug 2009 20:53:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908292048570.26533-100000@netrider.rowland.org>
References: <200908292117.06049.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200908292117.06049.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 29 Aug 2009, Rafael J. Wysocki wrote:

> On Saturday 29 August 2009, Rafael J. Wysocki wrote:
> > On Saturday 29 August 2009, Alan Stern wrote:
> ...
> > > Strictly speaking, a new thread should be started only when needed.  
> > > That is, only when all the existing threads are busy running a 
> > > callback.  It shouldn't be too hard to keep track of when that happens.
> > 
> > The async framework does that for us. :-)
> 
> So, when I said "async threads", I should have rather said "async functions",
> because one async thread can execute multiple functions scheduled with
> async_schedule().
> 
> Taking that into consideration, it all works like this.  When there's a new
> async device to handle and there are no async threads available, a new thread
> is started and it runs the async function that handles the device and
> "opportunistically" searches dpm_list (once) for other device that are ready
> for handling.  After this function has returned, the thread goes to sleep and
> it only exits after being idle for 1 s.  In turn, when there's a new async
> device to handle and there are async threads available, on of them gets the
> async function to run.
> 
> I don't really think we can do much better than this in any other approach.

Since it obviously works and is relatively simple, I guess we ought to 
adopt it.

Alan Stern
