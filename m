From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 3)
Date: Tue, 25 Mar 2008 10:24:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251020530.4838-100000@iolanthe.rowland.org>
References: <200803251437.17268.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44483 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753405AbYCYOYF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 10:24:05 -0400
In-Reply-To: <200803251437.17268.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, 25 Mar 2008, Oliver Neukum wrote:

> Am Dienstag, 25. M=E4rz 2008 13:40:53 schrieb Rafael J. Wysocki:
> > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > > Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
>=20
> > > > + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() de=
tects a situation it cannot
> > > > + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already =
in progress), it may return
> > > > + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it o=
nce again (e.g. after the
> > > > + *=A0=A0=A0=A0=A0new child has been registered) to recover fro=
m the race condition. This
> > > > + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend t=
ransitions and is followed
> > > > + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), =
@freeze(), or @poweroff().
> > >=20
> > > This could be understood so that disconnect() cannot be called.
> >=20
> > At what time exactly?
>=20
> I see no locking that would would prevent disconnect() in the window =
between
> prepare() and suspend()/...

There is no such locking.  It's perfectly legal for a device to be=20
unregistered between prepare() and suspend().  I suppose it wouldn't=20
hurt to add a general comment explaining that a device can be=20
unregistered at any time except when one of its methods is running.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
