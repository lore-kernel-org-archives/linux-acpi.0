Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B50FC10F14
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF30820880
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfDHUws (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:52:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:41642 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfDHUws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 16:52:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="141104040"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2019 13:52:46 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 2/8] ACPICA: Rename nameseg compare macro for clarity
Date:   Mon,  8 Apr 2019 13:42:24 -0700
Message-Id: <20190408204230.4335-3-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190408204230.4335-1-erik.schmauss@intel.com>
References: <20190408204230.4335-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 92ec0935f27e217dff0b176fca02c2ec3d782bb5

ACPI_COMPARE_NAME changed to ACPI_COMPARE_NAMESEG
This clarifies (1) this is a compare on 4-byte namesegs, not
a generic compare. Improves understanding of the code.

Link: https://github.com/acpica/acpica/commit/92ec0935
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 arch/x86/boot/compressed/acpi.c               |  2 +-
 drivers/acpi/acpica/dbexec.c                  |  2 +-
 drivers/acpi/acpica/dsinit.c                  |  2 +-
 drivers/acpi/acpica/nsinit.c                  |  4 +--
 drivers/acpi/acpica/nsparse.c                 |  2 +-
 drivers/acpi/acpica/nsrepair.c                |  2 +-
 drivers/acpi/acpica/nsrepair2.c               |  2 +-
 drivers/acpi/acpica/nsxfname.c                |  4 +--
 drivers/acpi/acpica/rsxface.c                 |  8 ++---
 drivers/acpi/acpica/tbdata.c                  |  3 +-
 drivers/acpi/acpica/tbinstal.c                |  2 +-
 drivers/acpi/acpica/tbprint.c                 |  6 ++--
 drivers/acpi/acpica/tbutils.c                 |  6 ++--
 drivers/acpi/acpica/tbxface.c                 |  4 +--
 drivers/acpi/acpica/tbxfload.c                | 15 +++++-----
 drivers/acpi/acpica/utmisc.c                  |  8 ++---
 drivers/acpi/acpica/utpredef.c                |  4 +--
 drivers/acpi/acpica/utstring.c                |  2 +-
 drivers/acpi/scan.c                           |  2 +-
 drivers/acpi/sysfs.c                          |  8 ++---
 drivers/acpi/tables.c                         |  4 +--
 include/acpi/actypes.h                        |  4 +--
 .../os_specific/service_layers/oslinuxtbl.c   | 30 +++++++++----------
 tools/power/acpi/tools/acpidump/apdump.c      |  4 +--
 24 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 0ef4ad55b29b..ad84239e595e 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -276,7 +276,7 @@ static unsigned long get_acpi_srat_table(void)
 		if (acpi_table) {
 			header = (struct acpi_table_header *)acpi_table;
 
-			if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_SRAT))
+			if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_SRAT))
 				return acpi_table;
 		}
 		entry += size;
diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index bb43305cb215..4027eaab18a4 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -453,7 +453,7 @@ acpi_db_execute(char *name, char **args, acpi_object_type *types, u32 flags)
 
 			/* Dump a _PLD buffer if present */
 
-			if (ACPI_COMPARE_NAME
+			if (ACPI_COMPARE_NAMESEG
 			    ((ACPI_CAST_PTR
 			      (struct acpi_namespace_node,
 			       acpi_gbl_db_method_info.method)->name.ascii),
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index a4a24ffe5fae..4ebd23700bbc 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -200,7 +200,7 @@ acpi_ds_initialize_objects(u32 table_index,
 
 	/* DSDT is always the first AML table */
 
-	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT)) {
+	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_DSDT)) {
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
 				      "\nInitializing Namespace objects:\n"));
 	}
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 19fb8dda870f..53e5d00d3a5e 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -478,7 +478,7 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 
 	/* We are only looking for methods named _INI */
 
