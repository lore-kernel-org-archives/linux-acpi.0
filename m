From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/27] ACPICA: OSL: Add section to collect the divergence in acpixf.h.
Date: Wed, 30 Apr 2014 10:05:02 +0800
Message-ID: <f7a84e23fe2a3486136da2e7218bcfec36e8a4fc.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch re-orders the interface prototypes defined in acpixf.h, moving
those having not back ported to ACPICA into a seperate section to reduce
the source code differences between Linux and ACPICA.
This can help to reduce the cost of linuxizing the follow up commits.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 923775a..7980c87 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -338,18 +338,11 @@ acpi_status __init acpi_reallocate_root_table(void);
 
 acpi_status __init acpi_find_root_pointer(acpi_size *rsdp_address);
 
-acpi_status acpi_unload_table_id(acpi_owner_id id);
-
 acpi_status
 acpi_get_table_header(acpi_string signature,
 		      u32 instance, struct acpi_table_header *out_table_header);
 
 acpi_status
-acpi_get_table_with_size(acpi_string signature,
-	       u32 instance, struct acpi_table_header **out_table,
-	       acpi_size *tbl_size);
-
-acpi_status
 acpi_get_table(acpi_string signature,
 	       u32 instance, struct acpi_table_header **out_table);
 
@@ -391,10 +384,6 @@ acpi_attach_data(acpi_handle object, acpi_object_handler handler, void *data);
 acpi_status acpi_detach_data(acpi_handle object, acpi_object_handler handler);
 
 acpi_status
-acpi_get_data_full(acpi_handle object, acpi_object_handler handler, void **data,
-		   void (*callback)(void *));
-
-acpi_status
 acpi_get_data(acpi_handle object, acpi_object_handler handler, void **data);
 
 acpi_status
@@ -429,8 +418,6 @@ acpi_get_next_object(acpi_object_type type,
 
 acpi_status acpi_get_type(acpi_handle object, acpi_object_type * out_type);
 
-acpi_status acpi_get_id(acpi_handle object, acpi_owner_id * out_type);
-
 acpi_status acpi_get_parent(acpi_handle object, acpi_handle * out_handle);
 
 /*
@@ -747,4 +734,21 @@ ACPI_DBG_DEPENDENT_RETURN_VOID(ACPI_PRINTF_LIKE(6)
 						     const char *module_name,
 						     u32 component_id,
 						     const char *format, ...))
+
+/*
+ * Divergences
+ */
+acpi_status acpi_get_id(acpi_handle object, acpi_owner_id * out_type);
+
+acpi_status acpi_unload_table_id(acpi_owner_id id);
+
+acpi_status
+acpi_get_table_with_size(acpi_string signature,
+	       u32 instance, struct acpi_table_header **out_table,
+	       acpi_size *tbl_size);
+
+acpi_status
+acpi_get_data_full(acpi_handle object, acpi_object_handler handler, void **data,
+		   void (*callback)(void *));
+
 #endif				/* __ACXFACE_H__ */
-- 
1.7.10
