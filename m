From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PNP / ACPI: Use DEVICE_ACPI_HANDLE() for device ACPI handle access
Date: Mon, 10 Jan 2011 21:23:16 +0100
Message-ID: <201101102123.16955.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47882 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749Ab1AJUYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jan 2011 15:24:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

The PNP ACPI driver squirrels the ACPI handles of PNP devices' ACPI
companions, but this isn't correct, because those handles should be
accessed using the DEVICE_ACPI_HANDLE() macro operating on struct
device objects.

Using DEVICE_ACPI_HANDLE() in the PNP ACPI driver instead of the
driver's own copies of the ACPI handles allows us to avoid a problem
with docking stations where a machine docked before suspend to RAM
and undocked while suspended crashes during the subsequent resume (in
that case the ACPI companion of the PNP device in question doesn't
exist any more while the device is being resumed).  It also allows us
to avoid the problem where suspend to RAM fails when the machine was
undocked while suspended before (again, the ACPI companion of the PNP
device is not present any more while it is being suspended).

This change doesn't fix all of the the PNP ACPI driver's problems
with PNP devices in docking stations (generally speaking, the driver
has no idea that devices can come and go and doesn't even attempt to
handle such events), but at least it makes suspend work for the
users of docking stations who don't use the PNP devices located in
there.

References: https://bugzilla.kernel.org/show_bug.cgi?id=3D15100
Reported-and-tested-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pnp/driver.c       |    7 ++-
 drivers/pnp/pnpacpi/core.c |   93 ++++++++++++++++++++++++++++++++----=
---------
 2 files changed, 72 insertions(+), 28 deletions(-)

Index: linux-2.6/drivers/pnp/pnpacpi/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pnp/pnpacpi/core.c
+++ linux-2.6/drivers/pnp/pnpacpi/core.c
@@ -81,12 +81,19 @@ static int pnpacpi_get_resources(struct
=20
 static int pnpacpi_set_resources(struct pnp_dev *dev)
 {
-	struct acpi_device *acpi_dev =3D dev->data;
-	acpi_handle handle =3D acpi_dev->handle;
+	struct acpi_device *acpi_dev;
+	acpi_handle handle;
 	struct acpi_buffer buffer;
 	int ret;
=20
 	pnp_dbg(&dev->dev, "set resources\n");
+
+	handle =3D DEVICE_ACPI_HANDLE(&dev->dev);
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &acpi_dev))) =
{
+		dev_dbg(&dev->dev, "ACPI device not found in %s!\n", __func__);
+		return -ENODEV;
+	}
+
 	ret =3D pnpacpi_build_resource_template(dev, &buffer);
 	if (ret)
 		return ret;
@@ -105,12 +112,18 @@ static int pnpacpi_set_resources(struct
=20
 static int pnpacpi_disable_resources(struct pnp_dev *dev)
 {
-	struct acpi_device *acpi_dev =3D dev->data;
-	acpi_handle handle =3D acpi_dev->handle;
+	struct acpi_device *acpi_dev;
+	acpi_handle handle;
 	int ret;
=20
 	dev_dbg(&dev->dev, "disable resources\n");
=20
+	handle =3D DEVICE_ACPI_HANDLE(&dev->dev);
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &acpi_dev))) =
{
+		dev_dbg(&dev->dev, "ACPI device not found in %s!\n", __func__);
+		return 0;
+	}
+
 	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
 	ret =3D 0;
 	if (acpi_bus_power_manageable(handle))
@@ -124,46 +137,74 @@ static int pnpacpi_disable_resources(str
 #ifdef CONFIG_ACPI_SLEEP
 static bool pnpacpi_can_wakeup(struct pnp_dev *dev)
 {
-	struct acpi_device *acpi_dev =3D dev->data;
-	acpi_handle handle =3D acpi_dev->handle;
+	struct acpi_device *acpi_dev;
+	acpi_handle handle;
+
+	handle =3D DEVICE_ACPI_HANDLE(&dev->dev);
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &acpi_dev))) =
{
+		dev_dbg(&dev->dev, "ACPI device not found in %s!\n", __func__);
+		return false;
+	}
=20
 	return acpi_bus_can_wakeup(handle);
 }
