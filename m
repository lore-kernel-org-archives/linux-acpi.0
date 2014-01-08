From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/21] ACPICA: Linuxize: Cleanup spaces after special macro invocations.
Date: Wed,  8 Jan 2014 13:44:56 +0800
Message-ID: <40bb21db1e5b97688729e37f07821cb596e2f233.1387514465.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64742 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbaAHFpF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:45:05 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch reflects the improvment of a cleanup step which is performed in
the release process.

There are still spaces in the linuxized ACPICA files after special macro
invocations.  This is because indent treats comments and pre-processor
directives as spaces, thus we need to skip them.
Before applying this patch, cleanup code will search from keyword back to
end of line and wipe spaces between them.
After applying this patch, cleanup code will search to the end of the macro
invocations, skip "empty lines", "comments" and "pre-processor directives",
then wipe the spaces between the new line and the first non-spaces
characters.

Following improvements are thus achieved in the release automation by this
commit which are originally maintained manually:
 - acpi_status acpi_ev_remove_global_lock_handler(void);
 +acpi_status acpi_ev_remove_global_lock_handler(void);
 - acpi_status
 +acpi_status
  acpi_ev_match_gpe_method(acpi_handle obj_handle,
 - acpi_status acpi_subsystem_status(void);
 +acpi_status acpi_subsystem_status(void);
 - acpi_status acpi_install_notify_handler(acpi_handle device, u32 handler_type,
 +acpi_status acpi_install_notify_handler(acpi_handle device, u32 handler_type,
 - acpi_status
 +acpi_status
  acpi_acquire_mutex(acpi_handle handle, acpi_string pathname, u16 timeout);
 - acpi_status
 +acpi_status
  acpi_get_sleep_type_data(u8 sleep_state, u8 *slp_typ_a, u8 *slp_typ_b);
 - acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
 +acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
Some empty lines are restored by this commit due to the change of the
removal implementation.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |    1 -
 drivers/acpi/acpica/acevents.h |    5 ++---
 drivers/acpi/acpica/utglobal.c |    4 ----
 include/acpi/acpixf.h          |   20 +++-----------------
 4 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index a9fd0b8..2bf3ca2 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -113,7 +113,6 @@ void acpi_db_display_handlers(void);
 ACPI_HW_DEPENDENT_RETURN_VOID(void
 			      acpi_db_generate_gpe(char *gpe_arg,
 						   char *block_arg))
-
 ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_db_generate_sci(void))
 
 /*
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 0738305..0fb0adf 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -71,9 +71,8 @@ acpi_status acpi_ev_init_global_lock_handler(void);
 
 ACPI_HW_DEPENDENT_RETURN_OK(acpi_status
 			    acpi_ev_acquire_global_lock(u16 timeout))
-
 ACPI_HW_DEPENDENT_RETURN_OK(acpi_status acpi_ev_release_global_lock(void))
- acpi_status acpi_ev_remove_global_lock_handler(void);
+acpi_status acpi_ev_remove_global_lock_handler(void);
 
 /*
  * evgpe - Low-level GPE support
@@ -133,7 +132,7 @@ acpi_status acpi_ev_gpe_initialize(void);
 ACPI_HW_DEPENDENT_RETURN_VOID(void
 			      acpi_ev_update_gpes(acpi_owner_id table_owner_id))
 
- acpi_status
+acpi_status
 acpi_ev_match_gpe_method(acpi_handle obj_handle,
 			 u32 level, void *context, void **return_value);
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 81f9a95..030cb0d 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -388,11 +388,7 @@ acpi_status acpi_ut_init_globals(void)
 /* Public globals */
 
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
-
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
-
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
-
 ACPI_EXPORT_SYMBOL(acpi_gpe_count)
-
 ACPI_EXPORT_SYMBOL(acpi_current_gpe_count)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 01ba80b..cfe929b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -131,10 +131,9 @@ acpi_status __init acpi_terminate(void);
  * Miscellaneous global interfaces
  */
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable(void))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable(void))
 #ifdef ACPI_FUTURE_USAGE
- acpi_status acpi_subsystem_status(void);
+acpi_status acpi_subsystem_status(void);
 #endif
 
 #ifdef ACPI_FUTURE_USAGE
@@ -279,16 +278,13 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_install_sci_handler(acpi_sci_handler
 							 address,
 							 void *context))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_sci_handler(acpi_sci_handler
 							 address))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_global_event_handler
 				 (acpi_gbl_event_handler handler,
 				  void *context))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_fixed_event_handler(u32
 								  acpi_event,
@@ -296,12 +292,10 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 								  handler,
 								  void
 								  *context))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_fixed_event_handler(u32 acpi_event,
 								 acpi_event_handler
 								 handler))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_gpe_handler(acpi_handle
 							  gpe_device,
@@ -310,15 +304,14 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							  acpi_gpe_handler
 							  address,
 							  void *context))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_gpe_handler(acpi_handle gpe_device,
 							 u32 gpe_number,
 							 acpi_gpe_handler
 							 address))
 acpi_status acpi_install_notify_handler(acpi_handle device, u32 handler_type,
-					acpi_notify_handler handler,
-					void *context);
+					 acpi_notify_handler handler,
+					 void *context);
 
 acpi_status
 acpi_remove_notify_handler(acpi_handle device,
@@ -367,7 +360,6 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_disable_event(u32 event, u32 flags))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_clear_event(u32 event))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
@@ -405,20 +397,16 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							parent_device,
 							acpi_handle gpe_device,
 							u32 gpe_number))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_set_gpe_wake_mask(acpi_handle gpe_device,
 							u32 gpe_number,
 							u8 action))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_get_gpe_status(acpi_handle gpe_device,
 						     u32 gpe_number,
 						     acpi_event_status
 						     *event_status))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
@@ -432,7 +420,6 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						       *gpe_block_address,
 						       u32 register_count,
 						       u32 interrupt_number))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_gpe_block(acpi_handle gpe_device))
 
@@ -533,7 +520,6 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 #ifdef ACPI_FUTURE_USAGE
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_timer_resolution(u32 *resolution))
-
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_get_timer(u32 *ticks))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-- 
1.7.10

