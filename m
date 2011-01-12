From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/48] PNP / ACPI: Use DEVICE_ACPI_HANDLE() for device ACPI
 handle access
Date: Wed, 12 Jan 2011 05:19:21 -0500
Message-ID: <cc8e7a355c1ec64b06a5b8126c47c5cb47f44fce.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49351 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558Ab1ALSAe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:34 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:33 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

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
Acked-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/driver.c       |    7 ++-
 drivers/pnp/pnpacpi/core.c |   93 +++++++++++++++++++++++++++++++-----=
-------
 2 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index d1dbb9d..00e9403 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -189,8 +189,11 @@ static int pnp_bus_resume(struct device *dev)
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
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 57313f4..ca84d50 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -81,12 +81,19 @@ static int pnpacpi_get_resources(struct pnp_dev *de=
v)
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
@@ -105,12 +112,18 @@ static int pnpacpi_set_resources(struct pnp_dev *=
dev)
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
@@ -124,46 +137,74 @@ static int pnpacpi_disable_resources(struct pnp_d=
ev *dev)
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
+
+		if (power_state < 0)
+			power_state =3D (state.event =3D=3D PM_EVENT_ON) ?
+					ACPI_STATE_D0 : ACPI_STATE_D3;
=20
-		if (rc)
-			return rc;
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
--=20
1.7.4.rc1.7.g2cf08

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
