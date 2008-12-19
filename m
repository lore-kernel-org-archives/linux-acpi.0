From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2.6.28-rc6] ACPICA: don't cond_resched() when
 irqs_disabled()
Date: Fri, 19 Dec 2008 13:35:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812191325020.3745@localhost.localdomain>
References: <20081126135508.GA1891@localhost>
 <alpine.LFD.2.00.0812190016120.6312@localhost.localdomain>
 <1229670120.3990.11.camel@yakui_zhao.sh.intel.com>
 <alpine.LFD.2.00.0812190326000.6312@localhost.localdomain>
 <20081219135147.GA16488@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:51606 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbYLSSfp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 13:35:45 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KC400H0HZLGSA71@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 12:34:29 -0600 (CST)
In-reply-to: <20081219135147.GA16488@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>




On Fri, 19 Dec 2008, Wu Fengguang wrote:

> On Fri, Dec 19, 2008 at 10:38:18AM +0200, Len Brown wrote:
> > >     The issue on Fengguang's laptop is different with that on the box of
> > > T61.  On Fengguang's laptop after evaluating one ACPI object(GPE
> > > _L18object), the irq is disabled mystically. After some investigations
> > > we find that it is caused by SMI(The SMI will be triggered while
> > > evaluating the ACPI object. And this issue is also related with Video). 
> > 
> > Interesting.
> > I hadn't realized you root-caused that failure.
> > This is good to know, but the fact that SMM can
> > leave interrupts disabled is frightening.
> 
> > If the BIOS SMM on that box disables interrupts when
> > random AML is run, then it is going to run into
> > all kinds of other problems in addition to this one...
> 
> Exactly. This is another warning:
> 
> [ 6559.754331] irq status before SMI: enable
> [ 6559.757388] irq status after SMI: disable, value: 0xF3
> [ 6599.816127] Corrupted low memory at ffff88000000fe08 (fe08 phys) = 01007062
> [ 6599.816253] Corrupted low memory at ffff88000000fe10 (fe10 phys) = 7ba83066
> [ 6599.816376] Corrupted low memory at ffff88000000fe18 (fe18 phys) = 00010062
> [ 6599.816492] Corrupted low memory at ffff88000000fe20 (fe20 phys) = 01006062

I proposed a long term fix for this years ago.
If it had been implemented, this insanity would not be possible.

Every time a BIOS writer uses SMM, they should be rewarded
by having a digit severed.

This is a very simple proposal, very easy to understand.
Further, with "10-strikes and you're out", it comprehends that
there may be some BIOS writerse that take a while to catch on...

However, when they run out of fingers I'd draw the line
and insist that they find a new line of work.

-Len

