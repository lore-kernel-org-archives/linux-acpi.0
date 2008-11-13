From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20081031 linuxized patch set
Date: Thu, 13 Nov 2008 13:59:16 +0800
Message-ID: <1226555956.30025.150.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qBDtPPPrvfRv296e6vsQ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1998 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbYKMGA6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 01:00:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, acpi <acpi@linux.intel.com>


--=-qBDtPPPrvfRv296e6vsQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Len

ACPICA Release 20081031 linuxized patch set attached.

This patch set includes everything of v20081031 except the changes of "public header files".
﻿BIF patch is also included.

We are going to send out the "public header files" patch
after all symbols (count_num_gpes, get_gpe_device, acpi_hw_low_level_write, acpi_hw_disable_all_gpes, etc)
are resolved.

This patch set can be cleanly applied to Linus tree.
Build under 32 & 64 bit machines, no warnings.
Tested under 64 bit machines with abat, it works fine.


Lin Ming

--=-qBDtPPPrvfRv296e6vsQ
Content-Disposition: attachment; filename=acpica.v20081031.mbox
Content-Type: application/mbox; name=acpica.v20081031.mbox
Content-Transfer-Encoding: 7bit

>From f0e419debd584d66fc3a6c1f20e6b133d6913da6 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 14:16:21 +0800
Subject: [PATCH 01/18] ACPICA: Fix several warnings under gcc 4 compiler

New compiler is pickier than older versions.
Joerg Sonnenberger. From ACPICA BZ 732.

http://www.acpica.org/bugzilla/show_bug.cgi?id=732

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/tables/tbfadt.c |    4 ++--
 include/acpi/actypes.h       |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 2817158..d2e60a8 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -48,7 +48,7 @@
 ACPI_MODULE_NAME("tbfadt")
 
 /* Local prototypes */
-static void inline
+static inline void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 byte_width, u64 address);
 
@@ -122,7 +122,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
  *
  ******************************************************************************/
 
-static void inline
+static inline void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 byte_width, u64 address)
 {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 7220361..a9719d6 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -291,7 +291,7 @@ typedef u32 acpi_physical_address;
 #endif
 
 /*
- * Mescellaneous types
+ * Miscellaneous types
  */
 typedef u32 acpi_status;	/* All ACPI Exceptions */
 typedef u32 acpi_name;		/* 4-byte ACPI name */
@@ -319,7 +319,7 @@ struct uint32_struct {
 #define acpi_semaphore                  void *
 
 /*
- * Acpi integer width. In ACPI version 1, integers are 32 bits.  In ACPI
+ * Acpi integer width. In ACPI version 1, integers are 32 bits. In ACPI
  * version 2, integers are 64 bits. Note that this pertains to the ACPI integer
  * type only, not other integers used in the implementation of the ACPI CA
  * subsystem.
@@ -414,7 +414,7 @@ typedef unsigned long long acpi_integer;
 #define ACPI_NOTIFY_MAX                 0x0B
 
 /*
- * Types associated with ACPI names and objects.  The first group of
+ * Types associated with ACPI names and objects. The first group of
  * values (up to ACPI_TYPE_EXTERNAL_MAX) correspond to the definition
  * of the ACPI object_type() operator (See the ACPI Spec). Therefore,
  * only add to the first group if the spec changes.
@@ -787,7 +787,7 @@ acpi_status(*acpi_exception_handler) (acpi_status aml_status,
 				      u16 opcode,
 				      u32 aml_offset, void *context);
 
-/* Table Event handler (Load, load_table etc) and types */
+/* Table Event handler (Load, load_table, etc.) and types */
 
 typedef
 acpi_status(*acpi_tbl_handler) (u32 event, void *table, void *context);

>From a43c09504ee42b2091de1429c28e8cf162b7d9d0 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 14:54:05 +0800
Subject: [PATCH 02/18] ACPICA: Update FACS waking vector interfaces

Split AcpiSetFirmwareWakingVector into two: one for the 32-bit
vector, another for the 64-bit vector. This is required because the
host OS must setup the wake much differently for each vector (real
vs. protected mode, etc.) and the interface should not be deciding
which vector to use.  Also eliminate the GetFirmwareWakingVector
interface, as it served no purpose (only the firmware reads the
vector, OS only writes the vector.)  ACPICA BZ 731.

http://www.acpica.org/bugzilla/show_bug.cgi?id=731

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   54 +++++++++++++++++++++++----------------
 include/acpi/acpixf.h           |    6 +---
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 25dccdf..6a30c80 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -52,16 +52,16 @@ ACPI_MODULE_NAME("hwsleep")
  *
  * FUNCTION:    acpi_set_firmware_waking_vector
  *
- * PARAMETERS:  physical_address    - Physical address of ACPI real mode
+ * PARAMETERS:  physical_address    - 32-bit physical address of ACPI real mode
  *                                    entry point.
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Access function for the firmware_waking_vector field in FACS
+ * DESCRIPTION: Sets the 32-bit firmware_waking_vector field of the FACS
  *
  ******************************************************************************/
 acpi_status
-acpi_set_firmware_waking_vector(acpi_physical_address physical_address)
+acpi_set_firmware_waking_vector(u32 physical_address)
 {
 	struct acpi_table_facs *facs;
 	acpi_status status;
@@ -85,10 +85,16 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address)
 	 * Protected Mode.  Some systems (for example HP dv5-1004nr) are known
 	 * to fail to resume if the 64-bit vector is used.
 	 */
-	if (facs->version >= 1)
-		facs->xfirmware_waking_vector = 0;
 
-	facs->firmware_waking_vector = (u32)physical_address;
+	/* Set the 32-bit vector */
+
+	facs->firmware_waking_vector = physical_address;
+
+	/* Clear the 64-bit vector if it exists */
+
+	if ((facs->length > 32) && (facs->version >= 1)) {
+		facs->xfirmware_waking_vector = 0;
+	}
 
 	return_ACPI_STATUS(AE_OK);
 }
@@ -97,29 +103,25 @@ ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_get_firmware_waking_vector
+ * FUNCTION:    acpi_set_firmware_waking_vector64
  *
- * PARAMETERS:  *physical_address   - Where the contents of
- *                                    the firmware_waking_vector field of
- *                                    the FACS will be returned.
+ * PARAMETERS:  physical_address    - 64-bit physical address of ACPI protected
+ *                                    mode entry point.
  *
- * RETURN:      Status, vector
+ * RETURN:      Status
  *
- * DESCRIPTION: Access function for the firmware_waking_vector field in FACS
+ * DESCRIPTION: Sets the 64-bit X_firmware_waking_vector field of the FACS, if
+ *              it exists in the table.
  *
  ******************************************************************************/
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
+acpi_set_firmware_waking_vector64(u64 physical_address)
 {
 	struct acpi_table_facs *facs;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE(acpi_get_firmware_waking_vector);
+	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
 
-	if (!physical_address) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
 
 	/* Get the FACS */
 
@@ -131,14 +133,22 @@ acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Get the vector */
-	*physical_address = (acpi_physical_address)facs->firmware_waking_vector;
+	/* Determine if the 64-bit vector actually exists */
+
+	if ((facs->length <= 32) || (facs->version < 1)) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
+	/* Clear 32-bit vector, set the 64-bit X_ vector */
+
+	facs->firmware_waking_vector = 0;
+	facs->xfirmware_waking_vector = physical_address;
 
 	return_ACPI_STATUS(AE_OK);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_get_firmware_waking_vector)
-#endif
+ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state_prep
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 33bc0e3..c9b903f 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -320,12 +320,10 @@ acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value);
 acpi_status acpi_set_register(u32 register_id, u32 value);
 
 acpi_status
-acpi_set_firmware_waking_vector(acpi_physical_address physical_address);
+acpi_set_firmware_waking_vector(u32 physical_address);
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_get_firmware_waking_vector(acpi_physical_address * physical_address);
-#endif
+acpi_set_firmware_waking_vector64(u64 physical_address);
 
 acpi_status
 acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);

>From e4de01b27cb84472d3eabe6c34fd4ec642bd61a1 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 14:56:59 +0800
Subject: [PATCH 03/18] ACPICA: Fix possible memory leak on error in parser

Fixes a possible memory leak if an allocation failure happens in
the parse loop. Must terminate an executing control method.
Lin Ming, Bob Moore. ACPICA BZ 489.

http://www.acpica.org/bugzilla/show_bug.cgi?id=489

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/parser/psparse.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 68e932f..dfd3d90 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -451,6 +451,14 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 
 	thread = acpi_ut_create_thread_state();
 	if (!thread) {
+		if (walk_state->method_desc) {
+
+			/* Executing a control method - additional cleanup */
+
+			acpi_ds_terminate_control_method(
+				walk_state->method_desc, walk_state);
+		}
+
 		acpi_ds_delete_walk_state(walk_state);
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}

>From a8d68ec4250cf17fe8f56378e3f77ef408a9fc58 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 15:02:00 +0800
Subject: [PATCH 04/18] ACPICA: Optimize execution of AML While loops

Previously, a control state object was allocated and freed for
each execution of the loop. The optimization is to simply reuse
the control state for each iteration. This speeds up the raw loop
execution time by about 5%.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/dispatcher/dsopcode.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 69fae59..5cd4066 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -1140,10 +1140,29 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 			  op->common.aml_opcode, walk_state));
 
 	switch (op->common.aml_opcode) {
-	case AML_IF_OP:
 	case AML_WHILE_OP:
 
 		/*
+		 * If this is an additional iteration of a while loop, continue.
+		 * There is no need to allocate a new control state.
+		 */
+		if (walk_state->control_state) {
+			if (walk_state->control_state->control.aml_predicate_start
+				== (walk_state->parser_state.aml - 1)) {
+
+				/* Reset the state to start-of-loop */
+
+				walk_state->control_state->common.state =
+				    ACPI_CONTROL_CONDITIONAL_EXECUTING;
+				break;
+			}
+		}
+
+		/*lint -fallthrough */
+
+	case AML_IF_OP:
+
+		/*
 		 * IF/WHILE: Create a new control state to manage these
 		 * constructs. We need to manage these as a stack, in order
 		 * to handle nesting.
@@ -1248,8 +1267,13 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 			/* Predicate was true, go back and evaluate it again! */
 
 			status = AE_CTRL_PENDING;
+			walk_state->aml_last_while =
+			    walk_state->control_state->control.aml_predicate_start;
+			break;
 		}
 
+		/* Predicate was false, terminate this while loop */
+
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 				  "[WHILE_OP] termination! Op=%p\n", op));
 
@@ -1257,9 +1281,6 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 		control_state =
 		    acpi_ut_pop_generic_state(&walk_state->control_state);
-
-		walk_state->aml_last_while =
-		    control_state->control.aml_predicate_start;
 		acpi_ut_delete_generic_state(control_state);
 		break;
 

