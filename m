From: Zhang Rui <rui.zhang@intel.com>
Subject: [10/12] acpi: motherboard driver
Date: Fri, 22 Sep 2006 17:49:27 +0800
Message-ID: <1158918567.11985.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10815 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751136AbWIVJsk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Sep 2006 05:48:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com

From: Li Shaohua <shaohua.li@intel.com>

Consolidate motherboard1 and motherboard2 drivers into one
so that driver core doesn't complain that two drivers have 
the same name.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>

---
 drivers/acpi/motherboard.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

Index: linux-2.6.18-rc5/drivers/acpi/motherboard.c
===================================================================
--- linux-2.6.18-rc5.orig/drivers/acpi/motherboard.c	2006-09-13 14:52:04.000000000 +0800
+++ linux-2.6.18-rc5/drivers/acpi/motherboard.c	2006-09-13 17:28:19.000000000 +0800
@@ -33,8 +33,7 @@
 ACPI_MODULE_NAME("acpi_motherboard")
 
 /* Dell use PNP0C01 instead of PNP0C02 */
-#define ACPI_MB_HID1			"PNP0C01"
-#define ACPI_MB_HID2			"PNP0C02"
+#define ACPI_MB_HID			"PNP0C01,PNP0C02"
 /**
  * Doesn't care about legacy IO ports, only IO ports beyond 0x1000 are reserved
  * Doesn't care about the failure of 'request_region', since other may reserve
@@ -104,19 +103,10 @@ static int acpi_motherboard_add(struct a
 	return 0;
 }
 
-static struct acpi_driver acpi_motherboard_driver1 = {
+static struct acpi_driver acpi_motherboard_driver = {
 	.name = "motherboard",
 	.class = "",
-	.ids = ACPI_MB_HID1,
-	.ops = {
-		.add = acpi_motherboard_add,
-		},
-};
-
-static struct acpi_driver acpi_motherboard_driver2 = {
-	.name = "motherboard",
-	.class = "",
-	.ids = ACPI_MB_HID2,
+	.ids = ACPI_MB_HID,
 	.ops = {
 		.add = acpi_motherboard_add,
 		},
@@ -167,8 +157,7 @@ static void __init acpi_reserve_resource
 
 static int __init acpi_motherboard_init(void)
 {
-	acpi_bus_register_driver(&acpi_motherboard_driver1);
-	acpi_bus_register_driver(&acpi_motherboard_driver2);
+	acpi_bus_register_driver(&acpi_motherboard_driver);
 	/*
 	 * Guarantee motherboard IO reservation first
 	 * This module must run after scan.c
