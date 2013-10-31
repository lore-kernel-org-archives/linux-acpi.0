From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/15] ACPICA: Add __init for ACPICA initializers/finalizers.
Date: Thu, 31 Oct 2013 09:31:24 +0800
Message-ID: <a312b067cbffc85c5e75e18aed7959a0a145d2a4.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43865 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBb6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:58 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 196 lines of divergences.

This patch adds __init for the ACPICA documented initializers:
  acpi_initialize_tables()
  acpi_initialize_subsystem()
  acpi_load_tables()
  acpi_enable_subsystem()
  acpi_initialize_objects()
and acpi_reallocate_root_table(), acpi_find_root_pointer() APIs which are
also meant to be called during initialization.
This patch adds __init for the ACPICA documented finalizers:
  acpi_terminate()
as this finalizer is only called in __init function now.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbutils.c  |    3 +--
 drivers/acpi/acpica/tbxface.c  |    2 +-
 drivers/acpi/acpica/tbxfload.c |    2 +-
 drivers/acpi/acpica/tbxfroot.c |    2 +-
 drivers/acpi/acpica/utxface.c  |    2 +-
 drivers/acpi/acpica/utxfinit.c |    6 +++---
 include/acpi/acpixf.h          |   14 +++++++-------
 7 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 43ffe21..3d6bb83 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -430,8 +430,7 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
  *
  ******************************************************************************/
 
-acpi_status __init
-acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
+acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 {
 	struct acpi_table_rsdp *rsdp;
 	u32 table_entry_size;
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 7e63090..db826ea 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -164,7 +164,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_tables)
  *              kernel.
  *
  ******************************************************************************/
-acpi_status acpi_reallocate_root_table(void)
+acpi_status __init acpi_reallocate_root_table(void)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index b1e1edd..60b5a87 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -66,7 +66,7 @@ static acpi_status acpi_tb_load_namespace(void);
  *
  ******************************************************************************/
 
-acpi_status acpi_load_tables(void)
+acpi_status __init acpi_load_tables(void)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 1c95fab..e4e1468 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -111,7 +111,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
  *
  ******************************************************************************/
 
-acpi_status acpi_find_root_pointer(acpi_size *table_address)
+acpi_status __init acpi_find_root_pointer(acpi_size *table_address)
 {
 	u8 *table_ptr;
 	u8 *mem_rover;
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 3986902..be322c8 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("utxface")
  * DESCRIPTION: Shutdown the ACPICA subsystem and release all resources.
  *
  ******************************************************************************/
-acpi_status acpi_terminate(void)
+acpi_status __init acpi_terminate(void)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index ff6f4d1..75efea0 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -65,7 +65,7 @@ ACPI_MODULE_NAME("utxfinit")
  *              called, so any early initialization belongs here.
  *
  ******************************************************************************/
-acpi_status acpi_initialize_subsystem(void)
+acpi_status __init acpi_initialize_subsystem(void)
 {
 	acpi_status status;
 
@@ -140,7 +140,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_subsystem)
  *              Puts system into ACPI mode if it isn't already.
  *
  ******************************************************************************/
-acpi_status acpi_enable_subsystem(u32 flags)
+acpi_status __init acpi_enable_subsystem(u32 flags)
 {
 	acpi_status status = AE_OK;
 
@@ -245,7 +245,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_enable_subsystem)
  *              objects and executing AML code for Regions, buffers, etc.
  *
  ******************************************************************************/
-acpi_status acpi_initialize_objects(u32 flags)
+acpi_status __init acpi_initialize_objects(u32 flags)
 {
 	acpi_status status = AE_OK;
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 00725f4..d8f9457 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -114,17 +114,17 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
 /*
  * Initialization
  */
-acpi_status
+acpi_status __init
 acpi_initialize_tables(struct acpi_table_desc *initial_storage,
 		       u32 initial_table_count, u8 allow_resize);
 
 acpi_status __init acpi_initialize_subsystem(void);
 
-acpi_status acpi_enable_subsystem(u32 flags);
+acpi_status __init acpi_enable_subsystem(u32 flags);
 
-acpi_status acpi_initialize_objects(u32 flags);
+acpi_status __init acpi_initialize_objects(u32 flags);
 
-acpi_status acpi_terminate(void);
+acpi_status __init acpi_terminate(void);
 
 /*
  * Miscellaneous global interfaces
@@ -168,14 +168,14 @@ acpi_status acpi_load_table(struct acpi_table_header *table);
 
 acpi_status acpi_unload_parent_table(acpi_handle object);
 
-acpi_status acpi_load_tables(void);
+acpi_status __init acpi_load_tables(void);
 
 /*
  * ACPI table manipulation interfaces
  */
-acpi_status acpi_reallocate_root_table(void);
+acpi_status __init acpi_reallocate_root_table(void);
 
-acpi_status acpi_find_root_pointer(acpi_size * rsdp_address);
+acpi_status __init acpi_find_root_pointer(acpi_size *rsdp_address);
 
 acpi_status acpi_unload_table_id(acpi_owner_id id);
 
-- 
1.7.10

