From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 1 Jul 2008 09:45:47 +0200
Message-ID: <20080701074547.GA16262@elte.hu>
References: <200807010148.02135.rjw@sisk.pl> <20080701072024.GB26601@elte.hu> <20080701002856.2457a75d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:35391 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbYGAHqM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jul 2008 03:46:12 -0400
Content-Disposition: inline
In-Reply-To: <20080701002856.2457a75d.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel-testers@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 1 Jul 2008 09:20:24 +0200 Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > Hi,
> > > 
> > > The appended patch fixes a regression and is considered as 2.6.26 
> > > material. Everyone having a box with working suspend to RAM is gently 
> > > requested to test it and verify if it doesn't break things.
> > > 
> > > The patch applies to the current -git.
> > 
> > The fix is _really_ tempting, but i think it's 2.6.26.1 material at the 
> > earliest. I just counted about 8 red flag items in that commit:
> > 
> >   - "assembly code"
> >   - "fresh change"
> >   - "suspend/resume"
> >   - "real-mode code"
> >   - "ACPI"
> >   - "SMM"
> >   - "CPU erratas"
> >   - "boot code"
> > 
> > I'd say it's probably 90% fine, but it's just too much risk at this 
> > stage i think. The regression was only found 2 weeks ago, and the commit 
> > that broke it was upstream for 2 months (and was under testing for about 
> > 4 months).
> 
> Merge it into 2.6.27-rc1 and add Cc: <stable@kernel.org> to the changelog with
> a note "needed in 2.6.26.x after a couple of weeks testing in mainline" or
> something like that.

ok.

> I expect 2.6.25.x will be maintained for a while yet too...

2.6.25.x is not affected by the suspend+resume aspect of this problem.

	Ingo
