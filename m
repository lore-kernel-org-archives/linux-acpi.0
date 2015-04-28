From: Don Zickus <dzickus@redhat.com>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 11:35:21 -0400
Message-ID: <20150428153521.GE98296@redhat.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
 <20150428143009.GA98296@redhat.com>
 <20150428145548.GE19025@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150428145548.GE19025@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-edac <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 28, 2015 at 04:55:48PM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2015 at 10:30:09AM -0400, Don Zickus wrote:
> > On Wed, Apr 01, 2015 at 09:45:53AM +0200, Jiri Kosina wrote:
> > > On Fri, 27 Mar 2015, Borislav Petkov wrote:
> > > 
> > > > From: Jiri Kosina <jkosina@suse.cz>
> > > > 
> > > > Since GHES sources are global, we theoretically need only a single CPU
> > > > reading them per NMI instead of a thundering herd of CPUs waiting on a
> > > > spinlock in NMI context for no reason at all.
> > > 
> > > I originally wasn't 100% sure whether GHES sources are global (i.e. if it 
> > > really doesn't matter which CPU is reading the registers), but looking at 
> > > the code more it actually seems that this is really the right thing to do.
> > > 
> > > Rationale: ghes_ioremap_pfn_nmi() always ioremaps() (exclusively) the page 
> > > with the registers, performs apei_read() (which is ghes-source specific, 
> > > but not CPU-specific) and unmaps the page again.
> > > 
> > > There is nothing that would make this CPU-specific. Adding Huang Ying (the 
> > > original author of the code) to confirm this. Huang?
> > 
> > Hi,
> > 
> > I believe the answer to this question is no, they are not global but
> > instead external.  All external NMIs are routed to one cpu, normally cpu0.
> 
> Actually, the things we're talking about here are not global NMIs but
> global error sources. I.e., the GHES sources which use an NMI to report
> errors with and which we noodle over in ghes_notify_nmi() twice:
> 
> 	list_for_each_entry_rcu(ghes, &ghes_nmi, list) {

Sure, most systems use NMI to report them I believe (at least the ones I
have played with).  Regardless, I have hit performance problems on this lock
while doing perf testing.

I tried to work around it by splitting the NMI list into an
nmi_register(INTERNAL,...) and nmi_register(EXTERNAL,...) to allow perf to
avoid hitting this lock.  But the fallout of that change included missed
NMIs and various solutions from that resulted in complexities that blocked
inclusion last year.

Your solution seems much simpler. :-)

> 		...
> 
> > This spinlock was made global to handle the 'someday' case of hotplugging
> > the bsp cpu (cpu0).
> > 
> > The other external NMIs (IO_CHECK and SERR) suffer from the same spinlock
> > problem.  I tried using an irq_workqueue to work around quirks there and
> > PeterZ wasn't very fond of it (though he couldn't think of a better way to
> > solve it).
> > 
> > This patch seems interesting but you might still run into the thundering
> > herd problem with the global spinlock in
> > arch/x86/kernel/nmi.c::default_do_nmi().  That functions grabs a global
> > spinlock before processing the external NMI list (which GHES is a part of).
> 
> nmi_reason_lock? And our handler is registered with
> register_nmi_handler() and so we iterate over it in nmi_handle(). It'd
> be interesting to know what NMI reason we get for those GHES NMIs so
> that we know whether nmi_handle() is called under the lock or not...

I followed up in another email stating I mis-spoke.  I forgot this still
uses the NMI_LOCAL shared NMI.  So every perf NMI, will also call the GHES
handler to make sure NMIs did not piggy back each other.  So I don't believe
the NMI reason lock is called a majority of the time (except when the NMI is
swallowed, but that is under heavy perf load...).


> 
> > So I am assuming this patch solves the 'thundering herd' problem by
> > minimizing all the useless writes the spinlock would do for each cpu that
> > noticed it had no work to do?
> 
> Not that spinlock. It used to take another one in ghes_notify_nmi().
> Removing it solved the issue. There were even boxes which would do:
> 
> [   24.332560] INFO: NMI handler (ghes_notify_nmi) took too long to run: 3.265 msecs
> [   24.332567] INFO: NMI handler (ghes_notify_nmi) took too long to run: 5.946 msecs
> [   24.332568] INFO: NMI handler (ghes_notify_nmi) took too long to run: 5.948 msecs
> 
> just like that during boot.
> 
> It was basically a lot of purely useless lock grabbing for no reason
> whatsoever.

Yes, I meant the 'raw_spin_lock(&ghes_nmi_lock);' one.  I poorly typed my
email and confused you into thinking I was referring to the wrong one.

Well, it isn't exactly no reason, but more along the lines of 'we do not
know who gets the external NMI, so everyone tries to talk with the GHES
firmware'.  But I think that is just me squabbling.

We both agree the mechanics of the spinlock are overkill here and cause much
cache contention.  Simplifying it to just 'reads' and return removes most of
the problem.

Cheers,
Don