>From 02156bf17a77d3afffc4be0cdf813bdd96b58acf Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 15:15:29 +0800
Subject: [PATCH 05/18] ACPICA: Add a mechanism to escape infinite AML While() loops

Add a loop counter to force exit from AML While loops if the
count becomes too large. This can occur in poorly written AML
when the hardware does not respond within a while loop and the
loop does not implement a timeout. The maximum loop count is
configurable. A new exception code is returned when a loop is
broken, AE_AML_INFINITE_LOOP.  Bob Moore, Alexey Starikovskiy.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/dispatcher/dsopcode.c |   24 +++++++++++++++++++++---
 include/acpi/acconfig.h            |    4 ++++
 include/acpi/acexcep.h             |    4 +++-
 include/acpi/aclocal.h             |    1 +
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index 5cd4066..50c892a 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -1262,13 +1262,31 @@ acpi_ds_exec_end_control_op(struct acpi_walk_state * walk_state,
 
 		ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "[WHILE_OP] Op=%p\n", op));
 
-		if (walk_state->control_state->common.value) {
+		control_state = walk_state->control_state;
+		if (control_state->common.value) {
 
-			/* Predicate was true, go back and evaluate it again! */
+			/* Predicate was true, the body of the loop was just executed */
 
+			/*
+			 * This loop counter mechanism allows the interpreter to escape
+			 * possibly infinite loops. This can occur in poorly written AML
+			 * when the hardware does not respond within a while loop and the
+			 * loop does not implement a timeout.
+			 */
+			control_state->control.loop_count++;
+			if (control_state->control.loop_count >
+				ACPI_MAX_LOOP_ITERATIONS) {
+				status = AE_AML_INFINITE_LOOP;
+				break;
+			}
+
+			/*
+			 * Go back and evaluate the predicate and maybe execute the loop
+			 * another time
+			 */
 			status = AE_CTRL_PENDING;
 			walk_state->aml_last_while =
-			    walk_state->control_state->control.aml_predicate_start;
+			    control_state->control.aml_predicate_start;
 			break;
 		}
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 29feee2..e50fe71 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -119,6 +119,10 @@
 
 #define ACPI_ROOT_TABLE_SIZE_INCREMENT  4
 
+/* Maximum number of While() loop iterations before forced abort */
+
+#define ACPI_MAX_LOOP_ITERATIONS        0xFFFF
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 84f5cb2..a1ae105 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -153,8 +153,9 @@
 #define AE_AML_CIRCULAR_REFERENCE       (acpi_status) (0x001E | AE_CODE_AML)
 #define AE_AML_BAD_RESOURCE_LENGTH      (acpi_status) (0x001F | AE_CODE_AML)
 #define AE_AML_ILLEGAL_ADDRESS          (acpi_status) (0x0020 | AE_CODE_AML)
+#define AE_AML_INFINITE_LOOP            (acpi_status) (0x0021 | AE_CODE_AML)
 
-#define AE_CODE_AML_MAX                 0x0020
+#define AE_CODE_AML_MAX                 0x0021
 
 /*
  * Internal exceptions used for control
@@ -267,6 +268,7 @@ char const *acpi_gbl_exception_names_aml[] = {
 	"AE_AML_CIRCULAR_REFERENCE",
 	"AE_AML_BAD_RESOURCE_LENGTH",
 	"AE_AML_ILLEGAL_ADDRESS",
+	"AE_AML_INFINITE_LOOP"
 };
 
 char const *acpi_gbl_exception_names_ctrl[] = {
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index ecab527..0323fa9 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -566,6 +566,7 @@ struct acpi_control_state {
 	union acpi_parse_object *predicate_op;
 	u8 *aml_predicate_start;	/* Start of if/while predicate */
 	u8 *package_end;	/* End of if/while block */
+	u32 loop_count;		/* While() loop counter */
 };
 
 /*

>From 5501a5126f3372a7410cddd44b97cecebf44f57c Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 15:16:49 +0800
Subject: [PATCH 06/18] ACPICA: Update debug output for IndexField I/O

Split the "data register I/O" with more informative read and
write messages.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/executer/exfldio.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/executer/exfldio.c b/drivers/acpi/executer/exfldio.c
index 9ff9d1f..94500c4 100644
--- a/drivers/acpi/executer/exfldio.c
+++ b/drivers/acpi/executer/exfldio.c
@@ -498,14 +498,13 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 			return_ACPI_STATUS(status);
 		}
 
-		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
-				  "I/O to Data Register: ValuePtr %p\n",
-				  value));
-
 		if (read_write == ACPI_READ) {
 
 			/* Read the datum from the data_register */
 
+			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
+					  "Read from Data Register\n"));
+
 			status =
 			    acpi_ex_extract_from_field(obj_desc->index_field.
 						       data_obj, value,
@@ -513,6 +512,10 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		} else {
 			/* Write the datum to the data_register */
 
+			ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
+					  "Write to Data Register: Value %8.8X%8.8X\n",
+					  ACPI_FORMAT_UINT64(*value)));
+
 			status =
 			    acpi_ex_insert_into_field(obj_desc->index_field.
 						      data_obj, value,

>From d73c7420b6d963d225a3f0c8b1e6a43760bae24c Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 15:17:41 +0800
Subject: [PATCH 07/18] ACPICA: Fix namestring for the SystemCMOS address space

This fixes the name of this address space, changing it from the
incorrect CMOS to the correct SystemCMOS.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/utilities/utglobal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 670551b..7b7f812 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -352,7 +352,7 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"PCI_Config",
 	"EmbeddedControl",
 	"SMBus",
-	"CMOS",
+	"SystemCMOS",
 	"PCIBARTarget",
 	"DataTable"
 };

>From b4c218543584976230e455ff662b12e5db852147 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 15:23:20 +0800
Subject: [PATCH 08/18] ACPICA: Emit warning if two FACS or DSDT tables found in the FADT

Checks if there are two valid but different addresses for the
FACS and DSDT within the FADT (mismatch between the 32-bit and
64-bit fields.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/tables/tbfadt.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index d2e60a8..14661a8 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -286,14 +286,27 @@ static void acpi_tb_convert_fadt(void)
 
 	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
 
-	/* Expand the 32-bit FACS and DSDT addresses to 64-bit as necessary */
-
+	/*
+	 * Expand the 32-bit FACS and DSDT addresses to 64-bit as necessary.
+	 * Later code will always use the X 64-bit field. Also, check for an
+	 * address mismatch between the 32-bit and 64-bit address fields
+	 * (FIRMWARE_CTRL/X_FIRMWARE_CTRL, DSDT/X_DSDT) which would indicate
+	 * the presence of two FACS or two DSDT tables.
+	 */
 	if (!acpi_gbl_FADT.Xfacs) {
 		acpi_gbl_FADT.Xfacs = (u64) acpi_gbl_FADT.facs;
+	} else if (acpi_gbl_FADT.facs &&
+		   (acpi_gbl_FADT.Xfacs != (u64) acpi_gbl_FADT.facs)) {
+		ACPI_WARNING((AE_INFO,
+		    "32/64 FACS address mismatch in FADT - two FACS tables!"));
 	}
 
 	if (!acpi_gbl_FADT.Xdsdt) {
 		acpi_gbl_FADT.Xdsdt = (u64) acpi_gbl_FADT.dsdt;
+	} else if (acpi_gbl_FADT.dsdt &&
+		   (acpi_gbl_FADT.Xdsdt != (u64) acpi_gbl_FADT.dsdt)) {
+		ACPI_WARNING((AE_INFO,
+		    "32/64 DSDT address mismatch in FADT - two DSDT tables!"));
 	}
 
 	/*

>From 2c00fa8e89ea27b14176ddb62358640e8e803a99 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 15:34:52 +0800
Subject: [PATCH 09/18] ACPICA: Add global pointer for FACS table to simplify FACS access

Use a global pointer instead of using AcpiGetTableByIndex for
each FACS access. This simplifies the code for the Global Lock
and the Firmware Waking Vector(s).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/events/evmisc.c      |   22 ++++++----------------
 drivers/acpi/hardware/hwsleep.c   |   37 ++++++-------------------------------
 drivers/acpi/tables/tbutils.c     |   24 ++++++++++++++++++++++++
 drivers/acpi/utilities/utglobal.c |    1 +
 drivers/acpi/utilities/utxface.c  |   11 +++++++++++
 include/acpi/acglobal.h           |    1 +
 include/acpi/actables.h           |    2 ++
 7 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 1d5670b..82c457f 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -49,11 +49,7 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evmisc")
 
-/* Pointer to FACS needed for the Global Lock */
-static struct acpi_table_facs *facs = NULL;
-
 /* Local prototypes */
-
 static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context);
 
 static u32 acpi_ev_global_lock_handler(void *context);
@@ -299,7 +295,7 @@ static u32 acpi_ev_global_lock_handler(void *context)
 	 * If we don't get it now, it will be marked pending and we will
 	 * take another interrupt when it becomes free.
 	 */
-	ACPI_ACQUIRE_GLOBAL_LOCK(facs, acquired);
+	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
 	if (acquired) {
 
 		/* Got the lock, now wake all threads waiting for it */
@@ -336,15 +332,8 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 
 	ACPI_FUNCTION_TRACE(ev_init_global_lock_handler);
 
-	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-					 ACPI_CAST_INDIRECT_PTR(struct
-								acpi_table_header,
-								&facs));
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	/* Attempt installation of the global lock handler */
 
-	acpi_gbl_global_lock_present = TRUE;
 	status = acpi_install_fixed_event_handler(ACPI_EVENT_GLOBAL,
 						  acpi_ev_global_lock_handler,
 						  NULL);
@@ -361,9 +350,10 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 			    "No response from Global Lock hardware, disabling lock"));
 
 		acpi_gbl_global_lock_present = FALSE;
-		status = AE_OK;
+		return_ACPI_STATUS(AE_OK);
 	}
 
+	acpi_gbl_global_lock_present = TRUE;
 	return_ACPI_STATUS(status);
 }
 
@@ -472,7 +462,7 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 
 	/* Attempt to acquire the actual hardware lock */
 
