From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] ACPI / scan: Apply default enumeration to devices with ACPI drivers
Date: Mon, 17 Apr 2017 01:19:50 +0200
Message-ID: <7942620.ijDeSLx5PQ@aspire.rjw.lan>
References: <20731969.imAyuWkf7P@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42409 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932296AbdDPX1D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Apr 2017 19:27:03 -0400
In-Reply-To: <20731969.imAyuWkf7P@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current code in acpi_bus_attach() is inconsistent with respect
to device objects with ACPI drivers bound to them, as it allows
ACPI drivers to bind to device objects with existing "physical"
device companions, but it doesn't allow "physical" device objects
to be created for ACPI device objects with ACPI drivers bound to
them.  Thus, in some cases, the outcome depends on the ordering
of events which is confusing at best.

For this reason, modify acpi_bus_attach() to call
acpi_default_enumeration() for device objects with the 
pnp.type.platform_id flag set regardless of whether or not
any ACPI drivers are bound to them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1866,10 +1866,10 @@ static void acpi_bus_attach(struct acpi_
 	if (ret < 0)
 		return;
 
-	if (ret > 0 || !device->pnp.type.platform_id)
-		acpi_device_set_enumerated(device);
-	else
+	if (device->pnp.type.platform_id)
 		acpi_default_enumeration(device);
+	else
+		acpi_device_set_enumerated(device);
 
  ok:
 	list_for_each_entry(child, &device->children, node)

