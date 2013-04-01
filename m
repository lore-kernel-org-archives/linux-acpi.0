From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ACPI / SPI: Use parent's ACPI_HANDLE() in
 acpi_register_spi_devices()
Date: Mon, 1 Apr 2013 12:44:23 +0100
Message-ID: <20130401114422.GA18636@opensource.wolfsonmicro.com>
References: <2747891.0orCNBJG8v@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34183 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758645Ab3DALo1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Apr 2013 07:44:27 -0400
Content-Disposition: inline
In-Reply-To: <2747891.0orCNBJG8v@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, grant.likely@secretlab.ca


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2013 at 02:21:08AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The ACPI handle of struct spi_master's dev member should not be
> set, because this causes that struct spi_master to be associated
> with the ACPI device node corresponding to its parent as the
> second "physical_device", which is incorrect (this happens during
> the registration of struct spi_master).  Consequently,
> acpi_register_spi_devices() should use the ACPI handle of the
> parent of the struct spi_master it is called for rather than that
> struct spi_master's ACPI handle (which should be NULL).

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

or does this need to be applied to the SPI tree?

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWXMMAAoJELSic+t+oim9UpAP/3fAVVMFf1gcc6udLLFSNezK
CCDQQoKrBZPPG75XVDNn5esc3PNAmVoT4V8CSuZItFvoDVXkstlA/WPlYvi8nY/m
1MRYUJnLq3ZfxoOoYz1UKViNU/QJ8nxHG9s+DgqH/TXJTU4uTGFkI29xC2CjzRzT
cid0OT97W8wSjea4hjBVUH94Crdrjdb8Fz/Kl76oxA2PT9YNHR/f6T4HDuQFUXfG
z86rxHj/E8IG1hpXEVq3L/9poc56JiJAtOnqzDAY1YU85sip3CHy+P/ud8jHgRHg
e14TcVroAP0MAp0gK7j6b1a3WrunEN3+M+R666iEXSzDhZdO0Mpv/G7+KikG5NY5
2IrrPrNgclb3i00hgJu+JRjT0GrAB3DL07DBFGfXPYs6oDDXmMvzzSuNXaD2ouMw
upQ1khBqOKwPIlYelmar0ELjhOz7xR1/LmQQl8KOuXro0486e9lZDxOEL2J6fM1Q
GVds+XJa4f4As8Aq2veUol1hG2GN0WegHmrtZvK5UGDBf5rrLLAHOc0Xpi6t+dSl
A5y/Yw7XTwQOjwv8tcMgJbkJQ5H+3WyDuMSzRToNEFyTccB7lC8jMCYPgvH6Zyzt
+WyrbB5rZdpwZoKW+M4mdHjOai/FYN+w3/P3KLjECMLj6pFBasUrPcLMWlHKIWf8
jlJS5+ikB/tPL4cXgffJ
=vPnE
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
