From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/4] ACPI / EC: Cleanup first_ec/boot_ec code
Date: Wed,  7 Sep 2016 16:50:08 +0800
Message-ID: <20ecf8d6955a3a1ab998b94e74af07f4d754142b.1473238007.git.lv.zheng@intel.com>
References: <cover.1472802172.git.lv.zheng@intel.com> <cover.1473238007.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52244 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754707AbcIGIuO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 04:50:14 -0400
In-Reply-To: <cover.1473238007.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>

In order to support full ECDT (driving the ECDT EC after probing the
namespace EC), we need to change our EC device alloc/free algorithm, ensure
not to free old boot EC before qualifying new boot EC.
This patch achieves this by cleaning up first_ec/boot_ec logic:
1. first_ec: used to perform transactions, so it is assigned in new
   acpi_ec_setup() function.
2. boot_ec: used to track early EC device, so it is assigned in new
   acpi_config_boot_ec() function which explictly tells the driver to save
   the EC device as early EC device.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=115021
Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
Tested-by: Jonh Henderson <jw.hendy@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Peter Wu <peter@lekensteyn.nl>
---
 drivers/acpi/ec.c |   96 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1925589..9eab651 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -184,6 +184,7 @@ static void acpi_ec_event_processor(struct work_struct *work);
 
 struct acpi_ec *boot_ec, *first_ec;
 EXPORT_SYMBOL(first_ec);
+static bool boot_ec_is_ecdt = false;
 static struct workqueue_struct *ec_query_wq;
 
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
@@ -1304,7 +1305,16 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 static acpi_status
 ec_parse_io_ports(struct acpi_resource *resource, void *context);
 
-static struct acpi_ec *make_acpi_ec(void)
+static void acpi_ec_free(struct acpi_ec *ec)
+{
+	if (first_ec == ec)
+		first_ec = NULL;
+	if (boot_ec == ec)
+		boot_ec = NULL;
+	kfree(ec);
+}
+
+static struct acpi_ec *acpi_ec_alloc(void)
 {
 	struct acpi_ec *ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 
@@ -1365,6 +1375,11 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
+/*
+ * Note: This function returns an error code only when the address space
+ *       handler is not installed, which means "not able to handle
+ *       transactions".
+ */
 static int ec_install_handlers(struct acpi_ec *ec)
 {
 	acpi_status status;
@@ -1440,21 +1455,49 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	}
 }
 
-static struct acpi_ec *acpi_ec_alloc(void)
+static int acpi_ec_setup(struct acpi_ec *ec)
 {
-	struct acpi_ec *ec;
+	int ret;
 
-	/* Check for boot EC */
-	if (boot_ec) {
-		ec = boot_ec;
-		boot_ec = NULL;
-		ec_remove_handlers(ec);
-		if (first_ec == ec)
-			first_ec = NULL;
-	} else {
-		ec = make_acpi_ec();
+	ret = ec_install_handlers(ec);
+	if (ret)
+		return ret;
+
+	/* First EC capable of handling transactions */
+	if (!first_ec) {
+		first_ec = ec;
+		acpi_handle_info(first_ec->handle, "Used as first EC\n");
 	}
-	return ec;
+
+	acpi_handle_info(ec->handle,
+			 "GPE=0x%lx, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
+			 ec->gpe, ec->command_addr, ec->data_addr);
+	return ret;
+}
+
+static int acpi_config_boot_ec(struct acpi_ec *ec, bool is_ecdt)
+{
+	int ret;
+
+	if (boot_ec)
+		ec_remove_handlers(boot_ec);
+
+	/* Unset old boot EC */
+	if (boot_ec != ec)
+		acpi_ec_free(boot_ec);
+
+	ret = acpi_ec_setup(ec);
+	if (ret)
+		return ret;
+
+	/* Set new boot EC */
+	if (!boot_ec) {
+		boot_ec = ec;
+		boot_ec_is_ecdt = is_ecdt;
+		acpi_handle_info(boot_ec->handle, "Used as boot %s EC\n",
+				 is_ecdt ? "ECDT" : "DSDT");
+	}
+	return ret;
 }
 
 static int acpi_ec_add(struct acpi_device *device)
@@ -1470,7 +1513,7 @@ static int acpi_ec_add(struct acpi_device *device)
 		return -ENOMEM;
 	if (ec_parse_device(device->handle, 0, ec, NULL) !=
 		AE_CTRL_TERMINATE) {
-			kfree(ec);
+			acpi_ec_free(ec);
 			return -EINVAL;
 	}
 
@@ -1478,8 +1521,6 @@ static int acpi_ec_add(struct acpi_device *device)
 	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
 			    acpi_ec_register_query_methods, NULL, ec, NULL);
 
-	if (!first_ec)
-		first_ec = ec;
 	device->driver_data = ec;
 
 	ret = !!request_region(ec->data_addr, 1, "EC data");
@@ -1487,10 +1528,7 @@ static int acpi_ec_add(struct acpi_device *device)
 	ret = !!request_region(ec->command_addr, 1, "EC cmd");
 	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
 
-	pr_info("GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
-			  ec->gpe, ec->command_addr, ec->data_addr);
-
-	ret = ec_install_handlers(ec);
+	ret = acpi_config_boot_ec(ec, false);
 
 	/* Reprobe devices depending on the EC */
 	acpi_walk_dep_device_list(ec->handle);
@@ -1513,9 +1551,7 @@ static int acpi_ec_remove(struct acpi_device *device)
 	release_region(ec->data_addr, 1);
 	release_region(ec->command_addr, 1);
 	device->driver_data = NULL;
-	if (ec == first_ec)
-		first_ec = NULL;
-	kfree(ec);
+	acpi_ec_free(ec);
 	return 0;
 }
 
@@ -1567,13 +1603,10 @@ int __init acpi_ec_dsdt_probe(void)
 		ret = -ENODEV;
 		goto error;
 	}
-	ret = ec_install_handlers(ec);
-
+	ret = acpi_config_boot_ec(ec, false);
 error:
 	if (ret)
-		kfree(ec);
-	else
-		first_ec = boot_ec = ec;
+		acpi_ec_free(ec);
 	return ret;
 }
 
@@ -1671,7 +1704,6 @@ int __init acpi_ec_ecdt_probe(void)
 		goto error;
 	}
 
-	pr_info("EC description table is found, configuring boot EC\n");
 	if (EC_FLAGS_CORRECT_ECDT) {
 		ec->command_addr = ecdt_ptr->data.address;
 		ec->data_addr = ecdt_ptr->control.address;
@@ -1681,12 +1713,10 @@ int __init acpi_ec_ecdt_probe(void)
 	}
 	ec->gpe = ecdt_ptr->gpe;
 	ec->handle = ACPI_ROOT_OBJECT;
-	ret = ec_install_handlers(ec);
+	ret = acpi_config_boot_ec(ec, true);
 error:
 	if (ret)
-		kfree(ec);
-	else
-		first_ec = boot_ec = ec;
+		acpi_ec_free(ec);
 	return ret;
 }
 
-- 
1.7.10

