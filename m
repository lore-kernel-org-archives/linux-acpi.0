From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 13:17:02 -0800
Message-ID: <20091206131702.7d6cdc57@infradead.org>
References: <20091206113555.5a646713@infradead.org>
	<Pine.LNX.4.44L0.0912061534120.7903-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50120 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934195AbZLFVOt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2009 16:14:49 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912061534120.7903-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun, 6 Dec 2009 15:36:40 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Sun, 6 Dec 2009, Arjan van de Ven wrote:
> 
> > btw I instrumented both the suspend and resume, and made graphs out
> > of it for my laptop (modern laptop with Intel cpu/wifi/graphics of
> > course).
> > 
> > http://www.fenrus.org/graphs/suspend.svg
> > http://www.fenrus.org/graphs/resume.svg
> > 
> > (also attached for convenience)
> > 
> > the resume clearly shows that all this talking about PCI stuff is
> > completely without practical merit.. it's the USB stuff where the
> > time is spent.
> 
> Arjan, can you try testing the USB timings again with the patch below 
> (for vanilla 2.6.32)?
> 
> Fair warning: I just composed this and haven't tried it out myself.

unfortunately it does not make a difference that I can notice in the
graphs.

http://www.fenrus.org/graphs/resume2.svg

the resume problem seems to be that we resume all the hubs sequentially,
much like we used to discover them sequentially during boot....

I do not know how much I'm asking for, but would it be sensible to do a
similar thing for hub resume as we did for boot? eg start resuming them
all at the same time, so that the mandatory delays of these hubs will
overlap ?



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
