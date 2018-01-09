From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Tue, 9 Jan 2018 10:19:41 +0000
Message-ID: <20180109101941.GD31502@xora-haswell>
References: <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell>
 <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell>
 <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nadavh>
List-Id: linux-acpi@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2018 at 06:17:06PM +0100, Marcin Wojtas wrote:
> Hi Andrew,
>=20
>=20
>=20
> 2018-01-08 16:42 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
> > w> I am not familiar with MDIO, but if its similar or a specific
> >> implementation of a serial bus that does sound sane!
> >
>=20
> Thanks for digging, I will check if and how we can use
> GenericSerialBus with MDIO.
>=20
Maybe Lorenzo, Hanjun, Sudeep can comment here they might have come
across similar on other ARM boards.

Graeme


--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEenb+qYJ1KjE/UpmZkGKawB22KXYFAlpUlz0ACgkQkGKawB22
KXZKPw/6ArwlJJLWfRTrcM/CQr4U0Mcl0zzdvPNZordcQ7XJ9iwPV1S03z5FwBny
IDZx/1F4b48PZY5ecsO/XBco1QKQ0mS8PCw7IPwE6mIk5nNqRZ4D3yIKHakNhagW
XJXzhc5QwpWcZSfEd8jMs+0nQRvQgN9l29JH63SpCjGyCnTv8A1VYyg/+ehtXA5i
rvQnF1TJvJD4XvNAZGAZ/xP33N1q4TAygAK690UkzS6TyR7vcNOhVeL+jmmGSJMq
FWMWMwEAGYWMfCOUoSQkYW8U9ZbhfuJ9Pqne/7hveQnMG3m9GQi5mhkEZBRYIh7O
DYBH7vrRujf0qRiWOcTcVLzRL51FTcTYafVsavYe4YtOyx7YMPA+J4k55JV6J/OP
x2g0jbUfG2nVQEmJe8NCCEALRXw+l+5StEFo+CbBUELvapd4q9HaEx5H+fiEvJtV
wsXoZK1nPFwuBmBygCbcEq37J4fQ+sXkFiDYDPStQB/dYM7W1mxXt3tEl2v62ykh
Yz0ZTo7/RTjSBNr9yce0EuF2soVeWTIcFpszV7V/ksFl3huAbzEKWfxshMHU5xwZ
+uRHzPPx//SwaDsjy6Ecd+6daWecCYOWlLTo4iLjjbjJRCtoVJH2BnHUVG2BWi20
2q5cIrRx3YW5HOeC+Q96ZXjts1vZP/kDZdORd9KtALoxfcNa6X4=
=P2TR
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
