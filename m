From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20100528 linuxized patches
Date: Mon, 31 May 2010 17:07:42 +0800
Message-ID: <1275296862.7586.64.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-fC7D7GIIs9htSQr424Ez"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48282 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756063Ab0EaJJL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 May 2010 05:09:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>


--=-fC7D7GIIs9htSQr424Ez
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA Release 20100528 linuxized patches attached.
Applied cleanly on top of linus tree(67a3e12).

[PATCH 01/14] ACPICA: Add comment: _BCL cannot be sorted on the fly
[PATCH 02/14] ACPICA: Fix namestring associated with AE_NO_HANDLER exception
[PATCH 03/14] ACPICA: iASL/Core: Add support for _WDG/_WED MS methods
[PATCH 04/14] ACPICA: Expand initialization counters to 32 bits
[PATCH 05/14] ACPICA: Limit maximum time for Sleep() operator
[PATCH 06/14] ACPICA: Core: Replace all %d format specifiers with %u (unsigned)
[PATCH 07/14] ACPICA: Expand device initialization counters to 32 bits
[PATCH 08/14] ACPICA: Truncate I/O addresses to 16 bits for Windows compatibility
[PATCH 09/14] ACPICA: Performance enhancement for namespace search and access
[PATCH 10/14] ACPICA: Update flags for operand object
[PATCH 11/14] ACPICA: Enable multi-byte EC transfers
[PATCH 12/14] ACPICA: Optimization: Reduce the number of namespace walks
[PATCH 13/14] ACPICA: Add signatures for undefined tables: ATKG, GSCI, IEIT
[PATCH 14/14] ACPICA: Update version to 20100528

Lin Ming

--=-fC7D7GIIs9htSQr424Ez
Content-Disposition: attachment; filename="acpica-v20100528.mbox"
Content-Type: application/mbox; name="acpica-v20100528.mbox"
Content-Transfer-Encoding: 7bit

>From e1391ee4870c41cad9581a6370a79545c2639aaa Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 26 May 2010 11:03:56 +0800
Subject: [PATCH 01/14] ACPICA: Add comment: _BCL cannot be sorted on the fly

Because of package index values used for _BQC and _BCM.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 61bd0f6..4009498 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -112,6 +112,13 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
  * _GTM: Convert Buffer of BYTEs to a Buffer of DWORDs
  * _PSS: Sort the list descending by Power
  * _TSS: Sort the list descending by Power
+ *
+ * Names that must be packages, but cannot be sorted:
+ *
+ * _BCL: Values are tied to the Package index where they appear, and cannot
+ * be moved or sorted. These index values are used for _BQC and _BCM.
+ * However, we can fix the case where a buffer is returned, by converting
+ * it to a Package of integers.
  */
 static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 	{"_ALR", acpi_ns_repair_ALR},

>From 5e35febaa95a456babacd2f7c356f46961aee116 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 26 May 2010 11:06:12 +0800
Subject: [PATCH 02/14] ACPICA: Fix namestring associated with AE_NO_HANDLER exception

Was incorrectly AE_WAKE_ONLY_GPE.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acexcep.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 5958d78..17714be 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -212,7 +212,7 @@ char const *acpi_gbl_exception_names_env[] = {
 	"AE_NO_GLOBAL_LOCK",
 	"AE_ABORT_METHOD",
 	"AE_SAME_HANDLER",
-	"AE_WAKE_ONLY_GPE",
+	"AE_NO_HANDLER",
 	"AE_OWNER_ID_LIMIT"
 };
 

>From 07177f5066da1486bb397d3ec97a561f9603ceff Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 26 May 2010 11:18:35 +0800
Subject: [PATCH 03/14] ACPICA: iASL/Core: Add support for _WDG/_WED MS methods

These objects are defined by "Windows Instrumentation", and are
not part of the ACPI spec. Adds compiler support and runtime
typechecking support in the ACPICA core. ACPICA BZ 860.

http://www.acpica.org/bugzilla/show_bug.cgi?id=860

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acpredef.h |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 9711608..10998d3 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -503,15 +503,16 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE}},
 			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2,0}, 0,0}}, /* Fixed-length (2 Int), but is optional */
 
-	{{{0,0,0,0}, 0,0}} /* Table terminator */
-};
+	/* _WDG/_WED are MS extensions defined by "Windows Instrumentation" */
 
-#if 0
-	/* Not implemented */
+	{{"_WDG", 0, ACPI_RTYPE_BUFFER}},
+	{{"_WED", 1,
+	  ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER}},
 
-	{{"_WDG", 0, ACPI_RTYPE_BUFFER}},  /* MS Extension */
-	{{"_WED", 1, ACPI_RTYPE_PACKAGE}}, /* MS Extension */
+	{{{0, 0, 0, 0}, 0, 0}}  /* Table terminator */
+};
 
+#if 0
 	/* This is an internally implemented control method, no need to check */
 	{{"_OSI", 1, ACPI_RTYPE_INTEGER}},
 

>From edcaf16b32976190ef63a121c77bb11beb12ad8f Mon Sep 17 00:00:00 2001
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Date: Wed, 26 May 2010 11:20:47 +0800
Subject: [PATCH 04/14] ACPICA: Expand initialization counters to 32 bits

Expand the various initialization counters from 16-bit to 32-bit.
Allows for very large namespaces.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acstruct.h |   26 +++++++++++++-------------
 drivers/acpi/acpica/dsinit.c   |   14 +++++++-------
 drivers/acpi/acpica/nsinit.c   |    8 ++++----
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 161bc0e..0e2c66a 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -127,22 +127,22 @@ struct acpi_walk_state {
 	acpi_parse_upwards ascending_callback;
 };
 
-/* Info used by acpi_ps_init_objects */
+/* Info used by acpi_ns_initialize_objects and acpi_ds_initialize_objects */
 
 struct acpi_init_walk_info {
-	u16 method_count;
-	u16 device_count;
-	u16 op_region_count;
-	u16 field_count;
-	u16 buffer_count;
-	u16 package_count;
-	u16 op_region_init;
-	u16 field_init;
-	u16 buffer_init;
-	u16 package_init;
-	u16 object_count;
-	acpi_owner_id owner_id;
 	u32 table_index;
+	u32 object_count;
+	u32 method_count;
+	u32 device_count;
+	u32 op_region_count;
+	u32 field_count;
+	u32 buffer_count;
+	u32 package_count;
+	u32 op_region_init;
+	u32 field_init;
+	u32 buffer_init;
+	u32 package_init;
+	acpi_owner_id owner_id;
 };
 
 struct acpi_get_devices_info {
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index abe1403..cc4a38c 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -171,12 +171,12 @@ acpi_ds_initialize_objects(u32 table_index,
 			  "**** Starting initialization of namespace objects ****\n"));
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT, "Parsing all Control Methods:"));
 
-	info.method_count = 0;
-	info.op_region_count = 0;
-	info.object_count = 0;
-	info.device_count = 0;
-	info.table_index = table_index;
+	/* Set all init info to zero */
+
+	ACPI_MEMSET(&info, 0, sizeof(struct acpi_init_walk_info));
+
 	info.owner_id = owner_id;
+	info.table_index = table_index;
 
 	/* Walk entire namespace from the supplied root */
 
@@ -204,13 +204,13 @@ acpi_ds_initialize_objects(u32 table_index,
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nTable [%4.4s](id %4.4X) - %hd Objects with %hd Devices %hd Methods %hd Regions\n",
+			      "\nTable [%4.4s](id %4.4X) - %u Objects with %u Devices %u Methods %u Regions\n",
 			      table->signature, owner_id, info.object_count,
 			      info.device_count, info.method_count,
 			      info.op_region_count));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%hd Methods, %hd Regions\n", info.method_count,
