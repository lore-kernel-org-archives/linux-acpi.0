From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/20] ACPICA: Linuxize: Change indentation of C labels.
Date: Tue, 29 Oct 2013 09:30:02 +0800
Message-ID: <a913d02531f101a9fd8c0eb51a0a805632af55b8.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30085 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2BaP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:15 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

It is reported by kernel build test systems that all ACPICA linuxized
files have incorrect label indentation.  This patch changes default indent
option used in the release process to fix this bug.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsargs.c    |    2 +-
 drivers/acpi/acpica/dsfield.c   |    2 +-
 drivers/acpi/acpica/dsmethod.c  |    4 ++--
 drivers/acpi/acpica/dsobject.c  |    2 +-
 drivers/acpi/acpica/dsopcode.c  |    2 +-
 drivers/acpi/acpica/dsutils.c   |   10 +++++-----
 drivers/acpi/acpica/dswexec.c   |    6 +++---
 drivers/acpi/acpica/dswload2.c  |    2 +-
 drivers/acpi/acpica/evglock.c   |    2 +-
 drivers/acpi/acpica/evgpe.c     |    2 +-
 drivers/acpi/acpica/evgpeblk.c  |    6 +++---
 drivers/acpi/acpica/evgpeinit.c |    2 +-
 drivers/acpi/acpica/evgpeutil.c |    2 +-
 drivers/acpi/acpica/evhandler.c |    4 ++--
 drivers/acpi/acpica/evregion.c  |    6 +++---
 drivers/acpi/acpica/evxface.c   |   12 ++++++------
 drivers/acpi/acpica/evxfgpe.c   |    6 +++---
 drivers/acpi/acpica/evxfregn.c  |    4 ++--
 drivers/acpi/acpica/excreate.c  |    8 ++++----
 drivers/acpi/acpica/exfield.c   |    2 +-
 drivers/acpi/acpica/exfldio.c   |    2 +-
 drivers/acpi/acpica/exmisc.c    |    4 ++--
 drivers/acpi/acpica/exoparg1.c  |    8 ++++----
 drivers/acpi/acpica/exoparg2.c  |   10 +++++-----
 drivers/acpi/acpica/exoparg3.c  |    4 ++--
 drivers/acpi/acpica/exoparg6.c  |    2 +-
 drivers/acpi/acpica/exresolv.c  |    2 +-
 drivers/acpi/acpica/exresop.c   |    2 +-
 drivers/acpi/acpica/hwregs.c    |    2 +-
 drivers/acpi/acpica/hwxface.c   |    4 ++--
 drivers/acpi/acpica/nsaccess.c  |    2 +-
 drivers/acpi/acpica/nsdump.c    |    2 +-
 drivers/acpi/acpica/nseval.c    |    4 ++--
 drivers/acpi/acpica/nsinit.c    |    2 +-
 drivers/acpi/acpica/nsload.c    |    2 +-
 drivers/acpi/acpica/nsparse.c   |    2 +-
 drivers/acpi/acpica/nspredef.c  |    2 +-
 drivers/acpi/acpica/nsprepkg.c  |    4 ++--
 drivers/acpi/acpica/nsrepair.c  |    2 +-
 drivers/acpi/acpica/nsrepair2.c |    2 +-
 drivers/acpi/acpica/nsutils.c   |    2 +-
 drivers/acpi/acpica/nsxfeval.c  |   12 ++++++------
 drivers/acpi/acpica/nsxfname.c  |    4 ++--
 drivers/acpi/acpica/nsxfobj.c   |    4 ++--
 drivers/acpi/acpica/psparse.c   |    2 +-
 drivers/acpi/acpica/psxface.c   |    6 +++---
 drivers/acpi/acpica/rsmisc.c    |    4 ++--
 drivers/acpi/acpica/rsutils.c   |    2 +-
 drivers/acpi/acpica/tbinstal.c  |    6 +++---
 drivers/acpi/acpica/tbutils.c   |    2 +-
 drivers/acpi/acpica/tbxface.c   |    4 ++--
 drivers/acpi/acpica/tbxfload.c  |    4 ++--
 drivers/acpi/acpica/utcopy.c    |    4 ++--
 drivers/acpi/acpica/utdelete.c  |    2 +-
 drivers/acpi/acpica/uteval.c    |    2 +-
 drivers/acpi/acpica/utids.c     |    2 +-
 drivers/acpi/acpica/utownerid.c |    2 +-
 drivers/acpi/acpica/utresrc.c   |    4 ++--
 drivers/acpi/acpica/utstring.c  |    4 ++--
 drivers/acpi/acpica/uttrack.c   |    2 +-
 60 files changed, 112 insertions(+), 112 deletions(-)

diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index fb09b08..afdc6df 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -158,7 +158,7 @@ acpi_ds_execute_arguments(struct acpi_namespace_node *node,
 	walk_state->deferred_node = node;
 	status = acpi_ps_parse_aml(walk_state);
 
-      cleanup:
+cleanup:
 	acpi_ps_delete_parse_tree(op);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index d4bfe7b..2d4c073 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -259,7 +259,7 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 		goto cleanup;
 	}
 
-      cleanup:
+cleanup:
 
 	/* Remove local reference to the object */
 
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index a9ffd44..df3ea12 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -294,7 +294,7 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 	obj_desc->method.thread_count++;
 	return_ACPI_STATUS(status);
 
-      cleanup:
+cleanup:
 	/* On error, must release the method mutex (if present) */
 
 	if (obj_desc->method.mutex) {
@@ -424,7 +424,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 
 	return_ACPI_STATUS(status);
 
-      cleanup:
+cleanup:
 
 	/* On error, we must terminate the method properly */
 
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 63f0d22..b1746a6 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -240,7 +240,7 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(status);
 	}
 
-      exit:
+exit:
 	*obj_desc_ptr = obj_desc;
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 1fc1ff1..5205edc 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -257,7 +257,7 @@ acpi_ds_init_buffer_field(u16 aml_opcode,
 	    (buffer_desc->common.reference_count +
 	     obj_desc->common.reference_count);
 
-      cleanup:
+cleanup:
 
 	/* Always delete the operands */
 
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index c666fc0..ade44e4 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -299,7 +299,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 		goto result_used;
 	}
 
-      result_used:
+result_used:
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "Result of [%s] used by Parent [%s] Op=%p\n",
 			  acpi_ps_get_opcode_name(op->common.aml_opcode),
