From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH v3 1/8] ACPI: fix synthetic HID for \_SB_
Date: Thu, 24 Sep 2009 09:44:47 +0800
Message-ID: <1253756687.3609.399.camel@localhost.localdomain>
References: <20090921193417.21656.32718.stgit@bob.kio>
	 <20090921193504.21656.68847.stgit@bob.kio>
	 <1253672506.3609.355.camel@localhost.localdomain>
	 <200909231019.17961.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47957 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbZIXBoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Sep 2009 21:44:38 -0400
In-Reply-To: <200909231019.17961.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, "Lin, Ming M" <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thu, 2009-09-24 at 00:19 +0800, Bjorn Helgaas wrote:
> On Tuesday 22 September 2009 08:21:46 pm ykzhao wrote:
> > On Tue, 2009-09-22 at 03:35 +0800, Bjorn Helgaas wrote:
> > > This makes \_SB_ show up as /sys/devices/LNXSYSTM:00/LNXSYBUS:00
> > > rather than "device:00".  This has been broken for a loooong time
> > > (at least since 2.6.13) because device->parent is an acpi_device
> > > pointer, not a handle.
> >=20
> > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > ---
> > >  drivers/acpi/scan.c |   18 ++++++------------
> > >  1 files changed, 6 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > index 2c4cac5..e9227ea 100644
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -1100,6 +1100,12 @@ static void acpi_device_set_id(struct acpi=
_device *device)
> > >  		if (ACPI_IS_ROOT_DEVICE(device)) {
> > >  			hid =3D ACPI_SYSTEM_HID;
> > >  			break;
> > > +		} else if (ACPI_IS_ROOT_DEVICE(device->parent)) {
>=20
> > Can we still add the judgement about the device type?
> >    device->type =3D=3D ACPI_BUS_TYPE_DEVICE
>=20
> We are already checking this because this test is inside the
> ACPI_BUS_TYPE_DEVICE case of a switch statement.
If this is checed inside the ACPI_BUS_TYPE_DEVICE case, can we delete
the following check as =EF=BB=BFthe type of root device is ACPI_BUS_TYP=
E_SYSTEM?
   If (ACPI_IS_ROOT_DEVICE(device)) {
		hid =3D ACPI_SYSTEM_HID;
		break;
	}
 =20
>=20
> > Where can I find the macro definition of ACPI_IS_ROOT_DEVICE?
>=20
> It's patch 13/17 in the previous "ACPI: cleanups for hotplug" series.
> I should have mentioned that this series depends on that one.
Yes.=20
I also find that it is defined in patch 13/17.
It had better be defined as early as possible. Otherwise we may fail in
git-bisect.
thanks.
>=20
> Bjorn
>=20
> > > +			/* \_SB_, the only root-level namespace device */
> > > +			hid =3D ACPI_BUS_HID;
> > > +			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > > +			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > > +			break;
> > >  		}
> > > =20
> > >  		status =3D acpi_get_object_info(device->handle, &info);
> > > @@ -1149,18 +1155,6 @@ static void acpi_device_set_id(struct acpi=
_device *device)
> > >  		break;
> > >  	}
> > > =20
> > > -	/*
> > > -	 * \_SB
> > > -	 * ----
> > > -	 * Fix for the system root bus device -- the only root-level de=
vice.
> > > -	 */
> > > -	if (((acpi_handle)device->parent =3D=3D ACPI_ROOT_OBJECT) &&
> > > -	     (device->device_type =3D=3D ACPI_BUS_TYPE_DEVICE)) {
> > > -		hid =3D ACPI_BUS_HID;
> > > -		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > > -		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > > -	}
> > > -
> > >  	if (hid) {
> > >  		device->pnp.hardware_id =3D ACPI_ALLOCATE_ZEROED(strlen (hid) =
+ 1);
> > >  		if (device->pnp.hardware_id) {
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-a=
cpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >=20
> >=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
