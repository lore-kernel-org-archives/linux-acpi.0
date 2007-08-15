From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Make pnpacpi_suspend handle errors
Date: Wed, 15 Aug 2007 15:23:43 +0200
Message-ID: <200708151523.43921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47710 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604AbXHONOD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 09:14:03 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Shaohua Li <shaohua.li@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

pnpacpi_suspend() doesn't check the result returned by
acpi_pm_device_sleep_state() before passing it to acpi_bus_set_power(), which
may not be desirable.  Make it select the target power state of the device
using its second argument if acpi_pm_device_sleep_state() fails.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pnp/pnpacpi/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.23-rc3/drivers/pnp/pnpacpi/core.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/pnp/pnpacpi/core.c	2007-08-15 14:56:58.000000000 +0200
+++ linux-2.6.23-rc3/drivers/pnp/pnpacpi/core.c	2007-08-15 15:08:36.000000000 +0200
@@ -130,11 +130,16 @@ static int pnpacpi_disable_resources(str
 #ifdef CONFIG_ACPI_SLEEP
 static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
 {
-	return acpi_bus_set_power((acpi_handle) dev->data,
-				  acpi_pm_device_sleep_state(&dev->dev,
-							     device_may_wakeup
-							     (&dev->dev),
-							     NULL));
+	int power_state;
+
+	power_state = acpi_pm_device_sleep_state(&dev->dev,
+						device_may_wakeup(&dev->dev),
+						NULL);
+	if (power_state < 0)
+		power_state = (state.event == PM_EVENT_ON) ?
+				ACPI_STATE_D0 : ACPI_STATE_D3;
+
+	return acpi_bus_set_power((acpi_handle) dev->data, power_state);
 }
 
 static int pnpacpi_resume(struct pnp_dev *dev)
