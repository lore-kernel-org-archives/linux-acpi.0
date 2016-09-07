From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/4] ACPI / EC: Fix a gap that ECDT EC cannot handle EC events
Date: Wed,  7 Sep 2016 16:50:21 +0800
Message-ID: <45fb1ed5eabbb21181bb5340faad0f8149d7b0ad.1473238007.git.lv.zheng@intel.com>
References: <cover.1472802172.git.lv.zheng@intel.com> <cover.1473238007.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1473238007.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>
List-Id: linux-acpi@vger.kernel.org

It is possible to register _Qxx from namespace and use the ECDT EC to
perform event handling. The reported bug reveals that Windows is using ECDT
in this way in case the namespace EC is not present. This patch facilitates
Linux to support ECDT in this way.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=115021
Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
Tested-by: Jonh Henderson <jw.hendy@gmail.com>
Reviewed-by: Peter Wu <peter@lekensteyn.nl>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Peter Wu <peter@lekensteyn.nl>
---
 drivers/acpi/ec.c       |  119 ++++++++++++++++++++++++++++++++++++++---------
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    1 +
 3 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 50895ff..2ae9194 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -109,6 +109,7 @@ enum {
 	EC_FLAGS_QUERY_GUARDING,	/* Guard for SCI_EVT check */
 	EC_FLAGS_GPE_HANDLER_INSTALLED,	/* GPE handler installed */
 	EC_FLAGS_EC_HANDLER_INSTALLED,	/* OpReg handler installed */
+	EC_FLAGS_EVT_HANDLER_INSTALLED, /* _Qxx handlers installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
 	EC_FLAGS_COMMAND_STORM,		/* GPE storms occurred to the
@@ -1380,7 +1381,7 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
  *       handler is not installed, which means "not able to handle
  *       transactions".
  */
-static int ec_install_handlers(struct acpi_ec *ec)
+static int ec_install_handlers(struct acpi_ec *ec, bool handle_events)
 {
 	acpi_status status;
 
@@ -1409,6 +1410,16 @@ static int ec_install_handlers(struct acpi_ec *ec)
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
 
+	if (!handle_events)
+		return 0;
+
+	if (!test_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags)) {
+		/* Find and register all query methods */
+		acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
+				    acpi_ec_register_query_methods,
+				    NULL, ec, NULL);
+		set_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags);
+	}
 	if (!test_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags)) {
 		status = acpi_install_gpe_raw_handler(NULL, ec->gpe,
 					  ACPI_GPE_EDGE_TRIGGERED,
@@ -1419,6 +1430,9 @@ static int ec_install_handlers(struct acpi_ec *ec)
 			if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
 			    ec->reference_count >= 1)
 				acpi_ec_enable_gpe(ec, true);
+
+			/* EC is fully operational, allow queries */
+			acpi_ec_enable_event(ec);
 		}
 	}
 
@@ -1453,13 +1467,17 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 			pr_err("failed to remove gpe handler\n");
 		clear_bit(EC_FLAGS_GPE_HANDLER_INSTALLED, &ec->flags);
 	}
+	if (test_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags)) {
+		acpi_ec_remove_query_handlers(ec, true, 0);
+		clear_bit(EC_FLAGS_EVT_HANDLER_INSTALLED, &ec->flags);
+	}
 }
 
-static int acpi_ec_setup(struct acpi_ec *ec)
+static int acpi_ec_setup(struct acpi_ec *ec, bool handle_events)
 {
 	int ret;
 
-	ret = ec_install_handlers(ec);
+	ret = ec_install_handlers(ec, handle_events);
 	if (ret)
 		return ret;
 
@@ -1475,18 +1493,33 @@ static int acpi_ec_setup(struct acpi_ec *ec)
 	return ret;
 }
 
-static int acpi_config_boot_ec(struct acpi_ec *ec, bool is_ecdt)
+static int acpi_config_boot_ec(struct acpi_ec *ec, acpi_handle handle,
+			       bool handle_events, bool is_ecdt)
 {
 	int ret;
 
-	if (boot_ec)
+	/*
+	 * Changing the ACPI handle results in a re-configuration of the
+	 * boot EC. And if it happens after the namespace initialization,
+	 * it causes _REG evaluations.
+	 */
+	if (boot_ec && boot_ec->handle != handle)
 		ec_remove_handlers(boot_ec);
 
 	/* Unset old boot EC */
 	if (boot_ec != ec)
 		acpi_ec_free(boot_ec);
 
-	ret = acpi_ec_setup(ec);
+	/*
+	 * ECDT device creation is split into acpi_ec_ecdt_probe() and
+	 * acpi_ec_ecdt_start(). This function takes care of completing the
+	 * ECDT parsing logic as the handle update should be performed
+	 * between the installation/uninstallation of the handlers.
+	 */
+	if (ec->handle != handle)
+		ec->handle = handle;
+
+	ret = acpi_ec_setup(ec, handle_events);
 	if (ret)
 		return ret;
 
@@ -1494,9 +1527,12 @@ static int acpi_config_boot_ec(struct acpi_ec *ec, bool is_ecdt)
 	if (!boot_ec) {
 		boot_ec = ec;
 		boot_ec_is_ecdt = is_ecdt;
-		acpi_handle_info(boot_ec->handle, "Used as boot %s EC\n",
-				 is_ecdt ? "ECDT" : "DSDT");
 	}
+
+	acpi_handle_info(boot_ec->handle,
+			 "Used as boot %s EC to handle transactions%s\n",
+			 is_ecdt ? "ECDT" : "DSDT",
+			 handle_events ? " and events" : "");
 	return ret;
 }
 
