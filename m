From: Lv Zheng <lv.zheng@intel.com>
Subject: [UPDATE PATCH] ACPI / EC: Fix a boot EC regresion by restoring boot EC support for the DSDT EC
Date: Fri,  3 Jun 2016 10:26:12 +0800
Message-ID: <d2e91eb1bf5cd0fb67fa77f16863a52d4dfdbaa7.1464919752.git.lv.zheng@intel.com>
References: <1464828759-1846-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5560 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcFCC0c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jun 2016 22:26:32 -0400
In-Reply-To: <1464828759-1846-1-git-send-email-lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

(Email addresses in the SOB section are fixed)

According to the Windows probing result, during the table loading, the EC
device described in the ECDT should be used. And the ECDT EC is also
effective during the period the namespace objects are initialized (we can
see a separate process executing _STA/_INI on Windows before executing
other device specific control methods, for example, EC._REG). During the
device enumration, the EC device described in the DSDT should be used. But
there are differences between Linux and Windows around the device probing
order. Thus in Linux, we should enable the DSDT EC as early as possible
before enumerating devices in order not to trigger issues related to the
device enumeration order differences.

This patch thus converts acpi_boot_ec_enable() into acpi_ec_dsdt_probe() to
fix the gap. This also fixes a user reported regression triggered after we
switched the "table loading"/"ECDT support" to be ACPI spec 2.0 compliant.

Fixes: 59f0aa9480cf ("ACPI 2.0 / ECDT: Remove early namespace reference from EC")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=119261
Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/bus.c      |    2 +-
 drivers/acpi/ec.c       |   29 ++++++++++++++++++++++-------
 drivers/acpi/internal.h |    2 +-
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d177649..4582db3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1053,7 +1053,7 @@ static int __init acpi_bus_init(void)
 	 * Maybe EC region is required at bus_scan/acpi_get_devices. So it
 	 * is necessary to enable it as early as possible.
 	 */
-	acpi_boot_ec_enable();
+	acpi_ec_dsdt_probe();
 
 	printk(KERN_INFO PREFIX "Interpreter enabled\n");
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0e70181..73c76d6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1446,10 +1446,30 @@ ec_parse_io_ports(struct acpi_resource *resource, void *context)
 	return AE_OK;
 }
 
-int __init acpi_boot_ec_enable(void)
+static const struct acpi_device_id ec_device_ids[] = {
+	{"PNP0C09", 0},
+	{"", 0},
+};
+
+int __init acpi_ec_dsdt_probe(void)
 {
-	if (!boot_ec)
+	acpi_status status;
+
+	if (boot_ec)
 		return 0;
+
+	/*
+	 * Finding EC from DSDT if there is no ECDT EC available. When this
+	 * function is invoked, ACPI tables have been fully loaded, we can
+	 * walk namespace now.
+	 */
+	boot_ec = make_acpi_ec();
+	if (!boot_ec)
+		return -ENOMEM;
+	status = acpi_get_devices(ec_device_ids[0].id,
+				  ec_parse_device, boot_ec, NULL);
+	if (ACPI_FAILURE(status) || !boot_ec->handle)
+		return -ENODEV;
 	if (!ec_install_handlers(boot_ec)) {
 		first_ec = boot_ec;
 		return 0;
@@ -1457,11 +1477,6 @@ int __init acpi_boot_ec_enable(void)
 	return -EFAULT;
 }
 
-static const struct acpi_device_id ec_device_ids[] = {
-	{"PNP0C09", 0},
-	{"", 0},
-};
-
 #if 0
 /*
  * Some EC firmware variations refuses to respond QR_EC when SCI_EVT is not
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 9bb0773..27cc7fe 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -181,7 +181,7 @@ typedef int (*acpi_ec_query_func) (void *data);
 
 int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
-int acpi_boot_ec_enable(void);
+int acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 void acpi_ec_unblock_transactions_early(void);
-- 
1.7.10

