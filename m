From: "Tenoutit, Faouaz" <faouaz.tenoutit@intel.com>
Subject: [PATCH 2/2 V2] ACPI: Export PLD (Physical Location of Device)
Date: Wed, 9 Jul 2014 16:43:38 +0000
Message-ID: <56D4B9BFEADA5948B14547D2A81CE2C0284660FD@HASMSX106.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6015 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbaGIQoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2014 12:44:10 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

=46rom: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

This patch will export a sysfs entry with PLD information for each acpi=
 device:

$ ls -l /sys/bus/acpi/devices/ACPI-DEV/pld
-r--r--r-- root     root         4096 2014-05-30 08:39 bay
-r--r--r-- root     root         4096 2014-05-30 08:39 cabinet_number
-r--r--r-- root     root         4096 2014-05-30 08:39 card_cage_number
-r--r--r-- root     root         4096 2014-05-30 08:39 color
-r--r--r-- root     root         4096 2014-05-30 08:39 dock
-r--r--r-- root     root         4096 2014-05-30 08:39 ejectable
-r--r--r-- root     root         4096 2014-05-30 08:39 group_orientatio=
n
-r--r--r-- root     root         4096 2014-05-30 08:39 group_position
-r--r--r-- root     root         4096 2014-05-30 08:39 group_token
-r--r--r-- root     root         4096 2014-05-30 08:39 height
-r--r--r-- root     root         4096 2014-05-30 08:39 horizontal_offse=
t
-r--r--r-- root     root         4096 2014-05-30 08:39 horizontal_posit=
ion
-r--r--r-- root     root         4096 2014-05-30 08:39 ignore_color
-r--r--r-- root     root         4096 2014-05-30 08:39 lid
-r--r--r-- root     root         4096 2014-05-30 08:39 order
-r--r--r-- root     root         4096 2014-05-30 08:39 ospm_eject_requi=
red
-r--r--r-- root     root         4096 2014-05-30 08:39 panel
-r--r--r-- root     root         4096 2014-05-30 08:39 reference
-r--r--r-- root     root         4096 2014-05-30 08:39 revision
-r--r--r-- root     root         4096 2014-05-30 08:39 rotation
-r--r--r-- root     root         4096 2014-05-30 08:39 shape
-r--r--r-- root     root         4096 2014-05-30 08:39 user_visible
-r--r--r-- root     root         4096 2014-05-30 08:39 vertical_offset
-r--r--r-- root     root         4096 2014-05-30 08:39 vertical_positio=
n
-r--r--r-- root     root         4096 2014-05-30 08:39 width

This information can be used by user applications to:
- Determine which specific connector or device input mechanism may be u=
sed
for a given task.
- Describes which panel surface of the system=92s housing the device
connection point resides on (Front, Back, ...)

More information about these PLD fields can be found here:
Documentation/ABI/testing/sysfs-bus-acpi

Signed-off-by: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
Acked-by: Andrew J Ross <andrew.j.ross@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 144 +++++++++++++++++++++++=
++++++++
 drivers/acpi/scan.c                      |  93 ++++++++++++++++++--
 2 files changed, 232 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/A=
BI/testing/sysfs-bus-acpi
index 7fa9cbc..a1a5e24 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -56,3 +56,147 @@ Description:
         Writing 1 to this attribute will trigger hot removal of
         this device object.  This file exists for every device
         object that has _EJ0 method.
