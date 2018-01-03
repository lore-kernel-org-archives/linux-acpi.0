From: graeme.gregory@linaro.org
Subject: Re: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
Date: Wed, 3 Jan 2018 11:16:11 +0000
Message-ID: <20180103111611.GB21230@xora-haswell>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36091 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeACLQP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jan 2018 06:16:15 -0500
Received: by mail-wr0-f196.google.com with SMTP id u19so1198714wrc.3
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2018 03:16:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171231192354.GB20455@lunn.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marcin Wojtas <mw@semihalf.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk, rafael.j.wysocki@intel.com, f.fainelli@gmail.com, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, ezequiel.garcia@free-electrons.com, nadavh@marvell.com, neta@marvell.com, ard.biesheuvel@linaro.org, jaz@semihalf.com, tn@semihalf.com


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 08:23:54PM +0100, Andrew Lunn wrote:
> > * Modify way of obtaining interrupts - with ACPI they are resources
> >   bound to struct platform_device and it's not possible to obtain
> >   them directly from the child node. Hence a formula is used, depending
> >   on the port_id and number of possible CPUs.
>=20
> Hi Marcin
>=20
> I know nothing about ACPI. Is this limitation with respect to
> interrupts fundamental to ACPI, or just that nobody has implemented
> flexible interrupt support yet?
>=20
The infrastructure is there to traverse trees of children, but I don't
think there any helper functions.

Graeme


--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEenb+qYJ1KjE/UpmZkGKawB22KXYFAlpMu3sACgkQkGKawB22
KXYvsA/+JzcNOHYDlipDKaIyJ10NZBOW+hr/zlXFLUxTEw02iBLgPyEevnv0XU/b
qzN/XI1d5OQcSUEh6sWaZGKxfQm9S33rQKqLt3QjpYoVoX7tlF6sxGdFWTedfOpx
11AzzfEdtnBkZRGrR0az6qs1xYrTOG0ugUS11mZ3h/rOR6ezBUQCTwhwoKTkJk9Y
Y0QS9sjFBzZVhT7uQqHNZwgn+BeNElV620UIPZfgGQ3hxF6ORxXDApmKwEgqmNre
SWDH1TNHrcUNnjQoB2ydeuDn976kDl+u4iAiwO2Y5sstk657A8NjSt+uZy3XOwJj
xHBMSuBKIw7rZ0prOziZbQE2BB+2Chlo0lmjOnXIx74nzx/OVPjaM/g4QvHGqVPI
JLXkDz6Wwa16ZjwJcnXuWGepOyd3NFyIvUEV+6oX827qys7IIHUxeLpeaNiHfxWU
tDpG6YgvwbwQKQImsVE9Te4GFz6G+q0ahKEHR0rxFFRDShTpxZSvk+SP/kveX4Wk
PC/mxDOKLBh4fZcAvwGbGBRKml+JRv+ZqLjs+1VIx0qL1YsR1ghSmzLShDOez6C9
5QubUI+nUSs/bRfHkAUDlaRsn2yvJhebc89pAszlh07XQl9t8onJg60xQbN76pz8
vQc4u2wybORmPpL5itRmNFkMaqbn12lhgVt7v0GoK6ism0bHSP4=
=7JoR
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
