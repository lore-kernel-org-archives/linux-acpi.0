From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Tue, 25 Mar 2008 21:56:11 +0100
Message-ID: <200803252156.12185.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803251030220.4838-100000@iolanthe.rowland.org> <200803252141.49049.rjw@sisk.pl> <200803252149.37552.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34742 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYCYU4Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 16:56:25 -0400
In-Reply-To: <200803252149.37552.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> Am Dienstag, 25. M=E4rz 2008 21:41:48 schrieb Rafael J. Wysocki:
> > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > > Am Dienstag, 25. M=E4rz 2008 15:33:22 schrieb Alan Stern:
> > > > > so I'd say a
> > > > > failure to resume is just a limited subcase of a device vanis=
hing during
> > > > > sleep.
> > > >=20
> > > > I'll go along with that. =A0If a device vanishes during sleep, =
the PM=20
> > > > core isn't responsible for unregistering it -- the device's sub=
system=20
> > > > is.
> > >=20
> > > Yes, that makes sense. You are right.
> >=20
> > Still, if ->resume() returns an error, does it make sense, from the=
 PM core's
> > point of view, to execute ->complete() for that device, for example=
?
>=20
> IMO you must always keep the ordering invariant. If a parent returns =
an error
> the PM core must not wake its children.

I'm agreeing here, but one of the previous Alan's comments suggests he =
has a
differing opinion.  Alan?

I'm considering to make the PM core skip the resuming of the children o=
f
devices that failed to resume and skip calling ->complete() for that de=
vices
and their children.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
