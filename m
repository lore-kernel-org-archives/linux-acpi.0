From: Len Brown <len.brown@intel.com>
Subject: Linux/ACPI vs ACPICA audit -- ACPICA 20060707
Date: Fri, 7 Jul 2006 20:57:27 -0400
Message-ID: <200607072057.27329.len.brown@intel.com>
References: <200606280108.28321.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64610 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932470AbWGHA4E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jul 2006 20:56:04 -0400
In-Reply-To: <200606280108.28321.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

For the files that Linux gets from ACPICA, this diff shows how Linux
has diverged from upstream.

acpica-unix-20060707.audit.diff:# 42 files changed, 211 insertions(+), 92 deletions(-)
acpica-unix-20060623.audit.diff:# 37 files changed, 198 insertions(+), 78 deletions(-)
acpica-unix-20060608.audit.diff:# 35 files changed, 190 insertions(+), 70 deletions(-)
acpica-unix-20060526.audit.diff:# 34 files changed, 162 insertions(+), 53 deletions(-)
acpica-unix-20060512.audit.diff:# 34 files changed, 163 insertions(+), 53 deletions(-)

# 142 ACPICA files
# drivers/acpi/dispatcher/dswstate.c |    2 
# drivers/acpi/events/evxface.c      |   83 +++++++++++++----
# drivers/acpi/events/evxfevnt.c     |    2 
# drivers/acpi/executer/excreate.c   |    2 
# drivers/acpi/hardware/hwgpe.c      |    2 
# drivers/acpi/hardware/hwsleep.c    |   24 ----
# drivers/acpi/namespace/nsdump.c    |    6 -
# drivers/acpi/namespace/nsxfeval.c  |    4 
# drivers/acpi/parser/pstree.c       |    2 
# drivers/acpi/parser/psutils.c      |    4 
# drivers/acpi/resources/rsinfo.c    |    2 
# drivers/acpi/resources/rslist.c    |    2 
# drivers/acpi/resources/rsutils.c   |    2 
# drivers/acpi/resources/rsxface.c   |    4 
# drivers/acpi/tables/tbconvrt.c     |   11 +-
# drivers/acpi/tables/tbxface.c      |    2 
# drivers/acpi/utilities/utalloc.c   |    4 
# drivers/acpi/utilities/utcache.c   |    2 
# drivers/acpi/utilities/utdebug.c   |    4 
# drivers/acpi/utilities/utglobal.c  |   11 --
# drivers/acpi/utilities/utmisc.c    |    3 
# drivers/acpi/utilities/utmutex.c   |   15 +--
# drivers/acpi/utilities/utobject.c  |    1 
# drivers/acpi/utilities/utresrc.c   |    6 -
# drivers/acpi/utilities/utstate.c   |    1 
# drivers/acpi/utilities/utxface.c   |    2 
# include/acpi/acdebug.h             |    2 
# include/acpi/acdispat.h            |    2 
# include/acpi/acglobal.h            |    6 -
# include/acpi/achware.h             |    4 
# include/acpi/acinterp.h            |    2 
# include/acpi/aclocal.h             |    2 
# include/acpi/acmacros.h            |    2 
# include/acpi/acnamesp.h            |    4 
# include/acpi/acparser.h            |    4 
# include/acpi/acpiosxf.h            |   17 ++-
# include/acpi/acpixf.h              |   24 ++++
# include/acpi/acresrc.h             |    3 
# include/acpi/actbl.h               |    2 
# include/acpi/actbl1.h              |    2 
# include/acpi/acutils.h             |    8 +
# include/acpi/platform/aclinux.h    |   16 ++-
# 42 files changed, 211 insertions(+), 92 deletions(-)