+			  "%u Methods, %u Regions\n", info.method_count,
 			  info.op_region_count));
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 9bd6f05..b3d88d8 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -103,8 +103,8 @@ acpi_status acpi_ns_initialize_objects(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nInitialized %hd/%hd Regions %hd/%hd Fields %hd/%hd "
-			      "Buffers %hd/%hd Packages (%hd nodes)\n",
+			      "\nInitialized %u/%u Regions %u/%u Fields %u/%u "
+			      "Buffers %u/%u Packages (%u nodes)\n",
 			      info.op_region_init, info.op_region_count,
 			      info.field_init, info.field_count,
 			      info.buffer_init, info.buffer_count,
@@ -112,9 +112,9 @@ acpi_status acpi_ns_initialize_objects(void)
 			      info.object_count));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%hd Control Methods found\n", info.method_count));
+			  "%u Control Methods found\n", info.method_count));
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-			  "%hd Op Regions found\n", info.op_region_count));
+			  "%u Op Regions found\n", info.op_region_count));
 
 	return_ACPI_STATUS(AE_OK);
 }

>From b3c8803b8aee4af633af853069d0ac872e95bbff Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 26 May 2010 11:22:41 +0800
Subject: [PATCH 05/14] ACPICA: Limit maximum time for Sleep() operator

To prevent accidental deep sleeps, limit the maximum time that
Sleep() will sleep. Configurable, default maximum is two seconds.
ACPICA bugzilla 854.

http://www.acpica.org/bugzilla/show_bug.cgi?id=854

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acconfig.h |    4 ++++
 drivers/acpi/acpica/exsystem.c |    8 ++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index 33181ad..b17d8de 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -119,6 +119,10 @@
 
 #define ACPI_MAX_LOOP_ITERATIONS        0xFFFF
 
+/* Maximum sleep allowed via Sleep() operator */
+
+#define ACPI_MAX_SLEEP                  20000	/* Two seconds */
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 6d32e09..675aaa9 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -201,6 +201,14 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long)
 
 	acpi_ex_relinquish_interpreter();
 
+	/*
+	 * For compatibility with other ACPI implementations and to prevent
+	 * accidental deep sleeps, limit the sleep time to something reasonable.
+	 */
+	if (how_long > ACPI_MAX_SLEEP) {
+		how_long = ACPI_MAX_SLEEP;
+	}
+
 	acpi_os_sleep(how_long);
 
 	/* And now we must get the interpreter again */

>From cd2c132642d27070621c8880429e8a4285e913b9 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 26 May 2010 11:47:13 +0800
Subject: [PATCH 06/14] ACPICA: Core: Replace all %d format specifiers with %u (unsigned)

With only a few exceptions, ACPICA does not use signed integers.
Therefore, %d is incorrect.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |    2 +-
 drivers/acpi/acpica/dsmthdat.c |   10 +++++-----
 drivers/acpi/acpica/dsutils.c  |    4 ++--
 drivers/acpi/acpica/exdump.c   |    4 ++--
 drivers/acpi/acpica/exfldio.c  |    4 ++--
 drivers/acpi/acpica/exprep.c   |   14 +++++++-------
 drivers/acpi/acpica/exregion.c |    6 +++---
 drivers/acpi/acpica/hwsleep.c  |    2 +-
 drivers/acpi/acpica/nsaccess.c |    4 ++--
 drivers/acpi/acpica/nsdump.c   |    2 +-
 drivers/acpi/acpica/nsparse.c  |    4 ++--
 11 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 2a9a561..0084633 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -605,7 +605,7 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		 * we immediately reuse it for the next thread executing this method
 		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "*** Completed execution of one thread, %d threads remaining\n",
+				  "*** Completed execution of one thread, %u threads remaining\n",
 				  method_desc->method.thread_count));
 	} else {
 		/* This is the only executing thread for this method */
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index f3d52f5..d5e927f 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -146,7 +146,7 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state)
 
 	for (index = 0; index < ACPI_METHOD_NUM_LOCALS; index++) {
 		if (walk_state->local_variables[index].object) {
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Local%d=%p\n",
+			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Local%u=%p\n",
 					  index,
 					  walk_state->local_variables[index].
 					  object));
@@ -162,7 +162,7 @@ void acpi_ds_method_data_delete_all(struct acpi_walk_state *walk_state)
 
 	for (index = 0; index < ACPI_METHOD_NUM_ARGS; index++) {
 		if (walk_state->arguments[index].object) {
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Arg%d=%p\n",
+			ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Deleting Arg%u=%p\n",
 					  index,
 					  walk_state->arguments[index].object));
 
@@ -226,7 +226,7 @@ acpi_ds_method_data_init_args(union acpi_operand_object **params,
 		index++;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%d args passed to method\n", index));
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%u args passed to method\n", index));
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -323,7 +323,7 @@ acpi_ds_method_data_set_value(u8 type,
 	ACPI_FUNCTION_TRACE(ds_method_data_set_value);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "NewObj %p Type %2.2X, Refs=%d [%s]\n", object,
+			  "NewObj %p Type %2.2X, Refs=%u [%s]\n", object,
 			  type, object->common.reference_count,
 			  acpi_ut_get_type_name(object->common.type)));
 
@@ -543,7 +543,7 @@ acpi_ds_store_object_to_local(u8 type,
 	union acpi_operand_object *new_obj_desc;
 
 	ACPI_FUNCTION_TRACE(ds_store_object_to_local);
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Type=%2.2X Index=%d Obj=%p\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Type=%2.2X Index=%u Obj=%p\n",
 			  type, index, obj_desc));
 
 	/* Parameter validation */
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 306c62a..15135c2 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -746,7 +746,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 		index--;
 
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
-				  "Arg #%d (%p) done, Arg1=%p\n", index, arg,
+				  "Arg #%u (%p) done, Arg1=%p\n", index, arg,
 				  first_arg));
 	}
 
@@ -760,7 +760,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 */
 	acpi_ds_obj_stack_pop_and_delete(arg_count, walk_state);
 
-	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %d", index));
+	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %u", index));
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index d39d438..cdb66d1 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -742,7 +742,7 @@ acpi_ex_dump_operands(union acpi_operand_object **operands,
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-			  "**** Start operand dump for opcode [%s], %d operands\n",
+			  "**** Start operand dump for opcode [%s], %u operands\n",
 			  opcode_name, num_operands));
 
 	if (num_operands == 0) {
@@ -945,7 +945,7 @@ acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
 
 	case ACPI_TYPE_PACKAGE:
 
-		acpi_os_printf("[Package] Contains %d Elements:\n",
+		acpi_os_printf("[Package] Contains %u Elements:\n",
 			       obj_desc->package.count);
 
 		for (i = 0; i < obj_desc->package.count; i++) {
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index a6dc26f..0472173 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -534,13 +534,13 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 	if (ACPI_SUCCESS(status)) {
 		if (read_write == ACPI_READ) {
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Value Read %8.8X%8.8X, Width %d\n",
+					  "Value Read %8.8X%8.8X, Width %u\n",
 					  ACPI_FORMAT_UINT64(*value),
 					  obj_desc->common_field.
 					  access_byte_width));
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Value Written %8.8X%8.8X, Width %d\n",
+					  "Value Written %8.8X%8.8X, Width %u\n",
 					  ACPI_FORMAT_UINT64(*value),
 					  obj_desc->common_field.
 					  access_byte_width));
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 25059da..0686f27 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -108,11 +108,11 @@ acpi_ex_generate_access(u32 field_bit_offset,
 	field_byte_length = field_byte_end_offset - field_byte_offset;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-			  "Bit length %d, Bit offset %d\n",
+			  "Bit length %u, Bit offset %u\n",
 			  field_bit_length, field_bit_offset));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-			  "Byte Length %d, Byte Offset %d, End Offset %d\n",
