From: Len Brown <lenb@kernel.org>
Subject: Linux/ACPI vs ACPICA audit -- 20070126
Date: Mon, 29 Jan 2007 23:51:51 -0500
Message-ID: <200701292351.51243.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50154 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965237AbXA3ExL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jan 2007 23:53:11 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l0U4puhX016154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jan 2007 04:53:07 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Bob, Alexey,

For the files that Linux gets from ACPICA, this diff shows how Linux
has diverged from upstream.

There are a couple of nits that ACPICA should pick up -- as gcc
knows the difference between a void* and a void**; and gcc knows
the difference between %zX and %X.  There are a couple things
Linux should clean up too, and then there are some places
where we are known to diverge.

acpica-unix-20070126.audit.diff:# 52 files changed, 379 insertions(+), 191 deletions(-)
acpica-unix-20060707.audit.diff:# 42 files changed, 221 insertions(+), 76 deletions(-)
acpica-unix-20060623.audit.diff:# 37 files changed, 198 insertions(+), 78 deletions(-)
acpica-unix-20060608.audit.diff:# 35 files changed, 190 insertions(+), 70 deletions(-)
acpica-unix-20060526.audit.diff:# 34 files changed, 162 insertions(+), 53 deletions(-)

# 140 ACPICA files
# drivers/acpi/dispatcher/dswload.c  |    3 
# drivers/acpi/dispatcher/dswstate.c |    2 
# drivers/acpi/events/evmisc.c       |    9 -
# drivers/acpi/events/evxface.c      |   59 +++++++++-
# drivers/acpi/events/evxfevnt.c     |    2 
# drivers/acpi/executer/exconfig.c   |    1 
# drivers/acpi/executer/exmutex.c    |    6 -
# drivers/acpi/hardware/hwgpe.c      |    2 
# drivers/acpi/hardware/hwregs.c     |    2 
# drivers/acpi/hardware/hwsleep.c    |   23 ---
# drivers/acpi/namespace/nsdump.c    |    6 -
# drivers/acpi/namespace/nsparse.c   |    2 
# drivers/acpi/namespace/nsxfeval.c  |    8 -
# drivers/acpi/namespace/nsxfobj.c   |   44 +++++++
# drivers/acpi/parser/pstree.c       |    2 
# drivers/acpi/parser/psutils.c      |    2 
# drivers/acpi/resources/rsinfo.c    |    2 
# drivers/acpi/resources/rslist.c    |    2 
# drivers/acpi/resources/rsutils.c   |    2 
# drivers/acpi/resources/rsxface.c   |    4 
# drivers/acpi/tables/tbfadt.c       |    4 
# drivers/acpi/tables/tbinstal.c     |   11 -
# drivers/acpi/tables/tbutils.c      |    3 
# drivers/acpi/tables/tbxface.c      |   98 ++++++++++++++---
# drivers/acpi/utilities/utalloc.c   |    6 -
# drivers/acpi/utilities/utcache.c   |    2 
# drivers/acpi/utilities/utdebug.c   |    8 -
# drivers/acpi/utilities/utglobal.c  |   14 --
# drivers/acpi/utilities/utmisc.c    |    3 
# drivers/acpi/utilities/utmutex.c   |   23 +--
# drivers/acpi/utilities/utobject.c  |    1 
# drivers/acpi/utilities/utresrc.c   |    6 -
# drivers/acpi/utilities/utstate.c   |    5 
# drivers/acpi/utilities/utxface.c   |    2 
# include/acpi/acconfig.h            |    2 
# include/acpi/acdebug.h             |    2 
# include/acpi/acdispat.h            |    2 
# include/acpi/acglobal.h            |    7 -
# include/acpi/achware.h             |    4 
# include/acpi/acinterp.h            |    2 
# include/acpi/aclocal.h             |    4 
# include/acpi/acmacros.h            |    8 +
# include/acpi/acnamesp.h            |    4 
# include/acpi/acparser.h            |    4 
# include/acpi/acpiosxf.h            |   17 +-
# include/acpi/acpixf.h              |   28 ++++
# include/acpi/acresrc.h             |    3 
# include/acpi/actbl.h               |    7 -
# include/acpi/actbl1.h              |   10 -
# include/acpi/actbl2.h              |   49 --------
# include/acpi/acutils.h             |    8 +
# include/acpi/platform/aclinux.h    |   40 ++++++
# 52 files changed, 379 insertions(+), 191 deletions(-)

diff -Nau acpica-unix-20070126/drivers/acpi/dispatcher/dswload.c acpi/drivers/acpi/dispatcher/dswload.c
--- acpica-unix-20070126/drivers/acpi/dispatcher/dswload.c	2007-01-29 23:35:53.000000000 -0500
+++ acpi/drivers/acpi/dispatcher/dswload.c	2007-01-29 10:57:53.000000000 -0500
@@ -1062,9 +1062,6 @@
 			/*
 			 * If we have a valid region, initialize it
 			 * Namespace is NOT locked at this point.
-			 *
-			 * TBD: need to unlock interpreter if it is locked, in order
-			 * to allow _REG methods to be run.
 			 */
 			status =
 			    acpi_ev_initialize_region
diff -Nau acpica-unix-20070126/drivers/acpi/dispatcher/dswstate.c acpi/drivers/acpi/dispatcher/dswstate.c
--- acpica-unix-20070126/drivers/acpi/dispatcher/dswstate.c	2007-01-29 23:35:53.000000000 -0500
+++ acpi/drivers/acpi/dispatcher/dswstate.c	2007-01-29 10:57:53.000000000 -0500
@@ -65,6 +65,7 @@
 				  struct acpi_walk_state *walk_state);
 #endif
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ds_result_remove
@@ -126,6 +127,7 @@
 
 	return (AE_OK);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20070126/drivers/acpi/executer/exmutex.c acpi/drivers/acpi/executer/exmutex.c
--- acpica-unix-20070126/drivers/acpi/executer/exmutex.c	2007-01-29 23:35:53.000000000 -0500
+++ acpi/drivers/acpi/executer/exmutex.c	2007-01-29 10:57:53.000000000 -0500
@@ -270,10 +270,10 @@
 	     walk_state->thread->thread_id)
 	    && (obj_desc->mutex.os_mutex != acpi_gbl_global_lock_mutex)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
-			    walk_state->thread->thread_id,
+			    "Thread %lX cannot release Mutex [%4.4s] acquired by thread %lX",
+			    (unsigned long)walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    obj_desc->mutex.owner_thread->thread_id));
+			    (unsigned long)obj_desc->mutex.owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
diff -Nau acpica-unix-20070126/drivers/acpi/executer/exconfig.c acpi/drivers/acpi/executer/exconfig.c
--- acpica-unix-20070126/drivers/acpi/executer/exconfig.c	2007-01-29 23:35:53.000000000 -0500
+++ acpi/drivers/acpi/executer/exconfig.c	2007-01-29 10:57:53.000000000 -0500
@@ -272,7 +272,6 @@
 	ACPI_FUNCTION_TRACE(ex_load_op);
 
 	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
-	table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 
 	/* Source Object can be either an op_region or a Buffer/Field */
 
diff -Nau acpica-unix-20070126/drivers/acpi/resources/rsinfo.c acpi/drivers/acpi/resources/rsinfo.c
--- acpica-unix-20070126/drivers/acpi/resources/rsinfo.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/resources/rsinfo.c	2007-01-29 10:57:53.000000000 -0500
@@ -116,6 +116,7 @@
 	acpi_rs_convert_ext_address64	/* 0x0B, ACPI_RESOURCE_NAME_EXTENDED_ADDRESS64 */
 };
 
