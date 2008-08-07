From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 3/5] acpi: add lockdep magic
Date: Thu,  7 Aug 2008 07:59:41 -0700
Message-ID: <1218121178-13779-4-git-send-email-dwalker@mvista.com>
References: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
 <1218121178-13779-2-git-send-email-dwalker@mvista.com>
 <1218121178-13779-3-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:62991 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbYHGO7q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 10:59:46 -0400
In-Reply-To: <1218121178-13779-3-git-send-email-dwalker@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

Add lockdep integration for the ACPI mutex usage.

Cc: linux-acpi@vger.kernel.org
Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    4 ++++
 drivers/acpi/executer/excreate.c   |    7 ++++++-
 drivers/acpi/executer/exmutex.c    |    5 +++--
 drivers/acpi/executer/exsystem.c   |    3 ++-
 drivers/acpi/namespace/nsaccess.c  |    5 +++++
 drivers/acpi/osl.c                 |    3 ++-
 drivers/acpi/utilities/utmutex.c   |    6 ++++++
 include/acpi/acpiosxf.h            |    6 ++++--
 8 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 4613b9c..a3cf3d4 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -130,6 +130,7 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state)
 static acpi_status
 acpi_ds_create_method_mutex(union acpi_operand_object *method_desc)
 {
+	static struct lock_class_key method_mutex;
 	union acpi_operand_object *mutex_desc;
 	acpi_status status;
 
@@ -149,6 +150,9 @@ acpi_ds_create_method_mutex(union acpi_operand_object *method_desc)
 		return_ACPI_STATUS(status);
 	}
 
+	lockdep_set_class((struct mutex *)&mutex_desc->mutex.os_mutex,
+			  &method_mutex);
+
 	mutex_desc->mutex.sync_level = method_desc->method.sync_level;
 	method_desc->method.mutex = mutex_desc;
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/executer/excreate.c b/drivers/acpi/executer/excreate.c
index ad09696..4397015 100644
--- a/drivers/acpi/executer/excreate.c
+++ b/drivers/acpi/executer/excreate.c
@@ -222,6 +222,7 @@ acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state)
 {
 	acpi_status status = AE_OK;
 	union acpi_operand_object *obj_desc;
+	static struct lock_class_key interpreter_class;
 
 	ACPI_FUNCTION_TRACE_PTR(ex_create_mutex, ACPI_WALK_OPERANDS);
 
@@ -235,11 +236,15 @@ acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state)
 
 	/* Create the actual OS Mutex */
 
-	status = acpi_os_create_mutex(&obj_desc->mutex.os_mutex);
+	status = 
+	acpi_os_create_mutex(&obj_desc->mutex.os_mutex);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
 	}
 
+	lockdep_set_class((struct mutex *)obj_desc->mutex.os_mutex,
+			  &interpreter_class);
+
 	/* Init object and attach to NS node */
 
 	obj_desc->mutex.sync_level =
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
index 68990f1..1a4aa5e 100644
--- a/drivers/acpi/executer/exsystem.c
+++ b/drivers/acpi/executer/exsystem.c
@@ -108,7 +108,8 @@ acpi_status acpi_ex_system_wait_semaphore(acpi_semaphore semaphore, u16 timeout)
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
+acpi_status
+acpi_ex_system_wait_mutex(acpi_mutex mutex, u16 timeout)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index c39a7f6..293c0ba 100644
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
@@ -205,6 +206,10 @@ acpi_status acpi_ns_root_initialize(void)
 					goto unlock_and_exit;
 				}
 
+				lockdep_set_class((struct mutex *)
+					obj_desc->mutex.os_mutex,
+					&ns_root_mutex);
+
 				/* Special case for ACPI Global Lock */
 
 				if (ACPI_STRCMP(init_val->name, "_GL_") == 0) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c0184f4..7340baf 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -907,7 +907,8 @@ acpi_status acpi_os_delete_mutex(acpi_mutex handle)
 	return AE_OK;
 }
 
-acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout)
+acpi_status
+acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout)
 {
 	acpi_status status = AE_OK;
 	struct mutex *mutex = (struct mutex *)handle;
diff --git a/drivers/acpi/utilities/utmutex.c b/drivers/acpi/utilities/utmutex.c
index 7331dde..3f7f16c 100644
--- a/drivers/acpi/utilities/utmutex.c
+++ b/drivers/acpi/utilities/utmutex.c
@@ -134,6 +134,7 @@ void acpi_ut_mutex_terminate(void)
 
 static acpi_status acpi_ut_create_mutex(acpi_mutex_handle mutex_id)
 {
+	static struct lock_class_key utility_class_keys[ACPI_MAX_MUTEX];
 	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE_U32(ut_create_mutex, mutex_id);
@@ -145,6 +146,11 @@ static acpi_status acpi_ut_create_mutex(acpi_mutex_handle mutex_id)
 	if (!acpi_gbl_mutex_info[mutex_id].mutex) {
 		status =
 		    acpi_os_create_mutex(&acpi_gbl_mutex_info[mutex_id].mutex);
+
+		lockdep_set_class(
+			(struct mutex *)acpi_gbl_mutex_info[mutex_id].mutex,
+			&utility_class_keys[mutex_id]);
+
 		acpi_gbl_mutex_info[mutex_id].thread_id =
 		    ACPI_MUTEX_NOT_ACQUIRED;
 		acpi_gbl_mutex_info[mutex_id].use_count = 0;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 9032ec3..0f4247b 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -123,11 +123,13 @@ acpi_status acpi_os_signal_semaphore(acpi_semaphore handle, u32 units);
 /*
  * Mutex primitives
  */
-acpi_status acpi_os_create_mutex(acpi_mutex * out_handle);
+acpi_status
+acpi_os_create_mutex(acpi_mutex * handle);
 
 acpi_status acpi_os_delete_mutex(acpi_mutex handle);
 
-acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout);
+acpi_status
+acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout);
 
 acpi_status acpi_os_release_mutex(acpi_mutex handle);
 
-- 
1.5.5.1.32.gba7d2


