Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F71C10F13
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E071720857
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfDHUrU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:47:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:33548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbfDHUrS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 16:47:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="314181126"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2019 13:47:15 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 1/8] ACPICA: Rename nameseg copy macro for clarity
Date:   Mon,  8 Apr 2019 13:36:52 -0700
Message-Id: <20190408203659.4207-2-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190408203659.4207-1-erik.schmauss@intel.com>
References: <20190408203659.4207-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 19c18d3157945d1b8b64a826f0a8e848b7dbb127

ACPI_MOVE_NAME changed to ACPI_COPY_NAMESEG
This clarifies (1) this is a copy operation, and
(2) it operates on ACPI name_segs.
Improves understanding of the code.

Link: https://github.com/acpica/acpica/commit/19c18d31
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/nsnames.c                            | 2 +-
 drivers/acpi/acpica/nsutils.c                            | 4 ++--
 drivers/acpi/acpica/tbfind.c                             | 2 +-
 drivers/acpi/acpica/utstring.c                           | 2 +-
 include/acpi/actypes.h                                   | 4 ++--
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 4 ++--
 tools/power/acpi/tools/acpidump/apfiles.c                | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 289c15bb8c6a..c384320a0f26 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -108,7 +108,7 @@ acpi_ns_handle_to_name(acpi_handle target_handle, struct acpi_buffer *buffer)
 	/* Just copy the ACPI name from the Node and zero terminate it */
 
 	node_name = acpi_ut_get_node_name(node);
-	ACPI_MOVE_NAME(buffer->pointer, node_name);
+	ACPI_COPY_NAMESEG(buffer->pointer, node_name);
 	((char *)buffer->pointer)[ACPI_NAME_SIZE] = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%4.4s\n", (char *)buffer->pointer));
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index e5cef1edf49f..6f5940b02a4f 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -489,8 +489,8 @@ acpi_ns_externalize_name(u32 internal_name_length,
 
 			/* Copy and validate the 4-char name segment */
 
-			ACPI_MOVE_NAME(&(*converted_name)[j],
-				       &internal_name[names_index]);
+			ACPI_COPY_NAMESEG(&(*converted_name)[j],
+					  &internal_name[names_index]);
 			acpi_ut_repair_name(&(*converted_name)[j]);
 
 			j += ACPI_NAME_SIZE;
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 951bd8e1c50a..ddc88aaca376 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -56,7 +56,7 @@ acpi_tb_find_table(char *signature,
 	/* Normalize the input strings */
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
-	ACPI_MOVE_NAME(header.signature, signature);
+	ACPI_COPY_NAMESEG(header.signature, signature);
 	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
 	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 5bef0b059406..89dc79798d38 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -145,7 +145,7 @@ void acpi_ut_repair_name(char *name)
 		return;
 	}
 
-	ACPI_MOVE_NAME(&original_name, name);
+	ACPI_COPY_NAMESEG(&original_name, name);
 
 	/* Check each character in the name */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f73382e82c26..bfe54189f242 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -516,10 +516,10 @@ typedef u64 acpi_integer;
 
 #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
 #define ACPI_COMPARE_NAME(a,b)          (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
-#define ACPI_MOVE_NAME(dest,src)        (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
+#define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
 #else
 #define ACPI_COMPARE_NAME(a,b)          (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAME_SIZE))
-#define ACPI_MOVE_NAME(dest,src)        (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAME_SIZE))
+#define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAME_SIZE))
 #endif
 
 /* Support for the special RSDP signature (8 characters) */
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 2a1fd9182f94..587b701a7edb 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -286,7 +286,7 @@ static acpi_status osl_add_table_to_list(char *signature, u32 instance)
 		return (AE_NO_MEMORY);
 	}
 
-	ACPI_MOVE_NAME(new_info->signature, signature);
+	ACPI_COPY_NAMESEG(new_info->signature, signature);
 
 	if (!gbl_table_list_head) {
 		gbl_table_list_head = new_info;
@@ -1174,7 +1174,7 @@ osl_table_name_from_file(char *filename, char *signature, u32 *instance)
 
 	/* Extract signature */
 
-	ACPI_MOVE_NAME(signature, filename);
+	ACPI_COPY_NAMESEG(signature, filename);
 	return (AE_OK);
 }
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 49972bc78bc5..8abc8f998abd 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -110,9 +110,9 @@ int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 	/* Construct lower-case filename from the table local signature */
 
 	if (ACPI_VALIDATE_RSDP_SIG(table->signature)) {
-		ACPI_MOVE_NAME(filename, ACPI_RSDP_NAME);
+		ACPI_COPY_NAMESEG(filename, ACPI_RSDP_NAME);
 	} else {
-		ACPI_MOVE_NAME(filename, table->signature);
+		ACPI_COPY_NAMESEG(filename, table->signature);
 	}
 
 	filename[0] = (char)tolower((int)filename[0]);
-- 
2.17.2

