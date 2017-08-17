From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/2] ACPI: EC: Fix possible issues related to EC initialization order
Date: Thu, 17 Aug 2017 10:21:12 +0800
Message-ID: <9b78559899b3a7a984b0a821942f13d850721b7c.1502936401.git.lv.zheng@intel.com>
References: <756461e045cbddb16418685a1b12c3c9a491d328.1502868457.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45831 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdHQCVP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Aug 2017 22:21:15 -0400
In-Reply-To: <756461e045cbddb16418685a1b12c3c9a491d328.1502868457.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

EC command/data register addresses are sufficient to determine if two
EC devices are equivelent. This patch thus changes acpi_is_boot_ec().

Then for the removed comparison factors - EC ID and EC GPE, they need to
be synchronized for the boot_ec:
1. Before registering the BIOS provided EC event handlers in
   acpi_ec_register_query_methods(), the namespace node where _Qxx methods
   are underneath of should be located. The real namespace PNP0C09 device
   location then is apparently more trustworthy than the ECDT EC ID.
2. According to the ASUS quirks, the ECDT EC GPE is more trustworthy than
   the namespace PNP0C09 device's _GPE setting.
This patch thus synchronizes the boot_ec settings in acpi_ec_add()
according to these facts.

Finally, this patch also alters the order of acpi_ec_ecdt_start() and
acpi_ec_add() (invoked from acpi_bus_register_driver()) so that the fast
path of determining _Qxx location can be hit.

All required order logics of EC probe are collected in acpi_ec_init(), the
remained topics related to the EC initialization order are:
1. Shall acpi_ec_dsdt_probe() be removed?
2. Shall acpi_ec_init() be invoked earlier?
3. Can acpi_ec_ecdt_probe() be renamed to acpi_ec_early_init()?
4. Can PNP0C09 ACPI bus driver be split from EC driver core and combined
   with ec_sys.c to form a more accurate loadable module?
This patch doesn't cover the above topics but only focuses on the EC probe
ordering.

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

