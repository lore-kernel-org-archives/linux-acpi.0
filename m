From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/30] ACPICA: Divergence: Port declarators back to ACPICA
Date: Thu,  4 Aug 2016 16:43:19 +0800
Message-ID: <af77f00e56ea3098ceeaf65dd97e978c513f4fbf.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39695 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932814AbcHDIn1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:43:27 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit c160cae765412f5736cf88a9ebcc6138aa761a48

Linux uses asmlinkage and sparse macros to mark function symbols.  This
leads to the divergences between the Linux and the ACPICA.
This patch ports such declarators back to ACPICA. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/c160cae7
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/actables.h    |    3 ++-
 drivers/acpi/acpica/tbutils.c     |    3 ++-
 drivers/acpi/acpica/tbxface.c     |    4 ++--
 drivers/acpi/acpica/tbxfload.c    |    4 ++--
 drivers/acpi/acpica/tbxfroot.c    |    5 ++++-
 drivers/acpi/acpica/utxface.c     |    2 +-
 drivers/acpi/acpica/utxfinit.c    |    6 +++---
 include/acpi/acpixf.h             |   28 ++++++++++++++++------------
 include/acpi/platform/acenv.h     |    4 ++++
 include/acpi/platform/aclinux.h   |    2 ++
 include/acpi/platform/aclinuxex.h |    2 +-
 11 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index cd5a135..86d4d62 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -159,7 +159,8 @@ acpi_status
 acpi_tb_install_fixed_table(acpi_physical_address address,
 			    char *signature, u32 *table_index);
 
-acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
+acpi_status ACPI_INIT_FUNCTION
+acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
 /*
  * tbxfload
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index e285539..51eb07c 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -252,7 +252,8 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
  *
  ******************************************************************************/
 
-acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
+acpi_status ACPI_INIT_FUNCTION
+acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 {
 	struct acpi_table_rsdp *rsdp;
 	u32 table_entry_size;
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 3ecec93..4ab6b9c 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -98,7 +98,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count)
  *
  ******************************************************************************/
 
-acpi_status __init
+acpi_status ACPI_INIT_FUNCTION
 acpi_initialize_tables(struct acpi_table_desc *initial_table_array,
 		       u32 initial_table_count, u8 allow_resize)
 {
@@ -164,7 +164,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_tables)
  *              kernel.
  *
  ******************************************************************************/
-acpi_status __init acpi_reallocate_root_table(void)
+acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index ac71abc..e0cc919 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -63,7 +63,7 @@ ACPI_MODULE_NAME("tbxfload")
  * DESCRIPTION: Load the ACPI tables from the RSDT/XSDT
  *
  ******************************************************************************/
-acpi_status __init acpi_load_tables(void)
+acpi_status ACPI_INIT_FUNCTION acpi_load_tables(void)
 {
 	acpi_status status;
 
@@ -272,7 +272,7 @@ unlock_and_exit:
  *
  ******************************************************************************/
 
-acpi_status __init
+acpi_status ACPI_INIT_FUNCTION
 acpi_install_table(acpi_physical_address address, u8 physical)
 {
 	acpi_status status;
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index adb6cfc..0adb1c7 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -142,7 +142,8 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
  *
  ******************************************************************************/
 
-acpi_status __init acpi_find_root_pointer(acpi_physical_address *table_address)
+acpi_status ACPI_INIT_FUNCTION
+acpi_find_root_pointer(acpi_physical_address *table_address)
 {
 	u8 *table_ptr;
 	u8 *mem_rover;
@@ -244,6 +245,8 @@ acpi_status __init acpi_find_root_pointer(acpi_physical_address *table_address)
 	return_ACPI_STATUS(AE_NOT_FOUND);
 }
 
+ACPI_EXPORT_SYMBOL_INIT(acpi_find_root_pointer)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_scan_memory_for_rsdp
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index d9e6aac..ec503c8 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("utxface")
  * DESCRIPTION: Shutdown the ACPICA subsystem and release all resources.
  *
  ******************************************************************************/
-acpi_status __init acpi_terminate(void)
+acpi_status ACPI_INIT_FUNCTION acpi_terminate(void)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 75b5f27..d6d9462 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -69,7 +69,7 @@ void ae_do_object_overrides(void);
  *
  ******************************************************************************/
 
-acpi_status __init acpi_initialize_subsystem(void)
+acpi_status ACPI_INIT_FUNCTION acpi_initialize_subsystem(void)
 {
 	acpi_status status;
 
@@ -141,7 +141,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_subsystem)
  *              Puts system into ACPI mode if it isn't already.
  *
  ******************************************************************************/
-acpi_status __init acpi_enable_subsystem(u32 flags)
+acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
 {
 	acpi_status status = AE_OK;
 
@@ -239,7 +239,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_enable_subsystem)
  *              objects and executing AML code for Regions, buffers, etc.
  *
  ******************************************************************************/
-acpi_status __init acpi_initialize_objects(u32 flags)
+acpi_status ACPI_INIT_FUNCTION acpi_initialize_objects(u32 flags)
 {
 	acpi_status status = AE_OK;
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1ff3a76..875964d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -416,18 +416,19 @@ ACPI_GLOBAL(u8, acpi_gbl_system_awake_and_running);
 /*
  * Initialization
  */
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 			    acpi_initialize_tables(struct acpi_table_desc
 						   *initial_storage,
 						   u32 initial_table_count,
 						   u8 allow_resize))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_initialize_subsystem(void))
-
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_enable_subsystem(u32 flags))
-
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
-			    acpi_initialize_objects(u32 flags))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_terminate(void))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+			     acpi_initialize_subsystem(void))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+			     acpi_enable_subsystem(u32 flags))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+			     acpi_initialize_objects(u32 flags))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+			     acpi_terminate(void))
 
 /*
  * Miscellaneous global interfaces
@@ -467,7 +468,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 /*
  * ACPI table load/unload interfaces
  */
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 			    acpi_install_table(acpi_physical_address address,
 					       u8 physical))
 
@@ -476,14 +477,17 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_unload_parent_table(acpi_handle object))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_load_tables(void))
+
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+			    acpi_load_tables(void))
 
 /*
  * ACPI table manipulation interfaces
  */
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_reallocate_root_table(void))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
+			    acpi_reallocate_root_table(void))
 
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 			    acpi_find_root_pointer(acpi_physical_address
 						   *rsdp_address))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 86b5a84..ed959e5 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -403,4 +403,8 @@ typedef char *va_list;
 #endif				/* ACPI_APPLICATION */
 #endif				/* ACPI_FILE */
 
+#ifndef ACPI_INIT_FUNCTION
+#define ACPI_INIT_FUNCTION
+#endif
+
 #endif				/* __ACENV_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 296a276..cde6f33 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -92,6 +92,8 @@
 #include <asm/acenv.h>
 #endif
 
+#define ACPI_INIT_FUNCTION __init
+
 #ifndef CONFIG_ACPI
 
 /* External globals for __KERNEL__, stubs is needed */
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index f8bb0d8..a5509d8 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -71,7 +71,7 @@
 /*
  * Overrides for in-kernel ACPICA
  */
-acpi_status __init acpi_os_initialize(void);
+acpi_status ACPI_INIT_FUNCTION acpi_os_initialize(void);
 
 acpi_status acpi_os_terminate(void);
 
-- 
1.7.10

