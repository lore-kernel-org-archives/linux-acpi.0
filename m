From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 14:36:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906111433110.4875-100000@iolanthe.rowland.org>
References: <200906111805.53388.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57501 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753356AbZFKSg2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 14:36:28 -0400
In-Reply-To: <200906111805.53388.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 11 Jun 2009, Oliver Neukum wrote:

> Am Donnerstag, 11. Juni 2009 17:22:06 schrieb Alan Stern:
> > > > Okay, I'll agree to that. =A0It should be made clear that a dev=
ice which
> > > > is "suspended" according to this definition is not necessarily =
in a
> > > > low-power state. =A0For example, before powering down the link =
to a disk
> > > > drive you might want the drive's suspend method to flush the dr=
ive's
> > > > cache, but it wouldn't have to spin the drive down.
> > >
> > > This precludes handling busses that have low power states that ar=
e
> > > left automatically. If such links are stacked the management of
> > > acceptable latencies cannot be left to the busses.
> > > An actual example are the link states of USB 3.0
> >
> > I don't understand. =A0Can you explain more fully?
>=20
> I am talking about the U1 and U2 feature of USB 3.0.
>=20
> Or abstractly any power saving state that does autoresume in hardware=
=2E
> In these cases you know that you can enter a powersaving state that
> will add X latency.
>=20
> In terms of user space API we'll probably add a way for user space
> to specify how much latency may be added for power management's sake.
> If busses are stacked the "latency budget" has to be handled at core =
level.
> If furthermore states that allow IO but with additional latency are i=
gnored,
> the budget will be calculated wrongly.

Okay, fine.  What does this have to do with Rafael's work?  Why does=20
setting the status to RPM_SUSPENDED even when a device is not in a=20
low-power state preclude handling buses that automatically change their=
=20
power state?

I don't see any connection between Rafael's work and managing
latencies, beyond the obvious fact that a device will have a higher
latency when it is suspended than when it isn't.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