+			  "Byte Length %u, Byte Offset %u, End Offset %u\n",
 			  field_byte_length, field_byte_offset,
 			  field_byte_end_offset));
 
@@ -147,11 +147,11 @@ acpi_ex_generate_access(u32 field_bit_offset,
 			accesses = field_end_offset - field_start_offset;
 
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "AccessWidth %d end is within region\n",
+					  "AccessWidth %u end is within region\n",
 					  access_byte_width));
 
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Field Start %d, Field End %d -- requires %d accesses\n",
+					  "Field Start %u, Field End %u -- requires %u accesses\n",
 					  field_start_offset, field_end_offset,
 					  accesses));
 
@@ -159,7 +159,7 @@ acpi_ex_generate_access(u32 field_bit_offset,
 
 			if (accesses <= 1) {
 				ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-						  "Entire field can be accessed with one operation of size %d\n",
+						  "Entire field can be accessed with one operation of size %u\n",
 						  access_byte_width));
 				return_VALUE(access_byte_width);
 			}
@@ -174,7 +174,7 @@ acpi_ex_generate_access(u32 field_bit_offset,
 			}
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "AccessWidth %d end is NOT within region\n",
+					  "AccessWidth %u end is NOT within region\n",
 					  access_byte_width));
 			if (access_byte_width == 1) {
 				ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
@@ -190,7 +190,7 @@ acpi_ex_generate_access(u32 field_bit_offset,
 			 * previous access
 			 */
 			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-					  "Backing off to previous optimal access width of %d\n",
+					  "Backing off to previous optimal access width of %u\n",
 					  minimum_access_width));
 			return_VALUE(minimum_access_width);
 		}
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 531000f..8819d2a 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -194,7 +194,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 	    ((u64) address - (u64) mem_info->mapped_physical_address);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "System-Memory (width %d) R/W %d Address=%8.8X%8.8X\n",
+			  "System-Memory (width %u) R/W %u Address=%8.8X%8.8X\n",
 			  bit_width, function,
 			  ACPI_FORMAT_NATIVE_UINT(address)));
 
@@ -297,7 +297,7 @@ acpi_ex_system_io_space_handler(u32 function,
 	ACPI_FUNCTION_TRACE(ex_system_io_space_handler);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "System-IO (width %d) R/W %d Address=%8.8X%8.8X\n",
+			  "System-IO (width %u) R/W %u Address=%8.8X%8.8X\n",
 			  bit_width, function,
 			  ACPI_FORMAT_NATIVE_UINT(address)));
 
@@ -373,7 +373,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 	pci_register = (u16) (u32) address;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Pci-Config %d (%d) Seg(%04x) Bus(%04x) Dev(%04x) Func(%04x) Reg(%04x)\n",
+			  "Pci-Config %u (%u) Seg(%04x) Bus(%04x) Dev(%04x) Func(%04x) Reg(%04x)\n",
 			  function, bit_width, pci_id->segment, pci_id->bus,
 			  pci_id->device, pci_id->function, pci_register));
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 36eb803..3796811 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -307,7 +307,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
-			  "Entering sleep state [S%d]\n", sleep_state));
+			  "Entering sleep state [S%u]\n", sleep_state));
 
 	/* Clear the SLP_EN and SLP_TYP fields */
 
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 3a28146..2cebfa9 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -433,7 +433,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 
 			if (search_parent_flag == ACPI_NS_NO_UPSEARCH) {
 				ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-						  "Search scope is [%4.4s], path has %d carat(s)\n",
+						  "Search scope is [%4.4s], path has %u carat(s)\n",
 						  acpi_ut_get_node_name
 						  (this_node), num_carats));
 			}
@@ -495,7 +495,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			path++;
 
 			ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-					  "Multi Pathname (%d Segments, Flags=%X)\n",
+					  "Multi Pathname (%u Segments, Flags=%X)\n",
 					  num_segments, flags));
 			break;
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 2110cc2..a54dc39 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -441,7 +441,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			return (AE_OK);
 		}
 
-		acpi_os_printf("(R%d)", obj_desc->common.reference_count);
+		acpi_os_printf("(R%u)", obj_desc->common.reference_count);
 
 		switch (type) {
 		case ACPI_TYPE_METHOD:
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 27cda52..5808c89 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -136,8 +136,8 @@ acpi_ns_one_complete_parse(u32 pass_number,
 
 	/* Parse the AML */
 
-	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %d parse\n",
-			  (unsigned)pass_number));
+	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %u parse\n",
+			  pass_number));
 	status = acpi_ps_parse_aml(walk_state);
 
       cleanup:

>From 61e6f1121eedd191475eb4a2badbfd665d2f4204 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 26 May 2010 11:48:22 +0800
Subject: [PATCH 07/14] ACPICA: Expand device initialization counters to 32 bits

Expand the various device initialization counters from 16-bit
to 32-bit.  Allows for very large namespaces.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acstruct.h |    6 +++---
 drivers/acpi/acpica/nsinit.c   |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 0e2c66a..6e5dd97 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -201,11 +201,11 @@ struct acpi_evaluate_info {
 /* Info used by acpi_ns_initialize_devices */
 
 struct acpi_device_walk_info {
-	u16 device_count;
-	u16 num_STA;
-	u16 num_INI;
 	struct acpi_table_desc *table_desc;
 	struct acpi_evaluate_info *evaluate_info;
+	u32 device_count;
+	u32 num_STA;
+	u32 num_INI;
 };
 
 /* TBD: [Restructure] Merge with struct above */
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index b3d88d8..8009e71 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -199,8 +199,8 @@ acpi_status acpi_ns_initialize_devices(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nExecuted %hd _INI methods requiring %hd _STA executions "
-			      "(examined %hd objects)\n",
+			      "\nExecuted %u _INI methods requiring %u _STA executions "
+			      "(examined %u objects)\n",
 			      info.num_INI, info.num_STA, info.device_count));
 
 	return_ACPI_STATUS(status);

>From 7d6940db0ee35932aba334e20832bbf6bcf72a3a Mon Sep 17 00:00:00 2001
From: Matthew Garrett <mjg@redhat.com>
Date: Wed, 26 May 2010 11:50:48 +0800
Subject: [PATCH 08/14] ACPICA: Truncate I/O addresses to 16 bits for Windows compatibility

This feature is optional and is enabled if the BIOS requests any
Windows OSI strings. It can also be enabled by the host OS.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    8 ++++++++
 drivers/acpi/acpica/hwvalid.c  |   12 ++++++++++++
 drivers/acpi/acpica/nsinit.c   |    9 +++++++++
 include/acpi/acpixf.h          |    1 +
 4 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 9070f1f..899d68a 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -125,6 +125,14 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_copy_dsdt_locally, FALSE);
 