@@ -308,7 +308,7 @@ acpi_ds_is_result_used(union acpi_parse_object * op,
 
 	return_UINT8(TRUE);
 
-      result_not_used:
+result_not_used:
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "Result of [%s] not used by Parent [%s] Op=%p\n",
 			  acpi_ps_get_opcode_name(op->common.aml_opcode),
@@ -752,7 +752,7 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 
 	return_ACPI_STATUS(status);
 
-      cleanup:
+cleanup:
 	/*
 	 * We must undo everything done above; meaning that we must
 	 * pop everything off of the operand stack and delete those
@@ -851,7 +851,7 @@ acpi_status acpi_ds_evaluate_name_path(struct acpi_walk_state *walk_state)
 		goto exit;
 	}
 
-      push_result:
+push_result:
 
 	walk_state->result_obj = new_obj_desc;
 
@@ -863,7 +863,7 @@ acpi_status acpi_ds_evaluate_name_path(struct acpi_walk_state *walk_state)
 		op->common.flags |= ACPI_PARSEOP_IN_STACK;
 	}
 
-      exit:
+exit:
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 151d924..1bbb22f 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -170,7 +170,7 @@ acpi_ds_get_predicate_value(struct acpi_walk_state *walk_state,
 
 	(void)acpi_ds_do_implicit_return(local_obj_desc, walk_state, TRUE);
 
-      cleanup:
+cleanup:
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Completed a predicate eval=%X Op=%p\n",
 			  walk_state->control_state->common.value,
@@ -335,7 +335,7 @@ acpi_ds_exec_begin_op(struct acpi_walk_state *walk_state,
 
 	return_ACPI_STATUS(status);
 
-      error_exit:
+error_exit:
 	status = acpi_ds_method_error(status, walk_state);
 	return_ACPI_STATUS(status);
 }
@@ -722,7 +722,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 		walk_state->result_obj = NULL;
 	}
 
-      cleanup:
+cleanup:
 
 	if (walk_state->result_obj) {
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index b1f8f47..7f569d5 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -728,7 +728,7 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 		break;
 	}
 
-      cleanup:
+cleanup:
 
 	/* Remove the Node pushed at the very beginning */
 
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index fdb0a76..4c67193 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -173,7 +173,7 @@ static u32 acpi_ev_global_lock_handler(void *context)
 
 	acpi_gbl_global_lock_pending = FALSE;
 
-      cleanup_and_exit:
+cleanup_and_exit:
 
 	acpi_os_release_lock(acpi_gbl_global_lock_pending_lock, flags);
 	return (ACPI_INTERRUPT_HANDLED);
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 1979a25..a9cb4a1 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -458,7 +458,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 		gpe_block = gpe_block->next;
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return (int_status);
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index c1aa1ed..a9e76bc 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -111,7 +111,7 @@ acpi_ev_install_gpe_block(struct acpi_gpe_block_info *gpe_block,
 	gpe_block->xrupt_block = gpe_xrupt_block;
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
-      unlock_and_exit:
+unlock_and_exit:
 	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
@@ -178,7 +178,7 @@ acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 	ACPI_FREE(gpe_block->event_info);
 	ACPI_FREE(gpe_block);
 
-      unlock_and_exit:
+unlock_and_exit:
 	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
@@ -302,7 +302,7 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 
 	return_ACPI_STATUS(AE_OK);
 
-      error_exit:
+error_exit:
 	if (gpe_register_info) {
 		ACPI_FREE(gpe_register_info);
 	}
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 7842700..a3e2f38 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -203,7 +203,7 @@ acpi_status acpi_ev_gpe_initialize(void)
 		goto cleanup;
 	}
 
-      cleanup:
+cleanup:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index d523390..d3f5e1e 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -101,7 +101,7 @@ acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback, void *context)
 		gpe_xrupt_info = gpe_xrupt_info->next;
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 068af96..e315731 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -129,7 +129,7 @@ acpi_status acpi_ev_install_region_handlers(void)
 		}
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
@@ -531,6 +531,6 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 					acpi_ev_install_handler, NULL,
 					handler_obj, NULL);
 
-      unlock_and_exit:
+unlock_and_exit:
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 6293d6b..144cbb9 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -573,10 +573,10 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 	status = acpi_ns_evaluate(info);
 	acpi_ut_remove_reference(args[1]);
 
-      cleanup2:
+cleanup2:
 	acpi_ut_remove_reference(args[0]);
 
-      cleanup1:
+cleanup1:
 	ACPI_FREE(info);
 	return_ACPI_STATUS(status);
 }
@@ -761,7 +761,7 @@ acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node)
 
 	status = acpi_evaluate_object(reg_method, NULL, &args, NULL);
 
-      exit:
+exit:
 	/* We ignore all errors from above, don't care */
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 6d88b13..23a7fad 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -375,7 +375,7 @@ acpi_status acpi_install_exception_handler(acpi_exception_handler handler)
 
 	acpi_gbl_exception_handler = handler;
 
-      cleanup:
+cleanup:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
@@ -445,12 +445,12 @@ acpi_status acpi_install_sci_handler(acpi_sci_handler address, void *context)
 	new_sci_handler->next = acpi_gbl_sci_handler_list;
 	acpi_gbl_sci_handler_list = new_sci_handler;
 
