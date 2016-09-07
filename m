From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/4] ACPI / EC: Fix a memory leakage issue in acpi_ec_add()
Date: Wed,  7 Sep 2016 16:50:14 +0800
Message-ID: <2a0e9a11d5e16d4775a45773c94067a8d3ea98c1.1473238007.git.lv.zheng@intel.com>
References: <cover.1472802172.git.lv.zheng@intel.com> <cover.1473238007.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:1422 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754707AbcIGIuU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 04:50:20 -0400
In-Reply-To: <cover.1473238007.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>

When the handler installation failed, there was no code to free the
allocated EC device. This patch fixes this memory leakage issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=115021
Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
Tested-by: Jonh Henderson <jw.hendy@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Peter Wu <peter@lekensteyn.nl>
---
 drivers/acpi/ec.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9eab651..50895ff 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1513,14 +1513,18 @@ static int acpi_ec_add(struct acpi_device *device)
 		return -ENOMEM;
 	if (ec_parse_device(device->handle, 0, ec, NULL) !=
 		AE_CTRL_TERMINATE) {
-			acpi_ec_free(ec);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_alloc;
 	}
 
 	/* Find and register all query methods */
 	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
 			    acpi_ec_register_query_methods, NULL, ec, NULL);
 
+	ret = acpi_config_boot_ec(ec, false);
+	if (ret)
+		goto err_query;
+
 	device->driver_data = ec;
 
 	ret = !!request_region(ec->data_addr, 1, "EC data");
@@ -1528,13 +1532,17 @@ static int acpi_ec_add(struct acpi_device *device)
 	ret = !!request_region(ec->command_addr, 1, "EC cmd");
 	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
 
-	ret = acpi_config_boot_ec(ec, false);
-
 	/* Reprobe devices depending on the EC */
 	acpi_walk_dep_device_list(ec->handle);
 
 	/* EC is fully operational, allow queries */
 	acpi_ec_enable_event(ec);
+	return 0;
+
+err_query:
+	acpi_ec_remove_query_handlers(ec, true, 0);
+err_alloc:
+	acpi_ec_free(ec);
 	return ret;
 }
 
-- 
1.7.10

