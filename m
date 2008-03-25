From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 3)
Date: Tue, 25 Mar 2008 10:29:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251024120.4838-100000@iolanthe.rowland.org>
References: <200803251340.55210.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34872 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752566AbYCYO3g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 10:29:36 -0400
In-Reply-To: <200803251340.55210.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, 25 Mar 2008, Rafael J. Wysocki wrote:

> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
> > > -/*
> > > +/**
> > > + * struct pm_ops - device PM callbacks
> > > + *
> > > =A0 * Several driver power state transitions are externally visib=
le, affecting
> > > =A0 * the state of pending I/O queues and (for drivers that touch=
 hardware)
> > > =A0 * interrupts, wakeups, DMA, and other hardware state. =A0Ther=
e may also be
> > > @@ -122,6 +124,254 @@ typedef struct pm_message {
> > > =A0 * to the rest of the driver stack (such as a driver that's ON=
 gating off
> > > =A0 * clocks which are not in active use).
> > > =A0 *
> > > + * The externally visible transitions are handled with the help =
of the following
> > > + * callbacks included in this structure:
> > > + *
> > > + * @prepare: Prepare the device for the upcoming transition, but=
 do NOT change
> > > + *=A0=A0=A0=A0=A0its hardware state. =A0Prevent new children of =
the device from being
> > > + *=A0=A0=A0=A0=A0registered and prevent new calls to the probe m=
ethod from being made
> >=20
> > How is a driver supposed to prevent calls to probe()? You can block=
 in probe()
> > or you can fail it, but how do you prevent it from being called? Us=
er space
> > can trigger probe via sysfs.
>=20
> I overlooked that.

The driver isn't supposed to prevent calls to its own probe().  The
comment means that the subsystem -- or the rest of the kernel generally
-- is supposed to avoid binding a driver to the device (thereby calling
the probe routine), assuming the device isn't already bound.

I don't expect this sort of thing to be very common.  Mostly it happens
when new kernel modules are loaded and new drivers are registered; we
will have to block module loading during a sleep transition.  It also
happens when the user writes to a driver's "bind" attribute in sysfs; =20
the code there will have to block during a sleep transition.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
