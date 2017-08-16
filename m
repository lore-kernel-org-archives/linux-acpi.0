From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPI: EC: Fix a possible issue related to ECDT initialization order
Date: Wed, 16 Aug 2017 15:29:54 +0800
Message-ID: <b56820a24b6200242794deab18dd90a36f21f38a.1502868457.git.lv.zheng@intel.com>
References: <756461e045cbddb16418685a1b12c3c9a491d328.1502868457.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46721 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdHPH35 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Aug 2017 03:29:57 -0400
In-Reply-To: <756461e045cbddb16418685a1b12c3c9a491d328.1502868457.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

EC command/data register addresses are sufficient to determine if two
EC devices are equivelent. For EC ID and GPE settings:
1. The real namespace PNP0C09 device location should be more trustworthy
   than the ECDT ID.
2. According to the ASUS quirks, the ECDT GPE is more trustworthy than the
   namespace PNP0C09 device's _GPE setting.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ae3d6d1..d3d15d3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1586,9 +1586,7 @@ static bool acpi_is_boot_ec(struct acpi_ec *ec)
 {
 	if (!boot_ec)
 		return false;
-	if (ec->handle == boot_ec->handle &&
-	    ec->gpe == boot_ec->gpe &&
-	    ec->command_addr == boot_ec->command_addr &&
+	if (ec->command_addr == boot_ec->command_addr &&
 	    ec->data_addr == boot_ec->data_addr)
 		return true;
 	return false;
@@ -1613,6 +1611,14 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	if (acpi_is_boot_ec(ec)) {
 		boot_ec_is_ecdt = false;
+		/*
+		 * Trust PNP0C09 namespace location rather than ECDT ID.
+		 *
+		 * But trust ECDT GPE rather _GPE according to ASUS quirks.
+		 * Uncomment the following line if this fact is changed.
+		 *   boot_ec->gpe = ec->gpe;
+		 */
+		boot_ec->handle = ec->handle;
 		acpi_handle_debug(ec->handle, "duplicated.\n");
 		acpi_ec_free(ec);
 		ec = boot_ec;
@@ -1747,18 +1753,20 @@ static int __init acpi_ec_ecdt_start(void)
 
 	if (!boot_ec)
 		return -ENODEV;
-	/*
-	 * The DSDT EC should have already been started in
-	 * acpi_ec_add().
-	 */
+	/* In case acpi_ec_ecdt_start() is invoked after acpi_ec_add() */
 	if (!boot_ec_is_ecdt)
 		return -ENODEV;
 
 	/*
 	 * At this point, the namespace and the GPE is initialized, so
 	 * start to find the namespace objects and handle the events.
+	 *
+	 * Note: ec->handle can be valid if this function is invoked after
+	 *       acpi_ec_add(), thus the fast path.
 	 */
-	if (!acpi_ec_ecdt_get_handle(&handle))
+	if (boot_ec->handle != ACPI_ROOT_OBJECT)
+		handle = boot_ec->handle;
+	else if (!acpi_ec_ecdt_get_handle(&handle))
 		return -ENODEV;
 	return acpi_config_boot_ec(boot_ec, handle, true, true);
 }
@@ -2011,8 +2019,8 @@ int __init acpi_ec_init(void)
 		return result;
 
 	/* Drivers must be started after acpi_ec_query_init() */
-	ecdt_fail = acpi_ec_ecdt_start();
 	dsdt_fail = acpi_bus_register_driver(&acpi_ec_driver);
+	ecdt_fail = acpi_ec_ecdt_start();
 	return ecdt_fail && dsdt_fail ? -ENODEV : 0;
 }
 
-- 
2.7.4

