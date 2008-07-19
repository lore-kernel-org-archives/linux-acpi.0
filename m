From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 3/3] Add lockdep integration for the ACPI mutex usage.
Date: Sat, 19 Jul 2008 11:16:54 -0700
Message-ID: <1216491411-24080-4-git-send-email-dwalker@mvista.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
 <1216491411-24080-2-git-send-email-dwalker@mvista.com>
 <1216491411-24080-3-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:29146 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbYGSSRD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 14:17:03 -0400
In-Reply-To: <1216491411-24080-3-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, len.brown@intel.com, ak@linux.intel.com

Cc: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    3 ++-
 drivers/acpi/executer/excreate.c   |    7 ++++---
 drivers/acpi/executer/exmutex.c    |    5 +++--
 drivers/acpi/executer/exsystem.c   |    6 ++++--
 drivers/acpi/namespace/nsaccess.c  |    4 +++-
 drivers/acpi/osl.c                 |   11 +++++++----
 drivers/acpi/utilities/utmutex.c   |    7 ++++---
 include/acpi/acinterp.h            |    5 ++++-
 include/acpi/acpiosxf.h            |    8 ++++++--
 9 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 4613b9c..cbc6e60 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -130,6 +130,7 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 static acpi_status
 acpi_ds_create_method_mutex(union acpi_operand_object *method_desc)
 {
+	static struct lock_class_key method_mutex;
 	union acpi_operand_object *mutex_desc;
 	acpi_status status;
 
@@ -144,7 +145,7 @@ acpi_ds_create_method_mutex(union acpi_operand_object *method_desc)
 
 	/* Create the actual OS Mutex */
 
-	status = acpi_os_create_mutex(&mutex_desc->mutex.os_mutex);
+	status = acpi_os_create_mutex(&mutex_desc->mutex.os_mutex, &method_mutex);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index 625be14..c3657e6 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -222,6 +222,7 @@ acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state)
 {
 	acpi_status status = AE_OK;
 	union acpi_operand_object *obj_desc;
+	static struct lock_class_key interpreter_class;
 
 	ACPI_FUNCTION_TRACE_PTR(ex_create_mutex, ACPI_WALK_OPERANDS);
 
@@ -233,9 +234,9 @@ acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state)
 		goto cleanup;
 	}
 
-	/* Create the actual OS Mutex */
-
-	status = acpi_os_create_mutex(&obj_desc->mutex.os_mutex);
+	status = 
+	acpi_os_create_mutex(&obj_desc->mutex.os_mutex,
+			    &interpreter_class);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
diff --git a/drivers/acpi/executer/exmutex.c b/drivers/acpi/executer/exmutex.c
index a8bf3d7..6472a24 100644
--- a/drivers/acpi/executer/exmutex.c
+++ b/drivers/acpi/executer/exmutex.c
@@ -176,8 +176,9 @@ acpi_ex_acquire_mutex_object(u16 timeout,
 	if (obj_desc == acpi_gbl_global_lock_mutex) {
 		status = acpi_ev_acquire_global_lock(timeout);
 	} else {
-		status = acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
-						   timeout);
+		status =
+		acpi_ex_system_wait_mutex(obj_desc->mutex.os_mutex,
+						 timeout);
 	}
 
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/executer/exsystem.c b/drivers/acpi/executer/exsystem.c
index f35508a..5088e3a 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -108,13 +108,15 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_completion comp, u16 timeout)
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
+acpi_status
+acpi_ex_system_wait_mutex_nested(acpi_mutex mutex, u16 timeout,
+				 unsigned int subclass)
 {
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ex_system_wait_mutex);
 