+#ifdef ACPI_FUTURE_USAGE
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 
 /* Dispatch table for resource dump functions */
@@ -141,6 +142,7 @@
 };
 #endif
 
+#endif	/* ACPI_FUTURE_USAGE */
 /*
  * Base sizes for external AML resource descriptors, indexed by internal type.
  * Includes size of the descriptor header (1 byte for small descriptors,
diff -Nau acpica-unix-20070126/drivers/acpi/resources/rsxface.c acpi/drivers/acpi/resources/rsxface.c
--- acpica-unix-20070126/drivers/acpi/resources/rsxface.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/resources/rsxface.c	2007-01-29 10:57:53.000000000 -0500
@@ -218,6 +218,7 @@
 
 ACPI_EXPORT_SYMBOL(acpi_get_current_resources)
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_possible_resources
@@ -259,6 +260,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_possible_resources)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
@@ -474,6 +476,8 @@
 	return (AE_CTRL_TERMINATE);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_rs_match_vendor_resource)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_walk_resources
diff -Nau acpica-unix-20070126/drivers/acpi/resources/rslist.c acpi/drivers/acpi/resources/rslist.c
--- acpica-unix-20070126/drivers/acpi/resources/rslist.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/resources/rslist.c	2007-01-29 10:57:53.000000000 -0500
@@ -64,7 +64,7 @@
 acpi_status
 acpi_rs_convert_aml_to_resources(u8 * aml,
 				 u32 length,
-				 u32 offset, u8 resource_index, void *context)
+				 u32 offset, u8 resource_index, void **context)
 {
 	struct acpi_resource **resource_ptr =
 	    ACPI_CAST_INDIRECT_PTR(struct acpi_resource, context);
diff -Nau acpica-unix-20070126/drivers/acpi/resources/rsutils.c acpi/drivers/acpi/resources/rsutils.c
--- acpica-unix-20070126/drivers/acpi/resources/rsutils.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/resources/rsutils.c	2007-01-29 10:57:53.000000000 -0500
@@ -555,6 +555,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_rs_get_prs_method_data(struct acpi_namespace_node *node,
 			    struct acpi_buffer *ret_buffer)
@@ -586,6 +587,7 @@
 	acpi_ut_remove_reference(obj_desc);
 	return_ACPI_STATUS(status);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20070126/drivers/acpi/tables/tbfadt.c acpi/drivers/acpi/tables/tbfadt.c
--- acpica-unix-20070126/drivers/acpi/tables/tbfadt.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/tables/tbfadt.c	2007-01-29 10:57:53.000000000 -0500
@@ -222,8 +222,8 @@
 	 */
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
-			      "FADT (revision %u) is longer than ACPI 2.0 version, truncating length 0x%X to 0x%X",
-			      table->revision, length,
+			      "FADT (revision %u) is longer than ACPI 2.0 version, truncating length 0x%X to 0x%zX",
+			      table->revision, (unsigned)length,
 			      sizeof(struct acpi_table_fadt)));
 	}
 
diff -Nau acpica-unix-20070126/drivers/acpi/tables/tbutils.c acpi/drivers/acpi/tables/tbutils.c
--- acpica-unix-20070126/drivers/acpi/tables/tbutils.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/tables/tbutils.c	2007-01-29 10:57:53.000000000 -0500
@@ -158,6 +158,7 @@
 			      (u8) (table->checksum - checksum)));
 
 #if (ACPI_CHECKSUM_ABORT)
+
 		return (AE_BAD_CHECKSUM);
 #endif
 	}
@@ -331,7 +332,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 {
 	struct acpi_table_rsdp *rsdp;
diff -Nau acpica-unix-20070126/drivers/acpi/tables/tbinstal.c acpi/drivers/acpi/tables/tbinstal.c
--- acpica-unix-20070126/drivers/acpi/tables/tbinstal.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/tables/tbinstal.c	2007-01-29 10:57:53.000000000 -0500
@@ -74,7 +74,6 @@
 			    acpi_os_map_memory(table_desc->address,
 					       table_desc->length);
 		}
-
 		if (!table_desc->pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
@@ -307,24 +306,18 @@
 
 void acpi_tb_delete_table(struct acpi_table_desc *table_desc)
 {
-
 	/* Table must be mapped or allocated */
-
 	if (!table_desc->pointer) {
 		return;
 	}
-
 	switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
 	case ACPI_TABLE_ORIGIN_MAPPED:
 		acpi_os_unmap_memory(table_desc->pointer, table_desc->length);
 		break;
-
 	case ACPI_TABLE_ORIGIN_ALLOCATED:
 		ACPI_FREE(table_desc->pointer);
 		break;
-
-	default:
-		break;
+	default:;
 	}
 
 	table_desc->pointer = NULL;
@@ -352,7 +345,7 @@
 
 	/* Delete the individual tables */
 
-	for (i = 0; i < acpi_gbl_root_table_list.count; i++) {
+	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
 		acpi_tb_delete_table(&acpi_gbl_root_table_list.tables[i]);
 	}
 
diff -Nau acpica-unix-20070126/drivers/acpi/tables/tbxface.c acpi/drivers/acpi/tables/tbxface.c
--- acpica-unix-20070126/drivers/acpi/tables/tbxface.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/tables/tbxface.c	2007-01-29 10:57:53.000000000 -0500
@@ -101,7 +101,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status __init
 acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 		       u32 initial_table_count, u8 allow_resize)
 {
@@ -152,8 +152,6 @@
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_initialize_tables)
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_reallocate_root_table
@@ -203,8 +201,47 @@
 
 	return_ACPI_STATUS(AE_OK);
 }
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_load_table
+ *
+ * PARAMETERS:  table_ptr       - pointer to a buffer containing the entire
+ *                                table to be loaded
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function is called to load a table from the caller's
+ *              buffer. The buffer must contain an entire ACPI Table including
+ *              a valid header. The header fields will be verified, and if it
+ *              is determined that the table is invalid, the call will fail.
+ *
+ ******************************************************************************/
+acpi_status acpi_load_table(struct acpi_table_header *table_ptr)
+{
+	acpi_status status;
+	acpi_native_uint table_index;
+	struct acpi_table_desc table_desc;
+
+	if (!table_ptr)
+		return AE_BAD_PARAMETER;
 
-ACPI_EXPORT_SYMBOL(acpi_reallocate_root_table)
+	ACPI_MEMSET(&table_desc, 0, sizeof(struct acpi_table_desc));
+	table_desc.pointer = table_ptr;
+	table_desc.length = table_ptr->length;
+	table_desc.flags = ACPI_TABLE_ORIGIN_UNKNOWN;
+
+	/*
+	 * Install the new table into the local data structures
+	 */
+	status = acpi_tb_add_table(&table_desc, &table_index);
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+	status = acpi_ns_load_table(table_index, acpi_gbl_root_node);
+	return status;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_load_table)
 
 /******************************************************************************
  *
@@ -263,25 +300,19 @@
 				if (!header) {
 					return AE_NO_MEMORY;
 				}
-
 				ACPI_MEMCPY(out_table_header, header,
 					    sizeof(struct acpi_table_header));
 				acpi_os_unmap_memory(header,
 						     sizeof(struct
 							    acpi_table_header));
-			}
-
-			else {
+			} else {
 				return AE_NOT_FOUND;
 			}
-		}
-
-		else {
+		} else {
 			ACPI_MEMCPY(out_table_header,
 				    acpi_gbl_root_table_list.tables[i].pointer,
 				    sizeof(struct acpi_table_header));
 		}
-
 		return (AE_OK);
 	}
 
@@ -290,8 +321,47 @@
 
 ACPI_EXPORT_SYMBOL(acpi_get_table_header)
 
+
 /******************************************************************************
  *
+ * FUNCTION:    acpi_unload_table_id
+ *
+ * PARAMETERS:  id            - Owner ID of the table to be removed.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This routine is used to force the unload of a table (by id)
+ *
+ ******************************************************************************/
+acpi_status acpi_unload_table_id(acpi_owner_id id)
+{
+	int i;
+	acpi_status status = AE_NOT_EXIST;
+
+	ACPI_FUNCTION_TRACE(acpi_unload_table);
+
+	/* Find table from the requested type list */
+	for (i = 0; i < acpi_gbl_root_table_list.count; ++i) {
+		if (id != acpi_gbl_root_table_list.tables[i].owner_id) {
+			continue;
+		}
+		/*
+		* Delete all namespace objects owned by this table. Note that these
+		* objects can appear anywhere in the namespace by virtue of the AML
+		* "Scope" operator. Thus, we need to track ownership by an ID, not
+		* simply a position within the hierarchy
+		*/
+		acpi_tb_delete_namespace_by_owner(i);
+		acpi_tb_release_owner_id(i);
+		acpi_tb_set_table_loaded_flag(i, FALSE);
+	}
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_get_table
  *
  * PARAMETERS:  Signature           - ACPI signature of needed table
@@ -337,6 +407,10 @@
 			*out_table = acpi_gbl_root_table_list.tables[i].pointer;
 		}
 
