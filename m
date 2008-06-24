From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 1/3] ACPI: save/restore ACPI NVS memory during hibernation
Date: Tue, 24 Jun 2008 13:16:38 +0200
Message-ID: <200806241316.39132.rjw@sisk.pl>
References: <1214293383.3001.108.camel@rzhang-dt.sh.intel.com> <200806241218.25691.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46214 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbYFXLPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 07:15:18 -0400
In-Reply-To: <200806241218.25691.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-power-mgmt <linux-power-mgmt@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Tuesday, 24 of June 2008, Rafael J. Wysocki wrote:
> On Tuesday, 24 of June 2008, Zhang Rui wrote:
> > According to the ACPI spec, ACPI NVS memory region is required to b=
e
> > saved/restored by OS during hibernation.
> >=20
> > Section 15.3.2 ACPI Spec 3.0b,
> > "OSPM will call the _PTS control method some time before entering a=
 sleeping state,
> > to allow the platform=E2=80=99s AML code to update this memory imag=
e before entering the
> > sleeping state. After the system awakes from an S4 state, OSPM will=
 restore this memory
> > area and call the _WAK control method to enable the BIOS to reclaim=
 its memory image."
> >=20
> > Add the mechanism to save/restore ACPI NVS memory during hibernatio=
n.
> >=20
> > Note: now Linux save ACPI NVS memory in acpi_hibernation_pre_snapsh=
ot, and restore it in
> > 	acpi_hibernation_leave. Both of these functions will be invoked on=
ly once during
> > 	the hibernate and resume.
> > Note: in Section 14.3 ACPI spec 3.0b, I only get
> > 	"EfiACPIMemoryNVS: The OS and loader must preserve this memory ran=
ge in
> > 	the working and ACPI S1=E2=80=93S3 states."
> > 	whether we should save/restore this piece of memory is not cleared=
=2E
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> Well, I know what the specification says, but we tried that in the pa=
st and it
> caused regressions.
>=20
> > ---
> >  drivers/acpi/sleep/main.c |  122 +++++++++++++++++++++++++++++++++=
++++++++++++-
> >  include/linux/acpi.h      |    3 +
> >  2 files changed, 124 insertions(+), 1 deletion(-)
> >=20
> > Index: linux-2.6/drivers/acpi/sleep/main.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/acpi/sleep/main.c	2008-06-20 09:27:00.00=
0000000 +0800
> > +++ linux-2.6/drivers/acpi/sleep/main.c	2008-06-24 14:51:20.0000000=
00 +0800
> > @@ -15,6 +15,7 @@
> >  #include <linux/dmi.h>
> >  #include <linux/device.h>
> >  #include <linux/suspend.h>
> > +#include <linux/highmem.h>
> > =20
> >  #include <asm/io.h>
> > =20
> > @@ -255,6 +256,109 @@
> >  #endif /* CONFIG_SUSPEND */
> > =20
> >  #ifdef CONFIG_HIBERNATION
> > +
> > +/* ACPI NVS memory need to be saved/stored during hibernation */
> > +struct nvs_page {
> > +	unsigned long pfn;
> > +	void *data;
> > +	struct nvs_page *next;
> > +};

One more thing: I'd slightly prefer to use a list.h list instead of the=
 open
coded one here.  It won't cost us much, so IMO it's worth doing for con=
sistency
with the rest of the kernel.

> > +static struct nvs_page *nvs_pages;
> > +
> > +int acpi_mark_nvs_region(unsigned long start, unsigned long end)
> > +{
> > +	struct nvs_page *tmp;
> > +
> > +	while (start <=3D end) {
> > +		tmp =3D kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
> > +		if (!tmp)
> > +			return -ENOMEM;
>=20
> We should free the already allocated structures in this case IMO.
>=20
> > +		tmp->pfn =3D start;
> > +		tmp->next =3D nvs_pages;
> > +		start++;
> > +		nvs_pages =3D tmp;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int acpi_hibernation_allocate_nvs_pages(void)
> > +{
> > +	struct nvs_page *tmp =3D nvs_pages;
> > +
> > +	while (tmp) {
> > +		tmp->data =3D (void *)__get_free_page(GFP_KERNEL);
> > +		if (!tmp->data)
> > +			return -ENOMEM;
>=20
> Perhaps call acpi_hibernation_free_nvs_pages() here too.
>=20
> > +		tmp =3D tmp->next;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int acpi_hibernation_free_nvs_pages(void)
> > +{
> > +	struct nvs_page *tmp =3D nvs_pages;
> > +
> > +	while (tmp) {
> > +		if (tmp->data) {
> > +			free_page((long)tmp->data);
> > +			tmp->data =3D NULL;
> > +		}
> > +		tmp =3D tmp->next;
> > +	}
>=20
> Make nvs_pages =3D NULL explicitly, please.

Ah, sorry, scratch that.  I misread the code.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