diff -Nau acpica-unix-20060707/drivers/acpi/hardware/hwsleep.c linux-acpi-2.6/drivers/acpi/hardware/hwsleep.c
--- acpica-unix-20060707/drivers/acpi/hardware/hwsleep.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/hardware/hwsleep.c	2006-06-15 23:16:30.000000000 -0400
@@ -93,6 +93,7 @@
  * DESCRIPTION: Access function for the firmware_waking_vector field in FACS
  *
  ******************************************************************************/
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
 {
@@ -119,6 +120,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_firmware_waking_vector)
+#endif
 
 /*******************************************************************************
  *
@@ -219,7 +221,7 @@
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status acpi_enter_sleep_state(u8 sleep_state)
+acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 {
 	u32 PM1Acontrol;
 	u32 PM1Bcontrol;
@@ -257,17 +259,6 @@
 		return_ACPI_STATUS(status);
 	}
 
-	if (sleep_state != ACPI_STATE_S5) {
-
-		/* Disable BM arbitration */
-
-		status = acpi_set_register(ACPI_BITREG_ARB_DISABLE,
-					   1, ACPI_MTX_DO_NOT_LOCK);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
-
 	/*
 	 * 1) Disable/Clear all GPEs
 	 * 2) Enable all wakeup GPEs
@@ -403,7 +394,7 @@
  *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
  *
  ******************************************************************************/
-acpi_status acpi_enter_sleep_state_s4bios(void)
+acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 {
 	u32 in_value;
 	acpi_status status;
@@ -585,13 +576,6 @@
 			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1,
 			      ACPI_MTX_DO_NOT_LOCK);
 
-	/* Enable BM arbitration */
-
-	status = acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
diff -Nau acpica-unix-20060707/drivers/acpi/hardware/hwgpe.c linux-acpi-2.6/drivers/acpi/hardware/hwgpe.c
--- acpica-unix-20060707/drivers/acpi/hardware/hwgpe.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/hardware/hwgpe.c	2006-06-15 23:16:30.000000000 -0400
@@ -132,6 +132,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 		       acpi_event_status * event_status)
@@ -188,6 +189,7 @@
       unlock_and_exit:
 	return (status);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /******************************************************************************
  *
diff -Nau acpica-unix-20060707/drivers/acpi/events/evxfevnt.c linux-acpi-2.6/drivers/acpi/events/evxfevnt.c
--- acpica-unix-20060707/drivers/acpi/events/evxfevnt.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/events/evxfevnt.c	2006-06-15 23:16:30.000000000 -0400
@@ -476,6 +476,7 @@
 
 ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_event_status
@@ -569,6 +570,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20060707/drivers/acpi/events/evxface.c linux-acpi-2.6/drivers/acpi/events/evxface.c
--- acpica-unix-20060707/drivers/acpi/events/evxface.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/events/evxface.c	2006-07-07 20:46:57.000000000 -0400
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
@@ -423,7 +428,7 @@
 	node = acpi_ns_map_handle_to_node(device);
 	if (!node) {
 		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
+		goto unlock;
 	}
 
 	/* Root Object */
@@ -437,7 +442,16 @@
 		    ((handler_type & ACPI_DEVICE_NOTIFY) &&
 		     !acpi_gbl_device_notify.handler)) {
 			status = AE_NOT_EXIST;
-			goto unlock_and_exit;
+			goto unlock;
+		}
+
+		/* Make sure all deferred tasks are completed */
+
+		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+		acpi_os_wait_events_complete(NULL);
+		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE(status)) {
+			goto exit;
 		}
 
 		if (handler_type & ACPI_SYSTEM_NOTIFY) {
@@ -460,7 +474,7 @@
 
 		if (!acpi_ev_is_notify_object(node)) {
 			status = AE_TYPE;
-			goto unlock_and_exit;
+			goto unlock;
 		}
 
 		/* Check for an existing internal object */
@@ -468,7 +482,7 @@
 		obj_desc = acpi_ns_get_attached_object(node);
 		if (!obj_desc) {
 			status = AE_NOT_EXIST;
-			goto unlock_and_exit;
+			goto unlock;
 		}
 
 		/* Object exists - make sure there's an existing handler */
@@ -482,11 +496,18 @@
 
 			if (notify_obj->notify.handler != handler) {
 				status = AE_BAD_PARAMETER;
-				goto unlock_and_exit;
+				goto unlock;
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
@@ -500,18 +521,28 @@
 
 			if (notify_obj->notify.handler != handler) {
 				status = AE_BAD_PARAMETER;
-				goto unlock_and_exit;
+				goto unlock;
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
 	}
 
-      unlock_and_exit:
+unlock:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+exit:
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
@@ -562,7 +594,7 @@
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (!gpe_event_info) {
 		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
+		goto unlock;
 	}
 
 	/* Make sure that there isn't a handler there already */
@@ -570,7 +602,7 @@
 	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 	    ACPI_GPE_DISPATCH_HANDLER) {
 		status = AE_ALREADY_EXISTS;
-		goto unlock_and_exit;
+		goto unlock;
 	}
 
 	/* Allocate and init handler object */
@@ -578,7 +610,7 @@
 	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_handler_info));
 	if (!handler) {
 		status = AE_NO_MEMORY;
-		goto unlock_and_exit;
+		goto unlock;
 	}
 
 	handler->address = address;
