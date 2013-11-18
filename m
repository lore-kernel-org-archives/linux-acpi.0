From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / scan: Set flags.match_driver in acpi_bus_scan_fixed()
Date: Mon, 18 Nov 2013 14:30:56 +0100
Message-ID: <12372702.nqQ0u36ADq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63430 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750742Ab3KRNSV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2013 08:18:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Before commit 6931007cc90b (ACPI / scan: Start matching drivers
after trying scan handlers) the match_driver flag for all devices
was set in acpi_add_single_object(), but now it is set by
acpi_bus_device_attach() which is not called for the "fixed"
devices added by acpi_bus_scan_fixed().  This means that
flags.match_driver is never set for those devices now, so make
acpi_bus_scan_fixed() set it before calling device_attach().

Fixes: 6931007cc90b (ACPI / scan: Start matching drivers after trying scan handlers)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2023,6 +2023,7 @@ static int acpi_bus_scan_fixed(void)
 		if (result)
 			return result;
 
+		device->flags.match_driver = true;
 		result = device_attach(&device->dev);
 		if (result < 0)
 			return result;
@@ -2039,6 +2040,7 @@ static int acpi_bus_scan_fixed(void)
 		if (result)
 			return result;
 
+		device->flags.match_driver = true;
 		result = device_attach(&device->dev);
 	}
 