+
+What:        /sys/bus/acpi/devices/.../pld
+Date:        June 2014
+Contact:    Faouaz Tenoutit <faouaz.tenoutit@intel.com>
+Description:
+    This optional folder provides description of the physical
+    location of a device=92s external connection point.
+    This information can be used by system software to describe
+    to the user which specific connector or device input
+    mechanism may be used for a given task or may need user
+    intervention for correct operation.
+
+    The entries of this folder are described bellow:
+
+---------------------------------------------------------------------
+    Name            |                   Description
+---------------------------------------------------------------------
+revision            | The current Revision is 0x2
+---------------------------------------------------------------------
+ignore_color        | If this bit is set, the Color field is ignored,
+                    | as the color is unknown.
+---------------------------------------------------------------------
+color               | 24-bit RGB value for the color of the device
+                    | connection point.
+                    | Bits 8:15=3Dred value
+                    | Bits 16:23=3Dgreen value
+                    | Bits 24:31=3Dblue value
+---------------------------------------------------------------------
+width               | Width of the widest point of the device
+                    | connection point, in millimeters
+---------------------------------------------------------------------
+height              | Height of the tallest point of the device
+                    | connection point, in millimeters
+---------------------------------------------------------------------
+user_visible        | Set if the device connection point can be
+                    | seen by the user without disassembly.
+---------------------------------------------------------------------
+dock                | Set if the device connection point resides in
+                    | a docking station or port replicator.
+---------------------------------------------------------------------
+lid                 | Set if this device connection point resides on
+                    | the lid of laptop system.
+---------------------------------------------------------------------
+panel               | Describes which panel surface of the
+                    | system=92s housing the device connection
+                    | point resides on:
+                    |   0 =96 Top
+                    |   1 =96 Bottom
+                    |   2 =96 Left
+                    |   3 =96 Right
+                    |   4 =96 Front
+                    |   5 =96 Back
+                    |   6 =96 Unknown (Vertical Position and
+                    |       Horizontal Position will be ignored)
+---------------------------------------------------------------------
+vertical_position   | Vertical position on the panel where the
+                    | device connection point resides:
+                    |   0 =96 Upper
+                    |   1 =96 Center
+                    |   2 =96 Lower
+---------------------------------------------------------------------
+horizontal_position | Horizontal position on the panel where the
+                    | device connection point resides:
+                    |   0 =96 Upper
+                    |   1 =96 Center
+                    |   2 =96 Lower
+---------------------------------------------------------------------
+shape               | Describes the shape of the device
+                    | connection point. The Width and Height
+                    | fields may be used to distort a shape, e.g. A
+                    | Round shape will look like an Oval shape if
+                    | the Width and Height are not equal. And a
+                    | Vertical Rectangle or Horizontal Rectangle
+                    | may look like a square if Width and Height
+                    | are equal.
+                    |   0 =96 Round
+                    |   1 =96 Oval
+                    |   2 =96 Square
+                    |   3 =96 Vertical Rectangle
+                    |   4 =96 Horizontal Rectangle
+                    |   5 =96 Vertical Trapezoid
+                    |   6 =96 Horizontal Trapezoid
+                    |   7 =96 Unknown =96 Shape rendered as a
+                    |       Rectangle with dotted lines
+                    |   8 =96 Chamfered
+---------------------------------------------------------------------
+group_orientation   | if Set, indicates vertical grouping, otherwise
+                    | horizontal is assumed.
+---------------------------------------------------------------------
+group_token         | Unique numerical value identifying a group.
+---------------------------------------------------------------------
+group_position      | Identifies this device connection point=92s
+                    | position in the group (i.e. 1st, 2nd)
+---------------------------------------------------------------------
+bay                 | Set if describing a device in a bay or if
+                    | device connection point is a bay.
+---------------------------------------------------------------------
+ejectable           | Set if the device is ejectable. Indicates
+                    | ejectability in the absence of _EJx objects.
+---------------------------------------------------------------------
+ospm_eject_required | OSPM Ejection required: Set if OSPM
+                    | needs to be involved with ejection process.
+                    | User-operated physical hardware ejection is
+                    | not possible.
+---------------------------------------------------------------------
+cabinet_number      | For single cabinet system, this field is
+                    | Number always 0.
+---------------------------------------------------------------------
+card_cage_number    | For single card cage system, this field is
+                    | Number always 0.
+---------------------------------------------------------------------
+reference           | if Set, this _PLD defines a =93reference=94 shap=
e
+                    | that is used to help orient the user with
+                    | respect to the other shapes when rendering
+                    | _PLDs.
+---------------------------------------------------------------------
+rotation            | Rotates the Shape clockwise in 45 degree
+                    | steps around its origin where:
+                    |   0 =96 0=B0
+                    |   1 =96 45=B0
+                    |   2 =96 90=B0
+                    |   3 =96 135=B0
+                    |   4 =96 180=B0
+                    |   5 =96 225=B0
+                    |   6 =96 270=B0
+                    |   7 =96 315=B0
+---------------------------------------------------------------------
+order               | Identifies the drawing order of the
+                    | connection point described by a _PLD.
+                    | Order =3D 0 connection points are drawn
+                    | before Order =3D 1 connection points. Order =3D
+                    | 1 before Order =3D 2, and so on. Order =3D 31
+                    | connection points are drawn last. Order
+                    | should always start at 0 and be
+                    | consecutively assigned.
+---------------------------------------------------------------------
+vertical_offset     | Offset of Shape Origin from Panel Origin (in
+                    | mm). A value of 0xFFFFFFFF indicates that
+                    | this field is not supplied.
+---------------------------------------------------------------------
+horizontal_offset   | Offset of Shape Origin from Panel Origin (in
+                    | mm). A value of 0xFFFFFFFF indicates that
+                    | this field is not supplied.
+---------------------------------------------------------------------
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7ad6beb..cf03532 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -683,6 +683,78 @@ static ssize_t status_show(struct device *dev, str=
uct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);

