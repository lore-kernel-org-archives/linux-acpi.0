From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI: Export PLD (Physical Location of Device)
Date: Mon, 07 Jul 2014 23:03:56 +0200
Message-ID: <1884955.CnA0paX6L0@vostro.rjw.lan>
References: <56D4B9BFEADA5948B14547D2A81CE2C027AC3BD0@HASMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64969 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751048AbaGGUpx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jul 2014 16:45:53 -0400
In-Reply-To: <56D4B9BFEADA5948B14547D2A81CE2C027AC3BD0@HASMSX104.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tenoutit, Faouaz" <faouaz.tenoutit@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday, July 02, 2014 09:01:04 AM Tenoutit, Faouaz wrote:
> This patch will export a sysfs entry with PLD information for each ac=
pi device:
>=20
> $ ls -l /sys/bus/acpi/devices/ACPI-DEV/pld
> -r--r--r-- root     root         4096 2014-05-30 08:39 bay
> -r--r--r-- root     root         4096 2014-05-30 08:39 cabinet_number
> -r--r--r-- root     root         4096 2014-05-30 08:39 card_cage_numb=
er
> -r--r--r-- root     root         4096 2014-05-30 08:39 color
> -r--r--r-- root     root         4096 2014-05-30 08:39 dock
> -r--r--r-- root     root         4096 2014-05-30 08:39 ejectable
> -r--r--r-- root     root         4096 2014-05-30 08:39 group_orientat=
ion
> -r--r--r-- root     root         4096 2014-05-30 08:39 group_position
> -r--r--r-- root     root         4096 2014-05-30 08:39 group_token
> -r--r--r-- root     root         4096 2014-05-30 08:39 height
> -r--r--r-- root     root         4096 2014-05-30 08:39 horizontal_off=
set
> -r--r--r-- root     root         4096 2014-05-30 08:39 horizontal_pos=
ition
> -r--r--r-- root     root         4096 2014-05-30 08:39 ignore_color
> -r--r--r-- root     root         4096 2014-05-30 08:39 lid
> -r--r--r-- root     root         4096 2014-05-30 08:39 order
> -r--r--r-- root     root         4096 2014-05-30 08:39 ospm_eject_req=
uired
> -r--r--r-- root     root         4096 2014-05-30 08:39 panel
> -r--r--r-- root     root         4096 2014-05-30 08:39 reference
> -r--r--r-- root     root         4096 2014-05-30 08:39 revision
> -r--r--r-- root     root         4096 2014-05-30 08:39 rotation
> -r--r--r-- root     root         4096 2014-05-30 08:39 shape
> -r--r--r-- root     root         4096 2014-05-30 08:39 user_visible
> -r--r--r-- root     root         4096 2014-05-30 08:39 vertical_offse=
t
> -r--r--r-- root     root         4096 2014-05-30 08:39 vertical_posit=
ion
> -r--r--r-- root     root         4096 2014-05-30 08:39 width
>=20
> This information can be used by user applications to:
> - Determine which specific connector or device input mechanism may be=
 used
> for a given task.
> - Describes which panel surface of the system=E2=80=99s housing the d=
evice
> connection point resides on (Front, Back, ...)
>=20
> More information about these PLD fields can be found here:
> Documentation/ABI/testing/sysfs-bus-acpi
>=20
> Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
> Acked-by: Andrew J Ross <andrew.j.ross@intel.com>

It doesn't look like the majority of this patch is necessary for patch =
[2/2].

Can you please separate out the part needed by patch [2/2] from it?

I'm not sure if it's a good idea to export all _PLD information to user=
 space
this way.  Is there any particular user space framework that needs this
information?