+		if (!acpi_gbl_permanent_mmap) {
+			acpi_gbl_root_table_list.tables[i].pointer = 0;
+		}
+
 		return (status);
 	}
 
diff -Nau acpica-unix-20070126/drivers/acpi/namespace/nsdump.c acpi/drivers/acpi/namespace/nsdump.c
--- acpica-unix-20070126/drivers/acpi/namespace/nsdump.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/namespace/nsdump.c	2007-01-29 10:57:53.000000000 -0500
@@ -594,6 +594,7 @@
 	return (AE_OK);
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_objects
@@ -633,6 +634,7 @@
 				     acpi_ns_dump_one_object, (void *)&info,
 				     NULL);
 }
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*******************************************************************************
  *
@@ -704,5 +706,5 @@
 			     ACPI_OWNER_ID_MAX, search_handle);
 	return_VOID;
 }
-#endif
-#endif
+#endif				/* _ACPI_ASL_COMPILER */
+#endif				/* defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER) */
diff -Nau acpica-unix-20070126/drivers/acpi/namespace/nsxfeval.c acpi/drivers/acpi/namespace/nsxfeval.c
--- acpica-unix-20070126/drivers/acpi/namespace/nsxfeval.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/namespace/nsxfeval.c	2007-01-29 10:57:53.000000000 -0500
@@ -49,6 +49,7 @@
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfeval")
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_evaluate_object_typed
@@ -72,8 +73,8 @@
 acpi_status
 acpi_evaluate_object_typed(acpi_handle handle,
 			   acpi_string pathname,
-			   struct acpi_object_list *external_params,
-			   struct acpi_buffer *return_buffer,
+			   struct acpi_object_list * external_params,
+			   struct acpi_buffer * return_buffer,
 			   acpi_object_type return_type)
 {
 	acpi_status status;
@@ -132,7 +133,7 @@
 
 		/* Caller used ACPI_ALLOCATE_BUFFER, free the return buffer */
 
-		acpi_os_free(return_buffer->pointer);
+		ACPI_FREE(return_buffer->pointer);
 		return_buffer->pointer = NULL;
 	}
 
@@ -141,6 +142,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_evaluate_object_typed)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20070126/drivers/acpi/namespace/nsxfobj.c acpi/drivers/acpi/namespace/nsxfobj.c
--- acpica-unix-20070126/drivers/acpi/namespace/nsxfobj.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/namespace/nsxfobj.c	2007-01-29 10:57:53.000000000 -0500
@@ -50,6 +50,50 @@
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_get_id
+ *
+ * PARAMETERS:  Handle          - Handle of object whose id is desired
+ *              ret_id          - Where the id will be placed
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This routine returns the owner id associated with a handle
+ *
+ ******************************************************************************/
+acpi_status acpi_get_id(acpi_handle handle, acpi_owner_id * ret_id)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	/* Parameter Validation */
+
+	if (!ret_id) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Convert and validate the handle */
+
+	node = acpi_ns_map_handle_to_node(handle);
+	if (!node) {
+		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+		return (AE_BAD_PARAMETER);
+	}
+
+	*ret_id = node->owner_id;
+
+	status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return (status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_get_id)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_get_type
  *
  * PARAMETERS:  Handle          - Handle of object whose type is desired
diff -Nau acpica-unix-20070126/drivers/acpi/namespace/nsparse.c acpi/drivers/acpi/namespace/nsparse.c
--- acpica-unix-20070126/drivers/acpi/namespace/nsparse.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/namespace/nsparse.c	2007-01-29 10:57:53.000000000 -0500
@@ -124,7 +124,7 @@
 	/* Parse the AML */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "*PARSE* pass %d parse\n",
-			  pass_number));
+			  (unsigned)pass_number));
 	status = acpi_ps_parse_aml(walk_state);
 
 	acpi_ps_delete_parse_tree(parse_root);
diff -Nau acpica-unix-20070126/drivers/acpi/hardware/hwregs.c acpi/drivers/acpi/hardware/hwregs.c
--- acpica-unix-20070126/drivers/acpi/hardware/hwregs.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/hardware/hwregs.c	2007-01-29 10:57:53.000000000 -0500
@@ -660,8 +660,6 @@
 
 		/*
 		 * Perform a read first to preserve certain bits (per ACPI spec)
-		 *
-		 * Note: This includes SCI_EN, we never want to change this bit
 		 */
 		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
 					       ACPI_REGISTER_PM1_CONTROL,
