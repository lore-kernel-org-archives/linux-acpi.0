From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm] PNP: Make pnpacpi_suspend handle errors
Date: Fri, 17 Aug 2007 15:30:28 +0200
Message-ID: <200708171530.29592.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57051 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbXHQNUW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Aug 2007 09:20:22 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

=46rom: Rafael J. Wysocki <rjw@sisk.pl>

pnpacpi_suspend() doesn't check the result returned by
acpi_pm_device_sleep_state() before passing it to acpi_bus_set_power(),=
 which
may not be desirable. =A0Make it select the target power state of the d=
evice
using its second argument if acpi_pm_device_sleep_state() fails.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Looks-ok-to: Pavel Machek <pavel@ucw.cz>
---
 drivers/pnp/pnpacpi/core.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.23-rc3/drivers/pnp/pnpacpi/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23-rc3.orig/drivers/pnp/pnpacpi/core.c	2007-08-15 14:56:5=
8.000000000 +0200
+++ linux-2.6.23-rc3/drivers/pnp/pnpacpi/core.c	2007-08-15 15:08:36.000=
000000 +0200
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
+	power_state =3D acpi_pm_device_sleep_state(&dev->dev,
+						device_may_wakeup(&dev->dev),
+						NULL);
+	if (power_state < 0)
+		power_state =3D (state.event =3D=3D PM_EVENT_ON) ?
+				ACPI_STATE_D0 : ACPI_STATE_D3;
+
+	return acpi_bus_set_power((acpi_handle) dev->data, power_state);
 }
=20
 static int pnpacpi_resume(struct pnp_dev *dev)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
