From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 3/5] ACPI 2.0 / AML: Enable correct ACPI subsystem initialization order for new table loading mode
Date: Fri, 23 Sep 2016 11:26:49 +0800
Message-ID: <464cd800692310d4f3241a996319b49036cb7fc5.1474600034.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5> <cover.1474600034.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:49728 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934088AbcIWD0z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Sep 2016 23:26:55 -0400
In-Reply-To: <cover.1474600034.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch enables the following initialization order for the new table
loading mode (which is enabled by setting
acpi_gbl_parse_table_as_term_list to TRUE):
  1. Install default region handlers (SystemMemory, SystemIo, PciConfig,
     EmbeddedControl via ECDT) without evaluating _REG;
  2. Load the table and execute the module level AML opcodes instantly.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/bus.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 85b7d07..658b4c4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -985,7 +985,8 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-	if (acpi_gbl_group_module_level_code) {
+	if (!acpi_gbl_parse_table_as_term_list &&
+	    acpi_gbl_group_module_level_code) {
 		status = acpi_load_tables();
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX
@@ -1074,7 +1075,8 @@ static int __init acpi_bus_init(void)
 	status = acpi_ec_ecdt_probe();
 	/* Ignore result. Not having an ECDT is not fatal. */
 
-	if (!acpi_gbl_group_module_level_code) {
+	if (acpi_gbl_parse_table_as_term_list ||
+	    !acpi_gbl_group_module_level_code) {
 		status = acpi_load_tables();
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX
-- 
1.7.10