diff -Nau acpica-unix-20070126/drivers/acpi/hardware/hwsleep.c acpi/drivers/acpi/hardware/hwsleep.c
--- acpica-unix-20070126/drivers/acpi/hardware/hwsleep.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/hardware/hwsleep.c	2007-01-29 10:57:53.000000000 -0500
@@ -109,6 +109,7 @@
  * DESCRIPTION: Access function for the firmware_waking_vector field in FACS
  *
  ******************************************************************************/
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
 {
@@ -150,6 +151,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_firmware_waking_vector)
+#endif
 
 /*******************************************************************************
  *
@@ -250,7 +252,7 @@
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status acpi_enter_sleep_state(u8 sleep_state)
+acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 {
 	u32 PM1Acontrol;
 	u32 PM1Bcontrol;
@@ -287,16 +289,6 @@
 		return_ACPI_STATUS(status);
 	}
 
-	if (sleep_state != ACPI_STATE_S5) {
-
-		/* Disable BM arbitration */
-
-		status = acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
-
 	/*
 	 * 1) Disable/Clear all GPEs
 	 * 2) Enable all wakeup GPEs
@@ -431,7 +423,7 @@
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status acpi_enter_sleep_state_s4bios(void)
+acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 {
 	u32 in_value;
 	acpi_status status;
@@ -609,13 +601,6 @@
 	    acpi_set_register(acpi_gbl_fixed_event_info
 			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1);
 
-	/* Enable BM arbitration */
-
-	status = acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
diff -Nau acpica-unix-20070126/drivers/acpi/hardware/hwgpe.c acpi/drivers/acpi/hardware/hwgpe.c
--- acpica-unix-20070126/drivers/acpi/hardware/hwgpe.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/hardware/hwgpe.c	2007-01-29 10:57:53.000000000 -0500
@@ -138,6 +138,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 		       acpi_event_status * event_status)
@@ -197,6 +198,7 @@
       unlock_and_exit:
 	return (status);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /******************************************************************************
  *
diff -Nau acpica-unix-20070126/drivers/acpi/parser/psutils.c acpi/drivers/acpi/parser/psutils.c
--- acpica-unix-20070126/drivers/acpi/parser/psutils.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/parser/psutils.c	2007-01-29 10:57:53.000000000 -0500
@@ -211,6 +211,7 @@
 /*
  * Get op's name (4-byte name segment) or 0 if unnamed
  */
+#ifdef ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object * op)
 {
 
@@ -224,6 +225,7 @@
 
 	return (op->named.name);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*
  * Set op's name
diff -Nau acpica-unix-20070126/drivers/acpi/parser/pstree.c acpi/drivers/acpi/parser/pstree.c
--- acpica-unix-20070126/drivers/acpi/parser/pstree.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/parser/pstree.c	2007-01-29 10:57:53.000000000 -0500
@@ -174,6 +174,7 @@
 	}
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_depth_next
@@ -305,3 +306,4 @@
 	return (child);
 }
 #endif
+#endif				/*  ACPI_FUTURE_USAGE  */
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utmisc.c acpi/drivers/acpi/utilities/utmisc.c
--- acpica-unix-20070126/drivers/acpi/utilities/utmisc.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utmisc.c	2007-01-29 10:57:53.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
@@ -1047,6 +1049,7 @@
 	acpi_os_vprintf(format, args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
 }
+EXPORT_SYMBOL(acpi_ut_exception);
 
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utmutex.c acpi/drivers/acpi/utilities/utmutex.c
--- acpica-unix-20070126/drivers/acpi/utilities/utmutex.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utmutex.c	2007-01-29 10:57:53.000000000 -0500
@@ -82,12 +82,9 @@
 
 	/* Create the spinlocks for use at interrupt level */
 
-	status = acpi_os_create_lock(&acpi_gbl_gpe_lock);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	spin_lock_init(acpi_gbl_gpe_lock);
+	spin_lock_init(acpi_gbl_hardware_lock);
 
-	status = acpi_os_create_lock(&acpi_gbl_hardware_lock);
 	return_ACPI_STATUS(status);
 }
 
@@ -246,23 +243,24 @@
 #endif
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X attempting to acquire Mutex [%s]\n",
-			  this_thread_id, acpi_ut_get_mutex_name(mutex_id)));
+			  "Thread %lX attempting to acquire Mutex [%s]\n",
+			  (unsigned long) this_thread_id,
+			  acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Thread %X acquired Mutex [%s]\n",
-				  this_thread_id,
+				  "Thread %lX acquired Mutex [%s]\n",
+				  (unsigned long) this_thread_id,
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %X could not acquire Mutex [%X]",
-				this_thread_id, mutex_id));
+				"Thread %lX could not acquire Mutex [%X]",
+				(unsigned long) this_thread_id, mutex_id));
 	}
 
 	return (status);
@@ -288,7 +286,8 @@
 
 	this_thread_id = acpi_os_get_thread_id();
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X releasing Mutex [%s]\n", this_thread_id,
+			  "Thread %lX releasing Mutex [%s]\n",
+			  (unsigned long) this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utdebug.c acpi/drivers/acpi/utilities/utdebug.c
--- acpica-unix-20070126/drivers/acpi/utilities/utdebug.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utdebug.c	2007-01-29 10:57:53.000000000 -0500
@@ -47,7 +47,7 @@
 ACPI_MODULE_NAME("utdebug")
 
 #ifdef ACPI_DEBUG_OUTPUT
-static u32 acpi_gbl_prev_thread_id = 0xFFFFFFFF;
+static acpi_thread_id acpi_gbl_prev_thread_id;
 static char *acpi_gbl_fn_entry_str = "----Entry";
 static char *acpi_gbl_fn_exit_str = "----Exit-";
 
@@ -180,8 +180,8 @@
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     acpi_gbl_prev_thread_id, thread_id);
+			    ("\n**** Context Switch from TID %lX to TID %lX ****\n\n",
+			     (unsigned long)acpi_gbl_prev_thread_id, (unsigned long)thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
@@ -194,7 +194,7 @@
 	acpi_os_printf("%8s-%04ld ", module_name, line_number);
 
 	if (ACPI_LV_THREADS & acpi_dbg_level) {
-		acpi_os_printf("[%04lX] ", thread_id);
+		acpi_os_printf("[%04lX] ", (unsigned long)thread_id);
 	}
 
 	acpi_os_printf("[%02ld] %-22.22s: ",
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utobject.c acpi/drivers/acpi/utilities/utobject.c
--- acpica-unix-20070126/drivers/acpi/utilities/utobject.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utobject.c	2007-01-29 10:57:53.000000000 -0500
@@ -321,6 +321,7 @@
 
 	/* Mark the descriptor type */
 
+	memset(object, 0, sizeof(union acpi_operand_object));
 	ACPI_SET_DESCRIPTOR_TYPE(object, ACPI_DESC_TYPE_OPERAND);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p Size %X\n",
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utglobal.c acpi/drivers/acpi/utilities/utglobal.c
--- acpica-unix-20070126/drivers/acpi/utilities/utglobal.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utglobal.c	2007-01-29 10:57:53.000000000 -0500
@@ -55,20 +55,18 @@
  * Static global variable initialization.
  *
  ******************************************************************************/
+
 /*
  * We want the debug switches statically initialized so they
  * are already set when the debugger is entered.
  */
+
 /* Debug switch - level and trace mask */
-#ifdef ACPI_DEBUG_OUTPUT
 u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
-#else
-u32 acpi_dbg_level = ACPI_NORMAL_DEFAULT;
-#endif
 
 /* Debug switch - layer (component) mask */
 
-u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT;
+u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
 u32 acpi_gbl_nesting_level = 0;
 
 /* Debugger globals */
@@ -736,8 +734,6 @@
 	return_VOID;
 }
 
-/* Public globals */
-
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
-    ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
-    ACPI_EXPORT_SYMBOL(acpi_gpe_count)
+ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
+ACPI_EXPORT_SYMBOL(acpi_gpe_count)
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utcache.c acpi/drivers/acpi/utilities/utcache.c
--- acpica-unix-20070126/drivers/acpi/utilities/utcache.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utcache.c	2007-01-29 10:57:53.000000000 -0500
@@ -162,7 +162,7 @@
 
 	/* Now we can delete the cache object */
 
-	acpi_os_free(cache);
+	ACPI_FREE(cache);
 	return (AE_OK);
 }
 
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utstate.c acpi/drivers/acpi/utilities/utstate.c
--- acpica-unix-20070126/drivers/acpi/utilities/utstate.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utstate.c	2007-01-29 10:57:53.000000000 -0500
@@ -63,7 +63,7 @@
 acpi_ut_create_pkg_state_and_push(void *internal_object,
 				  void *external_object,
 				  u16 index,
-				  union acpi_generic_state ** state_list)
+				  union acpi_generic_state **state_list)
 {
 	union acpi_generic_state *state;
 
@@ -161,6 +161,7 @@
 	if (state) {
 
 		/* Initialize */
+		memset(state, 0, sizeof(union acpi_generic_state));
 		state->common.descriptor_type = ACPI_DESC_TYPE_STATE;
 	}
 
@@ -202,7 +203,7 @@
 
 	if (!state->thread.thread_id) {
 		ACPI_ERROR((AE_INFO, "Invalid zero ID from AcpiOsGetThreadId"));
-		state->thread.thread_id = 1;
+		state->thread.thread_id = (acpi_thread_id) 1;
 	}
 
 	return_PTR((struct acpi_thread_state *)state);
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utalloc.c acpi/drivers/acpi/utilities/utalloc.c
--- acpica-unix-20070126/drivers/acpi/utilities/utalloc.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utalloc.c	2007-01-29 10:57:53.000000000 -0500
@@ -175,10 +175,10 @@
 
 	/* Free memory lists */
 
-	acpi_os_free(acpi_gbl_global_list);
+	ACPI_FREE(acpi_gbl_global_list);
 	acpi_gbl_global_list = NULL;
 
-	acpi_os_free(acpi_gbl_ns_node_list);
+	ACPI_FREE(acpi_gbl_ns_node_list);
 	acpi_gbl_ns_node_list = NULL;
 #endif
 
@@ -294,6 +294,7 @@
 	return (status);
 }
 