@@ -589,7 +621,7 @@
 
 	status = acpi_ev_disable_gpe(gpe_event_info);
 	if (ACPI_FAILURE(status)) {
-		goto unlock_and_exit;
+		goto unlock;
 	}
 
 	/* Install the handler */
@@ -604,8 +636,12 @@
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
-      unlock_and_exit:
+unlock:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+exit:
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
diff -Nau acpica-unix-20060707/drivers/acpi/parser/pstree.c linux-acpi-2.6/drivers/acpi/parser/pstree.c
--- acpica-unix-20060707/drivers/acpi/parser/pstree.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/parser/pstree.c	2006-06-15 23:16:30.000000000 -0400
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
diff -Nau acpica-unix-20060707/drivers/acpi/parser/psutils.c linux-acpi-2.6/drivers/acpi/parser/psutils.c
--- acpica-unix-20060707/drivers/acpi/parser/psutils.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/parser/psutils.c	2006-06-15 23:16:30.000000000 -0400
@@ -139,10 +139,12 @@
 		/* The generic op (default) is by far the most common (16 to 1) */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_cache);
+		memset(op, 0, sizeof(struct acpi_parse_obj_common));
 	} else {
 		/* Extended parseop */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_ext_cache);
+		memset(op, 0, sizeof(struct acpi_parse_obj_named));
 	}
 
 	/* Initialize the Op */
@@ -211,6 +213,7 @@
 /*
  * Get op's name (4-byte name segment) or 0 if unnamed
  */