-	ACPI_ACQUIRE_GLOBAL_LOCK(facs, acquired);
+	ACPI_ACQUIRE_GLOBAL_LOCK(acpi_gbl_FACS, acquired);
 	if (acquired) {
 
 		/* We got the lock */
@@ -536,7 +526,7 @@ acpi_status acpi_ev_release_global_lock(void)
 
 		/* Allow any thread to release the lock */
 
-		ACPI_RELEASE_GLOBAL_LOCK(facs, pending);
+		ACPI_RELEASE_GLOBAL_LOCK(acpi_gbl_FACS, pending);
 
 		/*
 		 * If the pending bit was set, we must write GBL_RLS to the control
diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 6a30c80..5ec727f 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -63,20 +63,8 @@ ACPI_MODULE_NAME("hwsleep")
 acpi_status
 acpi_set_firmware_waking_vector(u32 physical_address)
 {
-	struct acpi_table_facs *facs;
-	acpi_status status;
-
 	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
 
-	/* Get the FACS */
-
-	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-					 ACPI_CAST_INDIRECT_PTR(struct
-								acpi_table_header,
-								&facs));
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 
 	/*
 	 * According to the ACPI specification 2.0c and later, the 64-bit
@@ -88,12 +76,12 @@ acpi_set_firmware_waking_vector(u32 physical_address)
 
 	/* Set the 32-bit vector */
 
-	facs->firmware_waking_vector = physical_address;
+	acpi_gbl_FACS->firmware_waking_vector = physical_address;
 
 	/* Clear the 64-bit vector if it exists */
 
-	if ((facs->length > 32) && (facs->version >= 1)) {
-		facs->xfirmware_waking_vector = 0;
+	if ((acpi_gbl_FACS->length > 32) && (acpi_gbl_FACS->version >= 1)) {
+		acpi_gbl_FACS->xfirmware_waking_vector = 0;
 	}
 
 	return_ACPI_STATUS(AE_OK);
@@ -117,32 +105,19 @@ ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector)
 acpi_status
 acpi_set_firmware_waking_vector64(u64 physical_address)
 {
-	struct acpi_table_facs *facs;
-	acpi_status status;
-
 	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
 
 
-	/* Get the FACS */
-
-	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
-					 ACPI_CAST_INDIRECT_PTR(struct
-								acpi_table_header,
-								&facs));
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Determine if the 64-bit vector actually exists */
 
-	if ((facs->length <= 32) || (facs->version < 1)) {
+	if ((acpi_gbl_FACS->length <= 32) || (acpi_gbl_FACS->version < 1)) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
 	/* Clear 32-bit vector, set the 64-bit X_ vector */
 
-	facs->firmware_waking_vector = 0;
-	facs->xfirmware_waking_vector = physical_address;
+	acpi_gbl_FACS->firmware_waking_vector = 0;
+	acpi_gbl_FACS->xfirmware_waking_vector = physical_address;
 
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 0cc92ef..50e6777 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -113,6 +113,30 @@ acpi_tb_check_xsdt(acpi_physical_address address)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_tb_initialize_facs
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Create a permanent mapping for the FADT and save it in a global
+ *              for accessing the Global Lock and Firmware Waking Vector
+ *
+ ******************************************************************************/
+
+acpi_status acpi_tb_initialize_facs(void)
+{
+	acpi_status status;
+
+	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+					 ACPI_CAST_INDIRECT_PTR(struct
+								acpi_table_header,
+								&acpi_gbl_FACS));
+	return status;
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_tb_tables_loaded
  *
  * PARAMETERS:  None
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 7b7f812..f06a2aa 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -771,6 +771,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_global_lock_mutex = NULL;
 	acpi_gbl_global_lock_acquired = FALSE;
 	acpi_gbl_global_lock_handle = 0;
+	acpi_gbl_global_lock_present = FALSE;
 
 	/* Miscellaneous variables */
 
diff --git a/drivers/acpi/utilities/utxface.c b/drivers/acpi/utilities/utxface.c
index c198a4d..7ca8952 100644
--- a/drivers/acpi/utilities/utxface.c
+++ b/drivers/acpi/utilities/utxface.c
@@ -45,6 +45,7 @@
 #include <acpi/acevents.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acdebug.h>
+#include <acpi/actables.h>
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utxface")
@@ -148,6 +149,16 @@ acpi_status acpi_enable_subsystem(u32 flags)
 	}
 
 	/*
+	 * Obtain a permanent mapping for the FACS. This is required for the
+	 * Global Lock and the Firmware Waking Vector
+	 */
+	status = acpi_tb_initialize_facs();
+	if (ACPI_FAILURE(status)) {
+		ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
+		return_ACPI_STATUS(status);
+	}
+
+	/*
 	 * Install the default op_region handlers. These are installed unless
 	 * other handlers have already been installed via the
 	 * install_address_space_handler interface.
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 15dda46..77d73a4 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -140,6 +140,7 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
+ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
 extern u8 acpi_gbl_permanent_mmap;
 
 /* These addresses are calculated from FADT address values */
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 0cbe1b9..7ce6e33 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -94,6 +94,8 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded);
 /*
  * tbutils - table manager utilities
  */
+acpi_status acpi_tb_initialize_facs(void);
+
 u8 acpi_tb_tables_loaded(void);
 
 void

>From d6a657d5c02800d1480a40e265755f7260b4ffff Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Nov 2008 16:01:56 +0800
Subject: [PATCH 10/18] ACPICA: Reformat comments, no functional changes

Reformat comments to use fewer lines.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/events/evevent.c  |   14 ++--
 drivers/acpi/events/evgpe.c    |   36 ++++++------
 drivers/acpi/events/evgpeblk.c |   38 ++++++------
 drivers/acpi/events/evmisc.c   |   29 ++++-----
 drivers/acpi/events/evregion.c |  133 +++++++++++++++++++---------------------
 drivers/acpi/events/evrgnini.c |   41 ++++++-------
 drivers/acpi/events/evsci.c    |   10 +--
 drivers/acpi/events/evxface.c  |    2 +-
 drivers/acpi/events/evxfevnt.c |   12 ++--
 9 files changed, 152 insertions(+), 163 deletions(-)

diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index c56c5c6..6ddf938 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -72,8 +72,8 @@ acpi_status acpi_ev_initialize_events(void)
 
 	/*
 	 * Initialize the Fixed and General Purpose Events. This is done prior to
-	 * enabling SCIs to prevent interrupts from occurring before the handlers are
-	 * installed.
+	 * enabling SCIs to prevent interrupts from occurring before the handlers
+	 * are installed.
 	 */
 	status = acpi_ev_fixed_event_initialize();
 	if (ACPI_FAILURE(status)) {
@@ -192,8 +192,8 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 	acpi_status status;
 
 	/*
-	 * Initialize the structure that keeps track of fixed event handlers
-	 * and enable the fixed events.
+	 * Initialize the structure that keeps track of fixed event handlers and
+	 * enable the fixed events.
 	 */
 	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
 		acpi_gbl_fixed_event_handlers[i].handler = NULL;
@@ -237,7 +237,7 @@ u32 acpi_ev_fixed_event_detect(void)
 
 	/*
 	 * Read the fixed feature status and enable registers, as all the cases
-	 * depend on their values.  Ignore errors here.
+	 * depend on their values. Ignore errors here.
 	 */
 	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_STATUS, &fixed_status);
 	(void)acpi_hw_register_read(ACPI_REGISTER_PM1_ENABLE, &fixed_enable);