+/*
+ * Optionally truncate I/O addresses to 16 bits. Provides compatibility
+ * with other ACPI implementations. NOTE: During ACPICA initialization,
+ * this value is set to TRUE if any Windows OSI strings have been
+ * requested by the BIOS.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_truncate_io_addresses, FALSE);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index c10d587..e1d9c77 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -222,6 +222,12 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
 	u32 one_byte;
 	u32 i;
 
+	/* Truncate address to 16 bits if requested */
+
+	if (acpi_gbl_truncate_io_addresses) {
+		address &= ACPI_UINT16_MAX;
+	}
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
@@ -279,6 +285,12 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 	acpi_status status;
 	u32 i;
 
+	/* Truncate address to 16 bits if requested */
+
+	if (acpi_gbl_truncate_io_addresses) {
+		address &= ACPI_UINT16_MAX;
+	}
+
 	/* Validate the entire request and perform the I/O */
 
 	status = acpi_hw_validate_io_request(address, width);
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 8009e71..f0e49df 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -193,6 +193,15 @@ acpi_status acpi_ns_initialize_devices(void)
 					acpi_ns_init_one_device, NULL, &info,
 					NULL);
 
+	/*
+	 * Any _OSI requests should be completed by now. If the BIOS has
+	 * requested any Windows OSI strings, we will always truncate
+	 * I/O addresses to 16 bits -- for Windows compatibility.
+	 */
+	if (acpi_gbl_osi_data >= ACPI_OSI_WIN_2000) {
+		acpi_gbl_truncate_io_addresses = TRUE;
+	}
+
 	ACPI_FREE(info.evaluate_info);
 	if (ACPI_FAILURE(status)) {
 		goto error_exit;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 0e4ab1f..1371cc9 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -69,6 +69,7 @@ extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
 extern u8 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
+extern u8 acpi_gbl_truncate_io_addresses;
 
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;

>From 57a4714a6ff51faf8f67b042a224ad8126ff254b Mon Sep 17 00:00:00 2001
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Date: Wed, 26 May 2010 11:53:07 +0800
Subject: [PATCH 09/14] ACPICA: Performance enhancement for namespace search and access

This change enhances the performance of namespace searches and
walks by adding a backpointer to the parent in each namespace
node. On large namespaces, this change can improve overall ACPI
performance by up to 9X.  Adding a pointer to each namespace node
increases the overall size of the internal namespace by about 5%,
since each namespace entry usually consists of both a namespace
node and an ACPI operand object.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |    5 +-
 drivers/acpi/acpica/acnamesp.h |    7 ---
 drivers/acpi/acpica/dsmthdat.c |    6 +--
 drivers/acpi/acpica/dsopcode.c |    6 +-
 drivers/acpi/acpica/evrgnini.c |   10 ++--
 drivers/acpi/acpica/exdump.c   |    2 +-
 drivers/acpi/acpica/nsaccess.c |    5 +-
 drivers/acpi/acpica/nsalloc.c  |   74 +++++++++-----------------
 drivers/acpi/acpica/nsinit.c   |    4 +-
 drivers/acpi/acpica/nsnames.c  |    4 +-
 drivers/acpi/acpica/nssearch.c |   15 +-----
 drivers/acpi/acpica/nsutils.c  |  113 ----------------------------------------
 drivers/acpi/acpica/nswalk.c   |   15 +----
 drivers/acpi/acpica/nsxfobj.c  |    2 +-
 drivers/acpi/acpica/utglobal.c |    2 +-
 15 files changed, 52 insertions(+), 218 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 147a7e6..eb2d420 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -184,8 +184,9 @@ struct acpi_namespace_node {
 	u8 flags;		/* Miscellaneous flags */
 	acpi_owner_id owner_id;	/* Node creator */
 	union acpi_name_union name;	/* ACPI Name, always 4 chars per ACPI spec */
+	struct acpi_namespace_node *parent;	/* Parent node */
 	struct acpi_namespace_node *child;	/* First child */
-	struct acpi_namespace_node *peer;	/* Peer. Parent if ANOBJ_END_OF_PEER_LIST set */
+	struct acpi_namespace_node *peer;	/* First peer */
 
 	/*
 	 * The following fields are used by the ASL compiler and disassembler only
@@ -199,7 +200,7 @@ struct acpi_namespace_node {
 
 /* Namespace Node flags */
 
-#define ANOBJ_END_OF_PEER_LIST          0x01	/* End-of-list, Peer field points to parent */
+#define ANOBJ_RESERVED                  0x01	/* Available for use */
 #define ANOBJ_TEMPORARY                 0x02	/* Node is create by a method and is temporary */
 #define ANOBJ_METHOD_ARG                0x04	/* Node is a method argument */
 #define ANOBJ_METHOD_LOCAL              0x08	/* Node is a method local */
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 258159c..9f60ff0 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -369,11 +369,4 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle);
 
 void acpi_ns_terminate(void);
 
-struct acpi_namespace_node *acpi_ns_get_parent_node(struct acpi_namespace_node
-						    *node);
-
-struct acpi_namespace_node *acpi_ns_get_next_valid_node(struct
-							acpi_namespace_node
-							*node);
-
 #endif				/* __ACNAMESP_H__ */
diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index d5e927f..8095306 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -102,8 +102,7 @@ void acpi_ds_method_data_init(struct acpi_walk_state *walk_state)
 		walk_state->arguments[i].name.integer |= (i << 24);
 		walk_state->arguments[i].descriptor_type = ACPI_DESC_TYPE_NAMED;
 		walk_state->arguments[i].type = ACPI_TYPE_ANY;
-		walk_state->arguments[i].flags =
-		    ANOBJ_END_OF_PEER_LIST | ANOBJ_METHOD_ARG;
+		walk_state->arguments[i].flags = ANOBJ_METHOD_ARG;
 	}
 
 	/* Init the method locals */
@@ -116,8 +115,7 @@ void acpi_ds_method_data_init(struct acpi_walk_state *walk_state)
 		walk_state->local_variables[i].descriptor_type =
 		    ACPI_DESC_TYPE_NAMED;
 		walk_state->local_variables[i].type = ACPI_TYPE_ANY;
-		walk_state->local_variables[i].flags =
-		    ANOBJ_END_OF_PEER_LIST | ANOBJ_METHOD_LOCAL;
+		walk_state->local_variables[i].flags = ANOBJ_METHOD_LOCAL;
 	}
 
 	return_VOID;
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 53a7e41..7c0e742 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -213,7 +213,7 @@ acpi_ds_get_buffer_field_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the AML code for the term_arg arguments */
 
-	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
+	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	return_ACPI_STATUS(status);
@@ -257,7 +257,7 @@ acpi_ds_get_bank_field_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the AML code for the term_arg arguments */
 
-	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
+	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	return_ACPI_STATUS(status);
@@ -394,7 +394,7 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the argument AML */
 
-	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
+	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 2e3b033..f40d271 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -199,7 +199,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 		return_ACPI_STATUS(status);
 	}
 
-	parent_node = acpi_ns_get_parent_node(region_obj->region.node);
+	parent_node = region_obj->region.node->parent;
 
 	/*
 	 * Get the _SEG and _BBN values from the device upon which the handler
@@ -248,7 +248,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 				break;
 			}
 
-			pci_root_node = acpi_ns_get_parent_node(pci_root_node);
+			pci_root_node = pci_root_node->parent;
 		}
 
 		/* PCI root bridge not found, use namespace root node */
