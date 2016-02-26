From: Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] device property: don't bother the drivers with struct
 property_set
Date: Fri, 26 Feb 2016 16:35:31 +0100
Message-ID: <20160226153530.GC9111@ulmo.nvidia.com>
References: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19667 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbcBZPfl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2016 10:35:41 -0500
In-Reply-To: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 01:20:00PM +0200, Heikki Krogerus wrote:
> Since device_add_property_set() now always takes a copy of
> the property_set, and also since the fwnode type is always
> hard coded to be FWNODE_PDATA, there is no need for the
> drivers to deliver the entire struct property_set. The
> function can just create the instance of it on its own and
> bind the properties from the drivers to it on the spot.
>=20
> This renames device_add_property_set() to
> device_add_properties(). The function now takes struct
> property_entry as its parameter instead of struct
> property_set.
>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  arch/arm/mach-tegra/board-paz00.c |  6 +-----
>  drivers/base/platform.c           | 19 ++++++++++---------
>  drivers/base/property.c           | 35 ++++++++++++++++++++++-----------=
--
>  drivers/mfd/intel-lpss-acpi.c     |  6 +-----
>  drivers/mfd/intel-lpss-pci.c      | 14 +++-----------
>  drivers/mfd/intel-lpss.c          |  2 +-
>  drivers/mfd/intel-lpss.h          |  2 +-
>  drivers/mfd/mfd-core.c            |  4 ++--
>  include/linux/mfd/core.h          |  2 +-
>  include/linux/platform_device.h   |  4 ++--
>  include/linux/property.h          | 15 +++------------
>  11 files changed, 47 insertions(+), 62 deletions(-)

For the Tegra bits:

Acked-by: Thierry Reding <treding@nvidia.com>

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0HC/AAoJEN0jrNd/PrOhn+MP/1Jz+sTG3ggs9Do0rI4g8Fad
Ec7giZabc91tan3LybDFGoZZx/jp/wzS0s9XD4QgK2dj+FJ8Djz7DjiQcWvoRFEt
ehsERscWNQb9yjWzglFcGiCS+KmTm25ho96In2xn00zEDhrrxafxz+Cytva9ZpUq
skWVK6vhbgHYX2EENwBIwHp3tGbsxXhPMFkuUG8T56GS06RAjJIjUtWHYyD2E/lI
WsvA+QIi3+4jlurV7ENxUbxLlivDsLIfeRbGfC/Y9szv2dDvSBxSSaYARk3ZNWG1
Gwl9EZXC4pqUNLYpRxhlbk0sAMAuDxjlhjlr9zwlDmJ6dp2vzQTWZjURrfSUStau
AUhFEIekHuRw0Nc9ggTraUT8d7wzqutj+xdnLwzp6s62SRCa3dpiJ7Hg57ZnLybK
VSgTQXPKmRPaQuPg1Cwo6uazj+DlE4t1tTu/RE9cf9LwqngUo4gtK/aZLt4cdxAY
vLrRHaKs6nYs5U+O2AcrrtQB5BuXKom/g902GaQHIfiLhjErZmyXkMdXYqyQaZzO
RuQgAA+QHZKomm9xo/U4MnzLve2LciXTcHb9hqTVPp3ri5q0aSTHUvpwEEmaJGYs
6ME0+CtrZX/RaNpkEdavokcBp38nyXzXaP996i2LplfyfCPwQIq99K17RdrHfS5M
3Qap+Q71Dvfx+JyCQExz
=N6T3
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
