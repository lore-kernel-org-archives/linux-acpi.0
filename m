From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Sun, 14 Jun 2009 00:04:41 +0200
Message-ID: <200906140004.42223.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0906131404160.25619-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34888 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbZFMWEf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Jun 2009 18:04:35 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906131404160.25619-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Saturday 13 June 2009, Alan Stern wrote:
> On Sat, 13 Jun 2009, Rafael J. Wysocki wrote:
> 
> > So, the conclusion seems to be that we should break the recurrence
> > at the point we find an already active device or a device with no parent and
> > let the driver(s) handle the more complicated cases.  Is this correct?
> 
> That's right.

OK

> > BTW, is __device_release_driver() the right place for blocking the run-time PM
> > temporarily during remove?
> 
> It is.

OK

> And for submitting a delayed autosuspend request afterward; we
> may as well try to suspend devices that don't have drivers.

OK, but I'd like to add this functionality if future, when at least one bus
type starts using the framework.

I think I have all of the ducks in a row now, so I'm going to post a cleaned-up
patch in a new thread in a while.

Thanks,
Rafael