=20
 static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
 {
-	struct acpi_device *acpi_dev =3D dev->data;
-	acpi_handle handle =3D acpi_dev->handle;
-	int power_state;
+	struct acpi_device *acpi_dev;
+	acpi_handle handle;
+	int error =3D 0;
+
+	handle =3D DEVICE_ACPI_HANDLE(&dev->dev);
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &acpi_dev))) =
{
+		dev_dbg(&dev->dev, "ACPI device not found in %s!\n", __func__);
+		return 0;
+	}
=20
 	if (device_can_wakeup(&dev->dev)) {
-		int rc =3D acpi_pm_device_sleep_wake(&dev->dev,
+		error =3D acpi_pm_device_sleep_wake(&dev->dev,
 				device_may_wakeup(&dev->dev));
+		if (error)
+			return error;
+	}
+
+	if (acpi_bus_power_manageable(handle)) {
+		int power_state =3D acpi_pm_device_sleep_state(&dev->dev, NULL);
=20
-		if (rc)
-			return rc;
+		if (power_state < 0)
+			power_state =3D (state.event =3D=3D PM_EVENT_ON) ?
+					ACPI_STATE_D0 : ACPI_STATE_D3;
+
+		/*
+		 * acpi_bus_set_power() often fails (keyboard port can't be
+		 * powered-down?), and in any case, our return value is ignored
+		 * by pnp_bus_suspend().  Hence we don't revert the wakeup
+		 * setting if the set_power fails.
+		 */
+		error =3D acpi_bus_set_power(handle, power_state);
 	}
-	power_state =3D acpi_pm_device_sleep_state(&dev->dev, NULL);
-	if (power_state < 0)
-		power_state =3D (state.event =3D=3D PM_EVENT_ON) ?
-				ACPI_STATE_D0 : ACPI_STATE_D3;
-
-	/* acpi_bus_set_power() often fails (keyboard port can't be
-	 * powered-down?), and in any case, our return value is ignored
-	 * by pnp_bus_suspend().  Hence we don't revert the wakeup
-	 * setting if the set_power fails.
-	 */
-	return acpi_bus_set_power(handle, power_state);
+
+	return error;
 }
=20
 static int pnpacpi_resume(struct pnp_dev *dev)
 {
-	struct acpi_device *acpi_dev =3D dev->data;
-	acpi_handle handle =3D acpi_dev->handle;
+	struct acpi_device *acpi_dev;
+	acpi_handle handle =3D DEVICE_ACPI_HANDLE(&dev->dev);
+	int error =3D 0;
+
+	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &acpi_dev))) =
{
+		dev_dbg(&dev->dev, "ACPI device not found in %s!\n", __func__);
+		return -ENODEV;
+	}
=20
 	if (device_may_wakeup(&dev->dev))
 		acpi_pm_device_sleep_wake(&dev->dev, false);
-	return acpi_bus_set_power(handle, ACPI_STATE_D0);
+
+	if (acpi_bus_power_manageable(handle))
+		error =3D acpi_bus_set_power(handle, ACPI_STATE_D0);
+
+	return error;
 }
 #endif
=20
Index: linux-2.6/drivers/pnp/driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pnp/driver.c
+++ linux-2.6/drivers/pnp/driver.c
@@ -189,8 +189,11 @@ static int pnp_bus_resume(struct device
 	if (!pnp_drv)
 		return 0;
=20
-	if (pnp_dev->protocol->resume)
-		pnp_dev->protocol->resume(pnp_dev);
+	if (pnp_dev->protocol->resume) {
+		error =3D pnp_dev->protocol->resume(pnp_dev);
+		if (error)
+			return error;
+	}
=20
 	if (pnp_can_write(pnp_dev)) {
 		error =3D pnp_start_dev(pnp_dev);
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