@@ -280,7 +280,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	 */
 	pci_device_node = region_obj->region.node;
 	while (pci_device_node && (pci_device_node->type != ACPI_TYPE_DEVICE)) {
-		pci_device_node = acpi_ns_get_parent_node(pci_device_node);
+		pci_device_node = pci_device_node->parent;
 	}
 
 	if (!pci_device_node) {
@@ -521,7 +521,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	node = acpi_ns_get_parent_node(region_obj->region.node);
+	node = region_obj->region.node->parent;
 	space_id = region_obj->region.space_id;
 
 	/* Setup defaults */
@@ -654,7 +654,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 
 		/* This node does not have the handler we need; Pop up one level */
 
-		node = acpi_ns_get_parent_node(node);
+		node = node->parent;
 	}
 
 	/* If we get here, there is no handler for this region */
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index cdb66d1..f067bbb 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -812,7 +812,7 @@ void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags)
 	acpi_ex_out_string("Type", acpi_ut_get_type_name(node->type));
 	acpi_ex_out_pointer("Attached Object",
 			    acpi_ns_get_attached_object(node));
-	acpi_ex_out_pointer("Parent", acpi_ns_get_parent_node(node));
+	acpi_ex_out_pointer("Parent", node->parent);
 
 	acpi_ex_dump_object(ACPI_CAST_PTR(union acpi_operand_object, node),
 			    acpi_ex_dump_node);
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 2cebfa9..0cd925b 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -338,8 +338,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			 */
 			while (!acpi_ns_opens_scope(prefix_node->type) &&
 			       prefix_node->type != ACPI_TYPE_ANY) {
-				prefix_node =
-				    acpi_ns_get_parent_node(prefix_node);
+				prefix_node = prefix_node->parent;
 			}
 		}
 	}
@@ -419,7 +418,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 				/* Backup to the parent node */
 
 				num_carats++;
-				this_node = acpi_ns_get_parent_node(this_node);
+				this_node = this_node->parent;
 				if (!this_node) {
 
 					/* Current scope has no parent scope */
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 982269c..8d3a43a 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -159,7 +159,7 @@ void acpi_ns_remove_node(struct acpi_namespace_node *node)
 
 	ACPI_FUNCTION_TRACE_PTR(ns_remove_node, node);
 
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 
 	prev_node = NULL;
 	next_node = parent_node->child;
@@ -168,29 +168,20 @@ void acpi_ns_remove_node(struct acpi_namespace_node *node)
 
 	while (next_node != node) {
 		prev_node = next_node;
-		next_node = prev_node->peer;
+		next_node = next_node->peer;
 	}
 
 	if (prev_node) {
 
 		/* Node is not first child, unlink it */
 
-		prev_node->peer = next_node->peer;
-		if (next_node->flags & ANOBJ_END_OF_PEER_LIST) {
-			prev_node->flags |= ANOBJ_END_OF_PEER_LIST;
-		}
+		prev_node->peer = node->peer;
 	} else {
-		/* Node is first child (has no previous peer) */
-
-		if (next_node->flags & ANOBJ_END_OF_PEER_LIST) {
-
-			/* No peers at all */
-
-			parent_node->child = NULL;
-		} else {	/* Link peer list to parent */
-
-			parent_node->child = next_node->peer;
-		}
+		/*
+		 * Node is first child (has no previous peer).
+		 * Link peer list to parent
+		 */
+		parent_node->child = node->peer;
 	}
 
 	/* Delete the node and any attached objects */
@@ -238,23 +229,20 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 
 	/* Link the new entry into the parent and existing children */
 
+	node->peer = NULL;
+	node->parent = parent_node;
 	child_node = parent_node->child;
+
 	if (!child_node) {
 		parent_node->child = node;
-		node->flags |= ANOBJ_END_OF_PEER_LIST;
-		node->peer = parent_node;
 	} else {
-		while (!(child_node->flags & ANOBJ_END_OF_PEER_LIST)) {
+		/* Add node to the end of the peer list */
+
+		while (child_node->peer) {
 			child_node = child_node->peer;
 		}
 
 		child_node->peer = node;
-
-		/* Clear end-of-list flag */
-
-		child_node->flags &= ~ANOBJ_END_OF_PEER_LIST;
-		node->flags |= ANOBJ_END_OF_PEER_LIST;
-		node->peer = parent_node;
 	}
 
 	/* Init the new entry */
@@ -288,9 +276,8 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 
 void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 {
-	struct acpi_namespace_node *child_node;
 	struct acpi_namespace_node *next_node;
-	u8 flags;
+	struct acpi_namespace_node *node_to_delete;
 
 	ACPI_FUNCTION_TRACE_PTR(ns_delete_children, parent_node);
 
@@ -298,37 +285,26 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 		return_VOID;
 	}
 
-	/* If no children, all done! */
-
-	child_node = parent_node->child;
-	if (!child_node) {
-		return_VOID;
-	}
-
 	/* Deallocate all children at this level */
 
-	do {
-
-		/* Get the things we need */
-
-		next_node = child_node->peer;
-		flags = child_node->flags;
+	next_node = parent_node->child;
+	while (next_node) {
 
 		/* Grandchildren should have all been deleted already */
 
-		if (child_node->child) {
+		if (next_node->child) {
 			ACPI_ERROR((AE_INFO, "Found a grandchild! P=%p C=%p",
-				    parent_node, child_node));
+				    parent_node, next_node));
 		}
 
 		/*
 		 * Delete this child node and move on to the next child in the list.
 		 * No need to unlink the node since we are deleting the entire branch.
 		 */
-		acpi_ns_delete_node(child_node);
-		child_node = next_node;
-
-	} while (!(flags & ANOBJ_END_OF_PEER_LIST));
+		node_to_delete = next_node;
+		next_node = next_node->peer;
+		acpi_ns_delete_node(node_to_delete);
+	};
 
 	/* Clear the parent's child pointer */
 
@@ -405,7 +381,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 
 			/* Move up the tree to the grandparent */
 
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 		}
 	}
 
