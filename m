From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/26] ACPICA: Audit/update for ACPICA return macros and debug depth counter
Date: Wed, 31 Oct 2012 10:26:01 +0800
Message-ID: <02b89f7fb4f0d6c0d437c978641f4b9ea7935452.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21187 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202Ab2JaC0H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:26:07 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

1) Ensure that all functions that use the various TRACE macros
   also use the appropriate ACPICA return macros.
2) Ensure that all normal return statements surround the return
   expression (value) with parens.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dswload2.c |    4 ++--
 drivers/acpi/acpica/dswstate.c |    4 ++--
 drivers/acpi/acpica/evxfgpe.c  |    4 ++--
 drivers/acpi/acpica/exdebug.c  |    2 +-
 drivers/acpi/acpica/exmutex.c  |    2 +-
 drivers/acpi/acpica/exoparg6.c |    2 +-
 drivers/acpi/acpica/hwpci.c    |    4 ++--
 drivers/acpi/acpica/nsnames.c  |    2 +-
 drivers/acpi/acpica/nsxfeval.c |    2 +-
 drivers/acpi/acpica/rslist.c   |    4 ++--
 drivers/acpi/acpica/tbinstal.c |    2 ++
 drivers/acpi/acpica/tbutils.c  |    2 +-
 drivers/acpi/acpica/tbxface.c  |    4 ++--
 drivers/acpi/acpica/tbxfroot.c |    1 -
 drivers/acpi/acpica/utdebug.c  |    1 +
 drivers/acpi/acpica/utmutex.c  |    2 ++
 drivers/acpi/acpica/uttrack.c  |    4 ++--
 drivers/acpi/acpica/utxface.c  |    3 ++-
 18 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 89c0114..3798357 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -254,7 +254,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 				    acpi_ut_get_type_name(node->type),
 				    acpi_ut_get_node_name(node)));
 
-			return (AE_AML_OPERAND_TYPE);
+			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
 		break;
 
@@ -602,7 +602,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 							  region_space,
 							  walk_state);
 				if (ACPI_FAILURE(status)) {
-					return (status);
+					return_ACPI_STATUS(status);
 				}
 
 				acpi_ex_exit_interpreter();
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 9bb7fa4..8e62679 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -708,13 +708,13 @@ void acpi_ds_delete_walk_state(struct acpi_walk_state *walk_state)
 	ACPI_FUNCTION_TRACE_PTR(ds_delete_walk_state, walk_state);
 
 	if (!walk_state) {
-		return;
+		return_VOID;
 	}
 
 	if (walk_state->descriptor_type != ACPI_DESC_TYPE_WALK) {
 		ACPI_ERROR((AE_INFO, "%p is not a valid walk state",
 			    walk_state));
-		return;
+		return_VOID;
 	}
 
 	/* There should not be any open scopes */
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index d36f997..3f30e75 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -569,7 +569,7 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return_ACPI_STATUS(status);
 	}
 
 	node = acpi_ns_validate_handle(gpe_device);
@@ -652,7 +652,7 @@ acpi_status acpi_remove_gpe_block(acpi_handle gpe_device)
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return_ACPI_STATUS(status);
 	}
 
 	node = acpi_ns_validate_handle(gpe_device);
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index bc5b9a6..e0c9050 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -190,7 +190,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 			acpi_os_printf("Table Index 0x%X\n",
 				       source_desc->reference.value);
-			return;
+			return_VOID;
 
 		default:
 			break;
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index bcceda5..9099783 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -305,7 +305,7 @@ acpi_status acpi_ex_release_mutex_object(union acpi_operand_object *obj_desc)
 	ACPI_FUNCTION_TRACE(ex_release_mutex_object);
 
 	if (obj_desc->mutex.acquisition_depth == 0) {
-		return (AE_NOT_ACQUIRED);
+		return_ACPI_STATUS(AE_NOT_ACQUIRED);
 	}
 
 	/* Match multiple Acquires with multiple Releases */
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 0786b86..ab68dc5 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -198,7 +198,7 @@ acpi_ex_do_match(u32 match_op,
 		return (FALSE);
 	}
 
-	return logical_result;
+	return (logical_result);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/hwpci.c b/drivers/acpi/acpica/hwpci.c
index 1455ddc..65bc345 100644
--- a/drivers/acpi/acpica/hwpci.c
+++ b/drivers/acpi/acpica/hwpci.c
@@ -259,7 +259,7 @@ acpi_hw_process_pci_list(struct acpi_pci_id *pci_id,
 		status = acpi_hw_get_pci_device_info(pci_id, info->device,
 						     &bus_number, &is_bridge);
 		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+			return (status);
 		}
 
 		info = info->next;
@@ -271,7 +271,7 @@ acpi_hw_process_pci_list(struct acpi_pci_id *pci_id,
 			  pci_id->segment, pci_id->bus, pci_id->device,
 			  pci_id->function, status, bus_number, is_bridge));
 
