From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Wed, 02 Apr 2008 06:34:27 +1100
Message-ID: <1207078467.23143.96.camel@nigel-laptop>
References: <Pine.LNX.4.44L0.0804011029010.3993-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.crca.org.au ([67.207.131.56]:49013 "EHLO crca.org.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758648AbYDATeD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Apr 2008 15:34:03 -0400
In-Reply-To: <Pine.LNX.4.44L0.0804011029010.3993-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>

Hi.

On Tue, 2008-04-01 at 10:31 -0400, Alan Stern wrote:
> On Tue, 1 Apr 2008, Benjamin Herrenschmidt wrote:
> 
> > On Tue, 2008-04-01 at 19:15 +1100, Nigel Cunningham wrote:
> > > > + *   However, drivers may NOT assume anything about the availability of the
> > > > + *   user space at that time and it is not correct to request firmware from
> > > > + *   within @prepare() (it's too late to do that).
> > > 
> > > That doesn't sound good. It would be good to be able to get drivers to
> > > request firmware early in the process.
> > 
> > Agreed. Prepare() should still allow request_firmware and full userspace
> > communication / helper usage.
> 
> Pepare() is called after userspace has been frozen.  (Of course, once 
> the freezer goes away this won't matter any more.)
> 
> There is a separate notifier chain which drivers can subscribe to;
> notifications about impending sleeps are sent out while userspace is
> still alive.  Drivers can use that for request_firmware, memory
> allocation, and other things.

Then that should be mentioned here so that drivers authors can know that
it is possible to request firmware, allocate memory and so on at a stage
when you can still rely on userspace being alive.

Regards,

Nigel

