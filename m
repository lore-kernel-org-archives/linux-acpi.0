From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/15] ACPICA: Remove unnecessary arguments to ACPI_INFO
Date: Fri, 19 Feb 2016 14:16:42 +0800
Message-ID: <a6f00a29faf32699a40f1380fe80a292e9f1a34f.1455857581.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 181f56605a771e0b91e24b0648d2565ca70bea20

This is used as a purely infomation message, without module name
and line number information. Therefore, these arguments are
not needed and they are unnecessary overhead.
Arguments are removed.
ACPICA BZ 872.

Link: https://github.com/acpica/acpica/commit/181f5660
Link: https://bugs.acpica.org/show_bug.cgi?id=872
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbcmds.c    |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    3 +--
 drivers/acpi/acpica/dsobject.c  |    3 +--
 drivers/acpi/acpica/evgpeblk.c  |    3 +--
 drivers/acpi/acpica/evgpeinit.c |    2 +-
 drivers/acpi/acpica/exconfig.c  |    4 ++--
 drivers/acpi/acpica/nseval.c    |    3 +--
 drivers/acpi/acpica/tbinstal.c  |    5 ++---
 drivers/acpi/acpica/tbprint.c   |    7 +++----
 drivers/acpi/acpica/tbutils.c   |    4 +---
 drivers/acpi/acpica/tbxfload.c  |    6 ++----
 drivers/acpi/acpica/uttrack.c   |    2 +-
 drivers/acpi/acpica/utxferror.c |    3 +--
 include/acpi/acpixf.h           |    6 ++----
 14 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 7ec62c4..772178c 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -348,7 +348,7 @@ void acpi_db_display_table_info(char *table_arg)
 		} else {
 			/* If the pointer is null, the table has been unloaded */
 
-			ACPI_INFO((AE_INFO, "%4.4s - Table has been unloaded",
+			ACPI_INFO(("%4.4s - Table has been unloaded",
 				   table_desc->signature.ascii));
 		}
 	}
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 6a72047..1982310 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -809,8 +809,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		if (method_desc->method.
 		    info_flags & ACPI_METHOD_SERIALIZED_PENDING) {
 			if (walk_state) {
-				ACPI_INFO((AE_INFO,
-					   "Marking method %4.4s as Serialized "
+				ACPI_INFO(("Marking method %4.4s as Serialized "
 					   "because of AE_ALREADY_EXISTS error",
 					   walk_state->method_node->name.
 					   ascii));
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index c303e9d..a91de2b 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -524,8 +524,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 			arg = arg->common.next;
 		}
 
-		ACPI_INFO((AE_INFO,
-			   "Actual Package length (%u) is larger than "
+		ACPI_INFO(("Actual Package length (%u) is larger than "
 			   "NumElements field (%u), truncated",
 			   i, element_count));
 	} else if (i < element_count) {
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 9275e62..447fa1c 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -499,8 +499,7 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 	}
 
 	if (gpe_enabled_count) {
-		ACPI_INFO((AE_INFO,
-			   "Enabled %u GPEs in block %02X to %02X",
+		ACPI_INFO(("Enabled %u GPEs in block %02X to %02X",
 			   gpe_enabled_count, (u32)gpe_block->block_base_number,
 			   (u32)(gpe_block->block_base_number +
 				 (gpe_block->gpe_count - 1))));
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 9fdd8d0..7dc7547 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -281,7 +281,7 @@ void acpi_ev_update_gpes(acpi_owner_id table_owner_id)
 	}
 
 	if (walk_info.count) {
-		ACPI_INFO((AE_INFO, "Enabled %u new GPEs", walk_info.count));
+		ACPI_INFO(("Enabled %u new GPEs", walk_info.count));
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 011df21..f741613 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -252,7 +252,7 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 	status = acpi_get_table_by_index(table_index, &table);
 	if (ACPI_SUCCESS(status)) {
-		ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
+		ACPI_INFO(("Dynamic OEM Table Load:"));
 		acpi_tb_print_table_header(0, table);
 	}
 
@@ -472,7 +472,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 	/* Install the new table into the local data structures */
 
-	ACPI_INFO((AE_INFO, "Dynamic OEM Table Load:"));
+	ACPI_INFO(("Dynamic OEM Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 65d58be..5d59cfc 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -378,8 +378,7 @@ void acpi_ns_exec_module_code_list(void)
 		acpi_ut_remove_reference(prev);
 	}
 
-	ACPI_INFO((AE_INFO,
-		   "Executed %u blocks of module-level executable AML code",
+	ACPI_INFO(("Executed %u blocks of module-level executable AML code",
 		   method_count));
 
 	ACPI_FREE(info);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index b661a1e..4dc6108 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -267,8 +267,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	if (!reload &&
 	    acpi_gbl_disable_ssdt_table_install &&
 	    ACPI_COMPARE_NAME(&new_table_desc.signature, ACPI_SIG_SSDT)) {
-		ACPI_INFO((AE_INFO,
-			   "Ignoring installation of %4.4s at %8.8X%8.8X",
+		ACPI_INFO(("Ignoring installation of %4.4s at %8.8X%8.8X",
 			   new_table_desc.signature.ascii,
 			   ACPI_FORMAT_UINT64(address)));
 		goto release_and_exit;
@@ -432,7 +431,7 @@ finish_override:
 		return;
 	}
 
-	ACPI_INFO((AE_INFO, "%4.4s 0x%8.8X%8.8X"
+	ACPI_INFO(("%4.4s 0x%8.8X%8.8X"
 		   " %s table override, new table: 0x%8.8X%8.8X",
 		   old_table_desc->signature.ascii,
 		   ACPI_FORMAT_UINT64(old_table_desc->address),
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index fd4146d..26d61db 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -132,7 +132,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 
 		/* FACS only has signature and length fields */
 
-		ACPI_INFO((AE_INFO, "%-4.4s 0x%8.8X%8.8X %06X",
+		ACPI_INFO(("%-4.4s 0x%8.8X%8.8X %06X",
 			   header->signature, ACPI_FORMAT_UINT64(address),
 			   header->length));
 	} else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
@@ -144,7 +144,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 		       ACPI_OEM_ID_SIZE);
 		acpi_tb_fix_string(local_header.oem_id, ACPI_OEM_ID_SIZE);
 
-		ACPI_INFO((AE_INFO, "RSDP 0x%8.8X%8.8X %06X (v%.2d %-6.6s)",
+		ACPI_INFO(("RSDP 0x%8.8X%8.8X %06X (v%.2d %-6.6s)",
 			   ACPI_FORMAT_UINT64(address),
 			   (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
 			    revision >
@@ -158,8 +158,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 
 		acpi_tb_cleanup_table_header(&local_header, header);
 
-		ACPI_INFO((AE_INFO,
-			   "%-4.4s 0x%8.8X%8.8X"
+		ACPI_INFO(("%-4.4s 0x%8.8X%8.8X"
 			   " %06X (v%.2d %-6.6s %-8.8s %08X %-4.4s %08X)",
 			   local_header.signature, ACPI_FORMAT_UINT64(address),
 			   local_header.length, local_header.revision,
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 3269bef..9240c76 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -174,9 +174,7 @@ struct acpi_table_header *acpi_tb_copy_dsdt(u32 table_index)
 				      ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL,
 				      new_table);
 
-	ACPI_INFO((AE_INFO,
-		   "Forced DSDT copy: length 0x%05X copied locally, original unmapped",
-		   new_table->length));
+	ACPI_INFO(("Forced DSDT copy: length 0x%05X copied locally, original unmapped", new_table->length));
 
 	return (new_table);
 }
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 278666e..c89943b 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -206,9 +206,7 @@ acpi_status acpi_tb_load_namespace(void)
 	}
 
 	if (!tables_failed) {
-		ACPI_INFO((AE_INFO,
-			   "%u ACPI AML tables successfully acquired and loaded\n",
-			   tables_loaded));
+		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n", tables_loaded));
 	} else {
 		ACPI_ERROR((AE_INFO,
 			    "%u table load failures, %u successful",
@@ -301,7 +299,7 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 
 	/* Install the table and load it into the namespace */
 
-	ACPI_INFO((AE_INFO, "Host-directed Dynamic ACPI Table Load:"));
+	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
 	status = acpi_tb_install_standard_table(ACPI_PTR_TO_PHYSADDR(table),
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index c7c2bb8..60c406a 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -712,7 +712,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 	/* Print summary */
 
 	if (!num_outstanding) {
-		ACPI_INFO((AE_INFO, "No outstanding allocations"));
+		ACPI_INFO(("No outstanding allocations"));
 	} else {
 		ACPI_ERROR((AE_INFO, "%u(0x%X) Outstanding allocations",
 			    num_outstanding, num_outstanding));
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 6fe5959..d9f15cb 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -175,8 +175,7 @@ ACPI_EXPORT_SYMBOL(acpi_warning)
  * TBD: module_name and line_number args are not needed, should be removed.
  *
  ******************************************************************************/
-void ACPI_INTERNAL_VAR_XFACE
-acpi_info(const char *module_name, u32 line_number, const char *format, ...)
+void ACPI_INTERNAL_VAR_XFACE acpi_info(const char *format, ...)
 {
 	va_list arg_list;
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c96621e..1755697 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -897,11 +897,9 @@ ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
 				acpi_warning(const char *module_name,
 					     u32 line_number,
 					     const char *format, ...))
-ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
+ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(1)
 				void ACPI_INTERNAL_VAR_XFACE
-				acpi_info(const char *module_name,
-					  u32 line_number,
-					  const char *format, ...))
+				acpi_info(const char *format, ...))
 ACPI_MSG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(3)
 				void ACPI_INTERNAL_VAR_XFACE
 				acpi_bios_error(const char *module_name,
-- 
1.7.10
