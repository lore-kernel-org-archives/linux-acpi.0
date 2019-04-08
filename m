Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB353C10F13
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7993A21841
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfDHUws (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:52:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:41643 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfDHUws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 16:52:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="141104043"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2019 13:52:46 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 3/8] ACPICA: Rename nameseg length macro/define for clarity
Date:   Mon,  8 Apr 2019 13:42:25 -0700
Message-Id: <20190408204230.4335-4-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190408204230.4335-1-erik.schmauss@intel.com>
References: <20190408204230.4335-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 24870bd9e73d71e2a1ff0a1e94519f8f8409e57d

ACPI_NAME_SIZE changed to ACPI_NAMESEG_SIZE
This clarifies that this is the length of an individual
nameseg, not the length of a generic namestring/namepath.
Improves understanding of the code.

Link: https://github.com/acpica/acpica/commit/24870bd9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/aclocal.h                  |  4 ++--
 drivers/acpi/acpica/dbnames.c                  |  2 +-
 drivers/acpi/acpica/evgpeinit.c                |  4 ++--
 drivers/acpi/acpica/exnames.c                  |  6 +++---
 drivers/acpi/acpica/nsaccess.c                 |  2 +-
 drivers/acpi/acpica/nsdump.c                   |  2 +-
 drivers/acpi/acpica/nsnames.c                  |  6 +++---
 drivers/acpi/acpica/nsrepair2.c                |  2 +-
 drivers/acpi/acpica/nsutils.c                  | 10 +++++-----
 drivers/acpi/acpica/psargs.c                   |  8 ++++----
 drivers/acpi/acpica/tbfind.c                   | 18 +++++++++---------
 drivers/acpi/acpica/tbprint.c                  |  4 ++--
 drivers/acpi/acpica/utascii.c                  |  2 +-
 drivers/acpi/acpica/utdecode.c                 |  2 +-
 drivers/acpi/acpica/utstring.c                 |  2 +-
 drivers/acpi/sysfs.c                           |  6 +++---
 include/acpi/actbl.h                           |  4 ++--
 include/acpi/actypes.h                         |  8 ++++----
 .../os_specific/service_layers/oslinuxtbl.c    | 14 +++++++-------
 tools/power/acpi/tools/acpidump/apdump.c       |  4 ++--
 tools/power/acpi/tools/acpidump/apfiles.c      |  4 ++--
 21 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index a2dfbf6b004e..13d513b81589 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
  * expected_return_btypes - Allowed type(s) for the return value
  */
 struct acpi_name_info {
-	char name[ACPI_NAME_SIZE];
+	char name[ACPI_NAMESEG_SIZE];
 	u16 argument_list;
 	u8 expected_btypes;
 };
@@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
 					      converted_object);
 
 struct acpi_simple_repair_info {
-	char name[ACPI_NAME_SIZE];
+	char name[ACPI_NAMESEG_SIZE];
 	u32 unexpected_btypes;
 	u32 package_index;
 	acpi_object_converter object_converter;
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 004d34d9369b..63fe30e86807 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -354,7 +354,7 @@ acpi_status acpi_db_find_name_in_namespace(char *name_arg)
 	char acpi_name[5] = "____";
 	char *acpi_name_ptr = acpi_name;
 
-	if (strlen(name_arg) > ACPI_NAME_SIZE) {
+	if (strlen(name_arg) > ACPI_NAMESEG_SIZE) {
 		acpi_os_printf("Name must be no longer than 4 characters\n");
 		return (AE_OK);
 	}
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index c92d2f6ebe01..b04f982e59fa 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -292,7 +292,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 	acpi_status status;
 	u32 gpe_number;
 	u8 temp_gpe_number;
-	char name[ACPI_NAME_SIZE + 1];
+	char name[ACPI_NAMESEG_SIZE + 1];
 	u8 type;
 
 	ACPI_FUNCTION_TRACE(ev_match_gpe_method);
@@ -310,7 +310,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 	 * 1) Extract the method name and null terminate it
 	 */
 	ACPI_MOVE_32_TO_32(name, &method_node->name.integer);
-	name[ACPI_NAME_SIZE] = 0;
+	name[ACPI_NAMESEG_SIZE] = 0;
 
 	/* 2) Name must begin with an underscore */
 
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index bd68d66e89f0..6b76be5212a4 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -53,10 +53,10 @@ static char *acpi_ex_allocate_name_string(u32 prefix_count, u32 num_name_segs)
 
 		/* Special case for root */
 
-		size_needed = 1 + (ACPI_NAME_SIZE * num_name_segs) + 2 + 1;
+		size_needed = 1 + (ACPI_NAMESEG_SIZE * num_name_segs) + 2 + 1;
 	} else {
 		size_needed =
-		    prefix_count + (ACPI_NAME_SIZE * num_name_segs) + 2 + 1;
+		    prefix_count + (ACPI_NAMESEG_SIZE * num_name_segs) + 2 + 1;
 	}
 
 	/*
@@ -141,7 +141,7 @@ static acpi_status acpi_ex_name_segment(u8 ** in_aml_address, char *name_string)
 	}
 
 	for (index = 0;
-	     (index < ACPI_NAME_SIZE)
+	     (index < ACPI_NAMESEG_SIZE)
 	     && (acpi_ut_valid_name_char(*aml_address, 0)); index++) {
 		char_buf[index] = *aml_address++;
 	}
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 75192b958544..7b855603f81a 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -683,7 +683,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 
 		/* Point to next name segment and make this node current */
 
