From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/27] ACPICA: Eliminate superfluous return_UINT8 and return_UINT32 macros.
Date: Mon, 31 Dec 2012 08:06:16 +0800
Message-ID: <f3c70762d637d86e9d10e1ca8c0cebdd40e14182.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3507 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAG0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:26 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

These macros were implemented the same as return_VALUE and thus
they were not needed.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h  |    7 -------
 drivers/acpi/acpica/dsutils.c   |   10 +++++-----
 drivers/acpi/acpica/evgpe.c     |    6 +++---
 drivers/acpi/acpica/evsci.c     |    4 ++--
 drivers/acpi/acpica/exprep.c    |    4 ++--
 drivers/acpi/acpica/exutils.c   |    4 ++--
 drivers/acpi/acpica/hwacpi.c    |    8 ++++----
 drivers/acpi/acpica/nsutils.c   |    8 ++++----
 drivers/acpi/acpica/psargs.c    |    2 +-
 drivers/acpi/acpica/utaddress.c |    4 ++--
 10 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index cd96135..81f3cf7 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -469,11 +469,6 @@
 #define return_VALUE(value) \
 	ACPI_TRACE_EXIT (acpi_ut_value_exit, (u64), value)
 
-/* These exit macros are superfluous and should be removed entirely */
-
-#define return_UINT8        return_VALUE
-#define return_UINT32       return_VALUE
-
 /* Conditional execution */
 
 #define ACPI_DEBUG_EXEC(a)              a
@@ -515,8 +510,6 @@
 #define return_VOID                     return
 #define return_ACPI_STATUS(s)           return(s)
 #define return_VALUE(s)                 return(s)
-#define return_UINT8(s)                 return(s)
-#define return_UINT32(s)                return(s)
 #define return_PTR(s)                   return(s)
 
 #endif				/* ACPI_DEBUG_OUTPUT */
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index afeb99f..466f5f2 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -178,7 +178,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 
 	if (!op) {
 		ACPI_ERROR((AE_INFO, "Null Op"));
-		return_UINT8(TRUE);
+		return_VALUE(TRUE);
 	}
 
 	/*
@@ -210,7 +210,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 				  "At Method level, result of [%s] not used\n",
 				  acpi_ps_get_opcode_name(op->common.
 							  aml_opcode)));
-		return_UINT8(FALSE);
+		return_VALUE(FALSE);
 	}
 
 	/* Get info on the parent. The root_op is AML_SCOPE */
@@ -219,7 +219,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 	    acpi_ps_get_opcode_info(op->common.parent->common.aml_opcode);
 	if (parent_info->class == AML_CLASS_UNKNOWN) {
 		ACPI_ERROR((AE_INFO, "Unknown parent opcode Op=%p", op));
-		return_UINT8(FALSE);
+		return_VALUE(FALSE);
 	}
 
 	/*
@@ -307,7 +307,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 			  acpi_ps_get_opcode_name(op->common.parent->common.
 						  aml_opcode), op));
 
-	return_UINT8(TRUE);
+	return_VALUE(TRUE);
 
       result_not_used:
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
@@ -316,7 +316,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 			  acpi_ps_get_opcode_name(op->common.parent->common.
 						  aml_opcode), op));
 
-	return_UINT8(FALSE);
+	return_VALUE(FALSE);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 4cbb600..052d4c8 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -707,7 +707,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
 					"Unable to clear GPE%02X", gpe_number));
-			return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
+			return_VALUE(ACPI_INTERRUPT_NOT_HANDLED);
 		}
 	}
 
@@ -724,7 +724,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Unable to disable GPE%02X", gpe_number));
-		return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
+		return_VALUE(ACPI_INTERRUPT_NOT_HANDLED);
 	}
 
 	/*
@@ -784,7 +784,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		break;
 	}
 
-	return_UINT32(ACPI_INTERRUPT_HANDLED);
+	return_VALUE(ACPI_INTERRUPT_HANDLED);
 }
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index f9661e2..6c90f15 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -89,7 +89,7 @@ static u32 ACPI_SYSTEM_XFACE acpi_ev_sci_xrupt_handler(void *context)
 	 */
 	interrupt_handled |= acpi_ev_gpe_detect(gpe_xrupt_list);
 
