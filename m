From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] =?utf-8?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Introduce_new_top?=
 =?utf-8?q?_level_suspend=09and_hibernation_callbacks_=28rev=2E_2?=
 =?utf-8?q?=29?=
Date: Tue, 25 Mar 2008 10:19:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251011110.4838-100000@iolanthe.rowland.org>
References: <200803251415.09088.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44473 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752889AbYCYOTq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 10:19:46 -0400
In-Reply-To: <200803251415.09088.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

On Tue, 25 Mar 2008, Oliver Neukum wrote:

> Am Dienstag, 25. M=C3=A4rz 2008 14:06:15 schrieb Rafael J. Wysocki:
> > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
>=20
> > > A device that cannot wake up is unusable. Shouldn't the pm core d=
isconnect()
> > > such a device?

It's not safe for the PM core to do such things unilaterally.  The=20
decision to unregister a device should be made by the driver or the=20
subsystem.

(The only problem is that it's impossible to unregister a device from=20
within its suspend or resume methods.  Perhaps there should be a way=20
for the driver to tell the PM core that the core should unregister the=20
device as soon as the method returns.  I don't know if such a facility=20
would get used...)

> > Well, if ->resume() returns an error, the driver already knows ther=
e's a
> > problem and it can act upon that, at least in principle.
>=20
> Then why return an error? If a driver returns an error I would assume=
 that
> to indicate an irrecoverable error.

The PM core prints a warning in the system log whenever an error is=20
returned.  There isn't much more it can do.

> > However, the PM core probably shouldn't try to resume the children =
of a failing
> > device.  Also, if ->resume_noirq() fails, it probably is not a good=
 idea to
> > call ->resume() and ->complete() for the same device and for it's c=
hildren.
>=20
> Exactly. But we need to define what happens in these cases. If we sim=
ply
> ignore the errors, the drivers must be able to deal with IO to half s=
uspended
> devices.

Just so -- it's up to the drivers to deal with this sort of thing.  The=
=20
PM core can't know the details of what should be done in each case.

=46or example, if a USB hub can't be resumed then usbcore marks all of
its descendants with USB_STATE_NOTATTACHED.  When the children's resume
methods are called, they return without trying to do anything.  Later
on khubd takes care of unregistering everything.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