-      unlock_and_exit:
+unlock_and_exit:
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 
-      exit:
+exit:
 	if (ACPI_FAILURE(status)) {
 		ACPI_FREE(new_sci_handler);
 	}
@@ -517,7 +517,7 @@ acpi_status acpi_remove_sci_handler(acpi_sci_handler address)
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	status = AE_NOT_EXIST;
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
@@ -566,7 +566,7 @@ acpi_install_global_event_handler(acpi_gbl_event_handler handler, void *context)
 	acpi_gbl_global_event_handler = handler;
 	acpi_gbl_global_event_handler_context = context;
 
-      cleanup:
+cleanup:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
@@ -638,7 +638,7 @@ acpi_install_fixed_event_handler(u32 event,
 				  handler));
 	}
 
-      cleanup:
+cleanup:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index fab40d9..5713da7 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -472,7 +472,7 @@ acpi_get_gpe_status(acpi_handle gpe_device,
 	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)
 		*event_status |= ACPI_EVENT_FLAG_HANDLE;
 
-      unlock_and_exit:
+unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
@@ -625,7 +625,7 @@ acpi_install_gpe_block(acpi_handle gpe_device,
 
 	obj_desc->device.gpe_block = gpe_block;
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
@@ -680,7 +680,7 @@ acpi_status acpi_remove_gpe_block(acpi_handle gpe_device)
 		obj_desc->device.gpe_block = NULL;
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 1bd3225..02ed75a 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -148,7 +148,7 @@ acpi_install_address_space_handler(acpi_handle device,
 
 	status = acpi_ev_execute_reg_methods(node, space_id);
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
@@ -287,7 +287,7 @@ acpi_remove_address_space_handler(acpi_handle device,
 
 	status = AE_NOT_EXIST;
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 269e81d..3c2e6dc 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -193,7 +193,7 @@ acpi_status acpi_ex_create_event(struct acpi_walk_state *walk_state)
 	    acpi_ns_attach_object((struct acpi_namespace_node *)walk_state->
 				  operands[0], obj_desc, ACPI_TYPE_EVENT);
 
-      cleanup:
+cleanup:
 	/*
 	 * Remove local reference to the object (on error, will cause deletion
 	 * of both object and semaphore if present.)
@@ -248,7 +248,7 @@ acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state)
 	    acpi_ns_attach_object(obj_desc->mutex.node, obj_desc,
 				  ACPI_TYPE_MUTEX);
 
-      cleanup:
+cleanup:
 	/*
 	 * Remove local reference to the object (on error, will cause deletion
 	 * of both object and semaphore if present.)
@@ -347,7 +347,7 @@ acpi_ex_create_region(u8 * aml_start,
 
 	status = acpi_ns_attach_object(node, obj_desc, ACPI_TYPE_REGION);
 
-      cleanup:
+cleanup:
 
 	/* Remove local reference to the object */
 
@@ -520,7 +520,7 @@ acpi_ex_create_method(u8 * aml_start,
 
 	acpi_ut_remove_reference(obj_desc);
 
-      exit:
+exit:
 	/* Remove a reference to the operand */
 
 	acpi_ut_remove_reference(operand[1]);
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index c2a65aa..cfd8752 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -197,7 +197,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	status = acpi_ex_extract_from_field(obj_desc, buffer, (u32) length);
 	acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 
-      exit:
+exit:
 	if (ACPI_FAILURE(status)) {
 		acpi_ut_remove_reference(buffer_desc);
 	} else {
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 7e0afe7..8ab01b6 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -1002,7 +1002,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 						mask, merged_datum,
 						field_offset);
 
-      exit:
+exit:
 	/* Free temporary buffer if we used one */
 
 	if (new_buffer) {
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index 00bf298..65d9360 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -388,7 +388,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 
 	*actual_return_desc = return_desc;
 
-      cleanup:
+cleanup:
 	if (local_operand1 != operand1) {
 		acpi_ut_remove_reference(local_operand1);
 	}
@@ -718,7 +718,7 @@ acpi_ex_do_logical_op(u16 opcode,
 		}
 	}
 
-      cleanup:
+cleanup:
 
 	/* New object was created if implicit conversion performed - delete */
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 2cdd41d..d74cea4 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -115,7 +115,7 @@ acpi_status acpi_ex_opcode_0A_0T_1R(struct acpi_walk_state *walk_state)
 		break;
 	}
 
-      cleanup:
+cleanup:
 
 	/* Delete return object on error */
 
@@ -234,7 +234,7 @@ acpi_status acpi_ex_opcode_1A_1T_0R(struct acpi_walk_state *walk_state)
 		goto cleanup;
 	}
 
-      cleanup:
+cleanup:
 
 	return_ACPI_STATUS(status);
 }
@@ -551,7 +551,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 		status = acpi_ex_store(return_desc, operand[1], walk_state);
 	}
 
