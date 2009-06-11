From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 11:22:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906111120260.3040-100000@iolanthe.rowland.org>
References: <200906111706.16848.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45611 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753547AbZFKPWE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 11:22:04 -0400
In-Reply-To: <200906111706.16848.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 11 Jun 2009, Oliver Neukum wrote:

> Am Donnerstag, 11. Juni 2009 16:52:03 schrieb Alan Stern:
> > > Under this definition all devices behind an inactive link are sus=
pended,
> > > because they can't do any I/O. =A0Which appears to makes sense, b=
ecause
> > > their drivers have to be notified before the link is suspended an=
d the
> > > link has to be turned on for the devices to be able to communicat=
e with
> > > the CPU and RAM.
> > >
> > > If this definition is adopted, then it's quite clear that the dev=
ice can
> > > only be suspended if all of its children are suspended and it's a=
lways
> > > necessary to resume the parent of a device in order to resume the=
 device
> > > itself.
> >
> > Okay, I'll agree to that. =A0It should be made clear that a device =
which
> > is "suspended" according to this definition is not necessarily in a
> > low-power state. =A0For example, before powering down the link to a=
 disk
> > drive you might want the drive's suspend method to flush the drive'=
s
> > cache, but it wouldn't have to spin the drive down.
>=20
> This precludes handling busses that have low power states that are
> left automatically. If such links are stacked the management of accep=
table
> latencies cannot be left to the busses.
> An actual example are the link states of USB 3.0

I don't understand.  Can you explain more fully?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
