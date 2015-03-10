From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 04/22] ACPI: Move run-time power supply configuration
 to separate structure
Date: Tue, 10 Mar 2015 15:08:11 +0100
Message-ID: <20150310140811.GB11992@earth>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-5-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59537 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbbCJOId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2015 10:08:33 -0400
Content-Disposition: inline
In-Reply-To: <1425976046-20973-5-git-send-email-k.kozlowski@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael and Len,

On Tue, Mar 10, 2015 at 09:27:08AM +0100, Krzysztof Kozlowski wrote:
> Add new structure 'power_supply_config' for holding run-time
> initialization data like of_node, supplies and private driver data.
>=20
> The power_supply_register() function is changed so all power supply
> drivers need updating.
>=20
> When registering the power supply this new 'power_supply_config' should be
> used instead of directly initializing 'struct power_supply'. This allows
> changing the ownership of power_supply structure from driver to the
> power supply core in next patches.
>=20
> When a driver does not use of_node or supplies then it should use NULL
> as config. If driver uses of_node or supplies then it should allocate
> config on stack and initialize it with proper values.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> [for the nvec part]
> Reviewed-by: Marc Dietrich <marvin24@gmx.de>
>=20
> [for drivers/platform/x86/compal-laptop.c]
> Reviewed-by: Darren Hart <dvhart@linux.intel.com>
> ---
>  drivers/acpi/ac.c                     |  2 +-
>  drivers/acpi/battery.c                |  3 ++-
>  drivers/acpi/sbs.c                    |  4 ++--
>  [...]
>  69 files changed, 224 insertions(+), 167 deletions(-)

I would like to merge this patch via power-supply tree. Can you
please provide your Acked-By?

-- Sebastian

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/vrKAAoJENju1/PIO/qadgEQAIuHlcOkxSYTZZCrAE6xGsoK
O+d93cJn+8870butWkDt7N87nesT7pAIzC+e+VdgOwz5RDPqIUG6RY51Zb4H1Bth
zfgSQiQNdjFFeKWaYoUt23/u1ET9Yznwm6iRojaYoCkJ5ZBCVAZrbDaIFTx4geyd
CbwDKAsbQUwPZu8GoZUaUtmcB6o1F0/lKlgq7Ho7a8msoECBsgiEHnbGeRumk2z1
QUg+khX9fOzuyW9P/BSBcoGXB8utzEIOgCsRq+gPKZHsiYSN2cSyZzOaHTHl6HyE
IfjYW3NbWGSIBYF/jyDHZVj8wOnZTGExJ7qFH9X03VH1YpbIMVMRQMt4ZzAz8e71
ag4g3tRa8ZUqmEJ3g6oFlkGB5UIL58homP9OB1P2oJLR4sKEr6JR0CsytecrqBSn
gb3SdRJOuPlKc4habwWmlXMf+vMdHmUirAN/8T0Wz6A6XzzTmmljkvGStHc0mKtR
uK+1GKbdsVnVEuCNYzCvNKwXC4w3hEW6g7blFA97Jm0TFcHfZ5z1Ya/21nWGU/81
YMxAZ3OTjqmTmswVybTXPhX6vSbCrgj9EMwBJiLkIer8eUvTO3xfUm/7Zc/5/xMj
I+fO0PZMWvemWLr5TIQv0wyW5XwORL2fW4qOFCeFYVaPgbBZH3S/nSjV3kFSNrj9
+AupHPpsDTwIUEaphh75
=YKbF
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
