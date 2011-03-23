From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/7] ACPI, APEI patches for 2.6.39
Date: Wed, 23 Mar 2011 00:16:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103230013260.10549@x980>
References: <1298267685-7357-1-git-send-email-ying.huang@intel.com>
 <alpine.LFD.2.02.1103021750250.12344@x980>
 <20110303000112.GG32215@one.firstfloor.org>
 <1300762892.3616.12.camel@yhuang-mobile.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:57010 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1CWEQa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 00:16:30 -0400
In-reply-to: <1300762892.3616.12.camel@yhuang-mobile.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>

> > > > [PATCH 1/7] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
> > > > [PATCH 2/7] lib, Add lock-less NULL terminated single list

> > > > [PATCH 3/7] ACPI, APEI, Add ERST record ID cache
> > > > [PATCH 4/7] PCIe, AER, use pre-generated prefix in error information printing
> > > > [PATCH 5/7] ACPI, APEI, Add PCIe AER error information printing support

I'll submit just 3,4,5/7 for upstream w/ the ACPI tree.
I'd like to see andrew take 1,2,6 (which now need to be refreshed)
in mm and when they ship, that will enable 7/7, which is the reason
that they exist.

thanks,
-Len

> > > > [PATCH 6/7] lib, Make gen_pool memory allocator lockless
> > > > [PATCH 7/7] ACPI, APEI, GHES, printk support for recoverable error via NMI
> > > 
> > > I've put this series into acpi-test, so it will be visible in linux-next;
> > > but I'm not the right person to review the generic lockless stuff,
> > > who is?
> > 
> > I reviewed it earlier and it seemed good to me (unless it has 
> > changed), but Linus wanted non Intel reviewers too. Any takers?
> 
> As for
> 
> [PATCH 1/7] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
> [PATCH 2/7] lib, Add lock-less NULL terminated single list
> [PATCH 6/7] lib, Make gen_pool memory allocator lockless
> 
> they are general kernel patches.  I remember you have reviewed some
> earlier version of these patches, and merged 1/2 into -mm tree.  Do you
> have time to review these patches?  Although Andi has reviewed them, we
> really need some non-Intel reviewers.
> 
> Thanks,
> Huang Ying
> b
> 