> ---
>  Documentation/ABI/testing/sysfs-bus-acpi | 144 +++++++++++++++++++++=
++++++++++
>  drivers/acpi/scan.c                      |  97 +++++++++++++++++++++
>  include/acpi/acpi_bus.h                  |   1 +
>  3 files changed, 242 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation=
/ABI/testing/sysfs-bus-acpi
> index 7fa9cbc..a1a5e24 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -56,3 +56,147 @@ Description:
>          Writing 1 to this attribute will trigger hot removal of
>          this device object.  This file exists for every device
>          object that has _EJ0 method.
> +
> +What:        /sys/bus/acpi/devices/.../pld
> +Date:        June 2014
> +Contact:    Faouaz Tenoutit <faouaz.tenoutit@intel.com>
> +Description:
> +    This optional folder provides description of the physical
> +    location of a device=E2=80=99s external connection point.
> +    This information can be used by system software to describe
> +    to the user which specific connector or device input
> +    mechanism may be used for a given task or may need user
> +    intervention for correct operation.
> +
> +    The entries of this folder are described bellow:
> +
> +--------------------------------------------------------------------=
-
> +    Name            |                   Description
> +--------------------------------------------------------------------=
-
> +revision            | The current Revision is 0x2
> +--------------------------------------------------------------------=
-
> +ignore_color        | If this bit is set, the Color field is ignored=
,
> +                    | as the color is unknown.
> +--------------------------------------------------------------------=
-
> +color               | 24-bit RGB value for the color of the device
> +                    | connection point.
> +                    | Bits 8:15=3Dred value
> +                    | Bits 16:23=3Dgreen value
> +                    | Bits 24:31=3Dblue value
> +--------------------------------------------------------------------=
-
> +width               | Width of the widest point of the device
> +                    | connection point, in millimeters
> +--------------------------------------------------------------------=
-
> +height              | Height of the tallest point of the device
> +                    | connection point, in millimeters
> +--------------------------------------------------------------------=
-
> +user_visible        | Set if the device connection point can be
> +                    | seen by the user without disassembly.
> +--------------------------------------------------------------------=
-
> +dock                | Set if the device connection point resides in
> +                    | a docking station or port replicator.
> +--------------------------------------------------------------------=
-
> +lid                 | Set if this device connection point resides on
> +                    | the lid of laptop system.
> +--------------------------------------------------------------------=
-
> +panel               | Describes which panel surface of the
> +                    | system=E2=80=99s housing the device connection
> +                    | point resides on:
> +                    |   0 =E2=80=93 Top
> +                    |   1 =E2=80=93 Bottom
> +                    |   2 =E2=80=93 Left
> +                    |   3 =E2=80=93 Right
> +                    |   4 =E2=80=93 Front
> +                    |   5 =E2=80=93 Back
> +                    |   6 =E2=80=93 Unknown (Vertical Position and
> +                    |       Horizontal Position will be ignored)
> +--------------------------------------------------------------------=
-
> +vertical_position   | Vertical position on the panel where the
> +                    | device connection point resides:
> +                    |   0 =E2=80=93 Upper
> +                    |   1 =E2=80=93 Center
> +                    |   2 =E2=80=93 Lower
> +--------------------------------------------------------------------=
-
> +horizontal_position | Horizontal position on the panel where the
> +                    | device connection point resides:
> +                    |   0 =E2=80=93 Upper
> +                    |   1 =E2=80=93 Center
> +                    |   2 =E2=80=93 Lower
> +--------------------------------------------------------------------=
-
> +shape               | Describes the shape of the device
> +                    | connection point. The Width and Height
> +                    | fields may be used to distort a shape, e.g. A
> +                    | Round shape will look like an Oval shape if
> +                    | the Width and Height are not equal. And a
> +                    | Vertical Rectangle or Horizontal Rectangle
> +                    | may look like a square if Width and Height
> +                    | are equal.
> +                    |   0 =E2=80=93 Round
> +                    |   1 =E2=80=93 Oval
> +                    |   2 =E2=80=93 Square
> +                    |   3 =E2=80=93 Vertical Rectangle
> +                    |   4 =E2=80=93 Horizontal Rectangle
> +                    |   5 =E2=80=93 Vertical Trapezoid
> +                    |   6 =E2=80=93 Horizontal Trapezoid
> +                    |   7 =E2=80=93 Unknown =E2=80=93 Shape rendered=
 as a