+#ifdef ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object * op)
 {
 
@@ -224,6 +227,7 @@
 
 	return (op->named.name);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*
  * Set op's name
diff -Nau acpica-unix-20060707/drivers/acpi/tables/tbconvrt.c linux-acpi-2.6/drivers/acpi/tables/tbconvrt.c
--- acpica-unix-20060707/drivers/acpi/tables/tbconvrt.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/tables/tbconvrt.c	2006-06-15 23:16:30.000000000 -0400
@@ -61,6 +61,9 @@
 acpi_tb_convert_fadt2(struct fadt_descriptor *local_fadt,
 		      struct fadt_descriptor *original_fadt);
 
+u8 acpi_fadt_is_v1;
+ACPI_EXPORT_SYMBOL(acpi_fadt_is_v1)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_get_table_count
@@ -221,6 +224,7 @@
 
 	/* ACPI 1.0 FACS */
 	/* The BIOS stored FADT should agree with Revision 1.0 */
+	acpi_fadt_is_v1 = 1;
 
 	/*
 	 * Copy the table header and the common part of the tables.
@@ -252,9 +256,12 @@
 	/*
 	 * Processor Performance State Control. This is the value OSPM writes to
 	 * the SMI_CMD register to assume processor performance state control
-	 * responsibility. There isn't any equivalence in 1.0, leave it zeroed.
+	 * responsibility. There isn't any equivalence in 1.0, but as many 1.x
+	 * ACPI tables contain _PCT and _PSS we also keep this value, unless
+	 * acpi_strict is set.
 	 */
-	local_fadt->pstate_cnt = 0;
+	if (acpi_strict)
+		local_fadt->pstate_cnt = 0;
 
 	/*
 	 * Support for the _CST object and C States change notification.
diff -Nau acpica-unix-20060707/drivers/acpi/tables/tbxface.c linux-acpi-2.6/drivers/acpi/tables/tbxface.c
--- acpica-unix-20060707/drivers/acpi/tables/tbxface.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/tables/tbxface.c	2006-07-07 20:46:57.000000000 -0400
@@ -123,6 +123,7 @@
 
 ACPI_EXPORT_SYMBOL(acpi_load_tables)
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_load_table
@@ -332,6 +333,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_table_header)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20060707/drivers/acpi/dispatcher/dswstate.c linux-acpi-2.6/drivers/acpi/dispatcher/dswstate.c
--- acpica-unix-20060707/drivers/acpi/dispatcher/dswstate.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/dispatcher/dswstate.c	2006-06-15 23:16:30.000000000 -0400
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
diff -Nau acpica-unix-20060707/drivers/acpi/resources/rsinfo.c linux-acpi-2.6/drivers/acpi/resources/rsinfo.c
--- acpica-unix-20060707/drivers/acpi/resources/rsinfo.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/resources/rsinfo.c	2006-06-15 23:16:30.000000000 -0400
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
diff -Nau acpica-unix-20060707/drivers/acpi/resources/rslist.c linux-acpi-2.6/drivers/acpi/resources/rslist.c
--- acpica-unix-20060707/drivers/acpi/resources/rslist.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/resources/rslist.c	2006-06-15 23:16:30.000000000 -0400
@@ -64,7 +64,7 @@
 acpi_status
 acpi_rs_convert_aml_to_resources(u8 * aml,
 				 u32 length,
-				 u32 offset, u8 resource_index, void *context)
+				 u32 offset, u8 resource_index, void **context)
 {
 	struct acpi_resource **resource_ptr =
 	    ACPI_CAST_INDIRECT_PTR(struct acpi_resource, context);
diff -Nau acpica-unix-20060707/drivers/acpi/resources/rsutils.c linux-acpi-2.6/drivers/acpi/resources/rsutils.c
--- acpica-unix-20060707/drivers/acpi/resources/rsutils.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/resources/rsutils.c	2006-06-30 02:58:48.000000000 -0400
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
diff -Nau acpica-unix-20060707/drivers/acpi/resources/rsxface.c linux-acpi-2.6/drivers/acpi/resources/rsxface.c
--- acpica-unix-20060707/drivers/acpi/resources/rsxface.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/resources/rsxface.c	2006-06-15 23:16:30.000000000 -0400
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
diff -Nau acpica-unix-20060707/drivers/acpi/executer/excreate.c linux-acpi-2.6/drivers/acpi/executer/excreate.c
--- acpica-unix-20060707/drivers/acpi/executer/excreate.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/executer/excreate.c	2006-06-30 14:28:00.000000000 -0400
@@ -63,7 +63,7 @@
  * DESCRIPTION: Create a new named alias
  *
  ******************************************************************************/
-acpi_status acpi_ex_create_alias(struct acpi_walk_state * walk_state)
+acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 {
 	struct acpi_namespace_node *target_node;
 	struct acpi_namespace_node *alias_node;
diff -Nau acpica-unix-20060707/drivers/acpi/namespace/nsdump.c linux-acpi-2.6/drivers/acpi/namespace/nsdump.c
--- acpica-unix-20060707/drivers/acpi/namespace/nsdump.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/namespace/nsdump.c	2006-06-15 23:16:30.000000000 -0400
@@ -588,6 +588,7 @@
 	return (AE_OK);
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_objects
@@ -626,6 +627,7 @@
 				     acpi_ns_dump_one_object, (void *)&info,
 				     NULL);
 }
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*******************************************************************************
  *
@@ -697,5 +699,5 @@
 			     ACPI_OWNER_ID_MAX, search_handle);
 	return_VOID;
 }
-#endif
-#endif
+#endif				/* _ACPI_ASL_COMPILER */
+#endif				/* defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER) */
diff -Nau acpica-unix-20060707/drivers/acpi/namespace/nsxfeval.c linux-acpi-2.6/drivers/acpi/namespace/nsxfeval.c
--- acpica-unix-20060707/drivers/acpi/namespace/nsxfeval.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/namespace/nsxfeval.c	2006-07-01 17:18:26.000000000 -0400
@@ -49,6 +49,7 @@
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsxfeval")
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_evaluate_object_typed
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
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utmisc.c linux-acpi-2.6/drivers/acpi/utilities/utmisc.c
--- acpica-unix-20060707/drivers/acpi/utilities/utmisc.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utmisc.c	2006-07-07 20:46:57.000000000 -0400
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
@@ -975,6 +977,7 @@
 	acpi_os_vprintf(format, args);
 	acpi_os_printf(" [%X]\n", ACPI_CA_VERSION);
 }