@@ -291,8 +291,8 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 				status_register_id, 1);
 
 	/*
-	 * Make sure we've got a handler.  If not, report an error.
-	 * The event is disabled to prevent further interrupts.
+	 * Make sure we've got a handler. If not, report an error. The event is
+	 * disabled to prevent further interrupts.
 	 */
 	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_set_register(acpi_gbl_fixed_event_info[event].
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index f45c74f..12b49d3 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -125,7 +125,7 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info,
 	    (1 <<
 	     (gpe_event_info->gpe_number - gpe_register_info->base_gpe_number));
 
-	/* 1) Disable case.  Simply clear all enable bits */
+	/* 1) Disable case. Simply clear all enable bits */
 
 	if (type == ACPI_GPE_DISABLE) {
 		ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake,
@@ -134,7 +134,7 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	/* 2) Enable case.  Set/Clear the appropriate enable bits */
+	/* 2) Enable case. Set/Clear the appropriate enable bits */
 
 	switch (gpe_event_info->flags & ACPI_GPE_TYPE_MASK) {
 	case ACPI_GPE_TYPE_WAKE:
@@ -295,7 +295,7 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
  *
  * FUNCTION:    acpi_ev_get_gpe_event_info
  *
- * PARAMETERS:  gpe_device          - Device node.  NULL for GPE0/GPE1
+ * PARAMETERS:  gpe_device          - Device node. NULL for GPE0/GPE1
  *              gpe_number          - Raw GPE number
  *
  * RETURN:      A GPE event_info struct. NULL if not a valid GPE
@@ -372,7 +372,7 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
  *
  * RETURN:      INTERRUPT_HANDLED or INTERRUPT_NOT_HANDLED
  *
- * DESCRIPTION: Detect if any GP events have occurred.  This function is
+ * DESCRIPTION: Detect if any GP events have occurred. This function is
  *              executed at interrupt level.
  *
  ******************************************************************************/
@@ -400,8 +400,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 
 	/*
 	 * We need to obtain the GPE lock for both the data structs and registers
-	 * Note: Not necessary to obtain the hardware lock, since the GPE registers
-	 * are owned by the gpe_lock.
+	 * Note: Not necessary to obtain the hardware lock, since the GPE
+	 * registers are owned by the gpe_lock.
 	 */
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
@@ -410,9 +410,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 	gpe_block = gpe_xrupt_list->gpe_block_list_head;
 	while (gpe_block) {
 		/*
-		 * Read all of the 8-bit GPE status and enable registers
-		 * in this GPE block, saving all of them.
-		 * Find all currently active GP events.
+		 * Read all of the 8-bit GPE status and enable registers in this GPE
+		 * block, saving all of them. Find all currently active GP events.
 		 */
 		for (i = 0; i < gpe_block->register_count; i++) {
 
@@ -527,8 +526,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	(void)acpi_ev_enable_gpe(gpe_event_info, FALSE);
 
 	/*
-	 * Take a snapshot of the GPE info for this level - we copy the
-	 * info to prevent a race condition with remove_handler/remove_block.
+	 * Take a snapshot of the GPE info for this level - we copy the info to
+	 * prevent a race condition with remove_handler/remove_block.
 	 */
 	ACPI_MEMCPY(&local_gpe_event_info, gpe_event_info,
 		    sizeof(struct acpi_gpe_event_info));
@@ -539,8 +538,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	}
 
 	/*
-	 * Must check for control method type dispatch one more
-	 * time to avoid race with ev_gpe_install_handler
+	 * Must check for control method type dispatch one more time to avoid a
+	 * race with ev_gpe_install_handler
 	 */
 	if ((local_gpe_event_info.flags & ACPI_GPE_DISPATCH_MASK) ==
 	    ACPI_GPE_DISPATCH_METHOD) {
@@ -584,8 +583,8 @@ static void acpi_ev_asynch_enable_gpe(void *context)
 	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
 	    ACPI_GPE_LEVEL_TRIGGERED) {
 		/*
-		 * GPE is level-triggered, we clear the GPE status bit after
-		 * handling the event.
+		 * GPE is level-triggered, we clear the GPE status bit after handling
+		 * the event.
 		 */
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
@@ -624,7 +623,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 	acpi_os_gpe_count(gpe_number);
 
 	/*
-	 * If edge-triggered, clear the GPE status bit now.  Note that
+	 * If edge-triggered, clear the GPE status bit now. Note that
 	 * level-triggered events are cleared after the GPE is serviced.
 	 */
 	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) ==
@@ -650,7 +649,8 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 
 		/*
 		 * Invoke the installed handler (at interrupt level)
-		 * Ignore return status for now.  TBD: leave GPE disabled on error?
+		 * Ignore return status for now.
+		 * TBD: leave GPE disabled on error?
 		 */
 		(void)gpe_event_info->dispatch.handler->address(gpe_event_info->
 								dispatch.
@@ -708,7 +708,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 			    gpe_number));
 
 		/*
-		 * Disable the GPE. The GPE will remain disabled until the ACPI
+		 * Disable the GPE. The GPE will remain disabled until the ACPICA
 		 * Core Subsystem is restarted, or a handler is installed.
 		 */
 		status = acpi_ev_disable_gpe(gpe_event_info);
diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index 73c058e..7537cda 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -309,17 +309,17 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 	     (gpe_block->block_base_number +
 	      (gpe_block->register_count * 8)))) {
 		/*
-		 * Not valid for this GPE block, just ignore it
-		 * However, it may be valid for a different GPE block, since GPE0 and GPE1
-		 * methods both appear under \_GPE.
+		 * Not valid for this GPE block, just ignore it. However, it may be
+		 * valid for a different GPE block, since GPE0 and GPE1 methods both
+		 * appear under \_GPE.
 		 */
 		return_ACPI_STATUS(AE_OK);
 	}
 
 	/*
-	 * Now we can add this information to the gpe_event_info block
-	 * for use during dispatch of this GPE. Default type is RUNTIME, although
-	 * this may change when the _PRW methods are executed later.
+	 * Now we can add this information to the gpe_event_info block for use
+	 * during dispatch of this GPE. Default type is RUNTIME, although this may
+	 * change when the _PRW methods are executed later.
 	 */
 	gpe_event_info =
 	    &gpe_block->event_info[gpe_number - gpe_block->block_base_number];
@@ -394,8 +394,8 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 	gpe_block = gpe_info->gpe_block;
 
 	/*
-	 * The _PRW object must return a package, we are only interested
-	 * in the first element
+	 * The _PRW object must return a package, we are only interested in the
+	 * first element
 	 */
 	obj_desc = pkg_desc->package.elements[0];
 
@@ -434,7 +434,7 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 	/*
 	 * Is this GPE within this block?
 	 *
-	 * TRUE iff these conditions are true:
+	 * TRUE if and only if these conditions are true:
 	 *     1) The GPE devices match.
 	 *     2) The GPE index(number) is within the range of the Gpe Block
 	 *          associated with the GPE device.
@@ -457,6 +457,7 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 		if (ACPI_FAILURE(status)) {
 			goto cleanup;
 		}
+
 		status =
 		    acpi_ev_update_gpe_enable_masks(gpe_event_info,
 						    ACPI_GPE_DISABLE);
@@ -476,9 +477,9 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
  * RETURN:      A GPE interrupt block
  *
  * DESCRIPTION: Get or Create a GPE interrupt block. There is one interrupt
- *              block per unique interrupt level used for GPEs.
- *              Should be called only when the GPE lists are semaphore locked
- *              and not subject to change.
+ *              block per unique interrupt level used for GPEs. Should be
+ *              called only when the GPE lists are semaphore locked and not
+ *              subject to change.
  *
  ******************************************************************************/
 
@@ -608,8 +609,9 @@ acpi_ev_delete_gpe_xrupt(struct acpi_gpe_xrupt_info *gpe_xrupt)
  *
  * FUNCTION:    acpi_ev_install_gpe_block
  *
- * PARAMETERS:  gpe_block       - New GPE block
- *              interrupt_number - Xrupt to be associated with this GPE block
+ * PARAMETERS:  gpe_block               - New GPE block
+ *              interrupt_number        - Xrupt to be associated with this
+ *                                        GPE block
  *
  * RETURN:      Status
  *
@@ -666,7 +668,7 @@ acpi_ev_install_gpe_block(struct acpi_gpe_block_info *gpe_block,
  *
  * FUNCTION:    acpi_ev_delete_gpe_block
  *
- * PARAMETERS:  gpe_block       - Existing GPE block
+ * PARAMETERS:  gpe_block           - Existing GPE block
  *
  * RETURN:      Status
  *
@@ -786,9 +788,9 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 
 	/*
 	 * Initialize the GPE Register and Event structures. A goal of these
-	 * tables is to hide the fact that there are two separate GPE register sets
-	 * in a given GPE hardware block, the status registers occupy the first half,
-	 * and the enable registers occupy the second half.
+	 * tables is to hide the fact that there are two separate GPE register
+	 * sets in a given GPE hardware block, the status registers occupy the
+	 * first half, and the enable registers occupy the second half.
 	 */
 	this_register = gpe_register_info;
 	this_event = gpe_event_info;
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 82c457f..dbac5b3 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -148,7 +148,9 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 			break;
 
 		default:
+
 			/* All other types are not supported */
+
 			return (AE_TYPE);
 		}
 	}
@@ -189,9 +191,8 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 			acpi_ut_delete_generic_state(notify_info);
 		}
 	} else {
-		/*
-		 * There is no notify handler (per-device or system) for this device.
-		 */
+		/* There is no notify handler (per-device or system) for this device */
+
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No notify handler for Notify (%4.4s, %X) node %p\n",
 				  acpi_ut_get_node_name(node), notify_value,
@@ -225,9 +226,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
 	ACPI_FUNCTION_ENTRY();
 
 	/*
-	 * We will invoke a global notify handler if installed.
-	 * This is done _before_ we invoke the per-device handler attached
-	 * to the device.
+	 * We will invoke a global notify handler if installed. This is done
+	 * _before_ we invoke the per-device handler attached to the device.
 	 */
 	if (notify_info->notify.value <= ACPI_MAX_SYS_NOTIFY) {
 
@@ -339,11 +339,10 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 						  NULL);
 
 	/*
-	 * If the global lock does not exist on this platform, the attempt
-	 * to enable GBL_STATUS will fail (the GBL_ENABLE bit will not stick)
-	 * Map to AE_OK, but mark global lock as not present.
-	 * Any attempt to actually use the global lock will be flagged
-	 * with an error.
+	 * If the global lock does not exist on this platform, the attempt to
+	 * enable GBL_STATUS will fail (the GBL_ENABLE bit will not stick).
+	 * Map to AE_OK, but mark global lock as not present. Any attempt to
+	 * actually use the global lock will be flagged with an error.
 	 */
 	if (status == AE_NO_HARDWARE_RESPONSE) {
 		ACPI_ERROR((AE_INFO,
@@ -452,8 +451,8 @@ acpi_status acpi_ev_acquire_global_lock(u16 timeout)
 	}
 
 	/*
-	 * Make sure that a global lock actually exists. If not, just treat
-	 * the lock as a standard mutex.
+	 * Make sure that a global lock actually exists. If not, just treat the
+	 * lock as a standard mutex.
 	 */
 	if (!acpi_gbl_global_lock_present) {
 		acpi_gbl_global_lock_acquired = TRUE;
@@ -572,8 +571,8 @@ void acpi_ev_terminate(void)
 
 	if (acpi_gbl_events_initialized) {
 		/*
-		 * Disable all event-related functionality.
-		 * In all cases, on error, print a message but obviously we don't abort.
+		 * Disable all event-related functionality. In all cases, on error,
+		 * print a message but obviously we don't abort.
 		 */
 
 		/* Disable all fixed events */
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index 236fbd1..3ddddbf 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -48,16 +48,8 @@
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evregion")
-#define ACPI_NUM_DEFAULT_SPACES     4
-static u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
-	ACPI_ADR_SPACE_SYSTEM_MEMORY,
-	ACPI_ADR_SPACE_SYSTEM_IO,
-	ACPI_ADR_SPACE_PCI_CONFIG,
-	ACPI_ADR_SPACE_DATA_TABLE
-};
 
 /* Local prototypes */
-
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -66,6 +58,17 @@ static acpi_status
 acpi_ev_install_handler(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value);
 
+/* These are the address spaces that will get default handlers */
+
+#define ACPI_NUM_DEFAULT_SPACES     4
+
+static u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
+	ACPI_ADR_SPACE_SYSTEM_MEMORY,
+	ACPI_ADR_SPACE_SYSTEM_IO,
+	ACPI_ADR_SPACE_PCI_CONFIG,
+	ACPI_ADR_SPACE_DATA_TABLE
+};
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_install_region_handlers
@@ -91,18 +94,19 @@ acpi_status acpi_ev_install_region_handlers(void)
 	}
 
 	/*
-	 * All address spaces (PCI Config, EC, SMBus) are scope dependent
-	 * and registration must occur for a specific device.
+	 * All address spaces (PCI Config, EC, SMBus) are scope dependent and
+	 * registration must occur for a specific device.
 	 *
-	 * In the case of the system memory and IO address spaces there is currently
-	 * no device associated with the address space.  For these we use the root.
+	 * In the case of the system memory and IO address spaces there is
+	 * currently no device associated with the address space. For these we
+	 * use the root.
 	 *
-	 * We install the default PCI config space handler at the root so
-	 * that this space is immediately available even though the we have
-	 * not enumerated all the PCI Root Buses yet.  This is to conform
-	 * to the ACPI specification which states that the PCI config
-	 * space must be always available -- even though we are nowhere
-	 * near ready to find the PCI root buses at this point.
+	 * We install the default PCI config space handler at the root so that
+	 * this space is immediately available even though the we have not
+	 * enumerated all the PCI Root Buses yet. This is to conform to the ACPI
+	 * specification which states that the PCI config space must be always
+	 * available -- even though we are nowhere near ready to find the PCI root
+	 * buses at this point.
 	 *
 	 * NOTE: We ignore AE_ALREADY_EXISTS because this means that a handler
 	 * has already been installed (via acpi_install_address_space_handler).
@@ -160,12 +164,11 @@ acpi_status acpi_ev_initialize_op_regions(void)
 		return_ACPI_STATUS(status);
 	}
 
-	/*
-	 * Run the _REG methods for op_regions in each default address space
-	 */
-	for (i = 0; i < ACPI_NUM_DEFAULT_SPACES; i++) {
+	/* Run the _REG methods for op_regions in each default address space */
 
-		/* TBD: Make sure handler is the DEFAULT handler, otherwise
+	for (i = 0; i < ACPI_NUM_DEFAULT_SPACES; i++) {
+		/*
+		 * TBD: Make sure handler is the DEFAULT handler, otherwise
 		 * _REG will have already been run.
 		 */
 		status = acpi_ev_execute_reg_methods(acpi_gbl_root_node,
@@ -318,13 +321,13 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	}
 
 	/*
-	 * It may be the case that the region has never been initialized
+	 * It may be the case that the region has never been initialized.
 	 * Some types of regions require special init code
 	 */
 	if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)) {
-		/*
-		 * This region has not been initialized yet, do it
-		 */
+
+		/* This region has not been initialized yet, do it */
+
 		region_setup = handler_desc->address_space.setup;
 		if (!region_setup) {
 
@@ -339,9 +342,9 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		}
 
 		/*
-		 * We must exit the interpreter because the region
-		 * setup will potentially execute control methods
-		 * (e.g., _REG method for this region)
+		 * We must exit the interpreter because the region setup will
+		 * potentially execute control methods (for example, the _REG method
+		 * for this region)
 		 */
 		acpi_ex_exit_interpreter();
 
@@ -364,9 +367,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(status);
 		}
 
-		/*
-		 * Region initialization may have been completed by region_setup
-		 */
+		/* Region initialization may have been completed by region_setup */
+
 		if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)) {
 			region_obj->region.flags |= AOPOBJ_SETUP_COMPLETE;
 
@@ -521,8 +523,8 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 			}
 
 			/*
-			 * If the region has been activated, call the setup handler
-			 * with the deactivate notification
+			 * If the region has been activated, call the setup handler with
+			 * the deactivate notification
 			 */
 			if (region_obj->region.flags & AOPOBJ_SETUP_COMPLETE) {
 				region_setup = handler_obj->address_space.setup;
@@ -668,8 +670,8 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 	}
 
 	/*
-	 * We only care about regions.and objects
-	 * that are allowed to have address space handlers
+	 * We only care about regions and objects that are allowed to have
+	 * address space handlers
 	 */
 	if ((node->type != ACPI_TYPE_DEVICE) &&
 	    (node->type != ACPI_TYPE_REGION) && (node != acpi_gbl_root_node)) {
@@ -710,9 +712,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 				/*
 				 * Since the object we found it on was a device, then it
 				 * means that someone has already installed a handler for
-				 * the branch of the namespace from this device on.  Just
+				 * the branch of the namespace from this device on. Just
 				 * bail out telling the walk routine to not traverse this
-				 * branch.  This preserves the scoping rule for handlers.
+				 * branch. This preserves the scoping rule for handlers.
 				 */
 				return (AE_CTRL_DEPTH);
 			}