-	if (!ACPI_COMPARE_NAME(node->name.ascii, METHOD_NAME__INI)) {
+	if (!ACPI_COMPARE_NAMESEG(node->name.ascii, METHOD_NAME__INI)) {
 		return (AE_OK);
 	}
 
@@ -641,7 +641,7 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 	 * Note: We know there is an _INI within this subtree, but it may not be
 	 * under this particular device, it may be lower in the branch.
 	 */
-	if (!ACPI_COMPARE_NAME(device_node->name.ascii, "_SB_") ||
+	if (!ACPI_COMPARE_NAMESEG(device_node->name.ascii, "_SB_") ||
 	    device_node->parent != acpi_gbl_root_node) {
 		ACPI_DEBUG_EXEC(acpi_ut_display_init_pathname
 				(ACPI_TYPE_METHOD, device_node,
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index c0b4f7bedfab..f16cf5e4742c 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -203,7 +203,7 @@ acpi_ns_one_complete_parse(u32 pass_number,
 
 	/* Found OSDT table, enable the namespace override feature */
 
-	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT) &&
+	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_OSDT) &&
 	    pass_number == ACPI_IMODE_LOAD_PASS1) {
 		walk_state->namespace_override = TRUE;
 	}
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index 0aacfa48e20d..be86fea8e4d4 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -316,7 +316,7 @@ static const struct acpi_simple_repair_info *acpi_ns_match_simple_repair(struct
 
 	this_name = acpi_object_repair_info;
 	while (this_name->object_converter) {
-		if (ACPI_COMPARE_NAME(node->name.ascii, this_name->name)) {
+		if (ACPI_COMPARE_NAMESEG(node->name.ascii, this_name->name)) {
 
 			/* Check if we can actually repair this name/type combination */
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index d5804a6d1d65..4c285e918465 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -188,7 +188,7 @@ static const struct acpi_repair_info *acpi_ns_match_complex_repair(struct
 
 	this_name = acpi_ns_repairable_names;
 	while (this_name->repair_function) {
-		if (ACPI_COMPARE_NAME(node->name.ascii, this_name->name)) {
+		if (ACPI_COMPARE_NAMESEG(node->name.ascii, this_name->name)) {
 			return (this_name);
 		}
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index de2d3135d6a9..55b4a5b3331f 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -495,8 +495,8 @@ acpi_status acpi_install_method(u8 *buffer)
 
 	/* Table must be a DSDT or SSDT */
 
-	if (!ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) &&
-	    !ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT)) {
+	if (!ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_DSDT) &&
+	    !ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_SSDT)) {
 		return (AE_BAD_HEADER);
 	}
 
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 1d6f136e4068..c62be3d91712 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -603,10 +603,10 @@ acpi_walk_resources(acpi_handle device_handle,
 	/* Parameter validation */
 
 	if (!device_handle || !user_function || !name ||
-	    (!ACPI_COMPARE_NAME(name, METHOD_NAME__CRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__DMA))) {
+	    (!ACPI_COMPARE_NAMESEG(name, METHOD_NAME__CRS) &&
+	     !ACPI_COMPARE_NAMESEG(name, METHOD_NAME__PRS) &&
+	     !ACPI_COMPARE_NAMESEG(name, METHOD_NAME__AEI) &&
+	     !ACPI_COMPARE_NAMESEG(name, METHOD_NAME__DMA))) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 0cecd0039acf..933f81316ad2 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -480,7 +480,8 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *table_desc,
 
 	/* If a particular signature is expected (DSDT/FACS), it must match */
 
-	if (signature && !ACPI_COMPARE_NAME(&table_desc->signature, signature)) {
+	if (signature &&
+	    !ACPI_COMPARE_NAMESEG(&table_desc->signature, signature)) {
 		ACPI_BIOS_ERROR((AE_INFO,
 				 "Invalid signature 0x%X for ACPI table, expected [%s]",
 				 table_desc->signature.integer, signature));
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index be6642bf6366..ef1ffd36ab3f 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -120,7 +120,7 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 	 */
 	if (!reload &&
 	    acpi_gbl_disable_ssdt_table_install &&
-	    ACPI_COMPARE_NAME(&new_table_desc.signature, ACPI_SIG_SSDT)) {
+	    ACPI_COMPARE_NAMESEG(&new_table_desc.signature, ACPI_SIG_SSDT)) {
 		ACPI_INFO(("Ignoring installation of %4.4s at %8.8X%8.8X",
 			   new_table_desc.signature.ascii,
 			   ACPI_FORMAT_UINT64(address)));
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 9b5df95d881b..0bc18fd5cd71 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -94,7 +94,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 {
 	struct acpi_table_header local_header;
 
-	if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_FACS)) {
+	if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
 
 		/* FACS only has signature and length fields */
 
@@ -158,8 +158,8 @@ acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
 	 * They are the odd tables, have no standard ACPI header and no checksum
 	 */
 
-	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_S3PT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_FACS)) {
+	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_S3PT) ||
+	    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_FACS)) {
 		return (AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 2469e01310e2..c5f0b8ec70cc 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -332,9 +332,9 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address)
 							&table_index);
 
 		if (ACPI_SUCCESS(status) &&
-		    ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.
-				      tables[table_index].signature,
-				      ACPI_SIG_FADT)) {
+		    ACPI_COMPARE_NAMESEG(&acpi_gbl_root_table_list.
+					 tables[table_index].signature,
+					 ACPI_SIG_FADT)) {
 			acpi_gbl_fadt_index = table_index;
 			acpi_tb_parse_fadt();
 		}
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 36592888f0e7..1640685bf4ae 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -230,7 +230,7 @@ acpi_get_table_header(char *signature,
 
 	for (i = 0, j = 0; i < acpi_gbl_root_table_list.current_table_count;
 	     i++) {
-		if (!ACPI_COMPARE_NAME
+		if (!ACPI_COMPARE_NAMESEG
 		    (&(acpi_gbl_root_table_list.tables[i].signature),
 		     signature)) {
 			continue;
@@ -323,7 +323,7 @@ acpi_get_table(char *signature,
 	     i++) {
 		table_desc = &acpi_gbl_root_table_list.tables[i];
 
-		if (!ACPI_COMPARE_NAME(&table_desc->signature, signature)) {
+		if (!ACPI_COMPARE_NAMESEG(&table_desc->signature, signature)) {
 			continue;
 		}
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 1a2592cc3245..4f30f06a6f78 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -118,7 +118,7 @@ acpi_status acpi_tb_load_namespace(void)
 	table = &acpi_gbl_root_table_list.tables[acpi_gbl_dsdt_index];
 
 	if (!acpi_gbl_root_table_list.current_table_count ||
-	    !ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_DSDT) ||
+	    !ACPI_COMPARE_NAMESEG(table->signature.ascii, ACPI_SIG_DSDT) ||
 	    ACPI_FAILURE(acpi_tb_validate_table(table))) {
 		status = AE_NO_ACPI_TABLES;
 		goto unlock_and_exit;
@@ -170,11 +170,12 @@ acpi_status acpi_tb_load_namespace(void)
 		table = &acpi_gbl_root_table_list.tables[i];
 
 		if (!table->address ||
-		    (!ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_SSDT)
-		     && !ACPI_COMPARE_NAME(table->signature.ascii,
-					   ACPI_SIG_PSDT)
-		     && !ACPI_COMPARE_NAME(table->signature.ascii,
-					   ACPI_SIG_OSDT))
+		    (!ACPI_COMPARE_NAMESEG
+		     (table->signature.ascii, ACPI_SIG_SSDT)
+		     && !ACPI_COMPARE_NAMESEG(table->signature.ascii,
+					      ACPI_SIG_PSDT)
+		     && !ACPI_COMPARE_NAMESEG(table->signature.ascii,
+					      ACPI_SIG_OSDT))
 		    || ACPI_FAILURE(acpi_tb_validate_table(table))) {
 			continue;
 		}
@@ -364,7 +365,7 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 		 * only these types can contain AML and thus are the only types
 		 * that can create namespace objects.
 		 */
-		if (ACPI_COMPARE_NAME
+		if (ACPI_COMPARE_NAMESEG
 		    (acpi_gbl_root_table_list.tables[i].signature.ascii,
 		     ACPI_SIG_DSDT)) {
 			status = AE_TYPE;
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index afaadc73196b..8638efacdbf4 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -59,10 +59,10 @@ u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
 
 	/* These are the only tables that contain executable AML */
 
-	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_PSDT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT) ||
+	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_DSDT) ||
+	    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_PSDT) ||
+	    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_SSDT) ||
+	    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_OSDT) ||
 	    ACPI_IS_OEM_SIG(table->signature)) {
 		return (TRUE);
 	}
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
index a9f08f43c685..1b0f68f5ed8c 100644
--- a/drivers/acpi/acpica/utpredef.c
+++ b/drivers/acpi/acpica/utpredef.c
@@ -84,7 +84,7 @@ const union acpi_predefined_info *acpi_ut_match_predefined_method(char *name)
 
 	this_name = acpi_gbl_predefined_methods;
 	while (this_name->info.name[0]) {
-		if (ACPI_COMPARE_NAME(name, this_name->info.name)) {
+		if (ACPI_COMPARE_NAMESEG(name, this_name->info.name)) {
 			return (this_name);
 		}
 
@@ -201,7 +201,7 @@ const union acpi_predefined_info *acpi_ut_match_resource_name(char *name)
 
 	this_name = acpi_gbl_resource_names;
 	while (this_name->info.name[0]) {
-		if (ACPI_COMPARE_NAME(name, this_name->info.name)) {
+		if (ACPI_COMPARE_NAMESEG(name, this_name->info.name)) {
 			return (this_name);
 		}
 
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 89dc79798d38..927797355da9 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -141,7 +141,7 @@ void acpi_ut_repair_name(char *name)
 	 * Special case for the root node. This can happen if we get an
 	 * error during the execution of module-level code.
 	 */
-	if (ACPI_COMPARE_NAME(name, ACPI_ROOT_PATHNAME)) {
+	if (ACPI_COMPARE_NAMESEG(name, ACPI_ROOT_PATHNAME)) {
 		return;
 	}
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 814a02568d68..b845dc3e0ba9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2257,7 +2257,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 
 	mutex_lock(&acpi_probe_mutex);
 	for (ape = ap_head; nr; ape++, nr--) {
-		if (ACPI_COMPARE_NAME(ACPI_SIG_MADT, ape->id)) {
+		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
 			acpi_table_parse_madt(ape->type, acpi_match_madt, 0);
 			count += acpi_probe_count;
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index fa76f5e41b5c..262d6ee4735d 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -368,10 +368,10 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 	char instance_str[ACPI_INST_SIZE];
 
 	sysfs_attr_init(&table_attr->attr.attr);
-	ACPI_MOVE_NAME(table_attr->name, table_header->signature);
+	ACPI_COPY_NAMESEG(table_attr->name, table_header->signature);
 
 	list_for_each_entry(attr, &acpi_table_attr_list, node) {
-		if (ACPI_COMPARE_NAME(table_attr->name, attr->name))
+		if (ACPI_COMPARE_NAMESEG(table_attr->name, attr->name))
 			if (table_attr->instance < attr->instance)
 				table_attr->instance = attr->instance;
 	}
@@ -382,7 +382,7 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 		return -ERANGE;
 	}
 
-	ACPI_MOVE_NAME(table_attr->filename, table_header->signature);
+	ACPI_COPY_NAMESEG(table_attr->filename, table_header->signature);
 	table_attr->filename[ACPI_NAME_SIZE] = '\0';
 	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
 					 !acpi_get_table
@@ -484,7 +484,7 @@ static int acpi_table_data_init(struct acpi_table_header *th)
 	int i;
 
 	for (i = 0; i < NUM_ACPI_DATA_OBJS; i++) {
-		if (ACPI_COMPARE_NAME(th->signature, acpi_data_objs[i].name)) {
+		if (ACPI_COMPARE_NAMESEG(th->signature, acpi_data_objs[i].name)) {
 			data_attr = kzalloc(sizeof(*data_attr), GFP_KERNEL);
 			if (!data_attr)
 				return -ENOMEM;
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 4672f9ef183a..d7bf936b1646 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -666,8 +666,8 @@ static void __init acpi_table_initrd_scan(void)
 		table_length = table->length;
 
 		/* Skip RSDT/XSDT which should only be used for override */
-		if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_RSDT) ||
-		    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_XSDT)) {
+		if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_RSDT) ||
+		    ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_XSDT)) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			goto next_table;
 		}
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index bfe54189f242..cb51172a47a3 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -515,10 +515,10 @@ typedef u64 acpi_integer;
 /* Optimizations for 4-character (32-bit) acpi_name manipulation */
 
 #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
-#define ACPI_COMPARE_NAME(a,b)          (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
+#define ACPI_COMPARE_NAMESEG(a,b)       (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
 #define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
 #else
-#define ACPI_COMPARE_NAME(a,b)          (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAME_SIZE))
+#define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAME_SIZE))
 #define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAME_SIZE))
 #endif
 
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 587b701a7edb..2686d858225a 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -293,7 +293,7 @@ static acpi_status osl_add_table_to_list(char *signature, u32 instance)
 	} else {
 		next = gbl_table_list_head;
 		while (1) {
-			if (ACPI_COMPARE_NAME(next->signature, signature)) {
+			if (ACPI_COMPARE_NAMESEG(next->signature, signature)) {
 				if (next->instance == instance) {
 					found = TRUE;
 				}
@@ -782,11 +782,11 @@ osl_get_bios_table(char *signature,
 
 	/* Handle special tables whose addresses are not in RSDT/XSDT */
 
-	if (ACPI_COMPARE_NAME(signature, ACPI_RSDP_NAME) ||
-	    ACPI_COMPARE_NAME(signature, ACPI_SIG_RSDT) ||
-	    ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT) ||
-	    ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT) ||
-	    ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
+	if (ACPI_COMPARE_NAMESEG(signature, ACPI_RSDP_NAME) ||
+	    ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_RSDT) ||
+	    ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_XSDT) ||
+	    ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_DSDT) ||
+	    ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_FACS)) {
 
 find_next_instance:
 
@@ -797,7 +797,7 @@ osl_get_bios_table(char *signature,
 		 * careful about the FADT length and validate table addresses.
 		 * Note: The 64-bit addresses have priority.
 		 */
-		if (ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT)) {
+		if (ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_DSDT)) {
 			if (current_instance < 2) {
 				if ((gbl_fadt->header.length >=
 				     MIN_FADT_FOR_XDSDT) && gbl_fadt->Xdsdt
@@ -815,7 +815,7 @@ osl_get_bios_table(char *signature,
 					    dsdt;
 				}
 			}
-		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_FACS)) {
+		} else if (ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_FACS)) {
 			if (current_instance < 2) {
 				if ((gbl_fadt->header.length >=
 				     MIN_FADT_FOR_XFACS) && gbl_fadt->Xfacs
@@ -833,7 +833,7 @@ osl_get_bios_table(char *signature,
 					    facs;
 				}
 			}
-		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_XSDT)) {
+		} else if (ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_XSDT)) {
 			if (!gbl_revision) {
 				return (AE_BAD_SIGNATURE);
 			}
@@ -842,7 +842,7 @@ osl_get_bios_table(char *signature,
 				    (acpi_physical_address)gbl_rsdp.
 				    xsdt_physical_address;
 			}
-		} else if (ACPI_COMPARE_NAME(signature, ACPI_SIG_RSDT)) {
+		} else if (ACPI_COMPARE_NAMESEG(signature, ACPI_SIG_RSDT)) {
 			if (current_instance == 0) {
 				table_address =
 				    (acpi_physical_address)gbl_rsdp.
@@ -931,7 +931,7 @@ osl_get_bios_table(char *signature,
 
 			/* Does this table match the requested signature? */
 
-			if (!ACPI_COMPARE_NAME
+			if (!ACPI_COMPARE_NAMESEG
 			    (mapped_table->signature, signature)) {
 				osl_unmap_table(mapped_table);
 				mapped_table = NULL;
@@ -1086,8 +1086,8 @@ osl_map_table(acpi_size address,
 				return (AE_BAD_SIGNATURE);
 			}
 		} else
-		    if (!ACPI_COMPARE_NAME(signature, mapped_table->signature))
-		{
+		    if (!ACPI_COMPARE_NAMESEG
+			(signature, mapped_table->signature)) {
 			acpi_os_unmap_memory(mapped_table,
 					     sizeof(struct acpi_table_header));
 			return (AE_BAD_SIGNATURE);
@@ -1236,7 +1236,7 @@ osl_read_table_from_file(char *filename,
 				status = AE_BAD_SIGNATURE;
 				goto exit;
 			}
-		} else if (!ACPI_COMPARE_NAME(signature, header.signature)) {
+		} else if (!ACPI_COMPARE_NAMESEG(signature, header.signature)) {
 			fprintf(stderr,
 				"Incorrect signature: Expecting %4.4s, found %4.4s\n",
 				signature, header.signature);
@@ -1329,7 +1329,7 @@ osl_get_customized_table(char *pathname,
 
 		/* Ignore meaningless files */
 
-		if (!ACPI_COMPARE_NAME(filename, signature)) {
+		if (!ACPI_COMPARE_NAMESEG(filename, signature)) {
 			continue;
 		}
 
diff --git a/tools/power/acpi/tools/acpidump/apdump.c b/tools/power/acpi/tools/acpidump/apdump.c
index e256c2ac5ddc..9dfcc0329d34 100644
--- a/tools/power/acpi/tools/acpidump/apdump.c
+++ b/tools/power/acpi/tools/acpidump/apdump.c
@@ -310,9 +310,9 @@ int ap_dump_table_by_name(char *signature)
 
 	/* To be friendly, handle tables whose signatures do not match the name */
 
-	if (ACPI_COMPARE_NAME(local_signature, "FADT")) {
+	if (ACPI_COMPARE_NAMESEG(local_signature, "FADT")) {
 		strcpy(local_signature, ACPI_SIG_FADT);
-	} else if (ACPI_COMPARE_NAME(local_signature, "MADT")) {
+	} else if (ACPI_COMPARE_NAMESEG(local_signature, "MADT")) {
 		strcpy(local_signature, ACPI_SIG_MADT);
 	}
 
-- 
2.17.2

