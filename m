From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v3 1/8] ACPI: fix synthetic HID for \_SB_
Date: Thu, 24 Sep 2009 15:42:00 -0600
Message-ID: <200909241542.01368.bjorn.helgaas@hp.com>
References: <20090921193417.21656.32718.stgit@bob.kio> <1253763417.12653.19.camel@dc7800.home> <1253769748.3609.447.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:1052 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZIXVl7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2009 17:41:59 -0400
In-Reply-To: <1253769748.3609.447.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, "Lin, Ming M" <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wednesday 23 September 2009 11:22:28 pm ykzhao wrote:
> On Thu, 2009-09-24 at 11:36 +0800, Bjorn Helgaas wrote:
> > On Thu, 2009-09-24 at 09:44 +0800, ykzhao wrote:
> > > On Thu, 2009-09-24 at 00:19 +0800, Bjorn Helgaas wrote:
> > > > On Tuesday 22 September 2009 08:21:46 pm ykzhao wrote:
> > > > > On Tue, 2009-09-22 at 03:35 +0800, Bjorn Helgaas wrote:
> > > > > > This makes \_SB_ show up as /sys/devices/LNXSYSTM:00/LNXSYB=
US:00
> > > > > > rather than "device:00".  This has been broken for a loooon=
g time
> > > > > > (at least since 2.6.13) because device->parent is an acpi_d=
evice
> > > > > > pointer, not a handle.
> > > > >=20
> > > > > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > > > > ---
> > > > > >  drivers/acpi/scan.c |   18 ++++++------------
> > > > > >  1 files changed, 6 insertions(+), 12 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > > > > index 2c4cac5..e9227ea 100644
> > > > > > --- a/drivers/acpi/scan.c
> > > > > > +++ b/drivers/acpi/scan.c
> > > > > > @@ -1100,6 +1100,12 @@ static void acpi_device_set_id(struc=
t acpi_device *device)
> > > > > >  		if (ACPI_IS_ROOT_DEVICE(device)) {
> > > > > >  			hid =3D ACPI_SYSTEM_HID;
> > > > > >  			break;
> > > > > > +		} else if (ACPI_IS_ROOT_DEVICE(device->parent)) {
> > > >=20
> > > > > Can we still add the judgement about the device type?
> > > > >    device->type =3D=3D ACPI_BUS_TYPE_DEVICE
> > > >=20
> > > > We are already checking this because this test is inside the
> > > > ACPI_BUS_TYPE_DEVICE case of a switch statement.
> > > If this is checed inside the ACPI_BUS_TYPE_DEVICE case, can we de=
lete
> > > the following check as =EF=BB=BFthe type of root device is ACPI_B=
US_TYPE_SYSTEM?
> > >    If (ACPI_IS_ROOT_DEVICE(device)) {
> > > 		hid =3D ACPI_SYSTEM_HID;
> > > 		break;
> > > 	}
> >=20
> > What?  Are you saying that we shouldn't add a HID of "LNXSYSTM" to =
the
> > root object?  I'm really not sure what you're proposing.
> Maybe I mix the two patch sets. One has 8 patches. And another has 17
> patches. In fact there exists the dependency between the two patch se=
t.

Yes, the second series ("make every acpi_device have a HID") does
depend on the first series ("cleanups for hotplug").  I forgot to
mention that in the initial posting, sorry.

> And you delete the ACPI_BUS_TYPE_SYSTEM type in another patch set,
> right?

Yes, I removed ACPI_BUS_TYPE_SYSTEM in patch [13/17] of the "ACPI:
cleanups for hotplug" series.

> What is the benefit if we change the type from ACPI_BUS_TYPE_SYSTEM t=
o
> ACPI_BUS_TYPE_DEVICE for the root device?

The benefit is removing special cases from the code.  If we don't
need to keep track of the difference between ACPI_BUS_TYPE_SYSTEM
and ACPI_BUS_TYPE_DEVICE, we shouldn't do it.

Bjorn

> Thanks.
> >=20
> > > >=20
> > > > > Where can I find the macro definition of ACPI_IS_ROOT_DEVICE?
> > > >=20
> > > > It's patch 13/17 in the previous "ACPI: cleanups for hotplug" s=
eries.
> > > > I should have mentioned that this series depends on that one.
> > > Yes.=20
> > > I also find that it is defined in patch 13/17.
> > > It had better be defined as early as possible. Otherwise we may f=
ail in
> > > git-bisect.
> >=20
> > Absolutely.  I'm pretty sure I defined ACPI_IS_ROOT_DEVICE before a=
ny
> > uses of it, but please point it out if I'm mistaken.
> >=20
> > Bjorn
> >=20
> > > > > > +			/* \_SB_, the only root-level namespace device */
> > > > > > +			hid =3D ACPI_BUS_HID;
> > > > > > +			strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > > > > > +			strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > > > > > +			break;
> > > > > >  		}
> > > > > > =20
> > > > > >  		status =3D acpi_get_object_info(device->handle, &info);
> > > > > > @@ -1149,18 +1155,6 @@ static void acpi_device_set_id(struc=
t acpi_device *device)
> > > > > >  		break;
> > > > > >  	}
> > > > > > =20
> > > > > > -	/*
> > > > > > -	 * \_SB
> > > > > > -	 * ----
> > > > > > -	 * Fix for the system root bus device -- the only root-le=
vel device.
> > > > > > -	 */
> > > > > > -	if (((acpi_handle)device->parent =3D=3D ACPI_ROOT_OBJECT)=
 &&
> > > > > > -	     (device->device_type =3D=3D ACPI_BUS_TYPE_DEVICE)) {
> > > > > > -		hid =3D ACPI_BUS_HID;
> > > > > > -		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
> > > > > > -		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
> > > > > > -	}
> > > > > > -
> > > > > >  	if (hid) {
> > > > > >  		device->pnp.hardware_id =3D ACPI_ALLOCATE_ZEROED(strlen =
(hid) + 1);
> > > > > >  		if (device->pnp.hardware_id) {
> > > > > >=20
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe l=
inux-acpi" in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-in=
fo.html
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > >=20
> >=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