+EXPORT_SYMBOL(acpi_ut_exception);
 
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_warning(char *module_name, u32 line_number, char *format, ...)
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utxface.c linux-acpi-2.6/drivers/acpi/utilities/utxface.c
--- acpica-unix-20060707/drivers/acpi/utilities/utxface.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utxface.c	2006-06-30 03:04:26.000000000 -0400
@@ -351,6 +351,7 @@
 
 ACPI_EXPORT_SYMBOL(acpi_terminate)
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_subsystem_status
@@ -491,6 +492,7 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_initialization_handler)
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*****************************************************************************
  *
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utdebug.c linux-acpi-2.6/drivers/acpi/utilities/utdebug.c
--- acpica-unix-20060707/drivers/acpi/utilities/utdebug.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utdebug.c	2006-07-07 20:46:53.000000000 -0400
@@ -47,7 +47,7 @@
 ACPI_MODULE_NAME("utdebug")
 
 #ifdef ACPI_DEBUG_OUTPUT
-static u32 acpi_gbl_prev_thread_id = 0xFFFFFFFF;
+static acpi_thread_id acpi_gbl_prev_thread_id;
 static char *acpi_gbl_fn_entry_str = "----Entry";
 static char *acpi_gbl_fn_exit_str = "----Exit-";
 
@@ -181,7 +181,7 @@
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
 			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     acpi_gbl_prev_thread_id, thread_id);
+			     (u32) acpi_gbl_prev_thread_id, (u32) thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utresrc.c linux-acpi-2.6/drivers/acpi/utilities/utresrc.c
--- acpica-unix-20060707/drivers/acpi/utilities/utresrc.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utresrc.c	2006-06-30 03:04:26.000000000 -0400
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
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utstate.c linux-acpi-2.6/drivers/acpi/utilities/utstate.c
--- acpica-unix-20060707/drivers/acpi/utilities/utstate.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utstate.c	2006-07-07 20:46:57.000000000 -0400
@@ -161,6 +161,7 @@
 	if (state) {
 
 		/* Initialize */
+		memset(state, 0, sizeof(union acpi_generic_state));
 		state->common.descriptor_type = ACPI_DESC_TYPE_STATE;
 	}
 
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utglobal.c linux-acpi-2.6/drivers/acpi/utilities/utglobal.c
--- acpica-unix-20060707/drivers/acpi/utilities/utglobal.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utglobal.c	2006-06-30 14:28:00.000000000 -0400
@@ -142,16 +142,11 @@
  */
 
 /* Debug switch - level and trace mask */
-
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
@@ -845,7 +840,5 @@
 	return_VOID;
 }
 
-/* Public globals */
-
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
-    ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
+ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utmutex.c linux-acpi-2.6/drivers/acpi/utilities/utmutex.c
--- acpica-unix-20060707/drivers/acpi/utilities/utmutex.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utmutex.c	2006-07-07 20:46:53.000000000 -0400
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
 
@@ -247,14 +244,14 @@
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
 			  "Thread %X attempting to acquire Mutex [%s]\n",
-			  this_thread_id, acpi_ut_get_mutex_name(mutex_id)));
+			  (u32) this_thread_id, acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
 				  "Thread %X acquired Mutex [%s]\n",
-				  this_thread_id,
+				  (u32) this_thread_id,
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
@@ -262,7 +259,7 @@
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Thread %X could not acquire Mutex [%X]",
-				this_thread_id, mutex_id));
+				(u32) this_thread_id, mutex_id));
 	}
 
 	return (status);
@@ -288,7 +285,7 @@
 
 	this_thread_id = acpi_os_get_thread_id();
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X releasing Mutex [%s]\n", this_thread_id,
+			  "Thread %X releasing Mutex [%s]\n", (u32) this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utalloc.c linux-acpi-2.6/drivers/acpi/utilities/utalloc.c
--- acpica-unix-20060707/drivers/acpi/utilities/utalloc.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utalloc.c	2006-07-01 17:18:26.000000000 -0400
@@ -166,10 +166,10 @@
 
 	/* Free memory lists */
 
-	acpi_os_free(acpi_gbl_global_list);
+	ACPI_FREE(acpi_gbl_global_list);
 	acpi_gbl_global_list = NULL;
 
