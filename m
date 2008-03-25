From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 13:40:53 +0100
Message-ID: <200803251340.55210.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803241519090.24400-100000@iolanthe.rowland.org> <200803242318.21052.rjw@sisk.pl> <200803251255.31482.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60608 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165AbYCYMlO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 08:41:14 -0400
In-Reply-To: <200803251255.31482.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
> > -/*
> > +/**
> > + * struct pm_ops - device PM callbacks
> > + *
> > =A0 * Several driver power state transitions are externally visible=
, affecting
> > =A0 * the state of pending I/O queues and (for drivers that touch h=
ardware)
> > =A0 * interrupts, wakeups, DMA, and other hardware state. =A0There =
may also be
> > @@ -122,6 +124,254 @@ typedef struct pm_message {
> > =A0 * to the rest of the driver stack (such as a driver that's ON g=
ating off
> > =A0 * clocks which are not in active use).
> > =A0 *
> > + * The externally visible transitions are handled with the help of=
 the following
> > + * callbacks included in this structure:
> > + *
> > + * @prepare: Prepare the device for the upcoming transition, but d=
o NOT change
> > + *=A0=A0=A0=A0=A0its hardware state. =A0Prevent new children of th=
e device from being
> > + *=A0=A0=A0=A0=A0registered and prevent new calls to the probe met=
hod from being made
>=20
> How is a driver supposed to prevent calls to probe()? You can block i=
n probe()
> or you can fail it, but how do you prevent it from being called? User=
 space
> can trigger probe via sysfs.

I overlooked that.

> To be useful to driver writers, this has to be clarified.

The comment is supposed to mean that probe() should be prevented from r=
unning
(i.e. even if it's executed, it should either fail or block).  I'll wri=
te it this way.

> > + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() detect=
s a situation it cannot
> > + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already in p=
rogress), it may return
> > + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it once =
again (e.g. after the
> > + *=A0=A0=A0=A0=A0new child has been registered) to recover from th=
e race condition. This
> > + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend trans=
itions and is followed
> > + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), @fre=
eze(), or @poweroff().
>=20
> This could be understood so that disconnect() cannot be called.

At what time exactly?
=20
> > + *=A0=A0=A0=A0=A0The PM core executes @prepare() for all devices b=
efore starting to
> > + *=A0=A0=A0=A0=A0execute suspend callbacks for any of them, so dri=
vers may assume all of
> > + *=A0=A0=A0=A0=A0the other devices to be present and functional wh=
ile @prepare() is being
> > + *=A0=A0=A0=A0=A0executed. =A0However, they may NOT assume anythin=
g about the availability
> > + *=A0=A0=A0=A0=A0of the user space at that time.
>=20
> Probably it should be mentioned that this is the time to allocate mem=
ory
> if you have to.

Well, not exactly.  Afterwards you cannot use GFP_KERNEL allocations, b=
ut
GFP_NOIO should still work, although for hibernation it's quite possibl=
e that
they'll fail if substantial amounts of memory are requested.

> And it is too late to request firmware.=20

Yes.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
