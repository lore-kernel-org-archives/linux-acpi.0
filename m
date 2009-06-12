From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 22:16:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906112210340.21931-100000@netrider.rowland.org>
References: <200906112305.49232.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:57174 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755674AbZFLCQI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 22:16:08 -0400
In-Reply-To: <200906112305.49232.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 11 Jun 2009, Oliver Neukum wrote:

> Am Donnerstag, 11. Juni 2009 20:36:30 schrieb Alan Stern:
> > > Or abstractly any power saving state that does autoresume in hard=
ware.
> > > In these cases you know that you can enter a powersaving state th=
at
> > > will add X latency.
> > >
> > > In terms of user space API we'll probably add a way for user spac=
e
> > > to specify how much latency may be added for power management's s=
ake.
> > > If busses are stacked the "latency budget" has to be handled at c=
ore
> > > level. If furthermore states that allow IO but with additional la=
tency
> > > are ignored, the budget will be calculated wrongly.
> >
> > Okay, fine. =A0What does this have to do with Rafael's work? =A0Why=
 does
> > setting the status to RPM_SUSPENDED even when a device is not in a
> > low-power state preclude handling buses that automatically change t=
heir
> > power state?
>=20
> For these cases the tree constraint does not apply.

What tree constraint?  You mean that the PM core shouldn't allow=20
devices to suspend unless all their children are suspended?  Why=20
doesn't it still apply?

Remember, when Rafael and I say "suspend" here, we don't mean "go to a=20
low-power state".  We mean "the PM core calls the runtime_suspend=20
method".  No matter what actions the link hardware may decide to take=20
on its own, the PM core will still want to observe the=20
all-children-suspended restriction when calling runtime_suspend=20
methods.

> I think there are devices who can be suspended while children are act=
ive
> and devices which can not be. This is an attribute of the device and =
should
> be evaluated by the core.

Clearly it should be decided by the driver.  Should there be a bit for
it in the dev_pm_info structure?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
