From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: Generic battery interface
Date: Sat, 29 Jul 2006 11:37:07 +0100 (BST)
Message-ID: <20060729103707.26737.qmail@web36908.mail.mud.yahoo.com>
References: <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web36908.mail.mud.yahoo.com ([209.191.85.76]:50296 "HELO
	web36908.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422741AbWG2KhI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Jul 2006 06:37:08 -0400
In-Reply-To: <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org


--- Shem Multinymous <multinymous@gmail.com> wrote:

> On 7/29/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > On Sat, 29 Jul 2006 01:10:40 +0300, Shem Multinymous said:
> > > On 7/28/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wro=
te:
> > > > Is there a reliable (or hack-worthy) way for the kernel to dete=
rmine how
> > > > often the values are re-posted by the hardware?
> > >
> > > That's hardware-specific. Some drivers can know, others may just
> > > assume 1sec or 0.1sec or whatever.
> >
> > That smells suspiciously like "We need an API for the hardware-spec=
ific
> > bits f code to pass the generic bits a value for this..." (and the
> > hardware-specific part can either ask the battery, or return a
> > hard-coded "10 seconds" that somebody measured, or whatever)....
>=20
> I don't think "update frequency" is a good abstraction. The hardware'=
s
> update may not be variable and irrregular (e.g., event-based), and
> there's there's an issue of phase sync to avoid unnecessary latency.
>=20
> The lazy polling approach I described in my last post to Vojtech
> ("block until there's  a new readout or N milliseconds have passed,
> whichever is later") looks like a more general, accurate and efficien=
t
> interface.
>=20

This sounds like a good idea. You could do a similar thing using sysfs =
by
providing a entry in sysfs which tells userland when the next update is=
 going
to happen, the userland app can then decide to use this as it's next po=
ll time
or not.

Mark

>   Shem
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20



	=09
___________________________________________________________=20
Yahoo! Photos =96 NEW, now offering a quality print service from just 7=
p a photo http://uk.photos.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