+#ifdef NOT_USED_BY_LINUX
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_allocate
@@ -369,3 +370,4 @@
 
 	return (allocation);
 }
+#endif
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utxface.c acpi/drivers/acpi/utilities/utxface.c
--- acpica-unix-20070126/drivers/acpi/utilities/utxface.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utxface.c	2007-01-29 10:57:53.000000000 -0500
@@ -338,6 +338,7 @@
 
 ACPI_EXPORT_SYMBOL(acpi_terminate)
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_subsystem_status
@@ -468,6 +469,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_initialization_handler)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*****************************************************************************
  *
diff -Nau acpica-unix-20070126/drivers/acpi/utilities/utresrc.c acpi/drivers/acpi/utilities/utresrc.c
--- acpica-unix-20070126/drivers/acpi/utilities/utresrc.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/utilities/utresrc.c	2007-01-29 10:57:53.000000000 -0500
@@ -258,7 +258,7 @@
 acpi_status
 acpi_ut_walk_aml_resources(u8 * aml,
 			   acpi_size aml_length,
-			   acpi_walk_aml_callback user_function, void *context)
+			   acpi_walk_aml_callback user_function, void **context)
 {
 	acpi_status status;
 	u8 *end_aml;
@@ -319,7 +319,7 @@
 			/* Return the pointer to the end_tag if requested */
 
 			if (!user_function) {
-				*(void **)context = aml;
+				*context = aml;
 			}
 
 			/* Normal exit */
@@ -610,7 +610,7 @@
 
 	status = acpi_ut_walk_aml_resources(obj_desc->buffer.pointer,
 					    obj_desc->buffer.length, NULL,
-					    end_tag);
+					    (void **)end_tag);
 
 	return_ACPI_STATUS(status);
 }
diff -Nau acpica-unix-20070126/drivers/acpi/events/evmisc.c acpi/drivers/acpi/events/evmisc.c
--- acpica-unix-20070126/drivers/acpi/events/evmisc.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/events/evmisc.c	2007-01-29 10:57:53.000000000 -0500
@@ -305,7 +305,6 @@
 static u32 acpi_ev_global_lock_handler(void *context)
 {
 	u8 acquired = FALSE;
-	acpi_status status;
 
 	/*
 	 * Attempt to get the lock.
@@ -316,15 +315,13 @@
 	ACPI_ACQUIRE_GLOBAL_LOCK(facs, acquired);
 	if (acquired) {
 
-		/* Got the lock, now wake the thread waiting for it */
+		/* Got the lock, now wake all threads waiting for it */
 
 		acpi_gbl_global_lock_acquired = TRUE;
-
 		/* Send a unit to the semaphore */
 
-		status =
-		    acpi_os_signal_semaphore(acpi_gbl_global_lock_semaphore, 1);
-		if (ACPI_FAILURE(status)) {
+		if (ACPI_FAILURE(acpi_os_signal_semaphore(
+			acpi_gbl_global_lock_semaphore, 1))) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not signal Global Lock semaphore"));
 		}
diff -Nau acpica-unix-20070126/drivers/acpi/events/evxface.c acpi/drivers/acpi/events/evxface.c
--- acpica-unix-20070126/drivers/acpi/events/evxface.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/events/evxface.c	2007-01-29 10:57:53.000000000 -0500
@@ -61,6 +61,7 @@
  * DESCRIPTION: Saves the pointer to the handler function
  *
  ******************************************************************************/
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler)
 {
 	acpi_status status;
@@ -89,6 +90,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_exception_handler)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
@@ -136,7 +138,9 @@
 	acpi_gbl_fixed_event_handlers[event].handler = handler;
 	acpi_gbl_fixed_event_handlers[event].context = context;
 
-	status = acpi_enable_event(event, 0);
+	status = acpi_clear_event(event);
+	if (ACPI_SUCCESS(status))
+		status = acpi_enable_event(event, 0);
 	if (ACPI_FAILURE(status)) {
 		ACPI_WARNING((AE_INFO, "Could not enable fixed event %X",
 			      event));
@@ -410,12 +414,13 @@
 
 	if ((!device) ||
 	    (!handler) || (handler_type > ACPI_MAX_NOTIFY_HANDLER_TYPE)) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		status = AE_BAD_PARAMETER;
+		goto exit;
 	}
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto exit;
 	}
 
 	/* Convert and validate the device handle */
@@ -440,6 +445,15 @@
 			goto unlock_and_exit;
 		}
 
+		/* Make sure all deferred tasks are completed */
+
+		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+		acpi_os_wait_events_complete(NULL);
+		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE(status)) {
+			goto exit;
+		}
+
 		if (handler_type & ACPI_SYSTEM_NOTIFY) {
 			acpi_gbl_system_notify.node = NULL;
 			acpi_gbl_system_notify.handler = NULL;
@@ -484,9 +498,16 @@
 				status = AE_BAD_PARAMETER;
 				goto unlock_and_exit;
 			}
+			/* Make sure all deferred tasks are completed */
 
-			/* Remove the handler */
+			(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+			acpi_os_wait_events_complete(NULL);
+			status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+			if (ACPI_FAILURE(status)) {
+				goto exit;
+			}
 
+			/* Remove the handler */
 			obj_desc->common_notify.system_notify = NULL;
 			acpi_ut_remove_reference(notify_obj);
 		}
@@ -502,9 +523,16 @@
 				status = AE_BAD_PARAMETER;
 				goto unlock_and_exit;
 			}
+			/* Make sure all deferred tasks are completed */
 