-	status = acpi_os_acquire_mutex(mutex, ACPI_DO_NOT_WAIT);
+	status = acpi_os_acquire_mutex_nested(mutex, ACPI_DO_NOT_WAIT, subclass);
 	if (ACPI_SUCCESS(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index fc54f45..36579c5 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -64,6 +64,7 @@ ACPI_MODULE_NAME("nsaccess")
  ******************************************************************************/
 acpi_status acpi_ns_root_initialize(void)
 {
+	static struct lock_class_key ns_root_mutex;
 	acpi_status status;
 	const struct acpi_predefined_names *init_val = NULL;
 	struct acpi_namespace_node *new_node;
@@ -199,7 +200,8 @@ acpi_status acpi_ns_root_initialize(void)
 
 				status =
 				    acpi_os_create_mutex(&obj_desc->mutex.
-							 os_mutex);
+							 os_mutex,
+							 &ns_root_mutex);
 				if (ACPI_FAILURE(status)) {
 					acpi_ut_remove_reference(obj_desc);
 					goto unlock_and_exit;
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3cb9b89..7c6abd6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -872,7 +872,7 @@ acpi_status acpi_os_signal_complete(acpi_handle handle, u32 units)
 }
 
 acpi_status
-acpi_os_create_mutex(acpi_mutex *handle)
+acpi_os_create_mutex(acpi_mutex * handle, struct lock_class_key *key)
 {
 	struct mutex *mutex = NULL;
 
@@ -882,6 +882,7 @@ acpi_os_create_mutex(acpi_mutex *handle)
 	memset(mutex, 0, sizeof(struct mutex));
 
 	mutex_init(mutex);
+	lockdep_set_class(mutex, key);
 
 	*handle = (acpi_handle *) mutex;
 
@@ -907,7 +908,9 @@ acpi_status acpi_os_delete_mutex(acpi_mutex handle)
 	return AE_OK;
 }
 
-acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout)
+acpi_status
+acpi_os_acquire_mutex_nested(acpi_mutex handle, u16 timeout,
+			     unsigned int subclass)
 {
 	acpi_status status = AE_OK;
 	struct mutex *mutex = (struct mutex *)handle;
@@ -924,8 +927,8 @@ acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout)
 		jiffies = MAX_SCHEDULE_TIMEOUT;
 	else
 		jiffies = msecs_to_jiffies(timeout);
-
-	ret = mutex_lock_interruptible_nested(mutex);
+	
+	ret = mutex_lock_interruptible_nested(mutex, subclass);
 	if (ret == -EINTR)
 		status = AE_TIME;
 
diff --git a/drivers/acpi/utilities/utmutex.c b/drivers/acpi/utilities/utmutex.c
index 7331dde..b4c6f33 100644
--- a/drivers/acpi/utilities/utmutex.c
+++ b/drivers/acpi/utilities/utmutex.c
@@ -134,6 +134,7 @@ void acpi_ut_mutex_terminate(void)
 
 static acpi_status acpi_ut_create_mutex(acpi_mutex_handle mutex_id)
 {
+	static struct lock_class_key utility_mutex;
 	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE_U32(ut_create_mutex, mutex_id);
@@ -144,7 +145,7 @@ static acpi_status acpi_ut_create_mutex(acpi_mutex_handle mutex_id)
 
 	if (!acpi_gbl_mutex_info[mutex_id].mutex) {
 		status =
-		    acpi_os_create_mutex(&acpi_gbl_mutex_info[mutex_id].mutex);
+		    acpi_os_create_mutex(&acpi_gbl_mutex_info[mutex_id].mutex, &utility_mutex);
 		acpi_gbl_mutex_info[mutex_id].thread_id =
 		    ACPI_MUTEX_NOT_ACQUIRED;
 		acpi_gbl_mutex_info[mutex_id].use_count = 0;
@@ -247,8 +248,8 @@ acpi_status acpi_ut_acquire_mutex(acpi_mutex_handle mutex_id)
 			  (unsigned long)this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
-	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
-				       ACPI_WAIT_FOREVER);
+	status = acpi_os_acquire_mutex_nested(acpi_gbl_mutex_info[mutex_id].mutex,
+				       ACPI_WAIT_FOREVER, mutex_id);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
 				  "Thread %lX acquired Mutex [%s]\n",
diff --git a/include/acpi/acinterp.h b/include/acpi/acinterp.h
index daaa478..a3cca24 100644
--- a/include/acpi/acinterp.h
+++ b/include/acpi/acinterp.h
@@ -293,7 +293,10 @@ acpi_status acpi_ex_system_reset_event(union acpi_operand_object *obj_desc);
 acpi_status
 acpi_ex_system_wait_semaphore(acpi_completion semaphore, u16 timeout);
 
-acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout);
+acpi_status acpi_ex_system_wait_mutex_nested(acpi_mutex mutex, u16 timeout,
+					     unsigned int subclass);
+#define acpi_ex_system_wait_mutex(mutex, timeout) \
+	acpi_ex_system_wait_mutex_nested(mutex, timeout, 0)
 
 /*
  * exoparg1 - ACPI AML execution, 1 operand
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 140e078..dd34079 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -123,11 +123,15 @@ acpi_status acpi_os_signal_complete(acpi_completion handle, u32 units);
 /*
  * Mutex primitives
  */
-acpi_status acpi_os_create_mutex(acpi_mutex * out_handle);
+acpi_status
+acpi_os_create_mutex(acpi_mutex * handle, struct lock_class_key *key);
 
 acpi_status acpi_os_delete_mutex(acpi_mutex handle);
 
-acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout);
+acpi_status
+acpi_os_acquire_mutex_nested(acpi_mutex handle, u16 timeout, unsigned int subclass);
+#define acpi_os_acquire_mutex(handle, timeout) \
+	acpi_os_acquire_mutex_nested(handle, timeout, 0)
 
 acpi_status acpi_os_release_mutex(acpi_mutex handle);
 
-- 
1.5.5.1.32.gba7d2

