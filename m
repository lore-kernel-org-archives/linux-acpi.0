From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 5/9] mfd: Add ACPI support
Date: Thu, 21 Aug 2014 12:05:31 +0300
Message-ID: <20140821090508.GK1660@lahna.fi.intel.com>
References: <1408172039-32513-1-git-send-email-mika.westerberg@linux.intel.com>
 <1408172039-32513-6-git-send-email-mika.westerberg@linux.intel.com>
 <20140820155459.GM4266@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61570 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbaHUJG2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Aug 2014 05:06:28 -0400
Content-Disposition: inline
In-Reply-To: <20140820155459.GM4266@lee--X1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <al.stone@linaro.org>, Olof Johansson <olof@lixom.net>, Matthew Garrett <matthew.garrett@nebula.com>, Matt Fleming <matt.fleming@intel.com>, David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Josh Triplett <josh@joshtriplett.org>, Aaron Lu <aaron.lu@intel.com>, Max Eliaser <max.eliaser@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Brown <broonie@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@linaro.org>R

On Wed, Aug 20, 2014 at 04:54:59PM +0100, Lee Jones wrote:
> On Sat, 16 Aug 2014, Mika Westerberg wrote:
> > If an MFD device is backed by ACPI namespace, we should allow subde=
vice
> > drivers to access their corresponding ACPI companion devices throug=
h normal
> > means (e.g using ACPI_COMPANION()).
> >=20
> > This patch adds such support to the MFD core. If the MFD parent dev=
ice
> > doesn't specify any ACPI _HID/_CID for the child device, the child =
device
> > will share the parent ACPI companion device. Otherwise the child de=
vice
> > will be assigned with the corresponding ACPI companion, if found in=
 the
> > namespace below the parent.
> >=20
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Darren Hart <dvhart@linux.intel.com>
> > ---
> >  Documentation/acpi/enumeration.txt | 27 +++++++++++++++++++++++++
> >  drivers/mfd/mfd-core.c             | 41 ++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/mfd/core.h           |  3 +++
> >  3 files changed, 71 insertions(+)
> >=20
> > diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acp=
i/enumeration.txt
> > index e182be5e3c83..74e35c54febf 100644
> > --- a/Documentation/acpi/enumeration.txt
> > +++ b/Documentation/acpi/enumeration.txt
> > @@ -312,3 +312,30 @@ a code like this:
> > =20
> >  There are also devm_* versions of these functions which release th=
e
> >  descriptors once the device is released.
> > +
> > +MFD devices
> > +~~~~~~~~~~~
> > +The MFD devices create platform devices from their children. For t=
he
>=20
> What does this mean?  MFD drivers register their children _as_
> platform devices.

Right, will fix.

> > +child devices there needs to be an ACPI handle that they can use t=
o
> > +reference parts of the ACPI namespace that relate to them. In the =
Linux
> > +MFD subsystem we provide two ways:
> > +
> > +	o The children share the parent ACPI handle.
> > +	o The MFD cell can specify the ACPI id of the device.
> > +
> > +For the first case, the MFD drivers do not need to do anything. Th=
e
> > +resulting child platform device will have its ACPI_COMPANION() set=
 to point
> > +to the parent device.
> > +
> > +If the ACPI namespace has a device that we can match using an ACPI=
 id,
> > +the id should be set like:
> > +
> > +	static struct mfd_cell my_subdevice_cell =3D {
> > +		.name =3D "my_subdevice",
> > +		/* set the resources relative to the parent */
> > +		.acpi_pnpid =3D "XYZ0001",
> > +	};
> > +
> > +The ACPI id "XYZ0001" is then used to lookup an ACPI device direct=
ly under
> > +the MFD device and if found, that ACPI companion device is bound t=
o the
> > +resulting child platform device.
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 892d343193ad..bb466b28b3b6 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -78,6 +78,45 @@ static int mfd_platform_add_cell(struct platform=
_device *pdev,
> >  	return 0;
> >  }
> > =20
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +static void mfd_acpi_add_device(const struct mfd_cell *cell,
> > +				struct platform_device *pdev)
> > +{
> > +	struct acpi_device *parent_adev;
> > +	struct acpi_device *adev =3D NULL;
> > +
> > +	parent_adev =3D ACPI_COMPANION(pdev->dev.parent);
> > +	if (!parent_adev)
> > +		return;
> > +
> > +	/*
> > +	 * MFD child device gets its ACPI handle either from the ACPI
> > +	 * device directly under the parent that matches the acpi_pnpid o=
r
> > +	 * it will use the parent handle if is no acpi_pnpid is given.
> > +	 */
> > +	if (cell->acpi_pnpid) {
> > +		struct acpi_device_id ids[2] =3D {};
> > +		struct acpi_device *child_adev;
> > +
> > +		strlcpy(ids[0].id, cell->acpi_pnpid, sizeof(ids[0].id));
> > +		list_for_each_entry(child_adev, &parent_adev->children, node)
> > +			if (acpi_match_device_ids(child_adev, ids)) {
> > +				adev =3D child_adev;
> > +				break;
> > +			}
> > +	} else {
> > +		adev =3D parent_adev;
> > +	}
> > +
> > +	ACPI_COMPANION_SET(&pdev->dev, adev);
> > +}
> > +#else
> > +static inline void mfd_acpi_add_device(const struct mfd_cell *cell=
,
> > +				       struct platform_device *pdev)
> > +{
> > +}
> > +#endif
> > +
>=20
> I'm not keen on polluting the MFD core driver with #differy.  Can't y=
ou
> think of another way to do it?

It may be possible to do that since we only use few ACPI functions that
have dummy stubs already.

>=20
> >  static int mfd_add_device(struct device *parent, int id,
> >  			  const struct mfd_cell *cell, atomic_t *usage_count,
> >  			  struct resource *mem_base,
> > @@ -118,6 +157,8 @@ static int mfd_add_device(struct device *parent=
, int id,
> >  		}
> >  	}
> > =20
> > +	mfd_acpi_add_device(cell, pdev);
> > +
> >  	if (cell->pdata_size) {
> >  		ret =3D platform_device_add_data(pdev,
> >  					cell->platform_data, cell->pdata_size);
> > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> > index f543de91ce19..73e1709d4c09 100644
> > --- a/include/linux/mfd/core.h
> > +++ b/include/linux/mfd/core.h
> > @@ -44,6 +44,9 @@ struct mfd_cell {
> >  	 */
> >  	const char		*of_compatible;
> > =20
> > +	/* Matches ACPI PNP id, either _HID or _CID */
> > +	const char		*acpi_pnpid;
> > +
> >  	/*
> >  	 * These resources can be specified relative to the parent device=
=2E
> >  	 * For accessing hardware you should use resources from the platf=
orm dev
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
