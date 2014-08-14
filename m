From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/2] ACPI: Export PLD (Physical Location of Device)
Date: Thu, 14 Aug 2014 02:15:22 +0200
Message-ID: <27105216.5Wqnan19yy@vostro.rjw.lan>
References: <1407950132-15863-1-git-send-email-sameo@linux.intel.com> <1407950132-15863-2-git-send-email-sameo@linux.intel.com> <20140813220524.GF7908@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53750 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752104AbaHMX4b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2014 19:56:31 -0400
In-Reply-To: <20140813220524.GF7908@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-acpi@vger.kernel.org, Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

On Thursday, August 14, 2014 06:05:24 AM Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2014 at 07:15:32PM +0200, Samuel Ortiz wrote:
> > From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> >=20
> > This patch exports a sysfs directory with ACPI _PLD information:
> >=20
> > $ ls -l /sys/bus/acpi/devices/ACPI-DEV/pld
> > -r--r--r-- root     root         4096 2014-05-30 08:39 panel
> > -r--r--r-- root     root         4096 2014-05-30 08:39 revision
> > -r--r--r-- root     root         4096 2014-05-30 08:39 rotation
> > -r--r--r-- root     root         4096 2014-05-30 08:39 shape
> >=20
> > This information can be used by user applications to:
> > - Determine which specific connector or device input mechanism may =
be used
> >   for a given task.
> > - Describes which panel surface of the system's housing the device
> >   connection point resides on (Front, Back, ...)
> >=20
> > More information about these _PLD fields can be found here:
> > Documentation/ABI/testing/sysfs-bus-acpi
> >=20
> > Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> > Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
> > Acked-by: Andrew J Ross <andrew.j.ross@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-acpi | 60 ++++++++++++++++++++=
++++++++++++
> >  drivers/acpi/scan.c                      | 53 ++++++++++++++++++++=
++++----
> >  2 files changed, 107 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentati=
on/ABI/testing/sysfs-bus-acpi
> > index 7fa9cbc..be58159 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > @@ -56,3 +56,63 @@ Description:
> >  		Writing 1 to this attribute will trigger hot removal of
> >  		this device object.  This file exists for every device
> >  		object that has _EJ0 method.
> > +
> > +What:		/sys/bus/acpi/devices/.../pld
> > +Date:		August 2014
> > +Contact:	Faouaz Tenoutit <faouaz.tenoutit@intel.com>
> > +Description:
> > +		This optional directory provides description of the physical
> > +		location, orientation and position of external devices.
> > +		It is for example used to describe how camera sensors are
> > +		physically mounted and allows user space software to rotate
> > +		images accordingly.
> > +
> > +What:		/sys/bus/acpi/devices/.../pld/revision
> > +Date:		August 2014
> > +Contact:	Faouaz Tenoutit <faouaz.tenoutit@intel.com>
> > +Description:
> > +		The current Revision is 0x2
> > +
> > +What:		/sys/bus/acpi/devices/.../pld/panel
> > +Date:		August 2014
> > +Contact:	Faouaz Tenoutit <faouaz.tenoutit@intel.com>
> > +Description:
> > +		Describes which panel surface of the system's housing the device
> > +		connection point resides on:
> > +		0 Top
> > +		1 Bottom
> > +		2 Left
> > +		3 Right
> > +		4 Front
> > +		5 Back
> > +		6 Unknown
> > +
> > +What:		/sys/bus/acpi/devices/.../pld/shape
> > +Date:		August 2014
> > +Contact:	Faouaz Tenoutit <faouaz.tenoutit@intel.com>
> > +Description:
> > +		Describes the shape of the device connection point:
> > +		0 Round
> > +		1 Oval
> > +		2 Square
> > +		3 Vertical Rectangle
> > +		4 Horizontal Rectangle
> > +		5 Vertical Trapezoid
> > +		6 Horizontal Trapezoid
> > +		7 Unknown - Shape rendered as a Rectangle with dotted lines
> > +		8 Chamfered
> > +
> > +What:		/sys/bus/acpi/devices/.../pld/rotation
> > +Date:		August 2014
> > +Contact:	Faouaz Tenoutit <faouaz.tenoutit@intel.com>
> > +Description:
> > +		Rotates the Shape clockwise in 45 degree steps around its
> > +		origin where:
> > +		0 0=C2=B0
> > +		1 45=C2=B0
> > +		2 90=C2=B0
> > +		3 135=C2=B0
> > +		4 180=C2=B0
> > +		5 225=C2=B0
> > +		6 270=C2=B0
> > +		7 315=C2=B0
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 2ca42d5..19889a3 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -686,6 +686,36 @@ static ssize_t status_show(struct device *dev,=
 struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(status);
> > =20
> > +#define ACPI_SYSFS_PLD_PROP(prop)				\
> > +	static ssize_t prop##_show(struct device *dev,		\
> > +			   struct device_attribute *attr,	\
> > +			   char *buf) {				\
> > +	struct acpi_device *acpi_dev =3D to_acpi_device(dev);     \
> > +	return sprintf(buf, "%d\n", acpi_dev->pld->prop);       \
> > +};							        \
> > +static DEVICE_ATTR_RO(prop)
> > +
> > +/*
> > + * sysfs PLD parameters
> > + */
> > +ACPI_SYSFS_PLD_PROP(revision);
> > +ACPI_SYSFS_PLD_PROP(panel);
> > +ACPI_SYSFS_PLD_PROP(shape);
> > +ACPI_SYSFS_PLD_PROP(rotation);
> > +
> > +static struct attribute *acpi_pld_attrs[] =3D {
> > +	&dev_attr_revision.attr,
> > +	&dev_attr_panel.attr,
> > +	&dev_attr_shape.attr,
> > +	&dev_attr_rotation.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group acpi_pld_attr_group =3D {
> > +	.name =3D "pld",
> > +	.attrs =3D acpi_pld_attrs,
> > +};
> > +
> >  static int acpi_device_setup_files(struct acpi_device *dev)
> >  {
> >  	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> > @@ -768,11 +798,20 @@ static int acpi_device_setup_files(struct acp=
i_device *dev)
> >  	}
> > =20
> >  	/*
> > -	 * If device has _PLD, initialize the 'pld' struct
> > +	 * If device has _PLD, 'pld' directory is created
> >  	 */
> > -	if (acpi_has_method(dev->handle, "_PLD"))
> > -		acpi_get_physical_device_location(dev->handle,
> > -						  &dev->pld);
> > +	if (acpi_has_method(dev->handle, "_PLD")) {
> > +		status =3D acpi_get_physical_device_location(dev->handle,
> > +							   &dev->pld);
> > +		if (ACPI_SUCCESS(status)) {
> > +			result =3D sysfs_create_group(&dev->dev.kobj,
> > +						    &acpi_pld_attr_group);
>=20
> It's a device, why not call device_create_groups()?
>=20
>=20
> > +			if (result) {
> > +				ACPI_FREE(dev->pld);
> > +				dev->pld =3D NULL;
> > +			}
> > +		}
> > +	}
>=20
> Is this being called after or before the device in question is
> registered with the driver core?
>=20
> Hint, I think I know the answer, but I want you to learn why this cod=
e
> is wrong and will not work properly...

It will work.  There are other groups created in the same function and =
ACPI has
a deferred KOBJ_ADD notification.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
