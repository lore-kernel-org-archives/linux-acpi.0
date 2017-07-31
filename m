From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/7] gpio: Cleanup kerneldoc
Date: Mon, 31 Jul 2017 13:02:17 +0200
Message-ID: <20170731110217.GK26667@ulmo>
References: <20170724145728.7662-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36499 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdGaLCU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2017 07:02:20 -0400
Content-Disposition: inline
In-Reply-To: <20170724145728.7662-1-thierry.reding@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 04:57:22PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Some kerneldoc has become stale or wasn't quite correct from the outset.
> Fix up the most serious issues to silence warnings when building the
> documentation.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpio/gpiolib.c      | 82 +++++++++++++++++++++++++++++++++------=
------
>  include/linux/gpio/driver.h |  3 +-
>  2 files changed, 61 insertions(+), 24 deletions(-)

Hi Linus,

any chance we can get this merged? The GPIO IRQ chip and banked
controller support patches that I'm working on depend on this, so I'd
like for these to go in before I send out the former in order to
decrease the dependency tracking for everyone involved.

Thanks,
Thierry

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAll/DjkACgkQ3SOs138+
s6HQiA//TlKC1zA9fPpn4FiEWU37G81ulRwhw/aDd4SO+ytvfOuZ1mnfeC9eMhNg
FSWoteOQ+vbMqvNLgOu7KYtwboTXeGNelXhweuDWwYvY8lAv9WTmdcTdl90qLVmo
O5NW8mQiKYT5kh6P+/uN2Kv9m3Ohq3UgGrxRHd0YYHZ6VhIRob9dEtbXhVpOKxwt
sYb9inu+AbE2IBz6eHGPP+YVDd+FiKw/W6Gaiwe6yB5bioiYEvgoRNfpj5HxmYgN
7w1N76YwnR3BwG3JIGiVNu/DjJ/Cyn/iCpZjKVxSjzzxZ1q4Ep/7z5kCVIhVsu5s
1tgi+pm8uT2CM3GxkQDLUahjKozBceEx+seY6AswMs5C5f6jpC5aEXLAeVXr4scD
NoM3XiSBnTvwCBYI8BYo/5s1+MTnjBydfidlTsCCKApGCrVeLSYnX64KlKFBLCLO
SxoI2KyUBBrIN2plSoZzNCn4RTthaYZc0lsMO3oh6iKsLEFGeOoRw90ZsSuBrKfe
7b59rH+2qEb5rVLOQrmHqPM7yqGAyV+ovi9O45CdgqfkL5CPc/gLEZ8ORYLt9O96
bHNHXfjG3fQPYRpAZkPgs7IUYQMRsptPPWSAy9ITHL66Ivu+f7+TR+MqqoB8dVUN
NfD89KFguE+Y2pXSVsZkEoyiiljATpTQCKBRR596uR8fSIgzwp8=
=FYYf
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