@@ -723,9 +725,8 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 		}
 
 		/*
-		 * As long as the device didn't have a handler for this
-		 * space we don't care about it.  We just ignore it and
-		 * proceed.
+		 * As long as the device didn't have a handler for this space we
+		 * don't care about it. We just ignore it and proceed.
 		 */
 		return (AE_OK);
 	}
@@ -733,16 +734,14 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 	/* Object is a Region */
 
 	if (obj_desc->region.space_id != handler_obj->address_space.space_id) {
-		/*
-		 * This region is for a different address space
-		 * -- just ignore it
-		 */
+
+		/* This region is for a different address space, just ignore it */
+
 		return (AE_OK);
 	}
 
 	/*
-	 * Now we have a region and it is for the handler's address
-	 * space type.
+	 * Now we have a region and it is for the handler's address space type.
 	 *
 	 * First disconnect region for any previous handler (if any)
 	 */
@@ -786,9 +785,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	ACPI_FUNCTION_TRACE(ev_install_space_handler);
 
 	/*
-	 * This registration is valid for only the types below
-	 * and the root.  This is where the default handlers
-	 * get placed.
+	 * This registration is valid for only the types below and the root. This
+	 * is where the default handlers get placed.
 	 */
 	if ((node->type != ACPI_TYPE_DEVICE) &&
 	    (node->type != ACPI_TYPE_PROCESSOR) &&
@@ -848,8 +846,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	obj_desc = acpi_ns_get_attached_object(node);
 	if (obj_desc) {
 		/*
-		 * The attached device object already exists.
-		 * Make sure the handler is not already installed.
+		 * The attached device object already exists. Make sure the handler
+		 * is not already installed.
 		 */
 		handler_obj = obj_desc->device.handler;
 
@@ -864,8 +862,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 				    handler) {
 					/*
 					 * It is (relatively) OK to attempt to install the SAME
-					 * handler twice. This can easily happen
-					 * with PCI_Config space.
+					 * handler twice. This can easily happen with the
+					 * PCI_Config space.
 					 */
 					status = AE_SAME_HANDLER;
 					goto unlock_and_exit;
@@ -925,9 +923,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	/*
 	 * Install the handler
 	 *
-	 * At this point there is no existing handler.
-	 * Just allocate the object for the handler and link it
-	 * into the list.
+	 * At this point there is no existing handler. Just allocate the object
+	 * for the handler and link it into the list.
 	 */
 	handler_obj =
 	    acpi_ut_create_internal_object(ACPI_TYPE_LOCAL_ADDRESS_HANDLER);
@@ -1000,11 +997,10 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	ACPI_FUNCTION_TRACE(ev_execute_reg_methods);
 
 	/*
-	 * Run all _REG methods for all Operation Regions for this
-	 * space ID.  This is a separate walk in order to handle any
-	 * interdependencies between regions and _REG methods.  (i.e. handlers
-	 * must be installed for all regions of this Space ID before we
-	 * can run any _REG methods)
+	 * Run all _REG methods for all Operation Regions for this space ID. This
+	 * is a separate walk in order to handle any interdependencies between
+	 * regions and _REG methods. (i.e. handlers must be installed for all
+	 * regions of this Space ID before we can run any _REG methods)
 	 */
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
 					ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run,
@@ -1042,8 +1038,8 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 	}
 
 	/*
-	 * We only care about regions.and objects
-	 * that are allowed to have address space handlers
+	 * We only care about regions.and objects that are allowed to have address
+	 * space handlers
 	 */
 	if ((node->type != ACPI_TYPE_REGION) && (node != acpi_gbl_root_node)) {
 		return (AE_OK);
@@ -1062,10 +1058,9 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 	/* Object is a Region */
 
 	if (obj_desc->region.space_id != space_id) {
-		/*
-		 * This region is for a different address space
-		 * -- just ignore it
-		 */
+
+		/* This region is for a different address space, just ignore it */
+
 		return (AE_OK);
 	}
 
diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/events/evrgnini.c
index 6b94b38..f9e561e 100644
--- a/drivers/acpi/events/evrgnini.c
+++ b/drivers/acpi/events/evrgnini.c
@@ -233,9 +233,9 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 				if (ACPI_FAILURE(status)) {
 					if (status == AE_SAME_HANDLER) {
 						/*
-						 * It is OK if the handler is already installed on the root
-						 * bridge.  Still need to return a context object for the
-						 * new PCI_Config operation region, however.
+						 * It is OK if the handler is already installed on the
+						 * root bridge. Still need to return a context object
+						 * for the new PCI_Config operation region, however.
 						 */
 						status = AE_OK;
 					} else {
@@ -272,8 +272,8 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	}
 
 	/*
-	 * For PCI_Config space access, we need the segment, bus,
-	 * device and function numbers.  Acquire them here.
+	 * For PCI_Config space access, we need the segment, bus, device and
+	 * function numbers. Acquire them here.
 	 *
 	 * Find the parent device object. (This allows the operation region to be
 	 * within a subscope under the device, such as a control method.)
@@ -289,16 +289,16 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	}
 
 	/*
-	 * Get the PCI device and function numbers from the _ADR object
-	 * contained in the parent's scope.
+	 * Get the PCI device and function numbers from the _ADR object contained
+	 * in the parent's scope.
 	 */
 	status =
 	    acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR, pci_device_node,
 					    &pci_value);
 
 	/*
-	 * The default is zero, and since the allocation above zeroed
-	 * the data, just do nothing on failure.
+	 * The default is zero, and since the allocation above zeroed the data,
+	 * just do nothing on failure.
 	 */
 	if (ACPI_SUCCESS(status)) {
 		pci_id->device = ACPI_HIWORD(ACPI_LODWORD(pci_value));
@@ -382,9 +382,8 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 	struct acpi_compatible_id_list *cid;
 	u32 i;
 
-	/*
-	 * Get the _HID and check for a PCI Root Bridge
-	 */
+	/* Get the _HID and check for a PCI Root Bridge */
+
 	status = acpi_ut_execute_HID(node, &hid);
 	if (ACPI_FAILURE(status)) {
 		return (FALSE);
@@ -394,10 +393,8 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 		return (TRUE);
 	}
 
-	/*
-	 * The _HID did not match.
-	 * Get the _CID and check for a PCI Root Bridge
-	 */
+	/* The _HID did not match. Get the _CID and check for a PCI Root Bridge */
+
 	status = acpi_ut_execute_CID(node, &cid);
 	if (ACPI_FAILURE(status)) {
 		return (FALSE);
@@ -516,9 +513,9 @@ acpi_ev_default_region_setup(acpi_handle handle,
  *              Get the appropriate address space handler for a newly
  *              created region.
  *
- *              This also performs address space specific initialization.  For
+ *              This also performs address space specific initialization. For
  *              example, PCI regions must have an _ADR object that contains
- *              a PCI address in the scope of the definition.  This address is
+ *              a PCI address in the scope of the definition. This address is
  *              required to perform an access to PCI config space.
  *
  * MUTEX:       Interpreter should be unlocked, because we may run the _REG
@@ -572,7 +569,7 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 	if (ACPI_SUCCESS(status)) {
 		/*
 		 * The _REG method is optional and there can be only one per region
-		 * definition.  This will be executed when the handler is attached
+		 * definition. This will be executed when the handler is attached
 		 * or removed
 		 */
 		region_obj2->extra.method_REG = method_node;
@@ -670,10 +667,8 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 			}
 		}
 
-		/*
-		 * This node does not have the handler we need;
-		 * Pop up one level
-		 */
+		/* This node does not have the handler we need; Pop up one level */
+
 		node = acpi_ns_get_parent_node(node);
 	}
 
diff --git a/drivers/acpi/events/evsci.c b/drivers/acpi/events/evsci.c
index 2a8b778..b5fc805 100644
--- a/drivers/acpi/events/evsci.c
+++ b/drivers/acpi/events/evsci.c
@@ -115,10 +115,8 @@ u32 ACPI_SYSTEM_XFACE acpi_ev_gpe_xrupt_handler(void *context)
 	 * if this interrupt handler is installed, ACPI is enabled.
 	 */
 
-	/*
-	 * GPEs:
-	 * Check for and dispatch any GPEs that have occurred
-	 */
+	/* GPEs: Check for and dispatch any GPEs that have occurred */
+
 	interrupt_handled |= acpi_ev_gpe_detect(gpe_xrupt_list);
 
 	return_UINT32(interrupt_handled);
@@ -158,11 +156,11 @@ u32 acpi_ev_install_sci_handler(void)
  * RETURN:      E_OK if handler uninstalled OK, E_ERROR if handler was not
  *              installed to begin with
  *
- * DESCRIPTION: Remove the SCI interrupt handler.  No further SCIs will be
+ * DESCRIPTION: Remove the SCI interrupt handler. No further SCIs will be
  *              taken.
  *
  * Note:  It doesn't seem important to disable all events or set the event
- *        enable registers to their original values.  The OS should disable
+ *        enable registers to their original values. The OS should disable
  *        the SCI interrupt level when the handler is removed, so no more
  *        events will come in.
  *
diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 94a6efe..a286787 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -267,7 +267,7 @@ acpi_install_notify_handler(acpi_handle device,
 	/*
 	 * Root Object:
 	 * Registering a notify handler on the root object indicates that the
-	 * caller wishes to receive notifications for all objects.  Note that
+	 * caller wishes to receive notifications for all objects. Note that
 	 * only one <external> global handler can be regsitered (per notify type).
 	 */
 	if (device == ACPI_ROOT_OBJECT) {
diff --git a/drivers/acpi/events/evxfevnt.c b/drivers/acpi/events/evxfevnt.c
index 41554f7..669b8ca 100644
--- a/drivers/acpi/events/evxfevnt.c
+++ b/drivers/acpi/events/evxfevnt.c
@@ -161,8 +161,8 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 	}
 
 	/*
-	 * Enable the requested fixed event (by writing a one to the
-	 * enable register bit)
+	 * Enable the requested fixed event (by writing a one to the enable
+	 * register bit)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
@@ -343,8 +343,8 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
 	}
 
 	/*
-	 * Disable the requested fixed event (by writing a zero to the
-	 * enable register bit)
+	 * Disable the requested fixed event (by writing a zero to the enable
+	 * register bit)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].
@@ -396,8 +396,8 @@ acpi_status acpi_clear_event(u32 event)
 	}
 
 	/*
-	 * Clear the requested fixed event (By writing a one to the
-	 * status register bit)
+	 * Clear the requested fixed event (By writing a one to the status
+	 * register bit)
 	 */
 	status =
 	    acpi_set_register(acpi_gbl_fixed_event_info[event].

>From 577a48a3f3e8981278557fcb693a6ca05996c480 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 09:45:35 +0800
Subject: [PATCH 11/18] ACPICA: Add support to externally execute _OSI method

The current implemenation of _OSI within ACPICA only allows other
control methods to execute _OSI. This change allows the host
OS to execute _OSI via the AcpiEvaluateObject interface. _OSI
is a special method -- it does not exist in the AML code, it is
implemented within ACPICA.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    3 +++
 drivers/acpi/parser/psparse.c      |    4 ++++
 drivers/acpi/parser/psxface.c      |   17 +++++++++++++++++
 drivers/acpi/utilities/uteval.c    |    6 +++---
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 279a5a6..77b7039 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -412,6 +412,9 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 
 	if (obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
 		status = obj_desc->method.implementation(next_walk_state);
+		if (status == AE_OK) {
+			status = AE_CTRL_TERMINATE;
+		}
 	}
 
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index dfd3d90..5156203 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -447,6 +447,10 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			  walk_state, walk_state->parser_state.aml,
 			  walk_state->parser_state.aml_size));
 
+	if (!walk_state->parser_state.aml) {
+		return_ACPI_STATUS(AE_NULL_OBJECT);
+	}
+
 	/* Create and initialize a new thread state */
 
 	thread = acpi_ut_create_thread_state();
diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 270469a..4985ce5 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -45,6 +45,7 @@
 #include <acpi/acparser.h>
 #include <acpi/acdispat.h>
 #include <acpi/acinterp.h>
+#include <acpi/amlcode.h>
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psxface")
@@ -278,6 +279,22 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 		goto cleanup;
 	}
 
+	/* Invoke an internal method if necessary */
+
+	if (info->obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
+		status = info->obj_desc->method.implementation(walk_state);
+		info->return_object = walk_state->return_desc;
+
+		/* Cleanup states */
+
+		acpi_ds_scope_stack_clear(walk_state);
+		acpi_ps_cleanup_scope(&walk_state->parser_state);
+		acpi_ds_terminate_control_method(walk_state->method_desc,
+						 walk_state);
+		acpi_ds_delete_walk_state(walk_state);
+		goto cleanup;
+	}
+
 	/* Parse the AML */
 
 	status = acpi_ps_parse_aml(walk_state);
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index 352747e..df2b511 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -129,7 +129,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 			/* The interface is supported */
 
-			return_ACPI_STATUS(AE_CTRL_TERMINATE);
+			return_ACPI_STATUS(AE_OK);
 		}
 	}
 