-      cleanup:
+cleanup:
 
 	/* Delete return object on error */
 
@@ -1054,7 +1054,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		goto cleanup;
 	}
 
-      cleanup:
+cleanup:
 
 	/* Delete return object on error */
 
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index d5088f7..d6fa0fc 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -215,7 +215,7 @@ acpi_status acpi_ex_opcode_2A_2T_1R(struct acpi_walk_state *walk_state)
 		goto cleanup;
 	}
 
-      cleanup:
+cleanup:
 	/*
 	 * Since the remainder is not returned indirectly, remove a reference to
 	 * it. Only the quotient is returned indirectly.
@@ -445,7 +445,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		break;
 	}
 
-      store_result_to_target:
+store_result_to_target:
 
 	if (ACPI_SUCCESS(status)) {
 		/*
@@ -462,7 +462,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 		}
 	}
 
-      cleanup:
+cleanup:
 
 	/* Delete return object on error */
 
@@ -553,7 +553,7 @@ acpi_status acpi_ex_opcode_2A_0T_1R(struct acpi_walk_state *walk_state)
 		goto cleanup;
 	}
 
-      store_logical_result:
+store_logical_result:
 	/*
 	 * Set return value to according to logical_result. logical TRUE (all ones)
 	 * Default is FALSE (zero)
@@ -562,7 +562,7 @@ acpi_status acpi_ex_opcode_2A_0T_1R(struct acpi_walk_state *walk_state)
 		return_desc->integer.value = ACPI_UINT64_MAX;
 	}
 
-      cleanup:
+cleanup:
 
 	/* Delete return object on error */
 
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 37656f1..bc042ad 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -124,7 +124,7 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 		goto cleanup;
 	}
 
-      cleanup:
+cleanup:
 
 	return_ACPI_STATUS(status);
 }
@@ -252,7 +252,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 	status = acpi_ex_store(return_desc, operand[3], walk_state);
 
-      cleanup:
+cleanup:
 
 	/* Delete return object on error */
 
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 879b6cd..4459e32 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -314,7 +314,7 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		goto cleanup;
 	}
 
-      cleanup:
+cleanup:
 
 	/* Delete return object on error */
 
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index ac04278..1606524 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -521,7 +521,7 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 	 */
 	type = obj_desc->common.type;
 
-      exit:
+exit:
 	/* Convert internal types to external types */
 
 	switch (type) {
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 00e5af7..be3f669 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -683,7 +683,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			return_ACPI_STATUS(status);
 		}
 
-	      next_operand:
+next_operand:
 		/*
 		 * If more operands needed, decrement stack_ptr to point
 		 * to next operand on stack
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 8d2e866..12e6cff 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -560,7 +560,7 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 		break;
 	}
 
-      exit:
+exit:
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index b156848..b4b47db 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -570,10 +570,10 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		break;
 	}
 
-      cleanup1:
+cleanup1:
 	acpi_ut_remove_reference(info->return_object);
 
-      cleanup:
+cleanup:
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"While evaluating Sleep State [%s]",
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index aff79c7..14f65f6 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -240,7 +240,7 @@ acpi_status acpi_ns_root_initialize(void)
 		}
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
 	/* Save a handle to "_GPE", it is always present */
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index c634854..48b9c6f 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -620,7 +620,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		obj_type = ACPI_TYPE_INVALID;	/* Terminate loop after next pass */
 	}
 
