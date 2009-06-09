From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Tue, 9 Jun 2009 09:25:18 +0200
Message-ID: <200906090925.18866.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org> <200906081404.04118.oliver@neukum.org> <200906082034.31091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:42977 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbZFIHYc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 03:24:32 -0400
In-Reply-To: <200906082034.31091.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Montag, 8. Juni 2009 20:34:30 schrieb Rafael J. Wysocki:
> On Monday 08 June 2009, Oliver Neukum wrote:
> > Am Montag, 8. Juni 2009 13:29:26 schrieb Rafael J. Wysocki:

> > Secondly, you are not using a counter. Therefore only one driver can
> > control the PM state of a device at a given time. Is that wise?
>
> I didn't think about it to be honest.  Obviously this patch doesn't cover
> all of the possible cases and I'm not even sure it's worth trying to cover
> them upfront.

I am thinking of multimedia cards, which have separate drivers for i2c, tuner
and so on.

> > Why is this needed?
>
> In some subsystems, like PCI, devices will be resumed by the BIOS
> unconditionally in the majority of cases and then it's not worth trying to
> complete run-time PM requests from before the suspend.

But why is it worth canceling them? That feature seems to be an unnecessary
complication. As long as you can safely suspend them, why not do it?

> > > +/**
> > > + * __pm_schedule_resume - Schedule run-time resume of given device.
> > > + * @dev: Device to resume.
> > > + * @autocancel: If set, the request will be cancelled during a resume from a 
> > > + *	system-wide sleep state if it happens before pm_autoresume() can be run.
> > > + */
> >
> > Eeek! This is a bad idea. You never want to a resume to be cancelled.
>
> Sometimes I do (see above).

Well no. A driver requests a resume because it has to.
This needs a defined call sequence.

Do you guarantee that autoresume follows autosuspend or not?
If not what sequences can happen? Obviously an autosuspended device
can be unplugged.
But the problem here is STR or STD. How do you notify drivers that the BIOS
has resumed their device instead of autoresume() being called? A driver
has to know that its device has become active without its knowledge.

> > > +		cancel_delayed_work_sync(&dev->power.suspend_work);
> >
> > That is the most glorious abuse of an API I've seen this year :-)
>
> Heh.
>
> OK, what would you do instead?

A waitqueue.

	Regards
		Oliver