@@ -143,13 +143,13 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 		/* The interface is supported */
 
-		return_ACPI_STATUS(AE_CTRL_TERMINATE);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* The interface is not supported */
 
 	return_desc->integer.value = 0;
-	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************

>From af962a13177518a19f4051e63c51ca090ba5e2f4 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 10:48:00 +0800
Subject: [PATCH 12/18] ACPICA: Remove references to obsolete ACPI_DUMP_APP

This define is no longer used.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/namespace/nsaccess.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index c39a7f6..29c7c27 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -165,12 +165,9 @@ acpi_status acpi_ns_root_initialize(void)
 
 				obj_desc->method.method_flags =
 				    AML_METHOD_INTERNAL_ONLY;
-
-#ifndef ACPI_DUMP_APP
 				obj_desc->method.implementation =
 				    acpi_ut_osi_implementation;
 #endif
-#endif
 				break;
 
 			case ACPI_TYPE_INTEGER:
@@ -521,11 +518,11 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 	}
 
 	/*
-	 * Search namespace for each segment of the name.  Loop through and
+	 * Search namespace for each segment of the name. Loop through and
 	 * verify (or add to the namespace) each name segment.
 	 *
 	 * The object type is significant only at the last name
-	 * segment.  (We don't care about the types along the path, only
+	 * segment. (We don't care about the types along the path, only
 	 * the type of the final target object.)
 	 */
 	this_search_type = ACPI_TYPE_ANY;

>From 8e82ae8edd61316adfd8b4a2d5975161ee56b3c4 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 10:51:49 +0800
Subject: [PATCH 13/18] ACPICA: Fix to allow aliases within ASL namepaths

Fixes a problem where the use of an alias within a namepath
would result in a not found error or cause the compiler to fault.
Also now allows forward references from the Alias operator itself.
ACPICA BZ 738.