-      cleanup:
+cleanup:
 	acpi_os_printf("\n");
 	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 18108bc..963ceef 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -314,7 +314,7 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 			  "*** Completed evaluation of object %s ***\n",
 			  info->relative_pathname));
 
- cleanup:
+cleanup:
 	/*
 	 * Namespace was unlocked by the handling acpi_ns* function, so we
 	 * just free the pathname and return
@@ -486,7 +486,7 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 		parent_node->type = (u8)type;
 	}
 
-      exit:
+exit:
 	if (parent_obj) {
 		acpi_ut_remove_reference(parent_obj);
 	}
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index dd2ceae..3a0423a 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -213,7 +213,7 @@ acpi_status acpi_ns_initialize_devices(void)
 
 	return_ACPI_STATUS(status);
 
-      error_exit:
+error_exit:
 	ACPI_EXCEPTION((AE_INFO, status, "During device initialization"));
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 0a7badc..89ec645 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -114,7 +114,7 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 		(void)acpi_tb_release_owner_id(table_index);
 	}
 
-      unlock:
+unlock:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index 35dde81..1778573 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -140,7 +140,7 @@ acpi_ns_one_complete_parse(u32 pass_number,
 			  pass_number));
 	status = acpi_ps_parse_aml(walk_state);
 
-      cleanup:
+cleanup:
 	acpi_ps_delete_parse_tree(parse_root);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 098e766..d2855d9 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -271,7 +271,7 @@ acpi_ns_check_object_type(struct acpi_evaluate_info *info,
 		return (AE_OK);	/* Successful repair */
 	}
 
-      type_error_exit:
+type_error_exit:
 
 	/* Create a string with all expected types for this predefined object */
 
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 6d55cef..3d5391f 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -330,7 +330,7 @@ acpi_ns_check_package(struct acpi_evaluate_info *info,
 
 	return (status);
 
-      package_too_small:
+package_too_small:
 
 	/* Error exit for the case with an incorrect package count */
 
@@ -555,7 +555,7 @@ acpi_ns_check_package_list(struct acpi_evaluate_info *info,
 
 	return (AE_OK);
 
-      package_too_small:
+package_too_small:
 
 	/* The sub-package count was smaller than required */
 
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index f8e71ea..a05afff 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -263,7 +263,7 @@ acpi_ns_simple_repair(struct acpi_evaluate_info *info,
 
 	return (AE_AML_OPERAND_TYPE);
 
-      object_repaired:
+object_repaired:
 
 	/* Object was successfully repaired */
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index c84603e..6a25d32 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -478,7 +478,7 @@ acpi_ns_repair_CST(struct acpi_evaluate_info *info,
 			removing = TRUE;
 		}
 
-	      remove_element:
+remove_element:
 		if (removing) {
 			acpi_ns_remove_element(return_object, i + 1);
 			outer_element_count--;
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 08c0b5b..cc2fea9 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -722,7 +722,7 @@ acpi_ns_get_node(struct acpi_namespace_node *prefix_node,
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
-      cleanup:
+cleanup:
 	ACPI_FREE(internal_path);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index ce2a845..e973e31 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -442,7 +442,7 @@ acpi_evaluate_object(acpi_handle handle,
 		acpi_ex_exit_interpreter();
 	}
 
-      cleanup:
+cleanup:
 
 	/* Free the input parameter list (if we created one) */
 
@@ -618,10 +618,10 @@ acpi_walk_namespace(acpi_object_type type,
 					descending_callback, ascending_callback,
 					context, return_value);
 
-      unlock_and_exit2:
+unlock_and_exit2:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_read_lock(&acpi_gbl_namespace_rw_lock);
 	return_ACPI_STATUS(status);
 }
@@ -865,7 +865,7 @@ acpi_attach_data(acpi_handle obj_handle,
 
 	status = acpi_ns_attach_data(node, handler, data);
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
 }
@@ -911,7 +911,7 @@ acpi_detach_data(acpi_handle obj_handle, acpi_object_handler handler)
 
 	status = acpi_ns_detach_data(node, handler);
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
 }
@@ -958,7 +958,7 @@ acpi_get_data(acpi_handle obj_handle, acpi_object_handler handler, void **data)
 
 	status = acpi_ns_get_attached_data(node, handler, data);
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
 }
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 3a6d78a..3a4bd3f 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -209,7 +209,7 @@ acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer * buffer)
 	((char *)buffer->pointer)[ACPI_NAME_SIZE] = 0;
 	status = AE_OK;
 
-      unlock_and_exit:
+unlock_and_exit:
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
@@ -497,7 +497,7 @@ acpi_get_object_info(acpi_handle handle,
 	*return_buffer = info;
 	status = AE_OK;
 
-      cleanup:
+cleanup:
 	if (hid) {
 		ACPI_FREE(hid);
 	}
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index 94e961c..0e6d79e 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -201,7 +201,7 @@ acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 		status = AE_NULL_ENTRY;
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
@@ -281,7 +281,7 @@ acpi_get_next_object(acpi_object_type type,
 		*ret_handle = ACPI_CAST_PTR(acpi_handle, node);
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 86198a9..79d9a28 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -297,7 +297,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 			}
 	}
 
-      cleanup:
+cleanup:
 
 	/* Now we can actually delete the subtree rooted at Op */
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 11b99ab..fcb7a84 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -142,7 +142,7 @@ static void acpi_ps_start_trace(struct acpi_evaluate_info *info)
 		acpi_dbg_layer = acpi_gbl_trace_dbg_layer;
 	}
 
