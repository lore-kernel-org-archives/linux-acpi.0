From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Sun, 30 Aug 2009 15:15:11 +0200
Message-ID: <200908301515.11525.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908292043500.26533-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48788 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543AbZH3NOR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Aug 2009 09:14:17 -0400
In-Reply-To: <Pine.LNX.4.44L0.0908292043500.26533-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>

On Sunday 30 August 2009, Alan Stern wrote:
> On Sat, 29 Aug 2009, Rafael J. Wysocki wrote:
> 
> > I only wanted to say that the advantage is not really that "big". :-)
> > 
> > > I must agree, 14 threads isn't a lot.  But at the moment that number is 
> > > random, not under your control.
> > 
> > It's not directly controlled, but there are some interactions between the
> > async threads, the main threads and the async framework that don't allow this
> > number to grow too much.
> > 
> > IMO it sometimes is better to allow things to work themselves out, as long as
> > they don't explode, than to try to keep everything under strict control.  YMMV.
> 
> For testing purposes it would be nice to have a one-line summary for
> each device containing a thread ID, start timestamp, end timestamp, and
> elapsed time.  With that information you could evaluate the amount of
> parallelism and determine where the bottlenecks are.  It would give a
> much more detailed picture of the entire process than the total time of
> your recent patch 9.

Of course it would.  I think I'll implement it.

The purpose of patch 9 is basically to allow one to see how much time is
spent on the handling of devices overall and to compare that with the time
spent on the other operation during suspend-resume.

Thanks,
Rafael
