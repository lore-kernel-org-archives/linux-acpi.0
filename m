From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPI / EC: Add EC setting preference support
Date: Tue, 16 May 2017 17:47:03 +0800
Message-ID: <259815d15a25b7f6e6dd1b8c765f17c9f38d8ccc.1494927504.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6434 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751912AbdEPJrL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 05:47:11 -0400
In-Reply-To: <cover.1494927504.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>

Due to unknown reasons, Windows may prefer ECDT EC GPE rather than DSDT
EC GPE setting as some ASUS BIOSen report wrong GPE in DSDT EC but correct
one in ECDT EC. Without knowing the root cause, this patch simply allows
users to specify preferred EC settings (ID and GPE) via command line and
provides default value to always prefere DSDT settings. Users can work
the ASUS BIOS problem around with "ec_use_boot_ec_gpe=Y".

Link: https://bugzilla.kernel.org/show_bug.cgi?id=195651
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a7e74ae..b4ae29f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -155,6 +155,14 @@ static bool ec_no_dsdt_boot_ec __read_mostly = false;
 module_param(ec_no_dsdt_boot_ec, bool, 0644);
 MODULE_PARM_DESC(ec_no_dsdt_boot_ec, "Do not probe DSDT EC as boot EC");
 
+static bool ec_use_boot_ec_id __read_mostly = false;
+module_param(ec_use_boot_ec_id, bool, 0644);
+MODULE_PARM_DESC(ec_use_boot_ec_id, "Override EC_ID using boot EC setting");
+
+static bool ec_use_boot_ec_gpe __read_mostly = false;
+module_param(ec_use_boot_ec_gpe, bool, 0644);
+MODULE_PARM_DESC(ec_use_boot_ec_gpe, "Override GPE_BIT using boot EC setting");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -1574,14 +1582,28 @@ static bool acpi_is_boot_ec(struct acpi_ec *ec)
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
 }
 
+static void acpi_ec_config_preference(struct acpi_ec *ec)
+{
+	if (ec->handle != boot_ec->handle) {
+		if (ec_use_boot_ec_id)
+			ec->handle = boot_ec->handle;
+		else
+			boot_ec->handle = ec->handle;
+	}
+	if (ec->gpe != boot_ec->gpe) {
+		if (ec_use_boot_ec_gpe)
+			ec->gpe = boot_ec->gpe;
+		else
+			boot_ec->gpe = ec->gpe;
+	}
+}
+
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec = NULL;
@@ -1600,8 +1622,8 @@ static int acpi_ec_add(struct acpi_device *device)
 	}
 
 	if (acpi_is_boot_ec(ec)) {
-		boot_ec_is_ecdt = false;
-		acpi_handle_debug(ec->handle, "duplicated.\n");
+		acpi_handle_debug(ec->handle, "duplicated late.\n");
+		acpi_ec_config_preference(ec);
 		acpi_ec_free(ec);
 		ec = boot_ec;
 		ret = acpi_config_boot_ec(ec, ec->handle, true, false);
@@ -1699,6 +1721,10 @@ int __init acpi_ec_dsdt_probe(void)
 		ret = -ENODEV;
 		goto error;
 	}
+	if (acpi_is_boot_ec(ec)) {
+		acpi_handle_debug(ec->handle, "duplicated early.\n");
+		acpi_ec_config_preference(ec);
+	}
 	/*
 	 * When the DSDT EC is available, always re-configure boot EC to
 	 * have _REG evaluated. _REG can only be evaluated after the
-- 
2.7.4

