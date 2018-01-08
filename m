From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
Date: Mon, 8 Jan 2018 14:45:48 +0000
Message-ID: <20180108144548.GA31502@xora-haswell>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180104162036.GL3401@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marcin Wojtas <mw@semihalf.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Nadav Haklai <nad>
List-Id: linux-acpi@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 05:20:36PM +0100, Andrew Lunn wrote:
> > > I already agreed with 'reg' being awkward in the later emails.
> > > Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?
> > >=20
> > Ah it is an actual address, then yes _ADR is probably more appropriate.
>=20
> Newbie ACPI question. What is the definition of an address?
>=20
> In this cause, we are talking about an address of a device on an MDIO
> bus. It takes a value between 0 and 31.
>=20
> How are IC2 device addresses represented in ACPI? MDIO devices and I2C
> devices are pretty similar. So it would make sense to use the same as
> what I2C uses.
>=20
Too big (and has table) to sensibly quote, but defined in ACPI spec

6.1.1 _ADR (Address)

Ive never though been quite sure if that is just an example list of
address types or its supposed to be canonical (in which case some ECRs
are needed to the spec).

Thanks

Graeme


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEenb+qYJ1KjE/UpmZkGKawB22KXYFAlpThAAACgkQkGKawB22
KXb0dw//SWt2W1dEnU8CnfP7S0ddkfiPEDp4jo5aMRGbt3ss23ZoUNvgjaucBCW9
CwURSjuyvk1pduIic2WNodPqSMoH9cMZyOc51F91JYngKuFoRn7zLy0YkAs+XSnz
y8kqKC6wtj9l9Ffwg3fOhdQ/XBAGHCIq+2fx0I/7gxkUfBi+NWwV/LEz2IfahNpt
5rIkKjIfQWW2e2eE8/XIWQJFOyvlrsJK/7KAGh8tUflzuFdZAl9WZr/BfsDBfqo9
nDFjzbH8wvV0oAVvxPz3kUXcR+rZwCmPj9LLscqIJlfNdx6rIwzlNE3rld8rvqJQ
JxVkqMALeyRHU4UGFQkeH6QlK4zVLVaPGXbwEHTrF4gTyVWR2yqBeWyFchsV2XQh
R8S0rt1nHx/Cf74Uq0+9OaFrAUGGU+Q7HRa6fV5xAOpvV9ury5jMZFwTbuMBdA17
U+3Ebj2kKPu8g8tWIzgAeJ/8a4v7B6Qdnjiujkg2mzxo8qH7npNbxXRYf2YMAqTN
rdlEDlwlQEC10ksz1SaqH7X/Z3zYPwGaIdW8a7KeoFKArrJ/rdBLxPH84s5jNTTi
oTTFU3BZh7r3vRPKDYe0h92QZd6ehyuWnE9IUEspxarL6kk+S1dsbpKD0a/KZgvK
yzzcPbM8BfMUcH6dHmE6xLSZx3LycxIg8rS/JDgP4bK5ok4/OP4=
=qir+
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
