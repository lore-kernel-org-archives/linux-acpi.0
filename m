From: Greg KH <gregkh@suse.de>
Subject: Re: acpi_cpu_freq_init warning...
Date: Tue, 6 May 2008 14:38:01 -0700
Message-ID: <20080506213801.GA26345@suse.de>
References: <86802c440805051951u153ebc21p15f0d73904496217@mail.gmail.com> <87k5i8hrmk.fsf@duaron.myhome.or.jp> <alpine.LFD.1.10.0805060741290.32269@woody.linux-foundation.org> <87skwvcl2a.fsf@duaron.myhome.or.jp> <20080506202033.GA3114@suse.de> <alpine.LFD.1.10.0805061325270.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36009 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995AbYEFVi1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 May 2008 17:38:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805061325270.32269@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Tue, May 06, 2008 at 01:27:37PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 6 May 2008, Greg KH wrote:
> 
> > On Wed, May 07, 2008 at 04:02:53AM +0900, OGAWA Hirofumi wrote:
> > > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > 
> > > > On Tue, 6 May 2008, OGAWA Hirofumi wrote:
> > > >> -	if ((drv->entry.next != drv->entry.prev) ||
> > > >> +	if ((drv->entry.next != drv->entry.prev) &&
> > > >>  	    (drv->entry.next != NULL)) {
> > > >
> > > > Umm. That code still makes no sense.
> > > >
> > > > The "drv->entry.next == drv->entry.prev" condition will trigger under 
> > > > *three* different circumstances:
> > > >
> > > >  - next/prev == NULL (uninitialized). Checked for by the explicit check 
> > > >    against NULL.
> > > >
> > > >  - list empty (both next/prev point back to itself), which I assume the 
> > > >    check was *meant* for.
> > > >
> > > >  - list has only *one* entry, when next/prev both point to the list head.
> > > >
> > > > and I'm pretty damn sure that whoever wrote that code didn't mean that 
> > > > last one, but who knows..
> > > >
> > > > The fact is, looking at next/prev this way is a sure way to have bugs.
> > > >
> > > > What is that PoS *trying* to test for? I assume it is meant to test for
> > > >
> > > > 	/* Is the list initialized and non-empty? */
> > > > 	if (drv->entry.next && !list_empty(&drv->entry)) {
> > > > 		...
> > > >
> > > > and dammit, just doing it that way is shorter and simpler.
> > 
> > But I don't think that will work as others have pointed out, this
> > structure's list field isn't initialized yet.
> 
> Umm. And what do you think the test for drv->entry.next is there for?

Doh, nevermind, I don't know what I was thinking, this should be fine.

I think I need a nap...

greg k-h
