From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/31] ACPICA: Utilities: Correct conditional compilation definitions.
Date: Mon, 13 Apr 2015 11:49:39 +0800
Message-ID: <f5e3923e6f22ef178113874cc374cf64b8d237aa.1428893937.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 9a5982afbebc56289c4834b5f6dac87e0f04af14

Some conditional compilation definitions are wrong across header and source
files. This patch corrects them for the utilities component.

Link: https://github.com/acpica/acpica/commit/9a5982af
Reported-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h |   14 ++++++++++++--
 drivers/acpi/acpica/utmisc.c  |    2 ++
 drivers/acpi/acpica/utuuid.c  |    2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 04f4c31..2b3c5bd 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -502,6 +502,9 @@ const union acpi_predefined_info *acpi_ut_get_next_predefined_method(const union
 
 const union acpi_predefined_info *acpi_ut_match_predefined_method(char *name);
 
+void acpi_ut_get_expected_return_types(char *buffer, u32 expected_btypes);
+
+#if (defined ACPI_ASL_COMPILER || defined ACPI_HELP_APP)
 const union acpi_predefined_info *acpi_ut_match_resource_name(char *name);
 
 void
@@ -509,9 +512,8 @@ acpi_ut_display_predefined_method(char *buffer,
 				  const union acpi_predefined_info *this_name,
 				  u8 multi_line);
 
-void acpi_ut_get_expected_return_types(char *buffer, u32 expected_btypes);
-
 u32 acpi_ut_get_resource_bit_width(char *buffer, u16 types);
+#endif
 
 /*
  * utstate - Generic state creation/cache routines
@@ -562,7 +564,9 @@ const struct acpi_exception_info *acpi_ut_validate_exception(acpi_status
 
 u8 acpi_ut_is_pci_root_bridge(char *id);
 
+#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP)
 u8 acpi_ut_is_aml_table(struct acpi_table_header *table);
+#endif
 
 acpi_status
 acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
@@ -621,15 +625,19 @@ acpi_ut_get_resource_end_tag(union acpi_operand_object *obj_desc, u8 **end_tag);
  */
 void acpi_ut_strupr(char *src_string);
 
+#ifdef ACPI_ASL_COMPILER
 void acpi_ut_strlwr(char *src_string);
 
 int acpi_ut_stricmp(char *string1, char *string2);
+#endif
 
 acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer);
 
 void acpi_ut_print_string(char *string, u16 max_length);
 
+#if defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP
 void ut_convert_backslashes(char *pathname);
+#endif
 
 u8 acpi_ut_valid_acpi_name(char *name);
 
@@ -777,6 +785,8 @@ int acpi_ut_file_printf(ACPI_FILE file, const char *format, ...);
 /*
  * utuuid -- UUID support functions
  */
+#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_HELP_APP)
 void acpi_ut_convert_string_to_uuid(char *in_string, u8 *uuid_buffer);
+#endif
 
 #endif				/* _ACUTILS_H */
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 56bbacd..cbb7034 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -75,6 +75,7 @@ u8 acpi_ut_is_pci_root_bridge(char *id)
 	return (FALSE);
 }
 
+#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_is_aml_table
@@ -102,6 +103,7 @@ u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
 
 	return (FALSE);
 }
+#endif
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index c6149a2..e6cab66 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -47,6 +47,7 @@
 #define _COMPONENT          ACPI_COMPILER
 ACPI_MODULE_NAME("utuuid")
 
+#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_HELP_APP)
 /*
  * UUID support functions.
  *
@@ -94,3 +95,4 @@ void acpi_ut_convert_string_to_uuid(char *in_string, u8 *uuid_buffer)
 					       1]);
 	}
 }
+#endif
-- 
1.7.10