-		path += ACPI_NAME_SIZE;
+		path += ACPI_NAMESEG_SIZE;
 		current_node = this_node;
 	}
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 15070bd0c28a..1b12c172e115 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -70,7 +70,7 @@ void acpi_ns_print_pathname(u32 num_segments, const char *pathname)
 			    acpi_os_printf("?");
 		}
 
-		pathname += ACPI_NAME_SIZE;
+		pathname += ACPI_NAMESEG_SIZE;
 		num_segments--;
 		if (num_segments) {
 			acpi_os_printf(".");
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index c384320a0f26..370bbc867745 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -109,7 +109,7 @@ acpi_ns_handle_to_name(acpi_handle target_handle, struct acpi_buffer *buffer)
 
 	node_name = acpi_ut_get_node_name(node);
 	ACPI_COPY_NAMESEG(buffer->pointer, node_name);
-	((char *)buffer->pointer)[ACPI_NAME_SIZE] = 0;
+	((char *)buffer->pointer)[ACPI_NAMESEG_SIZE] = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%4.4s\n", (char *)buffer->pointer));
 	return_ACPI_STATUS(AE_OK);
@@ -198,7 +198,7 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 			      char *full_path, u32 path_size, u8 no_trailing)
 {
 	u32 length = 0, i;
-	char name[ACPI_NAME_SIZE];
+	char name[ACPI_NAMESEG_SIZE];
 	u8 do_no_trailing;
 	char c, *left, *right;
 	struct acpi_namespace_node *next_node;
@@ -446,7 +446,7 @@ static void acpi_ns_normalize_pathname(char *original_path)
 
 		/* Do one nameseg at a time */
 
-		for (i = 0; (i < ACPI_NAME_SIZE) && *input_path; i++) {
+		for (i = 0; (i < ACPI_NAMESEG_SIZE) && *input_path; i++) {
 			if ((i == 0) || (*input_path != '_')) {	/* First char is allowed to be underscore */
 				*new_path = *input_path;
 				new_path++;
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 4c285e918465..8d776256b213 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
 				     return_object_ptr);
 
 typedef struct acpi_repair_info {
-	char name[ACPI_NAME_SIZE];
+	char name[ACPI_NAMESEG_SIZE];
 	acpi_repair_function repair_function;
 
 } acpi_repair_info;
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 6f5940b02a4f..6bc90d46db5c 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -178,7 +178,7 @@ void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 		}
 	}
 
-	info->length = (ACPI_NAME_SIZE * info->num_segments) +
+	info->length = (ACPI_NAMESEG_SIZE * info->num_segments) +
 	    4 + info->num_carats;
 
 	info->next_external_char = next_external_char;
@@ -249,7 +249,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 	/* Build the name (minus path separators) */
 
 	for (; num_segments; num_segments--) {
-		for (i = 0; i < ACPI_NAME_SIZE; i++) {
+		for (i = 0; i < ACPI_NAMESEG_SIZE; i++) {
 			if (ACPI_IS_PATH_SEPARATOR(*external_name) ||
 			    (*external_name == 0)) {
 
@@ -274,7 +274,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 		/* Move on the next segment */
 
 		external_name++;
-		result += ACPI_NAME_SIZE;
+		result += ACPI_NAMESEG_SIZE;
 	}
 
 	/* Terminate the string */
@@ -493,8 +493,8 @@ acpi_ns_externalize_name(u32 internal_name_length,
 					  &internal_name[names_index]);
 			acpi_ut_repair_name(&(*converted_name)[j]);
 
-			j += ACPI_NAME_SIZE;
-			names_index += ACPI_NAME_SIZE;
+			j += ACPI_NAMESEG_SIZE;
+			names_index += ACPI_NAMESEG_SIZE;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 9d9d442cd999..e62c7897fdf1 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -150,21 +150,21 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 
 		/* Two name segments */
 
-		end += 1 + (2 * ACPI_NAME_SIZE);
+		end += 1 + (2 * ACPI_NAMESEG_SIZE);
 		break;
 
 	case AML_MULTI_NAME_PREFIX:
 
 		/* Multiple name segments, 4 chars each, count in next byte */
 
-		end += 2 + (*(end + 1) * ACPI_NAME_SIZE);
+		end += 2 + (*(end + 1) * ACPI_NAMESEG_SIZE);
 		break;
 
 	default:
 
 		/* Single name segment */
 
-		end += ACPI_NAME_SIZE;
+		end += ACPI_NAMESEG_SIZE;
 		break;
 	}
 
@@ -522,7 +522,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 		ACPI_MOVE_32_TO_32(&name, parser_state->aml);
 		acpi_ps_set_name(field, name);
-		parser_state->aml += ACPI_NAME_SIZE;
+		parser_state->aml += ACPI_NAMESEG_SIZE;
 
 		ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index ddc88aaca376..b2abb40023a6 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -65,7 +65,7 @@ acpi_tb_find_table(char *signature,
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		if (memcmp(&(acpi_gbl_root_table_list.tables[i].signature),
-			   header.signature, ACPI_NAME_SIZE)) {
+			   header.signature, ACPI_NAMESEG_SIZE)) {
 
 			/* Not the requested table */
 
@@ -94,14 +94,14 @@ acpi_tb_find_table(char *signature,
 
 		if (!memcmp
 		    (acpi_gbl_root_table_list.tables[i].pointer->signature,
-		     header.signature, ACPI_NAME_SIZE) && (!oem_id[0]
-							   ||
-							   !memcmp
-							   (acpi_gbl_root_table_list.
-							    tables[i].pointer->
-							    oem_id,
-							    header.oem_id,
-							    ACPI_OEM_ID_SIZE))
+		     header.signature, ACPI_NAMESEG_SIZE) && (!oem_id[0]
+							      ||
+							      !memcmp
+							      (acpi_gbl_root_table_list.
+							       tables[i].
+							       pointer->oem_id,
+							       header.oem_id,
+							       ACPI_OEM_ID_SIZE))
 		    && (!oem_table_id[0]
 			|| !memcmp(acpi_gbl_root_table_list.tables[i].pointer->
 				   oem_table_id, header.oem_table_id,
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 0bc18fd5cd71..4764f849cb78 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -69,10 +69,10 @@ acpi_tb_cleanup_table_header(struct acpi_table_header *out_header,
 
 	memcpy(out_header, header, sizeof(struct acpi_table_header));
 
-	acpi_tb_fix_string(out_header->signature, ACPI_NAME_SIZE);
+	acpi_tb_fix_string(out_header->signature, ACPI_NAMESEG_SIZE);
 	acpi_tb_fix_string(out_header->oem_id, ACPI_OEM_ID_SIZE);
 	acpi_tb_fix_string(out_header->oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
-	acpi_tb_fix_string(out_header->asl_compiler_id, ACPI_NAME_SIZE);
+	acpi_tb_fix_string(out_header->asl_compiler_id, ACPI_NAMESEG_SIZE);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utascii.c b/drivers/acpi/acpica/utascii.c
index 79d7426fd7bf..f6cd7d4f698b 100644
--- a/drivers/acpi/acpica/utascii.c
+++ b/drivers/acpi/acpica/utascii.c
@@ -30,7 +30,7 @@ u8 acpi_ut_valid_nameseg(char *name)
 
 	/* Validate each character in the signature */
 
-	for (i = 0; i < ACPI_NAME_SIZE; i++) {
+	for (i = 0; i < ACPI_NAMESEG_SIZE; i++) {
 		if (!acpi_ut_valid_name_char(name[i], i)) {
 			return (FALSE);
 		}
diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index ad9f77eb554f..76e054c83c39 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -239,7 +239,7 @@ const char *acpi_ut_get_node_name(void *object)
 {
 	struct acpi_namespace_node *node = (struct acpi_namespace_node *)object;
 
-	/* Must return a string of exactly 4 characters == ACPI_NAME_SIZE */
+	/* Must return a string of exactly 4 characters == ACPI_NAMESEG_SIZE */
 
 	if (!object) {
 		return ("NULL");
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 927797355da9..c39b5483045d 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -149,7 +149,7 @@ void acpi_ut_repair_name(char *name)
 
 	/* Check each character in the name */
 
-	for (i = 0; i < ACPI_NAME_SIZE; i++) {
+	for (i = 0; i < ACPI_NAMESEG_SIZE; i++) {
 		if (acpi_ut_valid_name_char(name[i], i)) {
 			continue;
 		}
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 262d6ee4735d..75948a3f1a20 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -327,9 +327,9 @@ static struct kobject *hotplug_kobj;
 
 struct acpi_table_attr {
 	struct bin_attribute attr;
-	char name[ACPI_NAME_SIZE];
+	char name[ACPI_NAMESEG_SIZE];
 	int instance;
-	char filename[ACPI_NAME_SIZE+ACPI_INST_SIZE];
+	char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
 	struct list_head node;
 };
 
@@ -383,7 +383,7 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 	}
 
 	ACPI_COPY_NAMESEG(table_attr->filename, table_header->signature);
-	table_attr->filename[ACPI_NAME_SIZE] = '\0';
+	table_attr->filename[ACPI_NAMESEG_SIZE] = '\0';
 	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
 					 !acpi_get_table
 					 (table_header->signature, 2, &header))) {
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 65cc9cbf1141..d568128025df 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -66,14 +66,14 @@
  ******************************************************************************/
 
 struct acpi_table_header {
-	char signature[ACPI_NAME_SIZE];	/* ASCII table signature */
+	char signature[ACPI_NAMESEG_SIZE];	/* ASCII table signature */
 	u32 length;		/* Length of table in bytes, including this header */
 	u8 revision;		/* ACPI Specification minor version number */
 	u8 checksum;		/* To make sum of entire table == 0 */
 	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
 	u32 oem_revision;	/* OEM revision number */
-	char asl_compiler_id[ACPI_NAME_SIZE];	/* ASCII ASL compiler vendor ID */
+	char asl_compiler_id[ACPI_NAMESEG_SIZE];	/* ASCII ASL compiler vendor ID */
 	u32 asl_compiler_revision;	/* ASL compiler version */
 };
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index cb51172a47a3..ad6892a24015 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -375,7 +375,7 @@ typedef u64 acpi_physical_address;
 
 /* Names within the namespace are 4 bytes long */
 
-#define ACPI_NAME_SIZE                  4
+#define ACPI_NAMESEG_SIZE               4	/* Fixed by ACPI spec */
 #define ACPI_PATH_SEGMENT_LENGTH        5	/* 4 chars for name + 1 char for separator */
 #define ACPI_PATH_SEPARATOR             '.'
 
@@ -518,8 +518,8 @@ typedef u64 acpi_integer;
 #define ACPI_COMPARE_NAMESEG(a,b)       (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
 #define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
 #else
-#define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAME_SIZE))
-#define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAME_SIZE))
+#define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAMESEG_SIZE))
+#define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
 #endif
 
 /* Support for the special RSDP signature (8 characters) */
@@ -529,7 +529,7 @@ typedef u64 acpi_integer;
 
 /* Support for OEMx signature (x can be any character) */
 #define ACPI_IS_OEM_SIG(a)        (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_OEM_NAME, 3) &&\
-	 strnlen (a, ACPI_NAME_SIZE) == ACPI_NAME_SIZE)
+	 strnlen (a, ACPI_NAMESEG_SIZE) == ACPI_NAMESEG_SIZE)
 
 /*
  * Algorithm to obtain access bit width.
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 2686d858225a..d1f3d44e315e 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -19,7 +19,7 @@ ACPI_MODULE_NAME("oslinuxtbl")
 typedef struct osl_table_info {
 	struct osl_table_info *next;
 	u32 instance;
-	char signature[ACPI_NAME_SIZE];
+	char signature[ACPI_NAMESEG_SIZE];
 
 } osl_table_info;
 
@@ -995,7 +995,7 @@ static acpi_status osl_list_customized_tables(char *directory)
 {
 	void *table_dir;
 	u32 instance;
-	char temp_name[ACPI_NAME_SIZE];
+	char temp_name[ACPI_NAMESEG_SIZE];
 	char *filename;
 	acpi_status status = AE_OK;
 
@@ -1158,15 +1158,15 @@ osl_table_name_from_file(char *filename, char *signature, u32 *instance)
 
 	/* Ignore meaningless files */
 
-	if (strlen(filename) < ACPI_NAME_SIZE) {
+	if (strlen(filename) < ACPI_NAMESEG_SIZE) {
 		return (AE_BAD_SIGNATURE);
 	}
 
 	/* Extract instance number */
 
-	if (isdigit((int)filename[ACPI_NAME_SIZE])) {
-		sscanf(&filename[ACPI_NAME_SIZE], "%u", instance);
-	} else if (strlen(filename) != ACPI_NAME_SIZE) {
+	if (isdigit((int)filename[ACPI_NAMESEG_SIZE])) {
+		sscanf(&filename[ACPI_NAMESEG_SIZE], "%u", instance);
+	} else if (strlen(filename) != ACPI_NAMESEG_SIZE) {
 		return (AE_BAD_SIGNATURE);
 	} else {
 		*instance = 0;
@@ -1311,7 +1311,7 @@ osl_get_customized_table(char *pathname,
 {
 	void *table_dir;
 	u32 current_instance = 0;
-	char temp_name[ACPI_NAME_SIZE];
+	char temp_name[ACPI_NAMESEG_SIZE];
 	char table_filename[PATH_MAX];
 	char *filename;
 	acpi_status status;
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index 9dfcc0329d34..820baeb5092b 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -289,14 +289,14 @@ int ap_dump_table_by_address(char *ascii_address)
 
 int ap_dump_table_by_name(char *signature)
 {
-	char local_signature[ACPI_NAME_SIZE + 1];
+	char local_signature[ACPI_NAMESEG_SIZE + 1];
 	u32 instance;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
 	acpi_status status;
 	int table_status;
 
-	if (strlen(signature) != ACPI_NAME_SIZE) {
+	if (strlen(signature) != ACPI_NAMESEG_SIZE) {
 		fprintf(stderr,
 			"Invalid table signature [%s]: must be exactly 4 characters\n",
 			signature);
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 8abc8f998abd..a42cfcaa3293 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -97,7 +97,7 @@ int ap_open_output_file(char *pathname)
 
 int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 {
-	char filename[ACPI_NAME_SIZE + 16];
+	char filename[ACPI_NAMESEG_SIZE + 16];
 	char instance_str[16];
 	ACPI_FILE file;
 	acpi_size actual;
@@ -119,7 +119,7 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	filename[1] = (char)tolower((int)filename[1]);
 	filename[2] = (char)tolower((int)filename[2]);
 	filename[3] = (char)tolower((int)filename[3]);
-	filename[ACPI_NAME_SIZE] = 0;
+	filename[ACPI_NAMESEG_SIZE] = 0;
 
 	/* Handle multiple SSDts - create different filenames for each */
 
-- 
2.17.2

