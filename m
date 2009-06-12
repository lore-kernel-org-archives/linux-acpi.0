From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 10:32:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906121027300.2915-100000@iolanthe.rowland.org>
References: <200906121015.19504.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:32884 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755048AbZFLOcA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2009 10:32:00 -0400
In-Reply-To: <200906121015.19504.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, 12 Jun 2009, Oliver Neukum wrote:

> Am Freitag, 12. Juni 2009 04:16:10 schrieb Alan Stern:
> > What tree constraint? =A0You mean that the PM core shouldn't allow
> > devices to suspend unless all their children are suspended? =A0Why
> > doesn't it still apply?
>=20
> Because the hardware doesn't need it.

But maybe drivers need it.

> > Remember, when Rafael and I say "suspend" here, we don't mean "go t=
o a
> > low-power state". =A0We mean "the PM core calls the runtime_suspend
> > method". =A0No matter what actions the link hardware may decide to =
take
> > on its own, the PM core will still want to observe the
> > all-children-suspended restriction when calling runtime_suspend
> > methods.
>=20
> No. The core if it insists all children be suspended will not use
> the hardware's full capabilities.

That isn't what I said.  The core does not insist that all children be=20
suspended, i.e., be in a low-power state.  It insists only that the=20
children's drivers' runtime_suspend methods have been called.  Those=20
methods are not obligated to put the children in a low-power state.

> If it leaves such power saving measures to the drivers, latency
> accounting will be wrong.
>=20
> > > I think there are devices who can be suspended while children are=
 active
> > > and devices which can not be. This is an attribute of the device =
and
> > > should be evaluated by the core.
> >
> > Clearly it should be decided by the driver. =A0Should there be a bi=
t for
> > it in the dev_pm_info structure?
>=20
> Yes.

That would resolve the issue.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
