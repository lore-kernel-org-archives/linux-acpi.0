From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Wed, 10 Jun 2009 01:02:21 +0200
Message-ID: <200906100102.22307.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0906081626120.13888-100000@netrider.rowland.org> <200906082331.58933.rjw@sisk.pl> <200906090931.37626.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44014 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbZFIXJS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2009 19:09:18 -0400
In-Reply-To: <200906090931.37626.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday 09 June 2009, Oliver Neukum wrote:
> Am Montag, 8. Juni 2009 23:31:58 schrieb Rafael J. Wysocki:
> > If ->autosuspend() fails, the device power state may be known, but the core
> > can't be sure if the device is active.  This information is available to
> > the driver and/or the bus type, which should change the status to whatever
> > is appropriate.
> 
> That is quite confusing. You'd better define error returns.

That might work too, but the information need not be available to the driver
immediately.  It may need to schedule a reset of the device to recover from
the error condition, for example.

> One that would mean that the suspension has failed but the device is
> unaffected, and another one that means that the device is in an
> undefined state now.
>
> > > The scheme doesn't include any mechanism for communicating runtime
> > > power information up the device tree.  When a device is autosuspended,
> > > its parent's driver should be told so that the driver can consider
> > > autosuspending the parent.
> >
> > I thought the bus type's ->autosuspend() callback could take care of this.
> 
> That can't work because you have to operate between busses.

OK, point taken.

> > > Likewise, if we want to autoresume a device below an autosuspended
> > > parent, the parent should be autoresumed first.  Did you want to make the
> > > bus subsystem responsible for all of this?
> >
> > Yes, that was the idea.
> 
> That is an important point. Can some subsytems operate with a parent still
> suspended?

OK, I see the value of doing that at the core level.

I tried to address this in the new version of the patch, which has been sent
in my last reply to Alan.

Thanks,
Rafael