-	return_ACPI_STATUS(AE_OK);
+	return (AE_OK);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 96e0eb6..55a175e 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -195,7 +195,7 @@ acpi_size acpi_ns_get_pathname_length(struct acpi_namespace_node *node)
 			ACPI_ERROR((AE_INFO,
 				    "Invalid Namespace Node (%p) while traversing namespace",
 				    next_node));
-			return 0;
+			return (0);
 		}
 		size += ACPI_PATH_SEGMENT_LENGTH;
 		next_node = next_node->parent;
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 494f2eb..ee4d873 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -550,7 +550,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
-		return (status);
+		return_ACPI_STATUS(status);
 	}
 
 	node = acpi_ns_validate_handle(obj_handle);
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 46b5324..8b64db9 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -109,7 +109,7 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 		ACPI_ERROR((AE_INFO,
 			    "Invalid/unsupported resource descriptor: Type 0x%2.2X",
 			    resource_index));
-		return (AE_AML_INVALID_RESOURCE_TYPE);
+		return_ACPI_STATUS(AE_AML_INVALID_RESOURCE_TYPE);
 	}
 
 	/* Convert the AML byte stream resource to a local resource struct */
@@ -200,7 +200,7 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 			ACPI_ERROR((AE_INFO,
 				    "Invalid/unsupported resource descriptor: Type 0x%2.2X",
 				    resource->type));
-			return (AE_AML_INVALID_RESOURCE_TYPE);
+			return_ACPI_STATUS(AE_AML_INVALID_RESOURCE_TYPE);
 		}
 
 		status = acpi_rs_convert_resource_to_aml(resource,
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 70f9d78..f540ae4 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -526,6 +526,8 @@ void acpi_tb_terminate(void)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "ACPI Tables freed\n"));
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+
+	return_VOID;
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index b6cea30..285e24b 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -354,7 +354,7 @@ u8 acpi_tb_checksum(u8 *buffer, u32 length)
 		sum = (u8) (sum + *(buffer++));
 	}
 
-	return sum;
+	return (sum);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 2110126..f563278 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -236,7 +236,7 @@ acpi_get_table_header(char *signature,
 						       sizeof(struct
 							      acpi_table_header));
 				if (!header) {
-					return AE_NO_MEMORY;
+					return (AE_NO_MEMORY);
 				}
 				ACPI_MEMCPY(out_table_header, header,
 					    sizeof(struct acpi_table_header));
@@ -244,7 +244,7 @@ acpi_get_table_header(char *signature,
 						     sizeof(struct
 							    acpi_table_header));
 			} else {
-				return AE_NOT_FOUND;
+				return (AE_NOT_FOUND);
 			}
 		} else {
 			ACPI_MEMCPY(out_table_header,
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 74e7208..f8ee9b3 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -67,7 +67,6 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp);
 
 static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 {
-	ACPI_FUNCTION_ENTRY();
 
 	/*
 	 * The signature and checksum must both be correct
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 6e3ae6a..2c21799 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -300,6 +300,7 @@ acpi_ut_trace_ptr(u32 line_number,
 		  const char *function_name,
 		  const char *module_name, u32 component_id, void *pointer)
 {
+
 	acpi_gbl_nesting_level++;
 	acpi_ut_track_stack_ptr();
 
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 296baa6..93a1191 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -193,6 +193,8 @@ static void acpi_ut_delete_mutex(acpi_mutex_handle mutex_id)
 
 	acpi_gbl_mutex_info[mutex_id].mutex = NULL;
 	acpi_gbl_mutex_info[mutex_id].thread_id = ACPI_MUTEX_NOT_ACQUIRED;
+
+	return_VOID;
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 73ca27d..e79c49d 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -517,14 +517,14 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 	ACPI_FUNCTION_TRACE(ut_dump_allocations);
 
 	if (acpi_gbl_disable_mem_tracking) {
-		return;
+		return_VOID;
 	}
 
 	/*
 	 * Walk the allocation list.
 	 */
 	if (ACPI_FAILURE(acpi_ut_acquire_mutex(ACPI_MTX_MEMORY))) {
-		return;
+		return_VOID;
 	}
 
 	element = acpi_gbl_global_list->list_head;
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index b09632b..0c98d42 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -238,7 +238,7 @@ acpi_install_initialization_handler(acpi_init_handler handler, u32 function)
 	}
 
 	acpi_gbl_init_handler = handler;
-	return AE_OK;
+	return (AE_OK);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_initialization_handler)
@@ -263,6 +263,7 @@ acpi_status acpi_purge_cached_objects(void)
 	(void)acpi_os_purge_cache(acpi_gbl_operand_cache);
 	(void)acpi_os_purge_cache(acpi_gbl_ps_node_cache);
 	(void)acpi_os_purge_cache(acpi_gbl_ps_node_ext_cache);
+
 	return_ACPI_STATUS(AE_OK);
 }
 
-- 
1.7.10

