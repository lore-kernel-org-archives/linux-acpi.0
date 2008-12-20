From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when
	irqs_disabled()
Date: Sat, 20 Dec 2008 08:34:43 +0800
Message-ID: <20081220003443.GC5928@localhost>
References: <20081126135508.GA1891@localhost> <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain> <1229670120.3990.11.camel@yakui_zhao.sh.intel.com> <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain> <20081219135147.GA16488@localhost> <alpine.LFD.2.00.0812191325020.3745@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:49920 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbYLTAj5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 19:39:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812191325020.3745@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Sitsofe Wheeler <sitsofe@yahoo.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "stable@kernel.org" <stable@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>

On Fri, Dec 19, 2008 at 08:35:41PM +0200, Len Brown wrote:
> 
> 
> 
> On Fri, 19 Dec 2008, Wu Fengguang wrote:
> 
> > On Fri, Dec 19, 2008 at 10:38:18AM +0200, Len Brown wrote:
> > > >     The issue on Fengguang's laptop is different with that on the box of
> > > > T61.  On Fengguang's laptop after evaluating one ACPI object(GPE
> > > > _L18object), the irq is disabled mystically. After some investigations
> > > > we find that it is caused by SMI(The SMI will be triggered while
> > > > evaluating the ACPI object. And this issue is also related with Video). 
> > > 
> > > Interesting.
> > > I hadn't realized you root-caused that failure.
> > > This is good to know, but the fact that SMM can
> > > leave interrupts disabled is frightening.
> > 
> > > If the BIOS SMM on that box disables interrupts when
> > > random AML is run, then it is going to run into
> > > all kinds of other problems in addition to this one...
> > 
> > Exactly. This is another warning:
> > 
> > [ 6559.754331] irq status before SMI: enable
> > [ 6559.757388] irq status after SMI: disable, value: 0xF3
> > [ 6599.816127] Corrupted low memory at ffff88000000fe08 (fe08 phys) = 01007062
> > [ 6599.816253] Corrupted low memory at ffff88000000fe10 (fe10 phys) = 7ba83066
> > [ 6599.816376] Corrupted low memory at ffff88000000fe18 (fe18 phys) = 00010062
> > [ 6599.816492] Corrupted low memory at ffff88000000fe20 (fe20 phys) = 01006062
> 
> I proposed a long term fix for this years ago.
> If it had been implemented, this insanity would not be possible.
> 
> Every time a BIOS writer uses SMM, they should be rewarded
> by having a digit severed.
> 
> This is a very simple proposal, very easy to understand.
> Further, with "10-strikes and you're out", it comprehends that
> there may be some BIOS writerse that take a while to catch on...
> 
> However, when they run out of fingers I'd draw the line
> and insist that they find a new line of work.

I'm not sure I understand your scheme.  But what if the first
10-strikes already makes system unstable?

OpRegion seeks to replace SMI, however it may take time.