-	acpi_os_free(acpi_gbl_ns_node_list);
+	ACPI_FREE(acpi_gbl_ns_node_list);
 	acpi_gbl_ns_node_list = NULL;
 #endif
 
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utobject.c linux-acpi-2.6/drivers/acpi/utilities/utobject.c
--- acpica-unix-20060707/drivers/acpi/utilities/utobject.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utobject.c	2006-06-30 03:04:26.000000000 -0400
@@ -321,6 +321,7 @@
 
 	/* Mark the descriptor type */
 
+	memset(object, 0, sizeof(union acpi_operand_object));
 	ACPI_SET_DESCRIPTOR_TYPE(object, ACPI_DESC_TYPE_OPERAND);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p Size %X\n",
diff -Nau acpica-unix-20060707/drivers/acpi/utilities/utcache.c linux-acpi-2.6/drivers/acpi/utilities/utcache.c
--- acpica-unix-20060707/drivers/acpi/utilities/utcache.c	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/drivers/acpi/utilities/utcache.c	2006-07-01 17:18:26.000000000 -0400
@@ -162,7 +162,7 @@
 
 	/* Now we can delete the cache object */
 
-	acpi_os_free(cache);
+	ACPI_FREE(cache);
 	return (AE_OK);
 }
 
diff -Nau acpica-unix-20060707/include/acpi/acutils.h linux-acpi-2.6/include/acpi/acutils.h
--- acpica-unix-20060707/include/acpi/acutils.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acutils.h	2006-06-30 21:38:56.000000000 -0400
@@ -81,7 +81,7 @@
 acpi_status(*acpi_walk_aml_callback) (u8 * aml,
 				      u32 length,
 				      u32 offset,
-				      u8 resource_index, void *context);
+				      u8 resource_index, void **context);
 
 typedef
 acpi_status(*acpi_pkg_callback) (u8 object_type,
@@ -425,11 +425,13 @@
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
 
diff -Nau acpica-unix-20060707/include/acpi/achware.h linux-acpi-2.6/include/acpi/achware.h
--- acpica-unix-20060707/include/acpi/achware.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/achware.h	2006-03-31 00:46:34.000000000 -0500
@@ -102,9 +102,11 @@
 acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			struct acpi_gpe_block_info *gpe_block);
 
+#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status * event_status);
+#endif				/* ACPI_FUTURE_USAGE */
 
 acpi_status acpi_hw_disable_all_gpes(void);
 
@@ -116,6 +118,7 @@
 acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block);
 
+#ifdef	ACPI_FUTURE_USAGE
 /*
  * hwtimer - ACPI Timer prototypes
  */
@@ -125,5 +128,6 @@
 
 acpi_status
 acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed);
+#endif				/* ACPI_FUTURE_USAGE */
 
 #endif				/* __ACHWARE_H__ */
diff -Nau acpica-unix-20060707/include/acpi/acinterp.h linux-acpi-2.6/include/acpi/acinterp.h
--- acpica-unix-20060707/include/acpi/acinterp.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acinterp.h	2006-07-07 20:46:57.000000000 -0400
@@ -372,10 +372,12 @@
 		      u32 num_levels,
 		      char *note, char *module_name, u32 line_number);
 
+#ifdef	ACPI_FUTURE_USAGE
 void
 acpi_ex_dump_object_descriptor(union acpi_operand_object *object, u32 flags);
 
 void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags);
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * exnames - AML namestring support
diff -Nau acpica-unix-20060707/include/acpi/acnamesp.h linux-acpi-2.6/include/acpi/acnamesp.h
--- acpica-unix-20060707/include/acpi/acnamesp.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acnamesp.h	2006-06-15 23:16:34.000000000 -0400
@@ -147,7 +147,9 @@
 /*
  * nsdump - Namespace dump/print utilities
  */
+#ifdef	ACPI_FUTURE_USAGE
 void acpi_ns_dump_tables(acpi_handle search_base, u32 max_depth);
+#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ns_dump_entry(acpi_handle handle, u32 debug_level);
 
