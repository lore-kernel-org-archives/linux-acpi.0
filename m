From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 6)
Date: Tue, 1 Apr 2008 10:31:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804011029010.3993-100000@iolanthe.rowland.org>
References: <1207038460.10388.214.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41617 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755169AbYDAObp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Apr 2008 10:31:45 -0400
In-Reply-To: <1207038460.10388.214.camel@pasglop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>

On Tue, 1 Apr 2008, Benjamin Herrenschmidt wrote:

> On Tue, 2008-04-01 at 19:15 +1100, Nigel Cunningham wrote:
> > > + *   However, drivers may NOT assume anything about the availability of the
> > > + *   user space at that time and it is not correct to request firmware from
> > > + *   within @prepare() (it's too late to do that).
> > 
> > That doesn't sound good. It would be good to be able to get drivers to
> > request firmware early in the process.
> 
> Agreed. Prepare() should still allow request_firmware and full userspace
> communication / helper usage.

Pepare() is called after userspace has been frozen.  (Of course, once 
the freezer goes away this won't matter any more.)

There is a separate notifier chain which drivers can subscribe to;
notifications about impending sleeps are sent out while userspace is
still alive.  Drivers can use that for request_firmware, memory
allocation, and other things.

Alan Stern

