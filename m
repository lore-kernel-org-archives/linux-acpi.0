From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 6)
Date: Wed, 02 Apr 2008 08:38:06 +1100
Message-ID: <1207085886.23143.114.camel@nigel-laptop>
References: <Pine.LNX.4.44L0.0804011653140.9362-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.crca.org.au ([67.207.131.56]:37792 "EHLO crca.org.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760241AbYDAVhl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Apr 2008 17:37:41 -0400
In-Reply-To: <Pine.LNX.4.44L0.0804011653140.9362-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

Hi.

On Tue, 2008-04-01 at 16:56 -0400, Alan Stern wrote:
> On Tue, 1 Apr 2008, Rafael J. Wysocki wrote:
> 
> > > Does ..._ext_... mean extended? (external?) If 'extended' (or if not),
> > > does that imply that they're mutually exclusive alternatives for drivers
> > > to use?
> > 
> > 'ext' means 'extended'.  The idea is that the 'extended' version will be used
> > by bus types / driver types that don't need to implement the _noirq callbacks.
> 
> Something's wrong here.  This seems to say that the "extended" version
> has _fewer_ method pointers -- in which case it should be called 
> "restricted" instead.

Agreed.

> > > So drivers can never validly fail to resume. That sounds fair enough. If
> > > the hardware has gone away while in lower power mode (USB, say), should
> > > the driver then just printk an error and return success?
> > 
> > I think so.
> > 
> > IMO, an error code returned by a driver's ->resume() should mean "the device
> > hasn't resumed and is presumably dead".  Otherwise, ->resume() should return
> > success.
> 
> If the device is gone, it doesn't much matter what resume() returns.

What if the same driver is handling multiple instances and only some of
them fail to resume?

Regards,

Nigel

