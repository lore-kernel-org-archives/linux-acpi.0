From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / scan: Set the visited flag for all enumerated devices
Date: Tue, 11 Apr 2017 00:23:42 +0200
Message-ID: <1749017.AgSQtRUy3j@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62688 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751593AbdDJW3h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Apr 2017 18:29:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 10c7e20b2ff3 (ACPI / scan: fix enumeration (visited) flags for
bus rescans) attempted to fix a problem with ACPI-based enumerateion
of I2C/SPI devices, but it forgot to ensure that the visited flag
will be set for all of the other enumerated devices, so fix that.

Fixes: 10c7e20b2ff3 (ACPI / scan: fix enumeration (visited) flags for bus rescans)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1857,15 +1857,20 @@ static void acpi_bus_attach(struct acpi_
 		return;
 
 	device->flags.match_driver = true;
-	if (!ret) {
-		ret = device_attach(&device->dev);
-		if (ret < 0)
-			return;
-
-		if (!ret && device->pnp.type.platform_id)
-			acpi_default_enumeration(device);
+	if (ret > 0) {
+		acpi_device_set_enumerated(device);
+		goto ok;
 	}
 
+	ret = device_attach(&device->dev);
+	if (ret < 0)
+		return;
+
+	if (ret > 0 || !device->pnp.type.platform_id)
+		acpi_device_set_enumerated(device);
+	else
+		acpi_default_enumeration(device);
+
  ok:
 	list_for_each_entry(child, &device->children, node)
 		acpi_bus_attach(child);

