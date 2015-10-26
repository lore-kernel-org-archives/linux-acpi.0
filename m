From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: acpi_find_gpio with absent GPIOs
Date: Mon, 26 Oct 2015 12:20:31 +0200
Message-ID: <20151026102031.GG1526@lahna.fi.intel.com>
References: <562A4AB6.1010805@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53982 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496AbbJZKUe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2015 06:20:34 -0400
Content-Disposition: inline
In-Reply-To: <562A4AB6.1010805@emlix.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org

On Fri, Oct 23, 2015 at 04:56:54PM +0200, Daniel Gl=F6ckner wrote:
> Hi,
>=20
> I'm currently trying to use rfkill-gpio with a device that has just a
> single GPIO assigned by ACPI. rfkill-gpio calls acpi_dev_add_driver_g=
pios
> to assign names to the ACPI GPIOs and then uses devm_gpiod_get_option=
al
> to request both of them. The problem is that on the second call to
> devm_gpiod_get_optional acpi_find_gpio falls back to using the GPIO i=
ndex
> 0 (from gpiod_get) in _CRS, which leads to the same GPIO being return=
ed
> as in the first call. Probing the driver then fails with -EBUSY.
>=20
> In my opinion it is a bad idea to fall back to indexing the _CRS if t=
he
> con_id was found in the _DSD or the GPIOs added by
> acpi_dev_add_driver_gpios, but I don't know if there are drivers rely=
ing
> on this behavior.

I agree it is bad idea and I think this is actually a bug in the
implementation rather than wanted behavior. No drivers should rely on
that anyway.

> Luckily acpi_get_gpiod_by_index returns -ENODATA if the name can't be
> found and -ENOENT if the GPIO is absent, so we can distinguish the tw=
o
> cases. -EPROBE_DEFER also should not make acpi_find_gpio try to use
> another GPIO from the _CRS.
>=20
> There is also the possibility that the GPIO index exceeds the size of
> the package found in _DSD or added with acpi_dev_add_driver_gpios.
> The former will return -EPROTO, the latter will forward the error
> from acpi_dev_get_property_reference (usually -ENODATA). of_find_gpio
> returns -ENOENT in this case.
>=20
> So, what of this should be fixed?

I think both should be fixed.

=46or the first maybe something like below?

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5db3445552b1..441be96e18e7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1765,6 +1765,11 @@ static struct gpio_desc *acpi_find_gpio(struct d=
evice *dev, const char *con_id,
=20
 	/* Then from plain _CRS GPIOs */
 	if (IS_ERR(desc)) {
+		/* Only fallback if the device has no properties at all */
+		if (PTR_ERR(desc) =3D=3D -ENODATA &&
+		    (adev->data.properties || adev->driver_gpios))
+			return ERR_PTR(-ENOENT);
+
 		desc =3D acpi_get_gpiod_by_index(adev, NULL, idx, &info);
 		if (IS_ERR(desc))
 			return desc;
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