http://www.acpica.org/bugzilla/show_bug.cgi?id=738

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/namespace/nsaccess.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index 29c7c27..35b0e46 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -588,6 +588,10 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			 * segments).
 			 */
 			if (this_node->type == ACPI_TYPE_LOCAL_ALIAS) {
+				if (!this_node->object) {
+					return_ACPI_STATUS(AE_NOT_EXIST);
+				}
+
 				if (acpi_ns_opens_scope
 				    (((struct acpi_namespace_node *)this_node->
 				      object)->type)) {

>From cfdb0b3ab111c5800fb57cb1f6fce02be98fc3d0 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 10:54:39 +0800
Subject: [PATCH 14/18] ACPICA: Allow multiple backslash prefix in namepaths

In a fully qualified namepath, allow multiple backslash prefixes.
This can happen because of the use of a double-backslash in strings
(since backslash is the escape character) causing confusion.
ACPICA BZ 739 Lin Ming.

http://www.acpica.org/bugzilla/show_bug.cgi?id=739

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/namespace/nsutils.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/namespace/nsutils.c b/drivers/acpi/namespace/nsutils.c
index b0817e1..337fb04 100644
--- a/drivers/acpi/namespace/nsutils.c
+++ b/drivers/acpi/namespace/nsutils.c
@@ -314,9 +314,15 @@ void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 	 *
 	 * strlen() + 1 covers the first name_seg, which has no path separator
 	 */
-	if (acpi_ns_valid_root_prefix(next_external_char[0])) {
+	if (acpi_ns_valid_root_prefix(*next_external_char)) {
 		info->fully_qualified = TRUE;
 		next_external_char++;
+
+		/* Skip redundant root_prefix, like \\_SB.PCI0.SBRG.EC0 */
+
+		while (acpi_ns_valid_root_prefix(*next_external_char)) {
+			next_external_char++;
+		}
 	} else {
 		/*
 		 * Handle Carat prefixes

>From c90210cf976910a1915dbdfbbfcce7a75f3422af Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 11:01:34 +0800
Subject: [PATCH 15/18] ACPICA: Allow _WAK method to return an Integer

This can happen if the _WAK method returns nothing (as per ACPI
1.0) but does return an integer if the implicit return mechanism
is enabled.  This is the only method that has this problem,
since it is also defined to return a package of two integers
(ACPI 1.0b+). In all other cases, if a method returns an object
when one was not expected, no warning is issued.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpredef.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpredef.h b/include/acpi/acpredef.h
index 619fb75..e6452db 100644
--- a/include/acpi/acpredef.h
+++ b/include/acpi/acpredef.h
@@ -346,7 +346,7 @@ static const union acpi_predefined_info predefined_names[] = {
 
 	/* Acpi 1.0 defined _WAK with no return value. Later, it was changed to return a package */
 
-	{.info = {"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_PACKAGE}},
+	{.info = {"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE}},
 	{.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2, 0, 0, 0}},	/* fixed (2 Int), but is optional */
 	{.ret_info = {0, 0, 0, 0, 0, 0}}	/* Table terminator */
 };

>From 67ddef5c0250a8847049a17d7a8dd5e2f73cdc59 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 11:08:59 +0800
Subject: [PATCH 16/18] ACPICA: Add Buffer->String conversion for predefined methods

For predefined methods (such as _BIF), add automatic conversion for
objects that are required to be a String, but a Buffer was found
instead. This can happen when reading string battery data from
an operation region, because it used to be difficult to convert
the data from buffer to string from within the ASL. Linux BZ 11822.

http://bugzilla.kernel.org/show_bug.cgi?id=11822

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/namespace/nseval.c   |    3 +-
 drivers/acpi/namespace/nspredef.c |  135 +++++++++++++++++++++++++++++-------
 include/acpi/acnamesp.h           |    2 +-
 3 files changed, 110 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 4cdf03a..738a451 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -282,8 +282,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 			 * the method on invalid return object.
 			 */
 			(void)acpi_ns_check_predefined_names(node,
-							     info->
-							     return_object);
+			     &info->return_object);
 		}
 
 		/* Mark the node as having been evaluated */
diff --git a/drivers/acpi/namespace/nspredef.c b/drivers/acpi/namespace/nspredef.c
index 0f17cf0..7d6ee09 100644
--- a/drivers/acpi/namespace/nspredef.c
+++ b/drivers/acpi/namespace/nspredef.c
@@ -72,7 +72,7 @@ ACPI_MODULE_NAME("nspredef")
 /* Local prototypes */
 static acpi_status
 acpi_ns_check_package(char *pathname,
-		      union acpi_operand_object *return_object,
+		      union acpi_operand_object **return_object_ptr,
 		      const union acpi_predefined_info *predefined);
 
 static acpi_status
@@ -82,13 +82,17 @@ acpi_ns_check_package_elements(char *pathname,
 
 static acpi_status
 acpi_ns_check_object_type(char *pathname,
-			  union acpi_operand_object *return_object,
+			  union acpi_operand_object **return_object_ptr,
 			  u32 expected_btypes, u32 package_index);
 
 static acpi_status
 acpi_ns_check_reference(char *pathname,
 			union acpi_operand_object *return_object);
 
+static acpi_status
+acpi_ns_repair_object(u32 expected_btypes,
+		      union acpi_operand_object **return_object_ptr);
+
 /*
  * Names for the types that can be returned by the predefined objects.
  * Used for warning messages. Must be in the same order as the ACPI_RTYPEs
@@ -108,8 +112,8 @@ static const char *acpi_rtype_names[] = {
  * FUNCTION:    acpi_ns_check_predefined_names
  *
  * PARAMETERS:  Node            - Namespace node for the method/object
- *              return_object   - Object returned from the evaluation of this
- *                                method/object
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
  *
  * RETURN:      Status
  *
@@ -119,8 +123,9 @@ static const char *acpi_rtype_names[] = {
 
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
-			       union acpi_operand_object *return_object)
+			       union acpi_operand_object **return_object_ptr)
 {
+	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status = AE_OK;
 	const union acpi_predefined_info *predefined;
 	char *pathname;
@@ -182,7 +187,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * Check that the type of the return object is what is expected for
 	 * this predefined name
 	 */
-	status = acpi_ns_check_object_type(pathname, return_object,
+	status = acpi_ns_check_object_type(pathname, return_object_ptr,
 					   predefined->info.expected_btypes,
 					   ACPI_NOT_PACKAGE);
 	if (ACPI_FAILURE(status)) {
@@ -193,7 +198,8 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 
 	if (ACPI_GET_OBJECT_TYPE(return_object) == ACPI_TYPE_PACKAGE) {
 		status =
-		    acpi_ns_check_package(pathname, return_object, predefined);
+		    acpi_ns_check_package(pathname, return_object_ptr,
+					  predefined);
 	}
 
       exit:
@@ -307,8 +313,8 @@ const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
  * FUNCTION:    acpi_ns_check_package
  *
  * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
- *              return_object   - Object returned from the evaluation of a
- *                                method or object
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
  *              Predefined      - Pointer to entry in predefined name table
  *
  * RETURN:      Status
@@ -320,9 +326,10 @@ const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
 
 static acpi_status
 acpi_ns_check_package(char *pathname,
-		      union acpi_operand_object *return_object,
+		      union acpi_operand_object **return_object_ptr,
 		      const union acpi_predefined_info *predefined)
 {
+	union acpi_operand_object *return_object = *return_object_ptr;
 	const union acpi_predefined_info *package;
 	union acpi_operand_object *sub_package;
 	union acpi_operand_object **elements;
@@ -408,7 +415,7 @@ acpi_ns_check_package(char *pathname,
 		 * elements must be of the same type
 		 */
 		for (i = 0; i < count; i++) {
-			status = acpi_ns_check_object_type(pathname, *elements,
+			status = acpi_ns_check_object_type(pathname, elements,
 							   package->ret_info.
 							   object_type1, i);
 			if (ACPI_FAILURE(status)) {
@@ -441,7 +448,7 @@ acpi_ns_check_package(char *pathname,
 
 				status =
 				    acpi_ns_check_object_type(pathname,
-							      *elements,
+							      elements,
 							      package->
 							      ret_info3.
 							      object_type[i],
@@ -454,7 +461,7 @@ acpi_ns_check_package(char *pathname,
 
 				status =
 				    acpi_ns_check_object_type(pathname,
-							      *elements,
+							      elements,
 							      package->
 							      ret_info3.
 							      tail_object_type,
@@ -471,7 +478,7 @@ acpi_ns_check_package(char *pathname,
 
 		/* First element is the (Integer) count of sub-packages to follow */
 
-		status = acpi_ns_check_object_type(pathname, *elements,
+		status = acpi_ns_check_object_type(pathname, elements,
 						   ACPI_RTYPE_INTEGER, 0);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -509,7 +516,7 @@ acpi_ns_check_package(char *pathname,
 			/* Each sub-object must be of type Package */
 
 			status =
-			    acpi_ns_check_object_type(pathname, sub_package,
+			    acpi_ns_check_object_type(pathname, &sub_package,
 						      ACPI_RTYPE_PACKAGE, i);
 			if (ACPI_FAILURE(status)) {
 				return (status);
@@ -567,12 +574,8 @@ acpi_ns_check_package(char *pathname,
 				for (j = 0; j < expected_count; j++) {
 					status =
 					    acpi_ns_check_object_type(pathname,
-								      sub_elements
-								      [j],
-								      package->
-								      ret_info2.
-								      object_type
-								      [j], j);
+						&sub_elements[j],
+						package->ret_info2.object_type[j], j);
 					if (ACPI_FAILURE(status)) {
 						return (status);
 					}
@@ -611,7 +614,7 @@ acpi_ns_check_package(char *pathname,
 
 				status =
 				    acpi_ns_check_object_type(pathname,
-							      *sub_elements,
+							      sub_elements,
 							      ACPI_RTYPE_INTEGER,
 							      0);
 				if (ACPI_FAILURE(status)) {
@@ -708,7 +711,7 @@ acpi_ns_check_package_elements(char *pathname,
 	 * The second group can have a count of zero.
 	 */
 	for (i = 0; i < count1; i++) {
-		status = acpi_ns_check_object_type(pathname, *this_element,
+		status = acpi_ns_check_object_type(pathname, this_element,
 						   type1, i);
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -717,7 +720,7 @@ acpi_ns_check_package_elements(char *pathname,
 	}
 
 	for (i = 0; i < count2; i++) {
-		status = acpi_ns_check_object_type(pathname, *this_element,
+		status = acpi_ns_check_object_type(pathname, this_element,
 						   type2, (i + count1));
 		if (ACPI_FAILURE(status)) {
 			return (status);
@@ -733,8 +736,8 @@ acpi_ns_check_package_elements(char *pathname,
  * FUNCTION:    acpi_ns_check_object_type
  *
  * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
- *              return_object   - Object return from the execution of this
- *                                method/object
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
  *              expected_btypes - Bitmap of expected return type(s)
  *              package_index   - Index of object within parent package (if
  *                                applicable - ACPI_NOT_PACKAGE otherwise)
@@ -748,9 +751,10 @@ acpi_ns_check_package_elements(char *pathname,
 
 static acpi_status
 acpi_ns_check_object_type(char *pathname,
-			  union acpi_operand_object *return_object,
+			  union acpi_operand_object **return_object_ptr,
 			  u32 expected_btypes, u32 package_index)
 {
+	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status = AE_OK;
 	u32 return_btype;
 	char type_buffer[48];	/* Room for 5 types */
@@ -814,6 +818,14 @@ acpi_ns_check_object_type(char *pathname,
 	/* Is the object one of the expected types? */
 
 	if (!(return_btype & expected_btypes)) {
+
+		/* Type mismatch -- attempt repair of the returned object */
+
+		status =
+		    acpi_ns_repair_object(expected_btypes, return_object_ptr);
+		if (ACPI_SUCCESS(status)) {
+			return (status);
+		}
 		goto type_error_exit;
 	}
 
@@ -898,3 +910,72 @@ acpi_ns_check_reference(char *pathname,
 
 	return (AE_AML_OPERAND_TYPE);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_repair_object
+ *
+ * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
+ *              return_object_ptr - Pointer to the object returned from the
+ *                                evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if repair was successful.
+ *
+ * DESCRIPTION: Attempt to repair/convert a return object of a type that was
+ *              not expected.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ns_repair_object(u32 expected_btypes,
+		      union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object *new_object;
+	acpi_size length;
+
+	switch (ACPI_GET_OBJECT_TYPE(return_object)) {
+	case ACPI_TYPE_BUFFER:
+
+		if (!(expected_btypes & ACPI_RTYPE_STRING)) {
+			return (AE_AML_OPERAND_TYPE);
+		}
+
+		/*
+		 * Have a Buffer, expected a String, convert. Use a to_string
+		 * conversion, no transform performed on the buffer data. The best
+		 * example of this is the _BIF method, where the string data from
+		 * the battery is often (incorrectly) returned as buffer object(s).
+		 */
+		length = 0;
+		while ((length < return_object->buffer.length) &&
+		       (return_object->buffer.pointer[length])) {
+			length++;
+		}
+
+		/* Allocate a new string object */
+
+		new_object = acpi_ut_create_string_object(length);
+		if (!new_object) {
+			return (AE_NO_MEMORY);
+		}
+
+		/*
+		 * Copy the raw buffer data with no transform. String is already NULL
+		 * terminated at Length+1.
+		 */
+		ACPI_MEMCPY(new_object->string.pointer,
+			    return_object->buffer.pointer, length);
+
+		/* Install the new return object */
+
+		acpi_ut_remove_reference(return_object);
+		*return_object_ptr = new_object;
+		return (AE_OK);
+
+	default:
+		break;
+	}
+
+	return (AE_AML_OPERAND_TYPE);
+}
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index db4e6f6..db1e290 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -182,7 +182,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info);
  */
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
-			       union acpi_operand_object *return_object);
+			       union acpi_operand_object **return_object);
 
 const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
 								    acpi_namespace_node

>From 1b5d3407d0edb4ebf49f8dd1d2f6453a8f95a818 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 11:19:24 +0800
Subject: [PATCH 17/18] ACPICA: Consolidate method arg count validation code

Merge the code that validates control method argument counts into
the predefined validation module. Eliminates possible multiple
warnings for incorrect counts.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/namespace/nseval.c   |   69 +++++-------------------
 drivers/acpi/namespace/nspredef.c |  106 ++++++++++++++++++++++++++++++-------
 include/acpi/acnamesp.h           |    3 +
 3 files changed, 104 insertions(+), 74 deletions(-)

diff --git a/drivers/acpi/namespace/nseval.c b/drivers/acpi/namespace/nseval.c
index 738a451..b95bfbb 100644
--- a/drivers/acpi/namespace/nseval.c
+++ b/drivers/acpi/namespace/nseval.c
@@ -89,6 +89,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 	/* Initialize the return value to an invalid object */
 
 	info->return_object = NULL;
+	info->param_count = 0;
 
 	/*
 	 * Get the actual namespace node for the target object. Handles these cases:
@@ -141,41 +142,17 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 			return_ACPI_STATUS(AE_NULL_OBJECT);
 		}
 
-		/*
-		 * Calculate the number of arguments being passed to the method
-		 */
+		/* Count the number of arguments being passed to the method */
 
-		info->param_count = 0;
 		if (info->parameters) {
-			while (info->parameters[info->param_count])
+			while (info->parameters[info->param_count]) {
+				if (info->param_count > ACPI_METHOD_MAX_ARG) {
+					return_ACPI_STATUS(AE_LIMIT);
+				}
 				info->param_count++;
+			}
 		}
 
-		/*
-		 * Warning if too few or too many arguments have been passed by the
-		 * caller. We don't want to abort here with an error because an
-		 * incorrect number of arguments may not cause the method to fail.
-		 * However, the method will fail if there are too few arguments passed
-		 * and the method attempts to use one of the missing ones.
-		 */
-
-		if (info->param_count < info->obj_desc->method.param_count) {
-			ACPI_WARNING((AE_INFO,
-				    "Insufficient arguments - "
-				    "method [%4.4s] needs %d, found %d",
-				    acpi_ut_get_node_name(info->resolved_node),
-				    info->obj_desc->method.param_count,
-				    info->param_count));
-		} else if (info->param_count >
-				info->obj_desc->method.param_count) {
-			ACPI_WARNING((AE_INFO,
-				      "Excess arguments - "
-				      "method [%4.4s] needs %d, found %d",
-				      acpi_ut_get_node_name(info->
-							    resolved_node),
-				      info->obj_desc->method.param_count,
-				      info->param_count));
-		}
 
 		ACPI_DUMP_PATHNAME(info->resolved_node, "Execute Method:",
 				   ACPI_LV_INFO, _COMPONENT);
@@ -264,31 +241,13 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 		}
 	}
 
-	/* Validation of return values for ACPI-predefined methods and objects */
-
-	if ((status == AE_OK) || (status == AE_CTRL_RETURN_VALUE)) {
-		/*
-		 * If this is the first evaluation, check the return value. This
-		 * ensures that any warnings will only be emitted during the very
-		 * first evaluation of the object.
-		 */
-		if (!(node->flags & ANOBJ_EVALUATED)) {
-			/*
-			 * Check for a predefined ACPI name. If found, validate the
-			 * returned object.
-			 *
-			 * Note: Ignore return status for now, emit warnings if there are
-			 * problems with the returned object. May change later to abort
-			 * the method on invalid return object.
-			 */
-			(void)acpi_ns_check_predefined_names(node,
-			     &info->return_object);
-		}
-
-		/* Mark the node as having been evaluated */
-
-		node->flags |= ANOBJ_EVALUATED;
-	}
+	/*
+	 * Check input argument count against the ASL-defined count for a method.
+	 * Also check predefined names: argument count and return value against
+	 * the ACPI specification. Some incorrect return value types are repaired.
+	 */
+	(void)acpi_ns_check_predefined_names(node, info->param_count,
+		status, &info->return_object);
 
 	/* Check if there is a return value that must be dealt with */
 
diff --git a/drivers/acpi/namespace/nspredef.c b/drivers/acpi/namespace/nspredef.c
index 7d6ee09..82a28d0 100644
--- a/drivers/acpi/namespace/nspredef.c
+++ b/drivers/acpi/namespace/nspredef.c
@@ -123,6 +123,8 @@ static const char *acpi_rtype_names[] = {
 
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
+			       u32 user_param_count,
+			       acpi_status return_status,
 			       union acpi_operand_object **return_object_ptr)
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
@@ -133,12 +135,6 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	/* Match the name for this method/object against the predefined list */
 
 	predefined = acpi_ns_check_for_predefined_name(node);
-	if (!predefined) {
-
-		/* Name was not one of the predefined names */
-
-		return (AE_OK);
-	}
 
 	/* Get the full pathname to the object, for use in error messages */
 
@@ -148,10 +144,37 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
 	/*
-	 * Check that the parameter count for this method is in accordance
-	 * with the ACPI specification.
+	 * Check that the parameter count for this method matches the ASL
+	 * definition. For predefined names, ensure that both the caller and
+	 * the method itself are in accordance with the ACPI specification.
 	 */
-	acpi_ns_check_parameter_count(pathname, node, predefined);
+	acpi_ns_check_parameter_count(pathname, node, user_param_count,
+				      predefined);
+
+	/* If not a predefined name, we cannot validate the return object */
+
+	if (!predefined) {
+		goto exit;
+	}
+
+	/* If the method failed, we cannot validate the return object */
+
+	if ((return_status != AE_OK) && (return_status != AE_CTRL_RETURN_VALUE)) {
+		goto exit;
+	}
+
+	/*
+	 * Only validate the return value on the first successful evaluation of
+	 * the method. This ensures that any warnings will only be emitted during
+	 * the very first evaluation of the method/object.
+	 */
+	if (node->flags & ANOBJ_EVALUATED) {
+		goto exit;
+	}
+
+	/* Mark the node as having been successfully evaluated */
+
+	node->flags |= ANOBJ_EVALUATED;
 
 	/*
 	 * If there is no return value, check if we require a return value for
@@ -176,7 +199,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	 * We have a return value, but if one wasn't expected, just exit, this is
 	 * not a problem
 	 *
-	 * For example, if "Implicit return value" is enabled, methods will
+	 * For example, if the "Implicit Return" feature is enabled, methods will
 	 * always return a value
 	 */
 	if (!predefined->info.expected_btypes) {
@@ -203,7 +226,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
       exit:
-	if (pathname) {
+	if (pathname != predefined->info.name) {
 		ACPI_FREE(pathname);
 	}
 
@@ -216,6 +239,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
  *
  * PARAMETERS:  Pathname        - Full pathname to the node (for error msgs)
  *              Node            - Namespace node for the method/object
+ *              user_param_count - Number of args passed in by the caller
  *              Predefined      - Pointer to entry in predefined name table
  *
  * RETURN:      None
@@ -229,32 +253,76 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 void
 acpi_ns_check_parameter_count(char *pathname,
 			      struct acpi_namespace_node *node,
+			      u32 user_param_count,
 			      const union acpi_predefined_info *predefined)
 {
 	u32 param_count;
 	u32 required_params_current;
 	u32 required_params_old;
 
-	/*
-	 * Check that the ASL-defined parameter count is what is expected for
-	 * this predefined name.
-	 *
-	 * Methods have 0-7 parameters. All other types have zero.
-	 */
+	/* Methods have 0-7 parameters. All other types have zero. */
+
 	param_count = 0;
 	if (node->type == ACPI_TYPE_METHOD) {
 		param_count = node->object->method.param_count;
 	}
 
-	/* Validate parameter count - allow two different legal counts (_SCP) */
+	/* Argument count check for non-predefined methods/objects */
+
+	if (!predefined) {
+		/*
+		 * Warning if too few or too many arguments have been passed by the
+		 * caller. An incorrect number of arguments may not cause the method
+		 * to fail. However, the method will fail if there are too few
+		 * arguments and the method attempts to use one of the missing ones.
+		 */
+		if (user_param_count < param_count) {
+			ACPI_WARNING((AE_INFO,
+				      "%s: Insufficient arguments - needs %d, found %d",
+				      pathname, param_count, user_param_count));
+		} else if (user_param_count > param_count) {
+			ACPI_WARNING((AE_INFO,
+				      "%s: Excess arguments - needs %d, found %d",
+				      pathname, param_count, user_param_count));
+		}
+		return;
+	}
+
+	/* Allow two different legal argument counts (_SCP, etc.) */
 
 	required_params_current = predefined->info.param_count & 0x0F;
 	required_params_old = predefined->info.param_count >> 4;
 
+	if (user_param_count != ACPI_UINT32_MAX) {
+
+		/* Validate the user-supplied parameter count */
+
+		if ((user_param_count != required_params_current) &&
+		    (user_param_count != required_params_old)) {
+			ACPI_WARNING((AE_INFO,
+				      "%s: Parameter count mismatch - caller passed %d, ACPI requires %d",
+				      pathname, user_param_count,
+				      required_params_current));
+		}
+	}
+
+	/*
+	 * Only validate the argument count on the first successful evaluation of
+	 * the method. This ensures that any warnings will only be emitted during
+	 * the very first evaluation of the method/object.
+	 */
+	if (node->flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	/*
+	 * Check that the ASL-defined parameter count is what is expected for
+	 * this predefined name.
+	 */
 	if ((param_count != required_params_current) &&
 	    (param_count != required_params_old)) {
 		ACPI_WARNING((AE_INFO,
-			      "%s: Parameter count mismatch - ASL declared %d, expected %d",
+			      "%s: Parameter count mismatch - ASL declared %d, ACPI requires %d",
 			      pathname, param_count, required_params_current));
 	}
 }
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index db1e290..46cb5b4 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -182,6 +182,8 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info);
  */
 acpi_status
 acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
+			       u32 user_param_count,
+			       acpi_status return_status,
 			       union acpi_operand_object **return_object);
 
 const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
@@ -191,6 +193,7 @@ const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
 void
 acpi_ns_check_parameter_count(char *pathname,
 			      struct acpi_namespace_node *node,
+			      u32 user_param_count,
 			      const union acpi_predefined_info *info);
 
 /*

>From 7d1cbe933a947ec8ea4172e7f3d71377739cdb90 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 13 Nov 2008 11:25:22 +0800
Subject: [PATCH 18/18] ACPICA: Enhance implicit return mechanism

For Windows compatibility, return an implicit integer of value
zero for methods that have no executable code. A default implicit
value of zero is provided for methods. Lin Ming.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/parser/psxface.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 4985ce5..41b0c8c 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -295,6 +295,22 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 		goto cleanup;
 	}
 
+	/*
+	 * Start method evaluation with an implicit return of zero.
+	 * This is done for Windows compatibility.
+	 */
+	if (acpi_gbl_enable_interpreter_slack) {
+		walk_state->implicit_return_obj =
+		    acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		if (!walk_state->implicit_return_obj) {
+			status = AE_NO_MEMORY;
+			acpi_ds_delete_walk_state(walk_state);
+			goto cleanup;
+		}
+
+		walk_state->implicit_return_obj->integer.value = 0;
+	}
+
 	/* Parse the AML */
 
 	status = acpi_ps_parse_aml(walk_state);


--=-qBDtPPPrvfRv296e6vsQ--