-			/* Remove the handler */
+			(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+			acpi_os_wait_events_complete(NULL);
+			status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+			if (ACPI_FAILURE(status)) {
+				goto exit;
+			}
 
+			/* Remove the handler */
 			obj_desc->common_notify.device_notify = NULL;
 			acpi_ut_remove_reference(notify_obj);
 		}
@@ -512,6 +540,9 @@
 
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+      exit:
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status, "Removing notify handler"));
 	return_ACPI_STATUS(status);
 }
 
@@ -549,12 +580,13 @@
 	/* Parameter validation */
 
 	if ((!address) || (type > ACPI_GPE_XRUPT_TYPE_MASK)) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
+		status = AE_BAD_PARAMETER;
+		goto exit;
 	}
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto exit;
 	}
 
 	/* Ensure that we have a valid GPE number */
@@ -606,6 +638,10 @@
 
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+      exit:
+	if (ACPI_FAILURE(status))
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Installing notify handler failed"));
 	return_ACPI_STATUS(status);
 }
 
@@ -677,6 +713,15 @@
 		goto unlock_and_exit;
 	}
 
+	/* Make sure all deferred tasks are completed */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	acpi_os_wait_events_complete(NULL);
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	/* Remove the handler */
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
diff -Nau acpica-unix-20070126/drivers/acpi/events/evxfevnt.c acpi/drivers/acpi/events/evxfevnt.c
--- acpica-unix-20070126/drivers/acpi/events/evxfevnt.c	2007-01-29 23:35:54.000000000 -0500
+++ acpi/drivers/acpi/events/evxfevnt.c	2007-01-29 10:57:53.000000000 -0500
@@ -473,6 +473,7 @@
 
 ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_event_status
@@ -566,6 +567,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20070126/include/acpi/actbl1.h acpi/include/acpi/actbl1.h
--- acpica-unix-20070126/include/acpi/actbl1.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/actbl1.h	2007-01-29 10:57:53.000000000 -0500
@@ -669,16 +669,6 @@
 #define ACPI_SRAT_MEM_HOT_PLUGGABLE (1<<1)	/* 01: Memory region is hot pluggable */
 #define ACPI_SRAT_MEM_NON_VOLATILE  (1<<2)	/* 02: Memory region is non-volatile */
 
-/* Memory types */
-
-enum acpi_address_range_id {
-	ACPI_ADDRESS_RANGE_MEMORY = 1,
-	ACPI_ADDRESS_RANGE_RESERVED = 2,
-	ACPI_ADDRESS_RANGE_ACPI = 3,
-	ACPI_ADDRESS_RANGE_NVS = 4,
-	ACPI_ADDRESS_RANGE_COUNT = 5
-};
-
 /*******************************************************************************
  *
  * TCPA - Trusted Computing Platform Alliance table
diff -Nau acpica-unix-20070126/include/acpi/acglobal.h acpi/include/acpi/acglobal.h
--- acpica-unix-20070126/include/acpi/acglobal.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acglobal.h	2007-01-29 10:57:53.000000000 -0500
@@ -144,6 +144,7 @@
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
+extern acpi_native_uint acpi_gbl_permanent_mmap;
 
 /* These addresses are calculated from FADT address values */
 
@@ -182,8 +183,10 @@
  * Spinlocks are used for interfaces that can be possibly called at
  * interrupt level
  */
-ACPI_EXTERN acpi_spinlock acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
-ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
+ACPI_EXTERN spinlock_t _acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
+ACPI_EXTERN spinlock_t _acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
+#define acpi_gbl_gpe_lock	&_acpi_gbl_gpe_lock
+#define acpi_gbl_hardware_lock	&_acpi_gbl_hardware_lock
 
 /*****************************************************************************
  *
diff -Nau acpica-unix-20070126/include/acpi/acparser.h acpi/include/acpi/acparser.h
--- acpica-unix-20070126/include/acpi/acparser.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acparser.h	2007-01-29 10:57:53.000000000 -0500
@@ -167,8 +167,10 @@
 
 union acpi_parse_object *acpi_ps_get_arg(union acpi_parse_object *op, u32 argn);
 
+#ifdef	ACPI_FUTURE_USAGE
 union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 						union acpi_parse_object *op);
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * pswalk - parse tree walk routines
@@ -208,7 +210,9 @@
 
 u8 acpi_ps_is_prefix_char(u32 c);
 
+#ifdef	ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object *op);
+#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ps_set_name(union acpi_parse_object *op, u32 name);
 
diff -Nau acpica-unix-20070126/include/acpi/acpixf.h acpi/include/acpi/acpixf.h
--- acpica-unix-20070126/include/acpi/acpixf.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acpixf.h	2007-01-29 10:57:53.000000000 -0500
@@ -63,20 +63,26 @@
 
 acpi_status acpi_terminate(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_subsystem_status(void);
+#endif
 
 acpi_status acpi_enable(void);
 
 acpi_status acpi_disable(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_system_info(struct acpi_buffer *ret_buffer);
+#endif
 
 const char *acpi_format_exception(acpi_status exception);
 
 acpi_status acpi_purge_cached_objects(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_install_initialization_handler(acpi_init_handler handler, u32 function);
+#endif
 
 /*
  * ACPI Memory managment
@@ -96,6 +102,10 @@
 
 acpi_status acpi_load_tables(void);
 
+acpi_status acpi_load_table(struct acpi_table_header *table_ptr);
+
+acpi_status acpi_unload_table_id(acpi_owner_id id);
+
 acpi_status
 acpi_get_table_header(acpi_string signature,
 		      acpi_native_uint instance,
@@ -154,12 +164,14 @@
 		     struct acpi_object_list *parameter_objects,
 		     struct acpi_buffer *return_object_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_evaluate_object_typed(acpi_handle object,
 			   acpi_string pathname,
 			   struct acpi_object_list *external_params,
 			   struct acpi_buffer *return_buffer,
 			   acpi_object_type return_type);
+#endif
 
 acpi_status
 acpi_get_object_info(acpi_handle handle, struct acpi_buffer *return_buffer);
@@ -171,6 +183,8 @@
 
 acpi_status acpi_get_type(acpi_handle object, acpi_object_type * out_type);
 
+acpi_status acpi_get_id(acpi_handle object, acpi_owner_id * out_type);
+
 acpi_status acpi_get_parent(acpi_handle object, acpi_handle * out_handle);
 
 /*
@@ -208,7 +222,9 @@
 			 u32 gpe_number,
 			 u32 type, acpi_event_handler address, void *context);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
+#endif
 
 /*
  * Event interfaces
@@ -227,7 +243,9 @@
 
 acpi_status acpi_clear_event(u32 event);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status acpi_set_gpe_type(acpi_handle gpe_device, u32 gpe_number, u8 type);
 
@@ -237,10 +255,12 @@
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number,
 		    u32 flags, acpi_event_status * event_status);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_install_gpe_block(acpi_handle gpe_device,
@@ -266,9 +286,11 @@
 acpi_get_current_resources(acpi_handle device_handle,
 			   struct acpi_buffer *ret_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_possible_resources(acpi_handle device_handle,
 			    struct acpi_buffer *ret_buffer);
+#endif
 
 acpi_status
 acpi_walk_resources(acpi_handle device_handle,
@@ -297,17 +319,19 @@
 acpi_status
 acpi_set_firmware_waking_vector(acpi_physical_address physical_address);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_firmware_waking_vector(acpi_physical_address * physical_address);
+#endif
 
 acpi_status
 acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);
 
 acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
-acpi_status acpi_enter_sleep_state(u8 sleep_state);
+acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
 
-acpi_status acpi_enter_sleep_state_s4bios(void);
+acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void);
 
 acpi_status acpi_leave_sleep_state(u8 sleep_state);
 
diff -Nau acpica-unix-20070126/include/acpi/acdebug.h acpi/include/acpi/acdebug.h
--- acpica-unix-20070126/include/acpi/acdebug.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acdebug.h	2007-01-29 10:57:53.000000000 -0500
@@ -200,8 +200,6 @@
 
 void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context);
 
-acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op);
-
 /*
  * dbstats - Generation and display of ACPI table statistics
  */