-	return_UINT32(interrupt_handled);
+	return_VALUE(interrupt_handled);
 }
 
 /*******************************************************************************
@@ -120,7 +120,7 @@ u32 ACPI_SYSTEM_XFACE acpi_ev_gpe_xrupt_handler(void *context)
 
 	interrupt_handled |= acpi_ev_gpe_detect(gpe_xrupt_list);
 
-	return_UINT32(interrupt_handled);
+	return_VALUE(interrupt_handled);
 }
 
 /******************************************************************************
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index ba9db4d..60ee5e9 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -276,7 +276,7 @@ acpi_ex_decode_field_access(union acpi_operand_object *obj_desc,
 		/* Invalid field access type */
 
 		ACPI_ERROR((AE_INFO, "Unknown field access type 0x%X", access));
-		return_UINT32(0);
+		return_VALUE(0);
 	}
 
 	if (obj_desc->common.type == ACPI_TYPE_BUFFER_FIELD) {
@@ -289,7 +289,7 @@ acpi_ex_decode_field_access(union acpi_operand_object *obj_desc,
 	}
 
 	*return_byte_alignment = byte_alignment;
-	return_UINT32(bit_length);
+	return_VALUE(bit_length);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 264d22d..02ddc4c 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -336,7 +336,7 @@ static u32 acpi_ex_digits_needed(u64 value, u32 base)
 	/* u64 is unsigned, so we don't worry about a '-' prefix */
 
 	if (value == 0) {
-		return_UINT32(1);
+		return_VALUE(1);
 	}
 
 	current_value = value;
@@ -350,7 +350,7 @@ static u32 acpi_ex_digits_needed(u64 value, u32 base)
 		num_digits++;
 	}
 
-	return_UINT32(num_digits);
+	return_VALUE(num_digits);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index effa2b0..2613e29 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -151,18 +151,18 @@ u32 acpi_hw_get_mode(void)
 	 * system does not support mode transition.
 	 */
 	if (!acpi_gbl_FADT.smi_command) {
-		return_UINT32(ACPI_SYS_MODE_ACPI);
+		return_VALUE(ACPI_SYS_MODE_ACPI);
 	}
 
 	status = acpi_read_bit_register(ACPI_BITREG_SCI_ENABLE, &value);
 	if (ACPI_FAILURE(status)) {
-		return_UINT32(ACPI_SYS_MODE_LEGACY);
+		return_VALUE(ACPI_SYS_MODE_LEGACY);
 	}
 
 	if (value) {
-		return_UINT32(ACPI_SYS_MODE_ACPI);
+		return_VALUE(ACPI_SYS_MODE_ACPI);
 	} else {
-		return_UINT32(ACPI_SYS_MODE_LEGACY);
+		return_VALUE(ACPI_SYS_MODE_LEGACY);
 	}
 }
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 596d4cc..a771c8c 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -112,10 +112,10 @@ acpi_object_type acpi_ns_get_type(struct acpi_namespace_node * node)
 
 	if (!node) {
 		ACPI_WARNING((AE_INFO, "Null Node parameter"));
-		return_UINT32(ACPI_TYPE_ANY);
+		return_VALUE(ACPI_TYPE_ANY);
 	}
 
-	return_UINT32((acpi_object_type) node->type);
+	return_VALUE(node->type);
 }
 
 /*******************************************************************************
@@ -140,10 +140,10 @@ u32 acpi_ns_local(acpi_object_type type)
 		/* Type code out of range  */
 
 		ACPI_WARNING((AE_INFO, "Invalid Object Type 0x%X", type));
-		return_UINT32(ACPI_NS_NORMAL);
+		return_VALUE(ACPI_NS_NORMAL);
 	}
 
-	return_UINT32((u32) acpi_gbl_ns_properties[type] & ACPI_NS_LOCAL);
+	return_VALUE(acpi_gbl_ns_properties[type] & ACPI_NS_LOCAL);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 9f31893..9256513 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -108,7 +108,7 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 	/* Byte 0 is a special case, either bits [0:3] or [0:5] are used */
 
 	package_length |= (aml[0] & byte_zero_mask);
-	return_UINT32(package_length);
+	return_VALUE(package_length);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index 6488030..b86ef85 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -214,7 +214,7 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
 
 	if ((space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) &&
 	    (space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
-		return_UINT32(0);
+		return_VALUE(0);
 	}
 
 	range_info = acpi_gbl_address_range_list[space_id];
@@ -256,7 +256,7 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
 		range_info = range_info->next;
 	}
 
-	return_UINT32(overlap_count);
+	return_VALUE(overlap_count);
 }
 
 /*******************************************************************************
-- 
1.7.10

