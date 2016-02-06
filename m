From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/14] ACPI 2.0 / AML: Enable correct ACPI subsystem initialization order for new table loading mode
Date: Sat,  6 Feb 2016 11:54:24 +0800
Message-ID: <d444919a0a5e8555d5128936bd5f2814952354de.1454730660.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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
index 8752860..0d6bb22 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -911,7 +911,8 @@ void __init acpi_early_init(void)
 		goto error0;
 	}
 
-	if (acpi_gbl_group_module_level_code) {
+	if (!acpi_gbl_parse_table_as_term_list &&
+	    acpi_gbl_group_module_level_code) {
 		status = acpi_load_tables();
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR PREFIX
@@ -994,7 +995,8 @@ static int __init acpi_bus_init(void)
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