@@ -160,11 +162,13 @@
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
diff -Nau acpica-unix-20060707/include/acpi/acdebug.h linux-acpi-2.6/include/acpi/acdebug.h
--- acpica-unix-20060707/include/acpi/acdebug.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acdebug.h	2006-03-31 00:46:34.000000000 -0500
@@ -196,8 +196,6 @@
 
 void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context);
 
-acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op);
-
 /*
  * dbstats - Generation and display of ACPI table statistics
  */
diff -Nau acpica-unix-20060707/include/acpi/acresrc.h linux-acpi-2.6/include/acpi/acresrc.h
--- acpica-unix-20060707/include/acpi/acresrc.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acresrc.h	2006-07-07 20:46:57.000000000 -0400
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
diff -Nau acpica-unix-20060707/include/acpi/acpixf.h linux-acpi-2.6/include/acpi/acpixf.h
--- acpica-unix-20060707/include/acpi/acpixf.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acpixf.h	2006-06-15 23:16:34.000000000 -0400
@@ -59,20 +59,26 @@
 
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
@@ -91,6 +97,7 @@
 
 acpi_status acpi_load_tables(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_load_table(struct acpi_table_header *table_ptr);
 
 acpi_status acpi_unload_table(acpi_table_type table_type);
@@ -98,6 +105,7 @@
 acpi_status
 acpi_get_table_header(acpi_table_type table_type,
 		      u32 instance, struct acpi_table_header *out_table_header);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_get_table(acpi_table_type table_type,
@@ -153,12 +161,14 @@
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
@@ -207,7 +217,9 @@
 			 u32 gpe_number,
 			 u32 type, acpi_event_handler address, void *context);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
+#endif
 
 /*
  * Event interfaces
@@ -226,7 +238,9 @@
 
 acpi_status acpi_clear_event(u32 event);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status acpi_set_gpe_type(acpi_handle gpe_device, u32 gpe_number, u8 type);
 
@@ -236,10 +250,12 @@
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number,
 		    u32 flags, acpi_event_status * event_status);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_install_gpe_block(acpi_handle gpe_device,
@@ -265,9 +281,11 @@
 acpi_get_current_resources(acpi_handle device_handle,
 			   struct acpi_buffer *ret_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_possible_resources(acpi_handle device_handle,
 			    struct acpi_buffer *ret_buffer);
+#endif
 
 acpi_status
 acpi_walk_resources(acpi_handle device_handle,
@@ -296,17 +314,19 @@
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
 
diff -Nau acpica-unix-20060707/include/acpi/actbl.h linux-acpi-2.6/include/acpi/actbl.h
--- acpica-unix-20060707/include/acpi/actbl.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/actbl.h	2006-06-15 23:16:34.000000000 -0400
@@ -354,6 +354,8 @@
 	u8 flags;
 };
 
+extern u8 acpi_fadt_is_v1;	/* is set to 1 if FADT is revision 1,
+				 * needed for certain workarounds */
 /* Macros used to generate offsets to specific table fields */
 
 #define ACPI_FACS_OFFSET(f)             (u8) ACPI_OFFSET (struct facs_descriptor,f)
diff -Nau acpica-unix-20060707/include/acpi/actbl1.h linux-acpi-2.6/include/acpi/actbl1.h
--- acpica-unix-20060707/include/acpi/actbl1.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/actbl1.h	2006-06-15 23:16:34.000000000 -0400
@@ -398,6 +398,7 @@
 	u32 flags;		/* Interrupt Source Flags */
 };
 
+#ifdef DUPLICATE_DEFINITION_WITH_LINUX_ACPI_H
 /*******************************************************************************
  *
  * MCFG - PCI Memory Mapped Configuration table and sub-table
@@ -415,6 +416,7 @@
 	u8 end_bus_number;	/* Final PCI Bus number */
 	u32 reserved;
 };
+#endif
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20060707/include/acpi/acdispat.h linux-acpi-2.6/include/acpi/acdispat.h
--- acpica-unix-20060707/include/acpi/acdispat.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acdispat.h	2006-06-30 14:28:05.000000000 -0400
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
diff -Nau acpica-unix-20060707/include/acpi/acmacros.h linux-acpi-2.6/include/acpi/acmacros.h
--- acpica-unix-20060707/include/acpi/acmacros.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acmacros.h	2006-07-01 17:18:26.000000000 -0400
@@ -726,7 +726,7 @@
 
 #define ACPI_ALLOCATE(a)            acpi_ut_allocate((acpi_size)(a),_COMPONENT,_acpi_module_name,__LINE__)
 #define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed((acpi_size)(a), _COMPONENT,_acpi_module_name,__LINE__)
