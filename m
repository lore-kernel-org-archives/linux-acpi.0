From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] acpi: make ACPI device id constant
Date: Sun, 10 Jan 2010 17:15:36 +0100
Message-ID: <4B49FD28.6080800@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <cocci-bounces@diku.dk>
List-Unsubscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=unsubscribe>
List-Archive: <http://lists.diku.dk/pipermail/cocci>
List-Post: <mailto:cocci@diku.dk>
List-Help: <mailto:cocci-request@diku.dk?subject=help>
List-Subscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=subscribe>
Sender: cocci-bounces@diku.dk
Errors-To: cocci-bounces@diku.dk
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, cocci@diku.dk
List-Id: linux-acpi@vger.kernel.org

From: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The ids field of the struct acpi_driver is constant in <linux/acpi/acpi_b=
us.h>
so it is worth to make the initialization data also constant.

The semantic match that finds this kind of pattern is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
disable decl_init,const_decl_init;
identifier I1, I2, x;
@@
	struct I1 {
	  ...
	  const struct I2 *x;
	  ...
	};
@s@
identifier r.I1, y;
identifier r.x, E;
@@
	struct I1 y =3D {
	  .x =3D E,
	};
@c@
identifier r.I2;
identifier s.E;
@@
	const struct I2 E[] =3D ... ;
@depends on !c@
identifier r.I2;
identifier s.E;
@@
+	const
	struct I2 E[] =3D ...;
// </smpl>

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Cc: Julia Lawall <julia@diku.dk>
Cc: cocci@diku.dk
---
diff -u -p a/drivers/acpi/power.c b/drivers/acpi/power.c
--- a/drivers/acpi/power.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/acpi/power.c 2010-01-08 15:02:32.000000000 +0100
@@ -65,7 +65,7 @@ static int acpi_power_remove(struct acpi
 static int acpi_power_resume(struct acpi_device *device);
 static int acpi_power_open_fs(struct inode *inode, struct file *file);

-static struct acpi_device_id power_device_ids[] =3D {
+static const struct acpi_device_id power_device_ids[] =3D {
 	{ACPI_POWER_HID, 0},
 	{"", 0},
 };
diff -u -p a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
--- a/drivers/acpi/power_meter.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/acpi/power_meter.c 2010-01-08 15:03:09.000000000 +0100
@@ -64,7 +64,7 @@ static int can_cap_in_hardware(void)
 	return force_cap_on || cap_in_hardware;
 }

-static struct acpi_device_id power_meter_ids[] =3D {
+static const struct acpi_device_id power_meter_ids[] =3D {
 	{"ACPI000D", 0},
 	{"", 0},
 };
diff -u -p a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/acpi/pci_link.c 2010-01-08 15:03:22.000000000 +0100
@@ -56,7 +56,7 @@ ACPI_MODULE_NAME("pci_link");
 static int acpi_pci_link_add(struct acpi_device *device);
 static int acpi_pci_link_remove(struct acpi_device *device, int type);

-static struct acpi_device_id link_device_ids[] =3D {
+static const struct acpi_device_id link_device_ids[] =3D {
 	{"PNP0C0F", 0},
 	{"", 0},
 };
diff -u -p a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
--- a/drivers/acpi/pci_root.c 2010-01-07 19:08:39.000000000 +0100
+++ b/drivers/acpi/pci_root.c 2010-01-08 15:06:03.000000000 +0100
@@ -46,7 +46,7 @@ static int acpi_pci_root_add(struct acpi
 static int acpi_pci_root_remove(struct acpi_device *device, int type);
 static int acpi_pci_root_start(struct acpi_device *device);

-static struct acpi_device_id root_device_ids[] =3D {
+static const struct acpi_device_id root_device_ids[] =3D {
 	{"PNP0A03", 0},
 	{"", 0},
 };
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