-      exit:
+exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 }
 
@@ -185,7 +185,7 @@ static void acpi_ps_stop_trace(struct acpi_evaluate_info *info)
 	acpi_dbg_level = acpi_gbl_original_dbg_level;
 	acpi_dbg_layer = acpi_gbl_original_dbg_layer;
 
-      exit:
+exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 }
 
@@ -323,7 +323,7 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 
 	/* walk_state was deleted by parse_aml */
 
-      cleanup:
+cleanup:
 	acpi_ps_delete_parse_tree(op);
 
 	/* End optional tracing */
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 80d1299..c99cec9 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -440,7 +440,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 		info++;
 	}
 
-      exit:
+exit:
 	if (!flags_mode) {
 
 		/* Round the resource struct length up to the next boundary (32 or 64) */
@@ -783,7 +783,7 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 		info++;
 	}
 
-      exit:
+exit:
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 480b6b4..aef303d 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -784,7 +784,7 @@ acpi_rs_set_srs_method_data(struct acpi_namespace_node *node,
 
 	acpi_ut_remove_reference(args[0]);
 
-      cleanup:
+cleanup:
 	ACPI_FREE(info);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9e6788f..634357d 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -231,10 +231,10 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 		goto release;
 	}
 
-      print_header:
+print_header:
 	acpi_tb_print_table_header(table_desc->address, table_desc->pointer);
 
