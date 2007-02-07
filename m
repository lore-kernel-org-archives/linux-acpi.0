From: Len Brown <lenb@kernel.org>
Subject: [PATCH 94/140] ACPICA: Use manifest constants for parse pass number
Date: Wed,  7 Feb 2007 13:51:48 -0500
Message-ID: <11708745084156-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <ec3153fb0e96988dc7e378b3ab01e05131ba713b.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422819AbXBGSzN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:13 -0500
In-Reply-To: <11708745072908-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    3 ++-
 drivers/acpi/dispatcher/dsopcode.c |    4 ++--
 drivers/acpi/dispatcher/dswload.c  |    2 +-
 drivers/acpi/namespace/nsparse.c   |    6 +++---
 drivers/acpi/parser/psxface.c      |    2 +-
 include/acpi/aclocal.h             |    2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index aa60dca..57c5159 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -382,7 +382,8 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 
 	status = acpi_ds_init_aml_walk(next_walk_state, NULL, method_node,
 				       obj_desc->method.aml_start,
-				       obj_desc->method.aml_length, info, 3);
+				       obj_desc->method.aml_length, info,
+				       ACPI_IMODE_EXECUTE);
 
 	ACPI_FREE(info);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 5b974a8..26035a3 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -114,7 +114,7 @@ acpi_ds_execute_arguments(struct acpi_namespace_node *node,
 	}
 
 	status = acpi_ds_init_aml_walk(walk_state, op, NULL, aml_start,
-				       aml_length, NULL, 1);
+				       aml_length, NULL, ACPI_IMODE_LOAD_PASS1);
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
 		goto cleanup;
@@ -157,7 +157,7 @@ acpi_ds_execute_arguments(struct acpi_namespace_node *node,
 	/* Execute the opcode and arguments */
 
 	status = acpi_ds_init_aml_walk(walk_state, op, NULL, aml_start,
-				       aml_length, NULL, 3);
+				       aml_length, NULL, ACPI_IMODE_EXECUTE);
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
 		goto cleanup;
diff --git a/drivers/acpi/dispatcher/dswload.c b/drivers/acpi/dispatcher/dswload.c
index 4ed0868..baf04e8 100644
--- a/drivers/acpi/dispatcher/dswload.c
+++ b/drivers/acpi/dispatcher/dswload.c
@@ -754,7 +754,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 		}
 
 		flags = ACPI_NS_NO_UPSEARCH;
-		if (walk_state->pass_number == 3) {
+		if (walk_state->pass_number == ACPI_IMODE_EXECUTE) {
 
 			/* Execution mode, node cannot already exist, node is temporary */
 
diff --git a/drivers/acpi/namespace/nsparse.c b/drivers/acpi/namespace/nsparse.c
index 2e22479..a68de26 100644
--- a/drivers/acpi/namespace/nsparse.c
+++ b/drivers/acpi/namespace/nsparse.c
@@ -160,10 +160,10 @@ acpi_ns_parse_table(acpi_native_uint table_index,
 	 * each Parser Op subtree is deleted when it is finished.  This saves
 	 * a great deal of memory, and allows a small cache of parse objects
 	 * to service the entire parse.  The second pass of the parse then
-	 * performs another complete parse of the AML..
+	 * performs another complete parse of the AML.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
-	status = acpi_ns_one_complete_parse(1, table_index);
+	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1, table_index);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -178,7 +178,7 @@ acpi_ns_parse_table(acpi_native_uint table_index,
 	 * parse objects are all cached.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 2\n"));
-	status = acpi_ns_one_complete_parse(2, table_index);
+	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2, table_index);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 9069c69..fc5b3e5 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -260,7 +260,7 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 
 	/* Create and initialize a new walk state */
 
-	info->pass_number = 3;
+	info->pass_number = ACPI_IMODE_EXECUTE;
 	walk_state =
 	    acpi_ds_create_walk_state(info->obj_desc->method.owner_id, NULL,
 				      NULL, NULL);
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 287da6f..7b28d93 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -162,7 +162,7 @@ struct acpi_mutex_info {
 typedef enum {
 	ACPI_IMODE_LOAD_PASS1 = 0x01,
 	ACPI_IMODE_LOAD_PASS2 = 0x02,
-	ACPI_IMODE_EXECUTE = 0x0E
+	ACPI_IMODE_EXECUTE = 0x03
 } acpi_interpreter_mode;
 
 union acpi_name_union {
-- 
1.5.0.rc3.39.gec804
