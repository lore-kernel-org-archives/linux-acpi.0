From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [patch 04/12] cmpc_acpi: add support for Classmate PC ACPI
	devices
Date: Wed, 18 Nov 2009 16:22:00 -0200
Message-ID: <20091118182159.GC21600@vespa.holoscopio.com>
References: <200911172227.nAHMRUgH023139@imap1.linux-foundation.org> <9b2b86520911180107r54fc14a2of2ccb19b25698523@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 139.254.232.72.static.reverse.ltdomains.com ([72.232.254.139]:54257
	"EHLO liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932173AbZKRSWD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Nov 2009 13:22:03 -0500
Content-Disposition: inline
In-Reply-To: <9b2b86520911180107r54fc14a2of2ccb19b25698523@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, don@syst.com.br


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2009 at 09:07:22AM +0000, Alan Jenkins wrote:
> On 11/17/09, akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:
> > From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> >
> > This add supports for devices like keyboard, backlight, tablet and
> > accelerometer.
> >
> > This work is supported by International Syst S/A.
> >
> > [randy.dunlap@oracle.com: cmpc_acpi: depends on ACPI]
> > [akpm@linux-foundation.org: readability tweaks]
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  MAINTAINERS                      |    6
> >  drivers/platform/x86/Kconfig     |   12
> >  drivers/platform/x86/Makefile    |    1
> >  drivers/platform/x86/cmpc_acpi.c |  543 +++++++++++++++++++++++++++++
> >  4 files changed, 562 insertions(+)
> >
> > diff -puN MAINTAINERS~cmpc_acpi-add-support-for-classmate-pc-acpi-devic=
es
> > MAINTAINERS
> > --- a/MAINTAINERS~cmpc_acpi-add-support-for-classmate-pc-acpi-devices
> > +++ a/MAINTAINERS
> > @@ -1427,6 +1427,12 @@ L:	linux-scsi@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/scsi/fnic/
> >
> > +CMPC ACPI DRIVER
> > +M:	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> > +M:	Daniel Oliveira Nascimento <don@syst.com.br>
> > +S:	Supported
> > +F:	drivers/platform/x86/cmpc_acpi.c
> > +
> >  CODA FILE SYSTEM
> >  M:	Jan Harkes <jaharkes@cs.cmu.edu>
> >  M:	coda@cs.cmu.edu
> > diff -puN
> > drivers/platform/x86/Kconfig~cmpc_acpi-add-support-for-classmate-pc-acp=
i-devices
> > drivers/platform/x86/Kconfig
> > ---
> > a/drivers/platform/x86/Kconfig~cmpc_acpi-add-support-for-classmate-pc-a=
cpi-devices
> > +++ a/drivers/platform/x86/Kconfig
> > @@ -435,4 +435,16 @@ config ACPI_TOSHIBA
> >
> >  	  If you have a legacy free Toshiba laptop (such as the Libretto L1
> >  	  series), say Y.
> > +
> > +config ACPI_CMPC
> > +	tristate "CMPC Laptop Extras"
> > +	depends on X86 && ACPI
> > +	select INPUT
> > +	select BACKLIGHT_CLASS_DEVICE
> > +	default n
> > +	help
> > +	  Support for Intel Classmate PC ACPI devices, including some
> > +	  keys as input device, backlight device, tablet and accelerometer
> > +	  devices.
> > +
> >  endif # X86_PLATFORM_DEVICES
> > diff -puN
> > drivers/platform/x86/Makefile~cmpc_acpi-add-support-for-classmate-pc-ac=
pi-devices
> > drivers/platform/x86/Makefile
> > ---
> > a/drivers/platform/x86/Makefile~cmpc_acpi-add-support-for-classmate-pc-=
acpi-devices
> > +++ a/drivers/platform/x86/Makefile
> > @@ -21,3 +21,4 @@ obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
> >  obj-$(CONFIG_ACPI_ASUS)		+=3D asus_acpi.o
> >  obj-$(CONFIG_TOPSTAR_LAPTOP)	+=3D topstar-laptop.o
> >  obj-$(CONFIG_ACPI_TOSHIBA)	+=3D toshiba_acpi.o
> > +obj-$(CONFIG_ACPI_CMPC)		+=3D cmpc_acpi.o
> > diff -puN /dev/null drivers/platform/x86/cmpc_acpi.c
> > --- /dev/null
> > +++ a/drivers/platform/x86/cmpc_acpi.c
> > @@ -0,0 +1,543 @@
> > +/*
> > + *  Copyright (C) 2009  Thadeu Lima de Souza Cascardo
> > <cascardo@holoscopio.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License as published =
by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License =
along
> > + *  with this program; if not, write to the Free Software Foundation, =
Inc.,
> > + *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/workqueue.h>
> > +#include <acpi/acpi_drivers.h>
> > +#include <linux/backlight.h>
> > +#include <linux/input.h>
> > +
> > +MODULE_LICENSE("GPL");
> > +
> > +
> > +/*
> > + * Generic input device code.
> > + */
> > +
> > +typedef void (*input_device_init)(struct input_dev *dev);
> > +
> > +static int cmpc_add_acpi_notify_device(struct acpi_device *acpi, char
> > *name,
> > +				       acpi_notify_handler handler,
> > +				       input_device_init idev_init)
> > +{
> > +	struct input_dev *inputdev;
> > +	acpi_status status;
> > +	int error;
> > +
> > +	inputdev =3D input_allocate_device();
> > +	if (!inputdev) {
> > +		error =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +	inputdev->name =3D name;
> > +	inputdev->dev.parent =3D &acpi->dev;
> > +	idev_init(inputdev);
> > +	error =3D input_register_device(inputdev);
> > +	if (error)
> > +		goto err_reg;
> > +	dev_set_drvdata(&acpi->dev, inputdev);
> > +	status =3D acpi_install_notify_handler(acpi->handle, ACPI_DEVICE_NOTI=
FY,
> > +					     handler, inputdev);
> > +	if (ACPI_FAILURE(status)) {
> > +		error =3D -ENODEV;
> > +		goto err_acpi;
> > +	}
> > +	return 0;
> > +err_acpi:
> > +	input_unregister_device(inputdev);
> > +err_reg:
> > +	input_free_device(inputdev);
> > +out:
> > +	return error;
> > +}
> > +
> > +static int cmpc_remove_acpi_notify_device(struct acpi_device *acpi,
> > +					  acpi_notify_handler handler)
> > +{
> > +	struct input_dev *inputdev;
> > +	acpi_status status;
> > +
> > +	status =3D acpi_remove_notify_handler(acpi->handle, ACPI_DEVICE_NOTIF=
Y,
> > +					    handler);
> > +	inputdev =3D dev_get_drvdata(&acpi->dev);
> > +	input_unregister_device(inputdev);
> > +	input_free_device(inputdev);
> > +	return 0;
> > +}
>=20
> This version still needs some fixes.  For example, input_free_device()
> should not be called after input_unregister_device().
>=20
> The other main problem was that the state of the "tablet mode" switch
> is not set on initialisation (and the same for resume from suspend).
>=20
> At the very least, I don't think this version should be merged without
> putting it under CONFIG_EXPERIMENTAL.  For more details and less
> serious nits see
> <http://thread.gmane.org/gmane.linux.acpi.devel/42017/focus=3D42025>.
>=20
> Thanks
> Alan

Since Andrew has put some patches over the first version, I had some
doubts on how to handle the fixes. Should I import those patches as git
patches and submit them together with many other patches fixing every
issue in its own commit? Or should I write another version and write a
log in the commit message?

UPDATE:
I've just fixed every issue reported. How should I send it?

Regards,
Cascardo.

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksEO0cACgkQyTpryRcqtS1EgwCfWQrAVT1NT7l36fS/3hGiCZh7
OfYAniGu91CzYKqfKWqkG99cjUQTCRxb
=Nks8
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
