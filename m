From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH v3 1/8] ACPI: fix synthetic HID for \_SB_
Date: Thu, 24 Sep 2009 13:22:28 +0800
Message-ID: <1253769748.3609.447.camel@localhost.localdomain>
References: <20090921193417.21656.32718.stgit@bob.kio>
	 <20090921193504.21656.68847.stgit@bob.kio>
	 <1253672506.3609.355.camel@localhost.localdomain>
	 <200909231019.17961.bjorn.helgaas@hp.com>
	 <1253756687.3609.399.camel@localhost.localdomain>
	 <1253763417.12653.19.camel@dc7800.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40349 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbZIXFWT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Sep 2009 01:22:19 -0400
In-Reply-To: <1253763417.12653.19.camel@dc7800.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, "Lin, Ming M" <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, 2009-09-24 at 11:36 +0800, Bjorn Helgaas wrote:
> On Thu, 2009-09-24 at 09:44 +0800, ykzhao wrote:
> > On Thu, 2009-09-24 at 00:19 +0800, Bjorn Helgaas wrote:
> > > On Tuesday 22 September 2009 08:21:46 pm ykzhao wrote:
> > > > On Tue, 2009-09-22 at 03:35 +0800, Bjorn Helgaas wrote:
> > > > > This makes \_SB_ show up as /sys/devices/LNXSYSTM:00/LNXSYBUS=
:00
> > > > > rather than "device:00".  This has been broken for a loooong =
time
> > > > > (at least since 2.6.13) because device->parent is an acpi_dev=
ice
> > > > > pointer, not a handle.
> > > >=20
> > > > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > > > ---
> > > > >  drivers/acpi/scan.c |   18 ++++++------------
> > > > >  1 files changed, 6 insertions(+), 12 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > > > index 2c4cac5..e9227ea 100644
> > > > > --- a/drivers/acpi/scan.c
> > > > > +++ b/drivers/acpi/scan.c
> > > > > @@ -1100,6 +1100,12 @@ static void acpi_device_set_id(struct =
acpi_device *device)
> > > > >  		if (ACPI_IS_ROOT_DEVICE(device)) {
> > > > >  			hid =3D ACPI_SYSTEM_HID;
> > > > >  			break;
> > > > > +		} else if (ACPI_IS_ROOT_DEVICE(device->parent)) {
> > >=20
> > > > Can we still add the judgement about the device type?
> > > >    device->type =3D=3D ACPI_BUS_TYPE_DEVICE
> > >=20
> > > We are already checking this because this test is inside the
> > > ACPI_BUS_TYPE_DEVICE case of a switch statement.
> > If this is checed inside the ACPI_BUS_TYPE_DEVICE case, can we dele=
te
> > the following check as =EF=BB=BFthe type of root device is ACPI_BUS=
_TYPE_SYSTEM?
> >    If (ACPI_IS_ROOT_DEVICE(device)) {
> > 		hid =3D ACPI_SYSTEM_HID;
> > 		break;
> > 	}
>=20
> What?  Are you saying that we shouldn't add a HID of "LNXSYSTM" to th=
e
> root object?  I'm really not sure what you're proposing.
Maybe I mix the two patch sets. One has 8 patches. And another has 17
patches. In fact there exists the dependency between the two patch set.

And you delete the ACPI_BUS_TYPE_SYSTEM type in another patch set,
right?

What is the benefit if we change the type from ACPI_BUS_TYPE_SYSTEM to
ACPI_BUS_TYPE_DEVICE for the root device?

Thanks.
>=20
> > >=20
> > > > Where can I find the macro definition of ACPI_IS_ROOT_DEVICE?
> > >=20
> > > It's patch 13/17 in the previous "ACPI: cleanups for hotplug" ser=
ies.
> > > I should have mentioned that this series depends on that one.
> > Yes.=20
> > I also find that it is defined in patch 13/17.
> > It had better be defined as early as possible. Otherwise we may fai=
l in
> > git-bisect.
>=20
> Absolutely.  I'm pretty sure I defined ACPI_IS_ROOT_DEVICE before any
> uses of it, but please point it out if I'm mistaken.
>=20
> Bjorn
>=20
> > > > > +			/* \_SB_, the only root-level namespace device */
> > > > > +			hid =3D ACPI_BUS_HID;
> > > > > +			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > > > > +			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > > > > +			break;
> > > > >  		}
> > > > > =20
> > > > >  		status =3D acpi_get_object_info(device->handle, &info);
> > > > > @@ -1149,18 +1155,6 @@ static void acpi_device_set_id(struct =
acpi_device *device)
> > > > >  		break;
> > > > >  	}
> > > > > =20
> > > > > -	/*
> > > > > -	 * \_SB
> > > > > -	 * ----
> > > > > -	 * Fix for the system root bus device -- the only root-leve=
l device.
> > > > > -	 */
> > > > > -	if (((acpi_handle)device->parent =3D=3D ACPI_ROOT_OBJECT) &=
&
> > > > > -	     (device->device_type =3D=3D ACPI_BUS_TYPE_DEVICE)) {
> > > > > -		hid =3D ACPI_BUS_HID;
> > > > > -		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > > > > -		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > > > > -	}
> > > > > -
> > > > >  	if (hid) {
> > > > >  		device->pnp.hardware_id =3D ACPI_ALLOCATE_ZEROED(strlen (h=
id) + 1);
> > > > >  		if (device->pnp.hardware_id) {
> > > > >=20
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe lin=
ux-acpi" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
> > > >=20
> > > >=20
> > >=20
> > >=20
> >=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
