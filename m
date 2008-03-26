From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level
 =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Wed, 26 Mar 2008 10:10:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803261003540.4755-100000@iolanthe.rowland.org>
References: <200803252156.12185.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44918 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754739AbYCZOKB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 10:10:01 -0400
In-Reply-To: <200803252156.12185.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

On Tue, 25 Mar 2008, Rafael J. Wysocki wrote:

> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Dienstag, 25. M=E4rz 2008 21:41:48 schrieb Rafael J. Wysocki:
> > > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > > > Am Dienstag, 25. M=E4rz 2008 15:33:22 schrieb Alan Stern:
> > > > > > so I'd say a
> > > > > > failure to resume is just a limited subcase of a device van=
ishing during
> > > > > > sleep.
> > > > >=20
> > > > > I'll go along with that. =A0If a device vanishes during sleep=
, the PM=20
> > > > > core isn't responsible for unregistering it -- the device's s=
ubsystem=20
> > > > > is.
> > > >=20
> > > > Yes, that makes sense. You are right.
> > >=20
> > > Still, if ->resume() returns an error, does it make sense, from t=
he PM core's
> > > point of view, to execute ->complete() for that device, for examp=
le?
> >=20
> > IMO you must always keep the ordering invariant. If a parent return=
s an error
> > the PM core must not wake its children.

Don't think of it that way.  The PM core doesn't wake anything.  It
merely notifies drivers that the system sleep is ending, so that the
drivers can wake their devices.  It's up to the driver to detect
whether the parent failed to resume, in which case the driver should
take appropriate action.

The situation is no different from what happens when the user tries to=20
access a mounted USB disk drive after the USB cable has been unplugged.=
 =20
The drivers take care of everything.

> I'm agreeing here, but one of the previous Alan's comments suggests h=
e has a
> differing opinion.  Alan?
>=20
> I'm considering to make the PM core skip the resuming of the children=
 of
> devices that failed to resume and skip calling ->complete() for that =
devices
> and their children.

While that might in principle be a reasonable thing to do, it's=20
different from how the PM core has behaved in the past.  I don't see=20
any point in making a change like that now.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