@@ -510,7 +486,7 @@ void acpi_ns_delete_namespace_by_owner(acpi_owner_id owner_id)
 
 			/* Move up the tree to the grandparent */
 
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index f0e49df..660a272 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -410,7 +410,7 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 	 * The only _INI methods that we care about are those that are
 	 * present under Device, Processor, and Thermal objects.
 	 */
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 	switch (parent_node->type) {
 	case ACPI_TYPE_DEVICE:
 	case ACPI_TYPE_PROCESSOR:
@@ -420,7 +420,7 @@ acpi_ns_find_ini_methods(acpi_handle obj_handle,
 
 		while (parent_node) {
 			parent_node->flags |= ANOBJ_SUBTREE_HAS_INI;
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 7dea003..d3104af 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -93,7 +93,7 @@ acpi_ns_build_external_path(struct acpi_namespace_node *node,
 		/* Put the name into the buffer */
 
 		ACPI_MOVE_32_TO_32((name_buffer + index), &parent_node->name);
-		parent_node = acpi_ns_get_parent_node(parent_node);
+		parent_node = parent_node->parent;
 
 		/* Prefix name with the path separator */
 
@@ -198,7 +198,7 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 			return 0;
 		}
 		size += ACPI_PATH_SEGMENT_LENGTH;
-		next_node = acpi_ns_get_parent_node(next_node);
+		next_node = next_node->parent;
 	}
 
 	if (!size) {
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index a8e42b5..41102a8 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -152,17 +152,6 @@ acpi_ns_search_one_scope(u32 target_name,
 			return_ACPI_STATUS(AE_OK);
 		}
 
-		/*
-		 * The last entry in the list points back to the parent,
-		 * so a flag is used to indicate the end-of-list
-		 */
-		if (node->flags & ANOBJ_END_OF_PEER_LIST) {
-
-			/* Searched entire list, we are done */
-
-			break;
-		}
-
 		/* Didn't match name, move on to the next peer object */
 
 		node = node->peer;
@@ -217,7 +206,7 @@ acpi_ns_search_parent_tree(u32 target_name,
 
 	ACPI_FUNCTION_TRACE(ns_search_parent_tree);
 
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 
 	/*
 	 * If there is no parent (i.e., we are at the root) or type is "local",
@@ -261,7 +250,7 @@ acpi_ns_search_parent_tree(u32 target_name,
 
 		/* Not found here, go up another level (until we reach the root) */
 
-		parent_node = acpi_ns_get_parent_node(parent_node);
+		parent_node = parent_node->parent;
 	}
 
 	/* Not found in parent tree */
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index bab5597..e1add34 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -847,116 +847,3 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 	ACPI_FREE(internal_path);
 	return_ACPI_STATUS(status);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_get_parent_node
- *
- * PARAMETERS:  Node       - Current table entry
- *
- * RETURN:      Parent entry of the given entry
- *
- * DESCRIPTION: Obtain the parent entry for a given entry in the namespace.
- *
- ******************************************************************************/
-
-struct acpi_namespace_node *acpi_ns_get_parent_node(struct acpi_namespace_node
-						    *node)
-{
-	ACPI_FUNCTION_ENTRY();
-
-	if (!node) {
-		return (NULL);
-	}
-
-	/*
-	 * Walk to the end of this peer list. The last entry is marked with a flag
-	 * and the peer pointer is really a pointer back to the parent. This saves
-	 * putting a parent back pointer in each and every named object!
-	 */
-	while (!(node->flags & ANOBJ_END_OF_PEER_LIST)) {
-		node = node->peer;
-	}
-
-	return (node->peer);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_get_next_valid_node
- *
- * PARAMETERS:  Node       - Current table entry
- *
- * RETURN:      Next valid Node in the linked node list. NULL if no more valid
- *              nodes.
- *
- * DESCRIPTION: Find the next valid node within a name table.
- *              Useful for implementing NULL-end-of-list loops.
- *
- ******************************************************************************/
-
-struct acpi_namespace_node *acpi_ns_get_next_valid_node(struct
-							acpi_namespace_node
-							*node)
-{
-
-	/* If we are at the end of this peer list, return NULL */
-
-	if (node->flags & ANOBJ_END_OF_PEER_LIST) {
-		return NULL;
-	}
-
-	/* Otherwise just return the next peer */
-
-	return (node->peer);
-}
-
-#ifdef ACPI_OBSOLETE_FUNCTIONS
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_find_parent_name
- *
- * PARAMETERS:  *child_node            - Named Obj whose name is to be found
- *
- * RETURN:      The ACPI name
- *
- * DESCRIPTION: Search for the given obj in its parent scope and return the
- *              name segment, or "????" if the parent name can't be found
- *              (which "should not happen").
- *
- ******************************************************************************/
-
-acpi_name acpi_ns_find_parent_name(struct acpi_namespace_node * child_node)
-{
-	struct acpi_namespace_node *parent_node;
-
-	ACPI_FUNCTION_TRACE(ns_find_parent_name);
-
-	if (child_node) {
-
-		/* Valid entry.  Get the parent Node */
-
-		parent_node = acpi_ns_get_parent_node(child_node);
-		if (parent_node) {
-			ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-					  "Parent of %p [%4.4s] is %p [%4.4s]\n",
-					  child_node,
-					  acpi_ut_get_node_name(child_node),
-					  parent_node,
-					  acpi_ut_get_node_name(parent_node)));
-
-			if (parent_node->name.integer) {
-				return_VALUE((acpi_name) parent_node->name.
-					     integer);
-			}
-		}
-
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Unable to find parent of %p (%4.4s)\n",
-				  child_node,
-				  acpi_ut_get_node_name(child_node)));
-	}
-
-	return_VALUE(ACPI_UNKNOWN_NAME);
-}
-#endif
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 00e79fb..2cd5be8 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -79,15 +79,6 @@ struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
 		return parent_node->child;
 	}
 
-	/*
-	 * Get the next node.
-	 *
-	 * If we are at the end of this peer list, return NULL
-	 */
-	if (child_node->flags & ANOBJ_END_OF_PEER_LIST) {
-		return NULL;
-	}
-
 	/* Otherwise just return the next peer */
 
 	return child_node->peer;
@@ -146,9 +137,9 @@ struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
 			return (next_node);
 		}
 
-		/* Otherwise, move on to the next node */
+		/* Otherwise, move on to the next peer node */
 
-		next_node = acpi_ns_get_next_valid_node(next_node);
+		next_node = next_node->peer;
 	}
 
 	/* Not found */
@@ -355,7 +346,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			 */
 			level--;
 			child_node = parent_node;
-			parent_node = acpi_ns_get_parent_node(parent_node);
+			parent_node = parent_node->parent;
 
 			node_previously_visited = TRUE;
 		}
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index eafef24..a1f04e9 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -190,7 +190,7 @@ acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 
 	/* Get the parent entry */
 
-	parent_node = acpi_ns_get_parent_node(node);
+	parent_node = node->parent;
 	*ret_handle = ACPI_CAST_PTR(acpi_handle, parent_node);
 
 	/* Return exception if parent is null */
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 6611675..0558747 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -813,10 +813,10 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_root_node_struct.name.integer = ACPI_ROOT_NAME;
 	acpi_gbl_root_node_struct.descriptor_type = ACPI_DESC_TYPE_NAMED;
 	acpi_gbl_root_node_struct.type = ACPI_TYPE_DEVICE;
+	acpi_gbl_root_node_struct.parent = NULL;
 	acpi_gbl_root_node_struct.child = NULL;
 	acpi_gbl_root_node_struct.peer = NULL;
 	acpi_gbl_root_node_struct.object = NULL;
-	acpi_gbl_root_node_struct.flags = ANOBJ_END_OF_PEER_LIST;
 
 #ifdef ACPI_DEBUG_OUTPUT
 	acpi_gbl_lowest_stack_pointer = ACPI_CAST_PTR(acpi_size, ACPI_SIZE_MAX);

>From 5d728aec241a9b81c42f089e0c87da59a421611f Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 27 May 2010 09:27:34 +0800
Subject: [PATCH 10/14] ACPICA: Update flags for operand object

Remove obsolete AOPOBJ_SINGLE_DATUM. Add AOPOBJ_INVALID for
use if the host OS rejects the address of an operation region
(currently only used by Linux.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acobject.h |   16 ++++++++--------
 drivers/acpi/acpica/exprep.c   |    9 ---------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index cde18ea..54857fa 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -91,14 +91,14 @@
 
 /* Values for Flag byte above */
 
-#define AOPOBJ_AML_CONSTANT         0x01
-#define AOPOBJ_STATIC_POINTER       0x02
-#define AOPOBJ_DATA_VALID           0x04
-#define AOPOBJ_OBJECT_INITIALIZED   0x08
-#define AOPOBJ_SETUP_COMPLETE       0x10
-#define AOPOBJ_SINGLE_DATUM         0x20
-#define AOPOBJ_INVALID              0x40	/* Used if host OS won't allow an op_region address */
-#define AOPOBJ_MODULE_LEVEL         0x80
+#define AOPOBJ_AML_CONSTANT         0x01	/* Integer is an AML constant */
+#define AOPOBJ_STATIC_POINTER       0x02	/* Data is part of an ACPI table, don't delete */
+#define AOPOBJ_DATA_VALID           0x04	/* Object is intialized and data is valid */
+#define AOPOBJ_OBJECT_INITIALIZED   0x08	/* Region is initialized, _REG was run */
+#define AOPOBJ_SETUP_COMPLETE       0x10	/* Region setup is complete */
+#define AOPOBJ_INVALID              0x20	/* Host OS won't allow a Region address */
+#define AOPOBJ_MODULE_LEVEL         0x40	/* Method is actually module-level code */
+#define AOPOBJ_MODIFIED_NAMESPACE   0x80	/* Method modified the namespace */
 
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 0686f27..98a331d 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -385,15 +385,6 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 	    (field_bit_position -
 	     ACPI_MUL_8(obj_desc->common_field.base_byte_offset));
 
-	/*
-	 * Does the entire field fit within a single field access element? (datum)
-	 * (i.e., without crossing a datum boundary)
-	 */
-	if ((obj_desc->common_field.start_field_bit_offset +
-	     field_bit_length) <= (u16) access_bit_width) {
-		obj_desc->common.flags |= AOPOBJ_SINGLE_DATUM;
-	}
-
 	return_ACPI_STATUS(AE_OK);
 }
 

