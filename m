From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level
 =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Wed, 26 Mar 2008 10:40:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803261032140.4969-100000@iolanthe.rowland.org>
References: <200803261524.18300.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56996 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751554AbYCZOk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 10:40:28 -0400
In-Reply-To: <200803261524.18300.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

On Wed, 26 Mar 2008, Oliver Neukum wrote:

> Am Mittwoch, 26. M=E4rz 2008 15:10:01 schrieb Alan Stern:
> > > > IMO you must always keep the ordering invariant. If a parent re=
turns an error
> > > > the PM core must not wake its children.
> >=20
> > Don't think of it that way. =A0The PM core doesn't wake anything. =A0=
It
> > merely notifies drivers that the system sleep is ending, so that th=
e
> > drivers can wake their devices. =A0It's up to the driver to detect
> > whether the parent failed to resume, in which case the driver shoul=
d
> > take appropriate action.
>=20
> How do you propose that every driver should check the power state
> of its parent? Without locking the parent?

It depends entirely on the driver and subsystem; generalizations are=20
not possible.  When appropriate, they can copy the scheme used by USB. =
=20
Or they can make up their own scheme.

> > The situation is no different from what happens when the user tries=
 to=20
> > access a mounted USB disk drive after the USB cable has been unplug=
ged. =A0
> > The drivers take care of everything.
>=20
> That completely throws away the reason to have a PM core.

Nonsense.

>  We've made
> a guarantee to drivers that they wil not be woken unless their parent=
s are
> awake.

No we haven't.  The guarantee is only that the PM core will call the=20
parent's resume method before calling the child's method.  There is no=20
guarantee about whether the method succeeds or the parent is awake.

Remember, the whole purpose of this is to let drivers know when the=20
system is going to sleep or waking up.  Proper handling of devices is=20
up to the drivers, not up to the core.

>  In fact the semantics of the callbacks are defined in a way that
> adding devices to a parent can be enabled. You cannot add children to=
 a
> dead parent.

Depends what you mean.  In some cases it is possible -- i.e., you can
do it and the kernel won't crash, although the new children probably
won't be usable.  In any case it doesn't matter; the PM core doesn't
care whether children are added to a dead parent, only drivers care.

> It's the very reason for this rewrite.

No it isn't.  See Rafael's changelog ocmments; the rewrite is being=20
done for completely different reasons.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
