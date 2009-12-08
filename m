From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Tue, 8 Dec 2009 13:13:32 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912081309370.3560@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912081508220.3046-100000@iolanthe.rowland.org> <alpine.LFD.2.00.0912081304070.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60079 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965936AbZLHVNu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 16:13:50 -0500
In-Reply-To: <alpine.LFD.2.00.0912081304070.3560@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Tue, 8 Dec 2009, Linus Torvalds wrote:
> On Tue, 8 Dec 2009, Alan Stern wrote:
> > 
> > That's not the way it should be done.  Linus had children taking their
> > parents' locks during suspend, which is simple but leads to
> > difficulties.
> 
> No it doesn't. Name them.

Really. 

Let me put this simply: I've told you guys how to do it simply, with 
_zero_ crap. No "iterating over children". No games. No data structures. 
No new infrastructure. Just a single new rwlock per device, and _trivial_ 
code.

So here's the challenge: try it my simple way first. I've quoted the code 
about five million times already. If you _actually_ see some problems, 
explain them. Don't make up stupid "iterate over each child" things. Don't 
claim totally made-up "leads to difficulties". Don't make it any more 
complicated than it needs to be.

Keep it simple. And once you have tried that simple approach, and you 
really can show why it doesn't work, THEN you can try something else.

But before you try the simple approach and explain why it wouldn't work, I 
simply will not pull anything more complex. Understood and agreed?

			Linus