>From 8bc0eb0a5c062d902d4d61ac08642ddf45e77ac4 Mon Sep 17 00:00:00 2001
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Date: Thu, 27 May 2010 09:32:30 +0800
Subject: [PATCH 11/14] ACPICA: Enable multi-byte EC transfers

Previously, the maximum data size passed to the EC operation region
handler was a single byte. Since there are often larger datums
that need to be transfered, and the EC would like to lock these as
a single transaction, this change enables transfers larger than
a single byte.  This may require changes to the host-OS Embedded
Controller driver to enable 16/32/64 bit tranfers in addition to
8-bit transfers.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acobject.h |    2 +-
 drivers/acpi/acpica/exfldio.c  |   75 ++++++++++++++++++++++++++-------------
 drivers/acpi/acpica/exprep.c   |   46 ++++++++++++------------
 3 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 54857fa..bdbfaf2 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -248,7 +248,7 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 	u32                             base_byte_offset;   /* Byte offset within containing object */\
 	u32                             value;              /* Value to store into the Bank or Index register */\
 	u8                              start_field_bit_offset;/* Bit offset within first field datum (0-63) */\
-	u8                              access_bit_width;	/* Read/Write size in bits (8-64) */
+
 
 struct acpi_object_field_common {	/* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 0472173..38293fd 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -119,8 +119,8 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 	}
 
 	/*
-	 * Exit now for SMBus or IPMI address space, it has a non-linear address space
-	 * and the request cannot be directly validated
+	 * Exit now for SMBus or IPMI address space, it has a non-linear
+	 * address space and the request cannot be directly validated
 	 */
 	if (rgn_desc->region.space_id == ACPI_ADR_SPACE_SMBUS ||
 	    rgn_desc->region.space_id == ACPI_ADR_SPACE_IPMI) {
@@ -147,8 +147,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 	 * (Region length is specified in bytes)
 	 */
 	if (rgn_desc->region.length <
-	    (obj_desc->common_field.base_byte_offset +
-	     field_datum_byte_offset +
+	    (obj_desc->common_field.base_byte_offset + field_datum_byte_offset +
 	     obj_desc->common_field.access_byte_width)) {
 		if (acpi_gbl_enable_interpreter_slack) {
 			/*
@@ -680,6 +679,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	u32 buffer_tail_bits;
 	u32 datum_count;
 	u32 field_datum_count;
+	u32 access_bit_width;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(ex_extract_from_field);
@@ -694,16 +694,36 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 
 		return_ACPI_STATUS(AE_BUFFER_OVERFLOW);
 	}
+
 	ACPI_MEMSET(buffer, 0, buffer_length);
+	access_bit_width = ACPI_MUL_8(obj_desc->common_field.access_byte_width);
+
+	/* Handle the simple case here */
+
+	if ((obj_desc->common_field.start_field_bit_offset == 0) &&
+	    (obj_desc->common_field.bit_length == access_bit_width)) {
+		status = acpi_ex_field_datum_io(obj_desc, 0, buffer, ACPI_READ);
+		return_ACPI_STATUS(status);
+	}
+
+/* TBD: Move to common setup code */
+
+	/* Field algorithm is limited to sizeof(u64), truncate if needed */
+
+	if (obj_desc->common_field.access_byte_width > sizeof(u64)) {
+		obj_desc->common_field.access_byte_width = sizeof(u64);
+		access_bit_width = sizeof(u64) * 8;
+	}
 
 	/* Compute the number of datums (access width data items) */
 
-	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+	datum_count =
+	    ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
+			     access_bit_width);
+
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
-					     obj_desc->common_field.
 					     access_bit_width);
 
 	/* Priming read from the field */
@@ -738,12 +758,11 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
-		     obj_desc->common_field.start_field_bit_offset) <
+		if (access_bit_width -
+		    obj_desc->common_field.start_field_bit_offset <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum |=
-			    raw_datum << (obj_desc->common_field.
-					  access_bit_width -
+			    raw_datum << (access_bit_width -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		}
@@ -765,8 +784,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 
 	/* Mask off any extra bits in the last datum */
 
-	buffer_tail_bits = obj_desc->common_field.bit_length %
-	    obj_desc->common_field.access_bit_width;
+	buffer_tail_bits = obj_desc->common_field.bit_length % access_bit_width;
 	if (buffer_tail_bits) {
 		merged_datum &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
@@ -798,6 +816,7 @@ acpi_status
 acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 			  void *buffer, u32 buffer_length)
 {
+	void *new_buffer;
 	acpi_status status;
 	u64 mask;
 	u64 width_mask;
@@ -808,9 +827,9 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	u32 buffer_tail_bits;
 	u32 datum_count;
 	u32 field_datum_count;
-	u32 i;
+	u32 access_bit_width;
 	u32 required_length;
-	void *new_buffer;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ex_insert_into_field);
 
@@ -844,17 +863,24 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		buffer_length = required_length;
 	}
 
+/* TBD: Move to common setup code */
+
+	/* Algo is limited to sizeof(u64), so cut the access_byte_width */
+	if (obj_desc->common_field.access_byte_width > sizeof(u64)) {
+		obj_desc->common_field.access_byte_width = sizeof(u64);
+	}
+
+	access_bit_width = ACPI_MUL_8(obj_desc->common_field.access_byte_width);
+
 	/*
 	 * Create the bitmasks used for bit insertion.
 	 * Note: This if/else is used to bypass compiler differences with the
 	 * shift operator
 	 */
-	if (obj_desc->common_field.access_bit_width == ACPI_INTEGER_BIT_SIZE) {
+	if (access_bit_width == ACPI_INTEGER_BIT_SIZE) {
 		width_mask = ACPI_UINT64_MAX;
 	} else {
-		width_mask =
-		    ACPI_MASK_BITS_ABOVE(obj_desc->common_field.
-					 access_bit_width);
+		width_mask = ACPI_MASK_BITS_ABOVE(access_bit_width);
 	}
 
 	mask = width_mask &
@@ -863,12 +889,11 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	/* Compute the number of datums (access width data items) */
 
 	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+				       access_bit_width);
 
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
-					     obj_desc->common_field.
 					     access_bit_width);
 
 	/* Get initial Datum from the input buffer */
@@ -905,12 +930,11 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
+		if ((access_bit_width -
 		     obj_desc->common_field.start_field_bit_offset) <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum =
-			    raw_datum >> (obj_desc->common_field.
-					  access_bit_width -
+			    raw_datum >> (access_bit_width -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		} else {
@@ -929,6 +953,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		ACPI_MEMCPY(&raw_datum, ((char *)buffer) + buffer_offset,
 			    ACPI_MIN(obj_desc->common_field.access_byte_width,
 				     buffer_length - buffer_offset));
+
 		merged_datum |=
 		    raw_datum << obj_desc->common_field.start_field_bit_offset;
 	}
@@ -937,7 +962,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 
 	buffer_tail_bits = (obj_desc->common_field.bit_length +
 			    obj_desc->common_field.start_field_bit_offset) %
-	    obj_desc->common_field.access_bit_width;
+	    access_bit_width;
 	if (buffer_tail_bits) {
 		mask &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 98a331d..fa51450 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -355,12 +355,10 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
 
-	/* Setup width (access granularity) fields */
+	/* Setup width (access granularity) fields (values are: 1, 2, 4, 8) */
 
 	obj_desc->common_field.access_byte_width = (u8)
-	    ACPI_DIV_8(access_bit_width);	/* 1,  2,  4,  8 */
-
-	obj_desc->common_field.access_bit_width = (u8) access_bit_width;
+	    ACPI_DIV_8(access_bit_width);
 
 	/*
 	 * base_byte_offset is the address of the start of the field within the
@@ -405,8 +403,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 {
 	union acpi_operand_object *obj_desc;
 	union acpi_operand_object *second_desc = NULL;
-	u32 type;
 	acpi_status status;
+	u32 access_byte_width;
+	u32 type;
 
 	ACPI_FUNCTION_TRACE(ex_prep_field_value);
 
@@ -421,8 +420,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		type = acpi_ns_get_type(info->region_node);
 		if (type != ACPI_TYPE_REGION) {
 			ACPI_ERROR((AE_INFO,
-				    "Needed Region, found type 0x%X (%s)",
-				    type, acpi_ut_get_type_name(type)));
+				    "Needed Region, found type 0x%X (%s)", type,
+				    acpi_ut_get_type_name(type)));
 
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
@@ -438,7 +437,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 	/* Initialize areas of the object that are common to all fields */
 
 	obj_desc->common_field.node = info->field_node;
-	status = acpi_ex_prep_common_field_object(obj_desc, info->field_flags,
+	status = acpi_ex_prep_common_field_object(obj_desc,
+						  info->field_flags,
 						  info->attribute,
 						  info->field_bit_position,
 						  info->field_bit_length);
@@ -455,27 +455,27 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		obj_desc->field.region_obj =
 		    acpi_ns_get_attached_object(info->region_node);
 
-		/* An additional reference for the container */
+		/* Allow full data read from EC address space */
 
-		acpi_ut_add_reference(obj_desc->field.region_obj);
+		if ((obj_desc->field.region_obj->region.space_id ==
+		     ACPI_ADR_SPACE_EC)
+		    && (obj_desc->common_field.bit_length > 8)) {
+			access_byte_width =
+			    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.
+							bit_length);
 
-		/* allow full data read from EC address space */
-		if (obj_desc->field.region_obj->region.space_id ==
-			ACPI_ADR_SPACE_EC) {
-			if (obj_desc->common_field.bit_length > 8) {
-				unsigned width =
-					ACPI_ROUND_BITS_UP_TO_BYTES(
-					obj_desc->common_field.bit_length);
-				// access_bit_width is u8, don't overflow it
-				if (width > 8)
-					width = 8;
+			/* Maximum byte width supported is 255 */
+
+			if (access_byte_width < 256) {
 				obj_desc->common_field.access_byte_width =
-							width;
-				obj_desc->common_field.access_bit_width =
-							8 * width;
+				    (u8)access_byte_width;
 			}
 		}
 
+		/* An additional reference for the container */
+
+		acpi_ut_add_reference(obj_desc->field.region_obj);
+
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 				  "RegionField: BitOff %X, Off %X, Gran %X, Region %p\n",
 				  obj_desc->field.start_field_bit_offset,

>From b366308bad81572c55197500b8345b75fb6c7d4b Mon Sep 17 00:00:00 2001
From: Alexey Starikovskiy <astarikovskiy@suse.de>
Date: Wed, 26 May 2010 13:59:51 +0800
Subject: [PATCH 12/14] ACPICA: Optimization: Reduce the number of namespace walks

On control method exit, only walk the namespace if the method is
known to have created namespace objects outside of its local scope.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |   18 ++++++++++++++++--
 drivers/acpi/acpica/nsalloc.c  |   20 ++++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 0084633..64750ee 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -584,8 +584,22 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		 * want make the objects permanent.
 		 */
 		if (!(method_desc->method.flags & AOPOBJ_MODULE_LEVEL)) {
-			acpi_ns_delete_namespace_by_owner(method_desc->method.
-							  owner_id);
+
+			/* Delete any direct children of (created by) this method */
+
+			acpi_ns_delete_namespace_subtree(walk_state->
+							 method_node);
+
+			/*
+			 * Delete any objects that were created by this method
+			 * elsewhere in the namespace (if any were created).
+			 */
+			if (method_desc->method.
+			    flags & AOPOBJ_MODIFIED_NAMESPACE) {
+				acpi_ns_delete_namespace_by_owner(method_desc->
+								  method.
+								  owner_id);
+			}
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 8d3a43a..1e5ff80 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -219,12 +219,24 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 
 	ACPI_FUNCTION_TRACE(ns_install_node);
 
-	/*
-	 * Get the owner ID from the Walk state. The owner ID is used to track
-	 * table deletion and deletion of objects created by methods.
-	 */
 	if (walk_state) {
+		/*
+		 * Get the owner ID from the Walk state. The owner ID is used to
+		 * track table deletion and deletion of objects created by methods.
+		 */
 		owner_id = walk_state->owner_id;
+
+		if ((walk_state->method_desc) &&
+		    (parent_node != walk_state->method_node)) {
+			/*
+			 * A method is creating a new node that is not a child of the
+			 * method (it is non-local). Mark the executing method as having
+			 * modified the namespace. This is used for cleanup when the
+			 * method exits.
+			 */
+			walk_state->method_desc->method.flags |=
+			    AOPOBJ_MODIFIED_NAMESPACE;
+		}
 	}
 
 	/* Link the new entry into the parent and existing children */

>From ec5bbf3c41745c11eafb7b7ab65c2a4f381842af Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 31 May 2010 09:22:12 +0800
Subject: [PATCH 13/14] ACPICA: Add signatures for undefined tables: ATKG, GSCI, IEIT

These ACPI tables have been seen in the field, but the actual
table definitions are unkown at this time.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/actbl2.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 95f4d0e..0a600b8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -79,6 +79,15 @@
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
 
+#ifdef ACPI_UNDEFINED_TABLES
+/*
+ * These tables have been seen in the field, but no definition has been found
+ */
+#define ACPI_SIG_ATKG           "ATKG"
+#define ACPI_SIG_GSCI           "GSCI"	/* GMCH SCI table */
+#define ACPI_SIG_IEIT           "IEIT"
+#endif
+
 /*
  * All tables must be byte-packed to match the ACPI specification, since
  * the tables are provided by the system BIOS.

>From 41169ed44c029f223760a2e3e68f0aa2ceb7ae6e Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 31 May 2010 09:23:22 +0800
Subject: [PATCH 14/14] ACPICA: Update version to 20100528

Version 20100528.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1371cc9..8aaa596 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20100428
+#define ACPI_CA_VERSION                 0x20100528
 
 #include "actypes.h"
 #include "actbl.h"


--=-fC7D7GIIs9htSQr424Ez--

