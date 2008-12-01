From: akpm@linux-foundation.org
Subject: [patch 3/3] pnpacpi: enable Power Management
Date: Mon, 01 Dec 2008 14:12:51 -0800
Message-ID: <200812012212.mB1MCqRl008323@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42179 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752711AbYLAWNG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 17:13:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, Witold.Szczeponik@gmx.net, bjorn.helgaas@hp.com, rjw@sisk.pl

From: Witold Szczeponik <Witold.Szczeponik@gmx.net>

Set the power of PnP ACPI devices to D0 when they are activated and to D3
when they are disabled.  The latter is in correspondence with the ACPI 3.0
specification, whereas the former is added in order to be able to power up
a device after it has been previously disabled (or when booting up a
system).  (As a consequence, the patch makes the PnP ACPI code more ACPI
compliant.)

The patch fixes the problem with some IBM ThinkPads (at least the 600E and
the 600X) where the serial ports have a dedicated power source that needs
to be brought up before the serial port can be used.  Without this patch,
the serial port is enabled but has no power.

No regressions were observed on hardware that does not require this patch.

Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/pnp/pnpacpi/core.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff -puN drivers/pnp/pnpacpi/core.c~pnpacpi-enable-power-management drivers/pnp/pnpacpi/core.c
--- a/drivers/pnp/pnpacpi/core.c~pnpacpi-enable-power-management
+++ a/drivers/pnp/pnpacpi/core.c
@@ -98,18 +98,24 @@ static int pnpacpi_set_resources(struct 
 	status = acpi_set_current_resources(handle, &buffer);
 	if (ACPI_FAILURE(status))
 		ret = -EINVAL;
+	else if (acpi_bus_power_manageable(handle))
+		ret = acpi_bus_set_power(handle, ACPI_STATE_D0);
 	kfree(buffer.pointer);
 	return ret;
 }
 
 static int pnpacpi_disable_resources(struct pnp_dev *dev)
 {
+	acpi_handle handle = dev->data;
+	int ret = 0;
 	acpi_status status;
 
-	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
-	status = acpi_evaluate_object((acpi_handle) dev->data,
-				      "_DIS", NULL, NULL);
-	return ACPI_FAILURE(status) ? -ENODEV : 0;
+	if (acpi_bus_power_manageable(handle))
+		ret = acpi_bus_set_power(handle, ACPI_STATE_D3);
+	status = acpi_evaluate_object(handle, "_DIS", NULL, NULL);
+	if (ACPI_FAILURE(status))
+		ret = -ENODEV;
+	return ret;
 }
 
 #ifdef CONFIG_ACPI_SLEEP
_