@@ -1517,11 +1553,7 @@ static int acpi_ec_add(struct acpi_device *device)
 			goto err_alloc;
 	}
 
-	/* Find and register all query methods */
-	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
-			    acpi_ec_register_query_methods, NULL, ec, NULL);
-
-	ret = acpi_config_boot_ec(ec, false);
+	ret = acpi_config_boot_ec(ec, device->handle, true, false);
 	if (ret)
 		goto err_query;
 
@@ -1534,9 +1566,6 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	/* Reprobe devices depending on the EC */
 	acpi_walk_dep_device_list(ec->handle);
-
-	/* EC is fully operational, allow queries */
-	acpi_ec_enable_event(ec);
 	return 0;
 
 err_query:
@@ -1555,7 +1584,6 @@ static int acpi_ec_remove(struct acpi_device *device)
 
 	ec = acpi_driver_data(device);
 	ec_remove_handlers(ec);
-	acpi_ec_remove_query_handlers(ec, true, 0);
 	release_region(ec->data_addr, 1);
 	release_region(ec->command_addr, 1);
 	device->driver_data = NULL;
@@ -1601,9 +1629,8 @@ int __init acpi_ec_dsdt_probe(void)
 	if (!ec)
 		return -ENOMEM;
 	/*
-	 * Finding EC from DSDT if there is no ECDT EC available. When this
-	 * function is invoked, ACPI tables have been fully loaded, we can
-	 * walk namespace now.
+	 * At this point, the namespace is initialized, so start to find
+	 * the namespace objects.
 	 */
 	status = acpi_get_devices(ec_device_ids[0].id,
 				  ec_parse_device, ec, NULL);
@@ -1611,13 +1638,55 @@ int __init acpi_ec_dsdt_probe(void)
 		ret = -ENODEV;
 		goto error;
 	}
-	ret = acpi_config_boot_ec(ec, false);
+	/*
+	 * When the DSDT EC is available, always re-configure boot EC to
+	 * have _REG evaluated. _REG can only be evaluated after the
+	 * namespace initialization.
+	 * At this point, the GPE is not fully initialized, so do not to
+	 * handle the events.
+	 */
+	ret = acpi_config_boot_ec(ec, ec->handle, false, false);
 error:
 	if (ret)
 		acpi_ec_free(ec);
 	return ret;
 }
 
+/*
+ * If the DSDT EC is not functioning, we still need to prepare a fully
+ * functioning ECDT EC first in order to handle the events.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=115021
+ */
+int __init acpi_ec_ecdt_start(void)
+{
+	struct acpi_table_ecdt *ecdt_ptr;
+	acpi_status status;
+	acpi_handle handle;
+
+	if (!boot_ec)
+		return -ENODEV;
+	/*
+	 * The DSDT EC should have already been started in
+	 * acpi_ec_add().
+	 */
+	if (!boot_ec_is_ecdt)
+		return -ENODEV;
+
+	status = acpi_get_table(ACPI_SIG_ECDT, 1,
+				(struct acpi_table_header **)&ecdt_ptr);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	/*
+	 * At this point, the namespace and the GPE is initialized, so
+	 * start to find the namespace objects and handle the events.
+	 */
+	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	return acpi_config_boot_ec(boot_ec, handle, true, true);
+}
+
 #if 0
 /*
  * Some EC firmware variations refuses to respond QR_EC when SCI_EVT is not
@@ -1720,8 +1789,12 @@ int __init acpi_ec_ecdt_probe(void)
 		ec->data_addr = ecdt_ptr->data.address;
 	}
 	ec->gpe = ecdt_ptr->gpe;
-	ec->handle = ACPI_ROOT_OBJECT;
-	ret = acpi_config_boot_ec(ec, true);
+
+	/*
+	 * At this point, the namespace is not initialized, so do not find
+	 * the namespace objects, or handle the events.
+	 */
+	ret = acpi_config_boot_ec(ec, ACPI_ROOT_OBJECT, false, true);
 error:
 	if (ret)
 		acpi_ec_free(ec);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 358b012..3797155 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -186,6 +186,7 @@ typedef int (*acpi_ec_query_func) (void *data);
 int acpi_ec_init(void);
 int acpi_ec_ecdt_probe(void);
 int acpi_ec_dsdt_probe(void);
+int acpi_ec_ecdt_start(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e878fc7..f8f9f4e 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2044,6 +2044,7 @@ int __init acpi_scan_init(void)
 	}
 
 	acpi_update_all_gpes();
+	acpi_ec_ecdt_start();
 
 	acpi_scan_initialized = true;
 
-- 
1.7.10
