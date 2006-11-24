From: Len Brown <len.brown@intel.com>
Subject: [PATCH 53/65] ACPICA: Use manifest constants for parse pass number
Date: Fri, 24 Nov 2006 02:19:03 -0500
Message-ID: <11643528141248-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10249 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934499AbWKXHQQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:16 -0500
In-Reply-To: <11643528134106-git-send-email-len.brown@intel.com>
Message-Id: <471c0881b4517e4fd7ae8995146cb34bbfc7a01e.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

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
@@ -382,7 +382,8 @@ acpi_ds_call_control_method(struct acpi_
 
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
@@ -114,7 +114,7 @@ acpi_ds_execute_arguments(struct acpi_na
 	}
 
 	status = acpi_ds_init_aml_walk(walk_state, op, NULL, aml_start,
-				       aml_length, NULL, 1);
+				       aml_length, NULL, ACPI_IMODE_LOAD_PASS1);
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
 		goto cleanup;
@@ -157,7 +157,7 @@ acpi_ds_execute_arguments(struct acpi_na
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
@@ -754,7 +754,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_
 		}
 
 		flags = ACPI_NS_NO_UPSEARCH;
-		if (walk_state->pass_number == 3) {
+		if (walk_state->pass_number == ACPI_IMODE_EXECUTE) {
 
 			/* Execution mode, node cannot already exist, node is temporary */
 
diff --git a/drivers/acpi/namespace/nsparse.c b/drivers/acpi/namespace/nsparse.c
index 2e22479..a68de26 100644
--- a/drivers/acpi/namespace/nsparse.c
+++ b/drivers/acpi/namespace/nsparse.c
@@ -160,10 +160,10 @@ acpi_ns_parse_table(acpi_native_uint tab
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
@@ -178,7 +178,7 @@ acpi_ns_parse_table(acpi_native_uint tab
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
@@ -260,7 +260,7 @@ acpi_status acpi_ps_execute_method(struc
 
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
1.4.4.1
