From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 4/4] ACPI / EC: Fix issues related to boot_ec
Date: Wed,  7 Sep 2016 16:50:27 +0800
Message-ID: <cc1a9232a17c5f9df7c4547a2e87f48288574db4.1473238007.git.lv.zheng@intel.com>
References: <cover.1472802172.git.lv.zheng@intel.com> <cover.1473238007.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1473238007.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>
List-Id: linux-acpi@vger.kernel.org

There are issues related to the boot_ec:
1. If acpi_ec_remove() is invoked, boot_ec will also be freed, this is not
   expected as the boot_ec could be enumerated via ECDT.
2. Address space handler installation/unstallation lead to unexpected _REG
   evaluations.
This patch adds acpi_is_boot_ec() check to be used to fix the above issues.
However, since acpi_ec_remove() actually won't be invoked, this patch
doesn't handle the reference counting of "struct acpi_ec", it only ensures
the correctness of the boot_ec destruction during the boot.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=153511
Reported-and-tested-by: Jonh Henderson <jw.hendy@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Peter Wu <peter@lekensteyn.nl>
---
 drivers/acpi/ec.c |   63 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2ae9194..6805310 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1536,6 +1536,37 @@ static int acpi_config_boot_ec(struct acpi_ec *ec, acpi_handle handle,
 	return ret;
 }
 
+static bool acpi_ec_ecdt_get_handle(acpi_handle *phandle)
+{
+	struct acpi_table_ecdt *ecdt_ptr;
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_table(ACPI_SIG_ECDT, 1,
+				(struct acpi_table_header **)&ecdt_ptr);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	*phandle = handle;
+	return true;
+}
+
+static bool acpi_is_boot_ec(struct acpi_ec *ec)
+{
+	if (!boot_ec)
+		return false;
+	if (ec->handle == boot_ec->handle &&
+	    ec->gpe == boot_ec->gpe &&
+	    ec->command_addr == boot_ec->command_addr &&
+	    ec->data_addr == boot_ec->data_addr)
+		return true;
+	return false;
+}
+
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec = NULL;
@@ -1553,7 +1584,14 @@ static int acpi_ec_add(struct acpi_device *device)
 			goto err_alloc;
 	}
 
-	ret = acpi_config_boot_ec(ec, device->handle, true, false);
+	if (acpi_is_boot_ec(ec)) {
+		boot_ec_is_ecdt = false;
+		acpi_handle_debug(ec->handle, "duplicated.\n");
+		acpi_ec_free(ec);
+		ec = boot_ec;
+		ret = acpi_config_boot_ec(ec, ec->handle, true, false);
+	} else
+		ret = acpi_ec_setup(ec, true);
 	if (ret)
 		goto err_query;
 
@@ -1566,12 +1604,15 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	/* Reprobe devices depending on the EC */
 	acpi_walk_dep_device_list(ec->handle);
+	acpi_handle_debug(ec->handle, "enumerated.\n");
 	return 0;
 
 err_query:
-	acpi_ec_remove_query_handlers(ec, true, 0);
+	if (ec != boot_ec)
+		acpi_ec_remove_query_handlers(ec, true, 0);
 err_alloc:
-	acpi_ec_free(ec);
+	if (ec != boot_ec)
+		acpi_ec_free(ec);
 	return ret;
 }
 
@@ -1583,11 +1624,13 @@ static int acpi_ec_remove(struct acpi_device *device)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
-	ec_remove_handlers(ec);
 	release_region(ec->data_addr, 1);
 	release_region(ec->command_addr, 1);
 	device->driver_data = NULL;
-	acpi_ec_free(ec);
+	if (ec != boot_ec) {
+		ec_remove_handlers(ec);
+		acpi_ec_free(ec);
+	}
 	return 0;
 }
 
@@ -1659,8 +1702,6 @@ error:
  */
 int __init acpi_ec_ecdt_start(void)
 {
-	struct acpi_table_ecdt *ecdt_ptr;
-	acpi_status status;
 	acpi_handle handle;
 
 	if (!boot_ec)
@@ -1672,17 +1713,11 @@ int __init acpi_ec_ecdt_start(void)
 	if (!boot_ec_is_ecdt)
 		return -ENODEV;
 
-	status = acpi_get_table(ACPI_SIG_ECDT, 1,
-				(struct acpi_table_header **)&ecdt_ptr);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
 	/*
 	 * At this point, the namespace and the GPE is initialized, so
 	 * start to find the namespace objects and handle the events.
 	 */
-	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
-	if (ACPI_FAILURE(status))
+	if (!acpi_ec_ecdt_get_handle(&handle))
 		return -ENODEV;
 	return acpi_config_boot_ec(boot_ec, handle, true, true);
 }
-- 
1.7.10
