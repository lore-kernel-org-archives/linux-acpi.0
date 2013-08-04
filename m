From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: Linux 3.11-rc2 (acpi backlight, revert)
Date: Sun, 04 Aug 2013 21:33:43 +0200
Message-ID: <1514588.PZegN9olxR@merkaba>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com> <1991250.FX2pHCjA6v@merkaba> <1854576.vakuIzNrby@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:38517 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab3HDTdp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Aug 2013 15:33:45 -0400
In-Reply-To: <1854576.vakuIzNrby@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Steven Newbury <steve@snewbury.org.uk>, Joerg Platte <jplatte@naasa.net>, James Hogan <james@albanarts.com>, Kamal Mostafa <kamal@canonical.com>, Aaron Lu <aaron.lu@intel.com>, Kalle Valo <kvalo@adurom.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>

Am Freitag, 26. Juli 2013, 14:40:58 schrieb Rafael J. Wysocki:
> On Friday, July 26, 2013 02:09:08 PM Martin Steigerwald wrote:
> > Am Donnerstag, 25. Juli 2013, 15:00:26 schrieb Rafael J. Wysocki:
> > > On Monday, July 22, 2013 09:54:21 PM Rafael J. Wysocki wrote:
> > > > On Monday, July 22, 2013 11:11:54 AM Linus Torvalds wrote:
> > > > > On Mon, Jul 22, 2013 at 6:02 AM, Rafael J. Wysocki <rjw@sisk.=
pl>=20
wrote:
> > > > > > Linus, do you want me to send a pull request reverting 8c5b=
d7a and
> > > > > > efaa14c?
> > > > >=20
> > > > > Yes, but let's wait a while. Not because I think we'll fix th=
e
> > > > > problem
> > > > > (hey, miracles might happen), but because I think it would be=
 useful
> > > > > to couple the reverts with information about the particular m=
achines
> > > > > that broke (and the people who reported it). So that when we
> > > > > inevitably try again, we can perhaps get some testing effort =
with
> > > > > those machines/people.
> > > > >=20
> > > > > It doesn't seem to be a show-stopped for a large number of pe=
ople,
> > > > > so
> > > > > there's no huge hurry. I'd suggest doing the revert just in t=
ime for
> > > > > rc3, but waiting until then to gather info about people who s=
ee
> > > > > breakage.
> > > > >=20
> > > > > Sound like a plan?
> > > >=20
> > > > Yes, it does.
> > >=20
> > > OK, time to revert I guess.
> > >=20
> > > James, Kamal, Steven, J=F6rg, Martin, Kalle, please check if the =
apppended
> > > patch fixes the backlight for you.
> >=20
> > Rafael, do you still need more testing urgently? Otherwise I=B4d wa=
it till
> > its in some next 3.11 rc and test then.
>=20
> Well, it seems to work for everybody else (Steven, Joerg, thanks for =
your
> reports!), so I don't think you need to test it urgently.

Just a late confirmation: With 3.11-rc3 back light stuff is working nic=
ely on=20
this ThinkPad T520.

Thanks,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