+#define ACPI_SYSFS_PLD_PROP(prop)                       \
+static ssize_t prop##_show(struct device *dev,          \
+                struct device_attribute *attr,          \
+                char *buf) {                            \
+    struct acpi_device *acpi_dev =3D to_acpi_device(dev); \
+    return sprintf(buf, "%d\n", acpi_dev->pld->prop);   \
+};                                                      \
+static DEVICE_ATTR_RO(prop)
+
+/*
+ * sysfs PLD parameters
+ */
+ACPI_SYSFS_PLD_PROP(revision);
+ACPI_SYSFS_PLD_PROP(ignore_color);
+ACPI_SYSFS_PLD_PROP(color);
+ACPI_SYSFS_PLD_PROP(width);
+ACPI_SYSFS_PLD_PROP(height);
+ACPI_SYSFS_PLD_PROP(user_visible);
+ACPI_SYSFS_PLD_PROP(dock);
+ACPI_SYSFS_PLD_PROP(lid);
+ACPI_SYSFS_PLD_PROP(panel);
+ACPI_SYSFS_PLD_PROP(vertical_position);
+ACPI_SYSFS_PLD_PROP(horizontal_position);
+ACPI_SYSFS_PLD_PROP(shape);
+ACPI_SYSFS_PLD_PROP(group_orientation);
+ACPI_SYSFS_PLD_PROP(group_token);
+ACPI_SYSFS_PLD_PROP(group_position);
+ACPI_SYSFS_PLD_PROP(bay);
+ACPI_SYSFS_PLD_PROP(ejectable);
+ACPI_SYSFS_PLD_PROP(ospm_eject_required);
+ACPI_SYSFS_PLD_PROP(cabinet_number);
+ACPI_SYSFS_PLD_PROP(card_cage_number);
+ACPI_SYSFS_PLD_PROP(reference);
+ACPI_SYSFS_PLD_PROP(rotation);
+ACPI_SYSFS_PLD_PROP(order);
+ACPI_SYSFS_PLD_PROP(vertical_offset);
+ACPI_SYSFS_PLD_PROP(horizontal_offset);
+
+static struct attribute *acpi_pld_attrs[] =3D {
+    &dev_attr_revision.attr,
+    &dev_attr_ignore_color.attr,
+    &dev_attr_color.attr,
+    &dev_attr_width.attr,
+    &dev_attr_height.attr,
+    &dev_attr_user_visible.attr,
+    &dev_attr_dock.attr,
+    &dev_attr_lid.attr,
+    &dev_attr_panel.attr,
+    &dev_attr_vertical_position.attr,
+    &dev_attr_horizontal_position.attr,
+    &dev_attr_shape.attr,
+    &dev_attr_group_orientation.attr,
+    &dev_attr_group_token.attr,
+    &dev_attr_group_position.attr,
+    &dev_attr_bay.attr,
+    &dev_attr_ejectable.attr,
+    &dev_attr_ospm_eject_required.attr,
+    &dev_attr_cabinet_number.attr,
+    &dev_attr_card_cage_number.attr,
+    &dev_attr_reference.attr,
+    &dev_attr_rotation.attr,
+    &dev_attr_order.attr,
+    &dev_attr_vertical_offset.attr,
+    &dev_attr_horizontal_offset.attr,
+    NULL,
+};
+
+static const struct attribute_group acpi_pld_attr_group =3D {
+    .name =3D "pld",
+    .attrs =3D acpi_pld_attrs,
+};
+
 static int acpi_device_setup_files(struct acpi_device *dev)
 {
     struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
@@ -765,11 +837,20 @@ static int acpi_device_setup_files(struct acpi_de=
vice *dev)
     }

     /*
-     * If device has _PLD, initialize the 'pld' struct
+     * If device has _PLD, 'pld' directory is created
      */
-    if (acpi_has_method(dev->handle, "_PLD"))
-        acpi_get_physical_device_location(dev->handle,
+    if (acpi_has_method(dev->handle, "_PLD")) {
+        status =3D acpi_get_physical_device_location(dev->handle,
                     &dev->pld);
+        if (ACPI_SUCCESS(status)) {
+            result =3D sysfs_create_group(&dev->dev.kobj,
+                        &acpi_pld_attr_group);
+            if (result) {
+                ACPI_FREE(dev->pld);
+                dev->pld =3D NULL;
+            }
+        }
+    }

 end:
     return result;
@@ -812,10 +893,12 @@ static void acpi_device_remove_files(struct acpi_=
device *dev)
         device_remove_file(&dev->dev, &dev_attr_path);

     /*
-     * If device has _PLD, free 'pld' struct
+     * If device has _PLD, remove 'pld' directory
      */
-    if (dev->pld)
+    if (dev->pld) {
+        sysfs_remove_group(&dev->dev.kobj, &acpi_pld_attr_group);
         ACPI_FREE(dev->pld);
+    }
 }
 /* -------------------------------------------------------------------=
-------
             ACPI Bus operations
--
2.0.0

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris,=20
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