diff -Nau acpica-unix-20070126/include/acpi/acutils.h acpi/include/acpi/acutils.h
--- acpica-unix-20070126/include/acpi/acutils.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acutils.h	2007-01-29 10:57:53.000000000 -0500
@@ -81,7 +81,7 @@
 acpi_status(*acpi_walk_aml_callback) (u8 * aml,
 				      u32 length,
 				      u32 offset,
-				      u8 resource_index, void *context);
+				      u8 resource_index, void **context);
 
 typedef
 acpi_status(*acpi_pkg_callback) (u8 object_type,
@@ -423,11 +423,13 @@
 				     u16 action,
 				     union acpi_generic_state **state_list);
 
+#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_ut_create_pkg_state_and_push(void *internal_object,
 				  void *external_object,
 				  u16 index,
 				  union acpi_generic_state **state_list);
+#endif				/* ACPI_FUTURE_USAGE */
 
 union acpi_generic_state *acpi_ut_create_control_state(void);
 
@@ -496,7 +498,7 @@
 acpi_status
 acpi_ut_walk_aml_resources(u8 * aml,
 			   acpi_size aml_length,
-			   acpi_walk_aml_callback user_function, void *context);
+			   acpi_walk_aml_callback user_function, void **context);
 
 acpi_status acpi_ut_validate_resource(void *aml, u8 * return_index);
 
@@ -551,7 +553,9 @@
 void
 acpi_ut_free_and_track(void *address, u32 component, char *module, u32 line);
 
+#ifdef	ACPI_FUTURE_USAGE
 void acpi_ut_dump_allocation_info(void);
+#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ut_dump_allocations(u32 component, char *module);
 
diff -Nau acpica-unix-20070126/include/acpi/acpiosxf.h acpi/include/acpi/acpiosxf.h
--- acpica-unix-20070126/include/acpi/acpiosxf.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acpiosxf.h	2007-01-29 10:57:53.000000000 -0500
@@ -143,15 +143,15 @@
  */
 void *acpi_os_allocate(acpi_size size);
 
-void acpi_os_free(void *memory);
+void __iomem *acpi_os_map_memory(acpi_physical_address where, acpi_native_uint length);
 
-void *acpi_os_map_memory(acpi_physical_address where, acpi_native_uint length);
-
-void acpi_os_unmap_memory(void *logical_address, acpi_size size);
+void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address(void *logical_address,
 			     acpi_physical_address * physical_address);
+#endif
 
 /*
  * Memory/Object Cache
@@ -173,13 +173,12 @@
  * Interrupt handlers
  */
 acpi_status
-acpi_os_install_interrupt_handler(u32 interrupt_number,
+acpi_os_install_interrupt_handler(u32 gsi,
 				  acpi_osd_handler service_routine,
 				  void *context);
 
 acpi_status
-acpi_os_remove_interrupt_handler(u32 interrupt_number,
-				 acpi_osd_handler service_routine);
+acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler service_routine);
 
 /*
  * Threads and Scheduling
@@ -243,7 +242,9 @@
 
 u8 acpi_os_readable(void *pointer, acpi_size length);
 
+#ifdef ACPI_FUTURE_USAGE
 u8 acpi_os_writable(void *pointer, acpi_size length);
+#endif
 
 u64 acpi_os_get_timer(void);
 
@@ -258,10 +259,12 @@
 
 void acpi_os_redirect_output(void *destination);
 
+#ifdef ACPI_FUTURE_USAGE
 /*
  * Debug input
  */
 u32 acpi_os_get_line(char *buffer);
+#endif
 
 /*
  * Directory manipulation
diff -Nau acpica-unix-20070126/include/acpi/acconfig.h acpi/include/acpi/acconfig.h
--- acpica-unix-20070126/include/acpi/acconfig.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acconfig.h	2007-01-29 10:57:53.000000000 -0500
@@ -105,7 +105,7 @@
 
 /* Maximum object reference count (detects object deletion issues) */
 
-#define ACPI_MAX_REFERENCE_COUNT        0x800
+#define ACPI_MAX_REFERENCE_COUNT        0x1000
 
 /* Size of cached memory mapping for system memory operation region */
 
diff -Nau acpica-unix-20070126/include/acpi/actbl2.h acpi/include/acpi/actbl2.h
--- acpica-unix-20070126/include/acpi/actbl2.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/actbl2.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,49 +0,0 @@
-/******************************************************************************
- *
- * Name: actbl2.h - ACPI Specification Revision 2.0 Tables
- *
- *****************************************************************************/
-
-/*
- * Copyright (C) 2000 - 2007, R. Byron Moore
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce at minimum a disclaimer
- *    substantially similar to the "NO WARRANTY" disclaimer below
- *    ("Disclaimer") and any redistribution must be conditioned upon
- *    including a substantially similar Disclaimer requirement for further
- *    binary redistribution.
- * 3. Neither the names of the above-listed copyright holders nor the names
- *    of any contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * Alternatively, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2 as published by the Free
- * Software Foundation.
- *
- * NO WARRANTY
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
- * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGES.
- */
-
-#ifndef __ACTBL2_H__
-#define __ACTBL2_H__
-
-/* Code moved to both actbl.h and actbl1.h */
-
-#endif				/* __ACTBL2_H__ */
diff -Nau acpica-unix-20070126/include/acpi/actbl.h acpi/include/acpi/actbl.h
--- acpica-unix-20070126/include/acpi/actbl.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/actbl.h	2007-01-29 10:57:53.000000000 -0500
@@ -284,13 +284,12 @@
 
 #pragma pack()
 
+#define ACPI_FADT_OFFSET(f)             (u8) ACPI_OFFSET (struct acpi_table_fadt, f)
+
 /*
  * Get the remaining ACPI tables
  */
-#include "actbl1.h"
 
-/* Macros used to generate offsets to specific table fields */
-
-#define ACPI_FADT_OFFSET(f)             (u8) ACPI_OFFSET (struct acpi_table_fadt, f)
+#include <acpi/actbl1.h>
 
 #endif				/* __ACTBL_H__ */
diff -Nau acpica-unix-20070126/include/acpi/acmacros.h acpi/include/acpi/acmacros.h
--- acpica-unix-20070126/include/acpi/acmacros.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acmacros.h	2007-01-29 10:57:53.000000000 -0500
@@ -659,9 +659,15 @@
 
 /* Memory allocation */
 
+#ifndef ACPI_ALLOCATE
 #define ACPI_ALLOCATE(a)            acpi_ut_allocate((acpi_size)(a),_COMPONENT,_acpi_module_name,__LINE__)
+#endif
+#ifndef ACPI_ALLOCATE_ZEROED
 #define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed((acpi_size)(a), _COMPONENT,_acpi_module_name,__LINE__)
