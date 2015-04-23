From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Thu, 23 Apr 2015 10:39:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504231038470.3695@pobox.suse.cz>
References: <1427448178-20689-1-git-send-email-bp@alien8.de> <1427448178-20689-6-git-send-email-bp@alien8.de> <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz> <20150401134913.GB18523@pd.tnic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41052 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756497AbbDWIkD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2015 04:40:03 -0400
In-Reply-To: <20150401134913.GB18523@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: linux-edac <linux-edac@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Lv Zheng <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>

On Wed, 1 Apr 2015, Borislav Petkov wrote:

> > > From: Jiri Kosina <jkosina@suse.cz>
> > > 
> > > Since GHES sources are global, we theoretically need only a single CPU
> > > reading them per NMI instead of a thundering herd of CPUs waiting on a
> > > spinlock in NMI context for no reason at all.
> > 
> > I originally wasn't 100% sure whether GHES sources are global (i.e. if it 
> > really doesn't matter which CPU is reading the registers), but looking at 
> > the code more it actually seems that this is really the right thing to do.
> > 
> > Rationale: ghes_ioremap_pfn_nmi() always ioremaps() (exclusively) the page 
> > with the registers, performs apei_read() (which is ghes-source specific, 
> > but not CPU-specific) and unmaps the page again.
> > 
> > There is nothing that would make this CPU-specific. Adding Huang Ying (the 
> > original author of the code) to confirm this. Huang?
> > 
> > > Do that.
> > 
> > I think this should indeed be pushed forward. It fixes horrible spinlock 
> > contention on systems which are under NMI storm (such as when perf is 
> > active) unrelated to GHES.
> 
> Right, so I tested injecting an error without your patch and same
> behavior. So it all points at global sources AFAICT. It would be cool,
> though, if someone who knows the fw confirms unambiguously.

Three weeks have passed, therefore I find this an appropriate time for a 
friendly ping :)

Rafael? Naoya? Huang?

This fixes a contention spinlock problem in NMI observed on a real HW, so 
it would be really nice to have it fixed.

Thanks,

-- 
Jiri Kosina
SUSE Labs
