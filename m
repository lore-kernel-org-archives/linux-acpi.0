From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 14:37:16 +0100
Message-ID: <200803251437.17268.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0803241519090.24400-100000@iolanthe.rowland.org> <200803251255.31482.oliver@neukum.org> <200803251340.55210.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755813AbYCYNhf@vger.kernel.org>
In-Reply-To: <200803251340.55210.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-acpi@vger.kernel.org

Am Dienstag, 25. M=E4rz 2008 13:40:53 schrieb Rafael J. Wysocki:
> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:

> > > + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() dete=
cts a situation it cannot
> > > + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already in=
 progress), it may return
> > > + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it onc=
e again (e.g. after the
> > > + *=A0=A0=A0=A0=A0new child has been registered) to recover from =
the race condition. This
> > > + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend tra=
nsitions and is followed
> > > + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), @f=
reeze(), or @poweroff().
> >=20
> > This could be understood so that disconnect() cannot be called.
>=20
> At what time exactly?

I see no locking that would would prevent disconnect() in the window be=
tween
prepare() and suspend()/...
 =20
> > > + *=A0=A0=A0=A0=A0The PM core executes @prepare() for all devices=
 before starting to
> > > + *=A0=A0=A0=A0=A0execute suspend callbacks for any of them, so d=
rivers may assume all of
> > > + *=A0=A0=A0=A0=A0the other devices to be present and functional =
while @prepare() is being
> > > + *=A0=A0=A0=A0=A0executed. =A0However, they may NOT assume anyth=
ing about the availability
> > > + *=A0=A0=A0=A0=A0of the user space at that time.
> >=20
> > Probably it should be mentioned that this is the time to allocate m=
emory
> > if you have to.
>=20
> Well, not exactly.  Afterwards you cannot use GFP_KERNEL allocations,=
 but
> GFP_NOIO should still work, although for hibernation it's quite possi=
ble that
> they'll fail if substantial amounts of memory are requested.
>=20
> > And it is too late to request firmware.=20
>=20
> Yes.

This is better documented explicitly.

	Regards
		Oliver
