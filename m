From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Mon, 8 Jan 2018 15:14:53 +0000
Message-ID: <20180108151453.GB31502@xora-haswell>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell>
 <20180108145312.GH10940@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42529 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757665AbeAHPO4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jan 2018 10:14:56 -0500
Received: by mail-wr0-f194.google.com with SMTP id w107so11107312wrb.9
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jan 2018 07:14:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180108145312.GH10940@lunn.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marcin Wojtas <mw@semihalf.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nad>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2018 at 03:53:12PM +0100, Andrew Lunn wrote:
> On Mon, Jan 08, 2018 at 02:45:48PM +0000, Graeme Gregory wrote:
> > On Thu, Jan 04, 2018 at 05:20:36PM +0100, Andrew Lunn wrote:
> > > > > I already agreed with 'reg' being awkward in the later emails.
> > > > > Wouldn't _ADR be more appropriate to specify PHY address on MDIO =
bus?
> > > > >=20
> > > > Ah it is an actual address, then yes _ADR is probably more appropri=
ate.
> > >=20
> > > Newbie ACPI question. What is the definition of an address?
> > >=20
> > > In this cause, we are talking about an address of a device on an MDIO
> > > bus. It takes a value between 0 and 31.
> > >=20
> > > How are IC2 device addresses represented in ACPI? MDIO devices and I2C
> > > devices are pretty similar. So it would make sense to use the same as
> > > what I2C uses.
> > >=20
> > Too big (and has table) to sensibly quote, but defined in ACPI spec
> >=20
> > 6.1.1 _ADR (Address)
> >=20
> > Ive never though been quite sure if that is just an example list of
> > address types or its supposed to be canonical (in which case some ECRs
> > are needed to the spec).
>=20
> Hi Graeme
>=20
> I took a quick look at version 6.2, and noticed i2c devices use
> _ADR(). So using it for MDIO seems O.K.
>=20
> However, i2c, spi and uart devices all seem to be described using
> GenericSerialBus. Maybe the correct way to describe MDIO devices is to
> also use GenericSerialBus?
>
I am not familiar with MDIO, but if its similar or a specific
implementation of a serial bus that does sound sane!

Graeme


--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEenb+qYJ1KjE/UpmZkGKawB22KXYFAlpTiu0ACgkQkGKawB22
KXbGLg//bzlbUumGs84ruPm3x0uGw6wtVDovHUboj8rYBhx5O07xux/zfW5co2yI
X4sO7/h+A8ReC7LiElYi19fb13jG3doPUzlvZ4jZDTp32KH1HR9mi0nauc2+uSj1
fWjpDHLS/lu3ZQd3cfi+yIHg2ubltFzmFKcFS4qoLY7BXpdpU4A9IN8FNfFkqyjS
GC87vsVnhUO459FgMghjFpPoaST19Q46963FZr6IlqhNJhuXH4eeUHZi5JUItDKt
JWXv/0lXedhXYOJY5LK2tCzThBc8wcchfUzeQ2pyjFuHdgrMF3v+ZbRsjVbZ9Nt2
284gRes8YpMGmOKqPQeI0jGDNjz7j2ZosLbDNYP0oppma/782Za5LjoRT2iPKALo
E6Oit3CcTBBxB0rvSbwe076Zb7sfa71LA2Lx5OfH90pk5OTN/oJdwvnuiQzNH7nS
saTlBGPTBKdx7c+6ae0d/pvFstt5SS4rbjQ7O4+xNQ6aNZLokkkz6co+27oCrOo+
X1izd2dndDDCSEgHgHWLqkw9mJvuSy4SYzu0cxqf/UwwZ9kpNAq840kKv3TF1mH+
wmwJ3sy55TjuvgEv41Mpo4QXVj4Al11xWhmp1R4WPbIMnh2lyvZOXHDL7d2avD/p
itq8c5voWvJ5nCf3KAB4Y1DZ8BeczgIS2q3uuKKTA3D9+qqMfZY=
=6Rac
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
