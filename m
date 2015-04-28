From: Don Zickus <dzickus@redhat.com>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 10:30:09 -0400
Message-ID: <20150428143009.GA98296@redhat.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33827 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965713AbbD1OaM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 10:30:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>, linux-edac <linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>

On Wed, Apr 01, 2015 at 09:45:53AM +0200, Jiri Kosina wrote:
> On Fri, 27 Mar 2015, Borislav Petkov wrote:
> 
> > From: Jiri Kosina <jkosina@suse.cz>
> > 
> > Since GHES sources are global, we theoretically need only a single CPU
> > reading them per NMI instead of a thundering herd of CPUs waiting on a
> > spinlock in NMI context for no reason at all.
> 
> I originally wasn't 100% sure whether GHES sources are global (i.e. if it 
> really doesn't matter which CPU is reading the registers), but looking at 
> the code more it actually seems that this is really the right thing to do.
> 
> Rationale: ghes_ioremap_pfn_nmi() always ioremaps() (exclusively) the page 
> with the registers, performs apei_read() (which is ghes-source specific, 
> but not CPU-specific) and unmaps the page again.
> 
> There is nothing that would make this CPU-specific. Adding Huang Ying (the 
> original author of the code) to confirm this. Huang?

Hi,

I believe the answer to this question is no, they are not global but
instead external.  All external NMIs are routed to one cpu, normally cpu0.
This spinlock was made global to handle the 'someday' case of hotplugging
the bsp cpu (cpu0).

The other external NMIs (IO_CHECK and SERR) suffer from the same spinlock
problem.  I tried using an irq_workqueue to work around quirks there and
PeterZ wasn't very fond of it (though he couldn't think of a better way to
solve it).

This patch seems interesting but you might still run into the thundering
herd problem with the global spinlock in
arch/x86/kernel/nmi.c::default_do_nmi().  That functions grabs a global
spinlock before processing the external NMI list (which GHES is a part of).


So I am assuming this patch solves the 'thundering herd' problem by
minimizing all the useless writes the spinlock would do for each cpu that
noticed it had no work to do?

In that case, I am in favor of this solution and would like to apply a
similar solution to arch/x86/kernel/nmi.c, to see if that helps there too.

Cheers,
Don


> 
> > Do that.
> 
> I think this should indeed be pushed forward. It fixes horrible spinlock 
> contention on systems which are under NMI storm (such as when perf is 
> active) unrelated to GHES.
> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
