From: Don Zickus <dzickus@redhat.com>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 14:44:28 -0400
Message-ID: <20150428184428.GF98296@redhat.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
 <20150428143009.GA98296@redhat.com>
 <20150428145548.GE19025@pd.tnic>
 <20150428153521.GE98296@redhat.com>
 <20150428162229.GH19025@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59801 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030524AbbD1So7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 14:44:59 -0400
Content-Disposition: inline
In-Reply-To: <20150428162229.GH19025@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-edac <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>

On Tue, Apr 28, 2015 at 06:22:29PM +0200, Borislav Petkov wrote:
> On Tue, Apr 28, 2015 at 11:35:21AM -0400, Don Zickus wrote:
> > Your solution seems much simpler. :-)
> 
> ... and I love simpler :-)
> 
> > I followed up in another email stating I mis-spoke.  I forgot this still
> > uses the NMI_LOCAL shared NMI.  So every perf NMI, will also call the GHES
> > handler to make sure NMIs did not piggy back each other.  So I don't believe
> 
> And this is something we should really fix - perf and RAS should
> not have anything to do with each other. But I don't know the NMI
> code to even have an idea how. I don't even know whether we can
> differentiate NMIs, hell, I can't imagine the hardware giving us a
> different NMI reason through get_nmi_reason(). Maybe that byte returned
> from NMI_REASON_PORT is too small and hangs on too much legacy crap to
> even be usable. Questions over questions...

:-)  Well, let me first clear up some of your questions. 

RAS doesn't go through the legacy ports (ie get_nmi_reason()).  Instead it
triggers the external NMI through a different bit (ioapic I think).

The nmi code has no idea what io_remap'ed address apei is using to map its
error handling register that GHES uses.  Unlike the legacy port which is
always port 0x61.

So, with NMI being basically a shared interrupt, with no ability to discern
who sent the interrupt (and even worse no ability to know how _many_ were sent as
the NMI is edge triggered instead of level triggered).  As a result we rely
on the NMI handlers to talk to their address space/registers to determine if
they were they source of the interrupt.

Now I can agree that perf and RAS have nothing to do with each other, but
they both use NMI to interrupt.  Perf is fortunate enough to be internal to
each cpu and therefore needs no global lock unlike GHES (hence part of the
problem).

The only way to determine who sent the NMI is to have each handler read its
register, which is time consuming for GHES.

Of course, we could go back to playing tricks knowing that external NMIs
like GHES and IO_CHECK/SERR are only routed to one cpu (cpu0 mainly) and
optimize things that way, but that inhibits the bsp cpu hotplugging folks.



I also played tricks like last year's patchset that split out the
nmi_handlers into LOCAL and EXTERNAL queues.  Perf would be part of the
LOCAL queue while GHES was part of the EXTERNAL queue.  The thought was to
never touch the EXTERNAL queue if perf claimed an NMI.  This lead to all
sorts of missed external NMIs, so it didn't work out.


Anyway, any ideas or thoughts for improvement are always welcomed. :-) 


Cheers,
Don

> 
> > the NMI reason lock is called a majority of the time (except when the NMI is
> > swallowed, but that is under heavy perf load...).
> 
> ..
> 
> > We both agree the mechanics of the spinlock are overkill here and cause much
> > cache contention.  Simplifying it to just 'reads' and return removes most of
> > the problem.
> 
> Right.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> ECO tip #101: Trim your mails when you reply.
> --