-#define ACPI_FREE(a)                acpi_os_free(a)
+#endif
+#ifndef ACPI_FREE
+#define ACPI_FREE(a)                acpio_os_free(a)
+#endif
 #define ACPI_MEM_TRACKING(a)
 
 #else
diff -Nau acpica-unix-20070126/include/acpi/aclocal.h acpi/include/acpi/aclocal.h
--- acpica-unix-20070126/include/acpi/aclocal.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/aclocal.h	2007-01-29 10:57:53.000000000 -0500
@@ -127,7 +127,7 @@
 
 /* This Thread ID means that the mutex is not in use (unlocked) */
 
-#define ACPI_MUTEX_NOT_ACQUIRED         (u32) -1
+#define ACPI_MUTEX_NOT_ACQUIRED         (acpi_thread_id) 0
 
 /* Table for the global mutexes */
 
@@ -725,7 +725,7 @@
  * must be preserved.
  */
 #define ACPI_PM1_STATUS_PRESERVED_BITS          0x0800	/* Bit 11 */
-#define ACPI_PM1_CONTROL_PRESERVED_BITS         0x0201	/* Bit 9, Bit 0 (SCI_EN) */
+#define ACPI_PM1_CONTROL_PRESERVED_BITS         0x0200	/* Bit 9 (whatever) */
 
 /*
  * Register IDs
diff -Nau acpica-unix-20070126/include/acpi/achware.h acpi/include/acpi/achware.h
--- acpica-unix-20070126/include/acpi/achware.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/achware.h	2007-01-29 10:57:53.000000000 -0500
@@ -100,9 +100,11 @@
 acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			struct acpi_gpe_block_info *gpe_block);
 
+#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status * event_status);
+#endif				/* ACPI_FUTURE_USAGE */
 
 acpi_status acpi_hw_disable_all_gpes(void);
 
@@ -114,6 +116,7 @@
 acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block);
 
+#ifdef	ACPI_FUTURE_USAGE
 /*
  * hwtimer - ACPI Timer prototypes
  */
@@ -123,5 +126,6 @@
 
 acpi_status
 acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed);
+#endif				/* ACPI_FUTURE_USAGE */
 
 #endif				/* __ACHWARE_H__ */
diff -Nau acpica-unix-20070126/include/acpi/acdispat.h acpi/include/acpi/acdispat.h
--- acpica-unix-20070126/include/acpi/acdispat.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acdispat.h	2007-01-29 10:57:53.000000000 -0500
@@ -328,9 +328,11 @@
 struct acpi_walk_state *acpi_ds_get_current_walk_state(struct acpi_thread_state
 						       *thread);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ds_result_remove(union acpi_operand_object **object,
 		      u32 index, struct acpi_walk_state *walk_state);
+#endif
 
 acpi_status
 acpi_ds_result_pop(union acpi_operand_object **object,
diff -Nau acpica-unix-20070126/include/acpi/platform/aclinux.h acpi/include/acpi/platform/aclinux.h
--- acpica-unix-20070126/include/acpi/platform/aclinux.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/platform/aclinux.h	2007-01-29 10:57:53.000000000 -0500
@@ -49,23 +49,29 @@
 
 #ifdef __KERNEL__
 
-#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/ctype.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/div64.h>
 #include <asm/acpi.h>
+#include <linux/slab.h>
+#include <linux/spinlock_types.h>
+#include <asm/current.h>
 
 /* Host-dependent types and defines */
 
 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
-#define acpi_cache_t                        kmem_cache_t
-#define acpi_spinlock                       spinlock_t
+#define acpi_cache_t                        struct kmem_cache
+#define acpi_spinlock                   spinlock_t *
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
 
+/* Full namespace pathname length limit - arbitrary */
+#define ACPI_PATHNAME_MAX              256
+
 #else				/* !__KERNEL__ */
 
 #include <stdarg.h>
@@ -93,4 +99,32 @@
 
 #include "acgcc.h"
 
+#define acpi_cpu_flags unsigned long
+
+#define acpi_thread_id struct task_struct *
+
+static inline acpi_thread_id acpi_os_get_thread_id(void) { return current; }
+
+/*
+ * The irqs_disabled() check is for resume from RAM.
+ * Interrupts are off during resume, just like they are for boot.
+ * However, boot has  (system_state != SYSTEM_RUNNING)
+ * to quiet __might_sleep() in kmalloc() and resume does not.
+ */
+#include <acpi/actypes.h>
+static inline void *acpi_os_allocate(acpi_size size) {
+	return kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+}
+static inline void *acpi_os_allocate_zeroed(acpi_size size) {
+	return kzalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+}
+
+static inline void *acpi_os_acquire_object(acpi_cache_t * cache) {
+        return kmem_cache_zalloc(cache, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+}
+
+#define ACPI_ALLOCATE(a)	acpi_os_allocate(a)
+#define ACPI_ALLOCATE_ZEROED(a)	acpi_os_allocate_zeroed(a)
+#define ACPI_FREE(a)		kfree(a)
+
 #endif				/* __ACLINUX_H__ */
diff -Nau acpica-unix-20070126/include/acpi/acresrc.h acpi/include/acpi/acresrc.h
--- acpica-unix-20070126/include/acpi/acresrc.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acresrc.h	2007-01-29 10:57:53.000000000 -0500
@@ -168,6 +168,7 @@
 /*
  * rsutils
  */
+
 acpi_status
 acpi_rs_get_prt_method_data(struct acpi_namespace_node *node,
 			    struct acpi_buffer *ret_buffer);
@@ -206,7 +207,7 @@
 acpi_status
 acpi_rs_convert_aml_to_resources(u8 * aml,
 				 u32 length,
-				 u32 offset, u8 resource_index, void *context);
+				 u32 offset, u8 resource_index, void **context);
 
 acpi_status
 acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
diff -Nau acpica-unix-20070126/include/acpi/acinterp.h acpi/include/acpi/acinterp.h
--- acpica-unix-20070126/include/acpi/acinterp.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acinterp.h	2007-01-29 10:57:53.000000000 -0500
@@ -366,10 +366,12 @@
 		      u32 num_levels,
 		      char *note, char *module_name, u32 line_number);
 
+#ifdef	ACPI_FUTURE_USAGE
 void
 acpi_ex_dump_object_descriptor(union acpi_operand_object *object, u32 flags);
 
 void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags);
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * exnames - AML namestring support
diff -Nau acpica-unix-20070126/include/acpi/acnamesp.h acpi/include/acpi/acnamesp.h
--- acpica-unix-20070126/include/acpi/acnamesp.h	2007-01-29 23:35:53.000000000 -0500
+++ acpi/include/acpi/acnamesp.h	2007-01-29 10:57:53.000000000 -0500
@@ -152,7 +152,9 @@
 /*
  * nsdump - Namespace dump/print utilities
  */
+#ifdef	ACPI_FUTURE_USAGE
 void acpi_ns_dump_tables(acpi_handle search_base, u32 max_depth);
+#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ns_dump_entry(acpi_handle handle, u32 debug_level);
 
@@ -165,11 +167,13 @@
 acpi_ns_dump_one_object(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value);
 
+#ifdef	ACPI_FUTURE_USAGE
 void
 acpi_ns_dump_objects(acpi_object_type type,
 		     u8 display_type,
 		     u32 max_depth,
 		     acpi_owner_id owner_id, acpi_handle start_handle);
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * nseval - Namespace evaluation functions