-#define ACPI_FREE(a)                acpi_os_free(a)
+#define ACPI_FREE(a)                kfree(a)
 #define ACPI_MEM_TRACKING(a)
 
 #else
diff -Nau acpica-unix-20060707/include/acpi/aclocal.h linux-acpi-2.6/include/acpi/aclocal.h
--- acpica-unix-20060707/include/acpi/aclocal.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/aclocal.h	2006-07-07 20:46:58.000000000 -0400
@@ -127,7 +127,7 @@
 
 /* This Thread ID means that the mutex is not in use (unlocked) */
 
-#define ACPI_MUTEX_NOT_ACQUIRED         (u32) -1
+#define ACPI_MUTEX_NOT_ACQUIRED         (acpi_thread_id) 0
 
 /* Table for the global mutexes */
 
diff -Nau acpica-unix-20060707/include/acpi/platform/aclinux.h linux-acpi-2.6/include/acpi/platform/aclinux.h
--- acpica-unix-20060707/include/acpi/platform/aclinux.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/platform/aclinux.h	2006-07-07 20:46:54.000000000 -0400
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
 #define acpi_cache_t                        kmem_cache_t
-#define acpi_spinlock                       spinlock_t
+#define acpi_spinlock                   spinlock_t *
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
 #define strtoul                     simple_strtoul
 
+/* Full namespace pathname length limit - arbitrary */
+#define ACPI_PATHNAME_MAX              256
+
 #else				/* !__KERNEL__ */
 
 #include <stdarg.h>
@@ -93,4 +99,10 @@
 
 #include "acgcc.h"
 
+#define acpi_cpu_flags unsigned long
+
+#define acpi_thread_id struct task_struct *
+
+static inline acpi_thread_id acpi_os_get_thread_id(void) { return current; }
+
 #endif				/* __ACLINUX_H__ */
diff -Nau acpica-unix-20060707/include/acpi/acparser.h linux-acpi-2.6/include/acpi/acparser.h
--- acpica-unix-20060707/include/acpi/acparser.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acparser.h	2006-06-15 23:16:34.000000000 -0400
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
 
diff -Nau acpica-unix-20060707/include/acpi/acglobal.h linux-acpi-2.6/include/acpi/acglobal.h
--- acpica-unix-20060707/include/acpi/acglobal.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acglobal.h	2006-06-30 14:28:05.000000000 -0400
@@ -203,8 +203,10 @@
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
diff -Nau acpica-unix-20060707/include/acpi/acpiosxf.h linux-acpi-2.6/include/acpi/acpiosxf.h
--- acpica-unix-20060707/include/acpi/acpiosxf.h	2006-07-07 20:33:32.000000000 -0400
+++ linux-acpi-2.6/include/acpi/acpiosxf.h	2006-07-07 19:19:30.000000000 -0400
@@ -143,17 +143,17 @@
  */
 void *acpi_os_allocate(acpi_size size);
 
-void acpi_os_free(void *memory);
-
 acpi_status
 acpi_os_map_memory(acpi_physical_address physical_address,
-		   acpi_size size, void **logical_address);
+		   acpi_size size, void __iomem ** logical_address);
 
-void acpi_os_unmap_memory(void *logical_address, acpi_size size);
+void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address(void *logical_address,
 			     acpi_physical_address * physical_address);
+#endif
 
 /*
  * Memory/Object Cache
@@ -175,13 +175,12 @@
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
@@ -245,7 +244,9 @@
 
 u8 acpi_os_readable(void *pointer, acpi_size length);
 
+#ifdef ACPI_FUTURE_USAGE
 u8 acpi_os_writable(void *pointer, acpi_size length);
+#endif
 
 u64 acpi_os_get_timer(void);
 
@@ -260,10 +261,12 @@
 
 void acpi_os_redirect_output(void *destination);
 
+#ifdef ACPI_FUTURE_USAGE
 /*
  * Debug input
  */
 u32 acpi_os_get_line(char *buffer);
+#endif
 
 /*
  * Directory manipulation