-      release:
+release:
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
@@ -306,7 +306,7 @@ struct acpi_table_header *acpi_tb_table_override(struct acpi_table_header
 
 	return (NULL);		/* There was no override */
 
-      finish_override:
+finish_override:
 
 	ACPI_INFO((AE_INFO,
 		   "%4.4s %p %s table override, new table: %p",
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index bffdfc7..43ffe21 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -350,7 +350,7 @@ acpi_tb_install_table(acpi_physical_address address,
 		acpi_tb_delete_table(table_desc);
 	}
 
-      unmap_and_exit:
+unmap_and_exit:
 
 	/* Always unmap the table header that we mapped above */
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 2ad8532..bbaad5c 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -466,7 +466,7 @@ acpi_install_table_handler(acpi_table_handler handler, void *context)
 	acpi_gbl_table_handler = handler;
 	acpi_gbl_table_handler_context = context;
 
-      cleanup:
+cleanup:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
@@ -507,7 +507,7 @@ acpi_status acpi_remove_table_handler(acpi_table_handler handler)
 
 	acpi_gbl_table_handler = NULL;
 
-      cleanup:
+cleanup:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 2620dbe..5a22024 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -201,7 +201,7 @@ static acpi_status acpi_tb_load_namespace(void)
 
 	ACPI_INFO((AE_INFO, "All ACPI Tables successfully acquired"));
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
@@ -269,7 +269,7 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 					     acpi_gbl_table_handler_context);
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 1731c27..edff4e6 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -552,7 +552,7 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 	*ret_internal_object = internal_object;
 	return_ACPI_STATUS(AE_OK);
 
-      error_exit:
+error_exit:
 	acpi_ut_remove_reference(internal_object);
 	return_ACPI_STATUS(AE_NO_MEMORY);
 }
@@ -899,7 +899,7 @@ acpi_ut_copy_ielement_to_ielement(u8 object_type,
 
 	return (status);
 
-      error_exit:
+error_exit:
 	acpi_ut_remove_reference(target_object);
 	return (status);
 }
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index d6b33f2..c07d222 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -649,7 +649,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 
 	return (AE_OK);
 
-      error_exit:
+error_exit:
 
 	ACPI_EXCEPTION((AE_INFO, status,
 			"Could not update object reference count"));
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 4fd6897..16fb905 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -181,7 +181,7 @@ acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 
 	*return_desc = info->return_object;
 
-      cleanup:
+cleanup:
 	ACPI_FREE(info);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index fa69071..bfca7b4 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -184,7 +184,7 @@ acpi_ut_execute_SUB(struct acpi_namespace_node *device_node,
 	sub->length = length;
 	*return_id = sub;
 
-      cleanup:
+cleanup:
 
 	/* On exit, we must delete the return object */
 
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index 835340b..eb3aca7 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -148,7 +148,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 	ACPI_ERROR((AE_INFO,
 		    "Could not allocate new OwnerId (255 max), AE_OWNER_ID_LIMIT"));
 
-      exit:
+exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index cb7fa49..2c2accb 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -643,7 +643,7 @@ acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
 
 	return (AE_OK);
 
-      invalid_resource:
+invalid_resource:
 
 	if (walk_state) {
 		ACPI_ERROR((AE_INFO,
@@ -652,7 +652,7 @@ acpi_ut_validate_resource(struct acpi_walk_state *walk_state,
 	}
 	return (AE_AML_INVALID_RESOURCE_TYPE);
 
-      bad_resource_length:
+bad_resource_length:
 
 	if (walk_state) {
 		ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/utstring.c b/drivers/acpi/acpica/utstring.c
index 5ef41ff..45c0eb2 100644
--- a/drivers/acpi/acpica/utstring.c
+++ b/drivers/acpi/acpica/utstring.c
@@ -310,7 +310,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 
 	/* All done, normal exit */
 
-      all_done:
+all_done:
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Converted value: %8.8X%8.8X\n",
 			  ACPI_FORMAT_UINT64(return_value)));
@@ -318,7 +318,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 	*ret_integer = return_value;
 	return_ACPI_STATUS(AE_OK);
 
-      error_exit:
+error_exit:
 	/* Base was set/validated above */
 
 	if (base == 10) {
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 77e3eb7..c002777 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -430,7 +430,7 @@ acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
 		element->next = allocation;
 	}
 
-      unlock_and_exit:
+unlock_and_exit:
 	status = acpi_ut_release_mutex(ACPI_MTX_MEMORY);
 	return_ACPI_STATUS(status);
 }
-- 
1.7.10

