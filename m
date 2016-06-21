From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI / EC: Cleanup boot EC code using acpi_ec_alloc()
Date: Tue, 21 Jun 2016 17:42:05 +0800
Message-ID: <665386f1dc0a3f6cc343b00a0cf241c6b4a143f8.1466502046.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Failure handling of the boot EC code is not tidy. This patch cleans
them up with acpi_ec_alloc().
This patch also changes acpi_ec_dsdt_probe(), always switches the boot EC
from the ECDT one to the DSDT one in this function.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   85 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 73c76d6..f63a43a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1348,13 +1348,9 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	}
 }
 
-static int acpi_ec_add(struct acpi_device *device)
+static struct acpi_ec *acpi_ec_alloc(void)
 {
-	struct acpi_ec *ec = NULL;
-	int ret;
-
-	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
+	struct acpi_ec *ec;
 
 	/* Check for boot EC */
 	if (boot_ec) {
@@ -1365,9 +1361,21 @@ static int acpi_ec_add(struct acpi_device *device)
 			first_ec = NULL;
 	} else {
 		ec = make_acpi_ec();
-		if (!ec)
-			return -ENOMEM;
 	}
+	return ec;
+}
+
+static int acpi_ec_add(struct acpi_device *device)
+{
+	struct acpi_ec *ec = NULL;
+	int ret;
+
+	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
+
+	ec = acpi_ec_alloc();
+	if (!ec)
+		return -ENOMEM;
 	if (ec_parse_device(device->handle, 0, ec, NULL) !=
 		AE_CTRL_TERMINATE) {
 			kfree(ec);
@@ -1454,27 +1462,31 @@ static const struct acpi_device_id ec_device_ids[] = {
 int __init acpi_ec_dsdt_probe(void)
 {
 	acpi_status status;
+	struct acpi_ec *ec;
+	int ret;
 
-	if (boot_ec)
-		return 0;
-
+	ec = acpi_ec_alloc();
+	if (!ec)
+		return -ENOMEM;
 	/*
 	 * Finding EC from DSDT if there is no ECDT EC available. When this
 	 * function is invoked, ACPI tables have been fully loaded, we can
 	 * walk namespace now.
 	 */
-	boot_ec = make_acpi_ec();
-	if (!boot_ec)
-		return -ENOMEM;
 	status = acpi_get_devices(ec_device_ids[0].id,
-				  ec_parse_device, boot_ec, NULL);
-	if (ACPI_FAILURE(status) || !boot_ec->handle)
-		return -ENODEV;
-	if (!ec_install_handlers(boot_ec)) {
-		first_ec = boot_ec;
-		return 0;
+				  ec_parse_device, ec, NULL);
+	if (ACPI_FAILURE(status) || !ec->handle) {
+		ret = -ENODEV;
+		goto error;
 	}
-	return -EFAULT;
+	ret = ec_install_handlers(ec);
+
+error:
+	if (ret)
+		kfree(ec);
+	else
+		first_ec = boot_ec = ec;
+	return ret;
 }
 
 #if 0
@@ -1548,12 +1560,13 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
 
 int __init acpi_ec_ecdt_probe(void)
 {
-	int ret = 0;
+	int ret;
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
+	struct acpi_ec *ec;
 
-	boot_ec = make_acpi_ec();
-	if (!boot_ec)
+	ec = acpi_ec_alloc();
+	if (!ec)
 		return -ENOMEM;
 	/*
 	 * Generate a boot ec context
@@ -1583,22 +1596,20 @@ int __init acpi_ec_ecdt_probe(void)
 		 * MSI MS-171F
 		 * https://bugzilla.kernel.org/show_bug.cgi?id=12461
 		 */
-		boot_ec->command_addr = ecdt_ptr->data.address;
-		boot_ec->data_addr = ecdt_ptr->control.address;
+		ec->command_addr = ecdt_ptr->data.address;
+		ec->data_addr = ecdt_ptr->control.address;
 	} else {
-		boot_ec->command_addr = ecdt_ptr->control.address;
-		boot_ec->data_addr = ecdt_ptr->data.address;
+		ec->command_addr = ecdt_ptr->control.address;
+		ec->data_addr = ecdt_ptr->data.address;
 	}
-	boot_ec->gpe = ecdt_ptr->gpe;
-	boot_ec->handle = ACPI_ROOT_OBJECT;
-	ret = ec_install_handlers(boot_ec);
-	if (!ret)
-		first_ec = boot_ec;
+	ec->gpe = ecdt_ptr->gpe;
+	ec->handle = ACPI_ROOT_OBJECT;
+	ret = ec_install_handlers(ec);
 error:
-	if (ret) {
-		kfree(boot_ec);
-		boot_ec = NULL;
-	}
+	if (ret)
+		kfree(ec);
+	else
+		first_ec = boot_ec = ec;
 	return ret;
 }
 
-- 
1.7.10
