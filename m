From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/4] ACPI / EC: Fix a memory leakage issue in acpi_ec_add()
Date: Fri,  2 Sep 2016 15:46:38 +0800
Message-ID: <51bc232e82784a302fcba870d55ffa1a178f7e09.1472802172.git.lv.zheng@intel.com>
References: <cover.1472802172.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25082 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbcIBHqq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Sep 2016 03:46:46 -0400
In-Reply-To: <cover.1472802172.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>, Luya Tshimbalanga <luya@fedoraproject.org>

When the handler installation failed, there was no code to free the
allocated EC device. This patch fixes this memory leakage issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=115021
Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
Suggested-by: Peter Wu <peter@lekensteyn.nl>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Luya Tshimbalanga <luya@fedoraproject.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 4a5f3ab..4b4c0cb 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1438,22 +1438,25 @@ static int acpi_ec_add(struct acpi_device *device)
 		return -ENOMEM;
 	if (ec_parse_device(device->handle, 0, ec, NULL) !=
 		AE_CTRL_TERMINATE) {
-			acpi_ec_free(ec);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto error;
 	}
 
 	/* Find and register all query methods */
 	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
 			    acpi_ec_register_query_methods, NULL, ec, NULL);
 
+	ret = acpi_config_boot_ec(ec, false);
+	if (ret)
+		goto error;
+
 	device->driver_data = ec;
 
 	ret = !!request_region(ec->data_addr, 1, "EC data");
 	WARN(!ret, "Could not request EC data io port 0x%lx", ec->data_addr);
 	ret = !!request_region(ec->command_addr, 1, "EC cmd");
 	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
-
-	ret = acpi_config_boot_ec(ec, false);
+	ret = 0;
 
 	/* Reprobe devices depending on the EC */
 	acpi_walk_dep_device_list(ec->handle);
@@ -1464,6 +1467,9 @@ static int acpi_ec_add(struct acpi_device *device)
 	/* Clear stale _Q events if hardware might require that */
 	if (EC_FLAGS_CLEAR_ON_RESUME)
 		acpi_ec_clear(ec);
+error:
+	if (ret)
+		acpi_ec_free(ec);
 	return ret;
 }
 
-- 
1.7.10