> +                    |       Rectangle with dotted lines
> +                    |   8 =E2=80=93 Chamfered
> +--------------------------------------------------------------------=
-
> +group_orientation   | if Set, indicates vertical grouping, otherwise
> +                    | horizontal is assumed.
> +--------------------------------------------------------------------=
-
> +group_token         | Unique numerical value identifying a group.
> +--------------------------------------------------------------------=
-
> +group_position      | Identifies this device connection point=E2=80=99=
s
> +                    | position in the group (i.e. 1st, 2nd)
> +--------------------------------------------------------------------=
-
> +bay                 | Set if describing a device in a bay or if
> +                    | device connection point is a bay.
> +--------------------------------------------------------------------=
-
> +ejectable           | Set if the device is ejectable. Indicates
> +                    | ejectability in the absence of _EJx objects.
> +--------------------------------------------------------------------=
-
> +ospm_eject_required | OSPM Ejection required: Set if OSPM
> +                    | needs to be involved with ejection process.
> +                    | User-operated physical hardware ejection is
> +                    | not possible.
> +--------------------------------------------------------------------=
-
> +cabinet_number      | For single cabinet system, this field is
> +                    | Number always 0.
> +--------------------------------------------------------------------=
-
> +card_cage_number    | For single card cage system, this field is
> +                    | Number always 0.
> +--------------------------------------------------------------------=
-
> +reference           | if Set, this _PLD defines a =E2=80=9Creference=
=E2=80=9D shape
> +                    | that is used to help orient the user with
> +                    | respect to the other shapes when rendering
> +                    | _PLDs.
> +--------------------------------------------------------------------=
-
> +rotation            | Rotates the Shape clockwise in 45 degree
> +                    | steps around its origin where:
> +                    |   0 =E2=80=93 0=C2=B0
> +                    |   1 =E2=80=93 45=C2=B0
> +                    |   2 =E2=80=93 90=C2=B0
> +                    |   3 =E2=80=93 135=C2=B0
> +                    |   4 =E2=80=93 180=C2=B0
> +                    |   5 =E2=80=93 225=C2=B0
> +                    |   6 =E2=80=93 270=C2=B0
> +                    |   7 =E2=80=93 315=C2=B0
> +--------------------------------------------------------------------=
-
> +order               | Identifies the drawing order of the
> +                    | connection point described by a _PLD.
> +                    | Order =3D 0 connection points are drawn
> +                    | before Order =3D 1 connection points. Order =3D
> +                    | 1 before Order =3D 2, and so on. Order =3D 31
> +                    | connection points are drawn last. Order
> +                    | should always start at 0 and be
> +                    | consecutively assigned.
> +--------------------------------------------------------------------=
-
> +vertical_offset     | Offset of Shape Origin from Panel Origin (in
> +                    | mm). A value of 0xFFFFFFFF indicates that
> +                    | this field is not supplied.
> +--------------------------------------------------------------------=
-
> +horizontal_offset   | Offset of Shape Origin from Panel Origin (in
> +                    | mm). A value of 0xFFFFFFFF indicates that
> +                    | this field is not supplied.
> +--------------------------------------------------------------------=
-
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7efe546..53957be 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -683,6 +683,78 @@ static ssize_t status_show(struct device *dev, s=
truct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(status);
>=20
> +#define ACPI_SYSFS_PLD_PROP(prop)                       \
> +static ssize_t prop##_show(struct device *dev,          \
> +                struct device_attribute *attr,          \
> +                char *buf) {                            \
> +    struct acpi_device *acpi_dev =3D to_acpi_device(dev); \
> +    return sprintf(buf, "%d\n", acpi_dev->pld->prop);   \
> +};                                                      \
> +static DEVICE_ATTR_RO(prop);
> +
> +/*
> + * sysfs PLD parameters
> + */
> +ACPI_SYSFS_PLD_PROP(revision);
> +ACPI_SYSFS_PLD_PROP(ignore_color);
> +ACPI_SYSFS_PLD_PROP(color);
> +ACPI_SYSFS_PLD_PROP(width);
> +ACPI_SYSFS_PLD_PROP(height);
> +ACPI_SYSFS_PLD_PROP(user_visible);
> +ACPI_SYSFS_PLD_PROP(dock);
> +ACPI_SYSFS_PLD_PROP(lid);
> +ACPI_SYSFS_PLD_PROP(panel);
> +ACPI_SYSFS_PLD_PROP(vertical_position);
> +ACPI_SYSFS_PLD_PROP(horizontal_position);
> +ACPI_SYSFS_PLD_PROP(shape);
> +ACPI_SYSFS_PLD_PROP(group_orientation);
> +ACPI_SYSFS_PLD_PROP(group_token);
> +ACPI_SYSFS_PLD_PROP(group_position);
> +ACPI_SYSFS_PLD_PROP(bay);
> +ACPI_SYSFS_PLD_PROP(ejectable);
> +ACPI_SYSFS_PLD_PROP(ospm_eject_required);
> +ACPI_SYSFS_PLD_PROP(cabinet_number);
> +ACPI_SYSFS_PLD_PROP(card_cage_number);
> +ACPI_SYSFS_PLD_PROP(reference);
> +ACPI_SYSFS_PLD_PROP(rotation);
> +ACPI_SYSFS_PLD_PROP(order);
> +ACPI_SYSFS_PLD_PROP(vertical_offset);
> +ACPI_SYSFS_PLD_PROP(horizontal_offset);
> +
> +static struct attribute *acpi_pld_attrs[] =3D {
> +    &dev_attr_revision.attr,
> +    &dev_attr_ignore_color.attr,
> +    &dev_attr_color.attr,
> +    &dev_attr_width.attr,
> +    &dev_attr_height.attr,
> +    &dev_attr_user_visible.attr,
> +    &dev_attr_dock.attr,
> +    &dev_attr_lid.attr,
> +    &dev_attr_panel.attr,
> +    &dev_attr_vertical_position.attr,
> +    &dev_attr_horizontal_position.attr,
> +    &dev_attr_shape.attr,
> +    &dev_attr_group_orientation.attr,
> +    &dev_attr_group_token.attr,
> +    &dev_attr_group_position.attr,
> +    &dev_attr_bay.attr,
> +    &dev_attr_ejectable.attr,
> +    &dev_attr_ospm_eject_required.attr,
> +    &dev_attr_cabinet_number.attr,
> +    &dev_attr_card_cage_number.attr,
> +    &dev_attr_reference.attr,
> +    &dev_attr_rotation.attr,
> +    &dev_attr_order.attr,
> +    &dev_attr_vertical_offset.attr,
> +    &dev_attr_horizontal_offset.attr,
> +    NULL,
> +};
> +
> +static const struct attribute_group acpi_pld_attr_group =3D {
> +    .name =3D "pld",
> +    .attrs =3D acpi_pld_attrs,
> +};
> +
>  static int acpi_device_setup_files(struct acpi_device *dev)
>  {
>      struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -764,6 +836,23 @@ static int acpi_device_setup_files(struct acpi_d=
evice *dev)
>                              &dev_attr_real_power_state);
>      }
>=20
> +    /*
> +     * If device has _PLD, 'pld' directory is created
> +     */
> +    if (acpi_has_method(dev->handle, "_PLD")) {
> +        status =3D acpi_get_physical_device_location(dev->handle,
> +                    &dev->pld);
> +        if (ACPI_SUCCESS(status)) {
> +            result =3D sysfs_create_group(&dev->dev.kobj,
> +                        &acpi_pld_attr_group);
> +            if (result) {
> +                ACPI_FREE(dev->pld);
> +                dev->pld =3D NULL;
> +                goto end;
> +            }
> +        }
> +    }
> +
>  end:
>      return result;
>  }
> @@ -803,6 +892,14 @@ static void acpi_device_remove_files(struct acpi=
_device *dev)
>          device_remove_file(&dev->dev, &dev_attr_status);
>      if (dev->handle)
>          device_remove_file(&dev->dev, &dev_attr_path);
> +
> +    /*
> +     * If device has _PLD, remove 'pld' directory
> +     */
> +    if (dev->pld) {
> +        sysfs_remove_group(&dev->dev.kobj, &acpi_pld_attr_group);
> +        ACPI_FREE(dev->pld);
> +    }
>  }
>  /* -----------------------------------------------------------------=
---------
>              ACPI Bus operations
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 84a2e29..92d174e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -347,6 +347,7 @@ struct acpi_device {
>      struct acpi_scan_handler *handler;
>      struct acpi_hotplug_context *hp;
>      struct acpi_driver *driver;
> +    struct acpi_pld_info *pld;
>      void *driver_data;
>      struct device dev;
>      unsigned int physical_node_count;
> --
>=20
>=20
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,=20
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
>=20
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
