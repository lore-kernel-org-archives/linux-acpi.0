From: akpm@osdl.org
Subject: [patch 11/12] Fix up a multitude of ACPI compiler warnings on x86_64
Date: Tue, 10 Oct 2006 14:20:42 -0700
Message-ID: <200610102120.k9ALKjNc024296@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:31394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030538AbWJJVvJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:51:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, mbligh@google.com, jeff@garzik.org

From: Martin Bligh <mbligh@google.com>

32bit vs 64 bit issues.  sizeof(sizeof) and sizeof(pointer) is variable,
but we're trying to shove it into unsigned int or u32.

Casts to unsigned long are used because type acpi_thread_id can be any one of

typedef u64 acpi_native_uint;
typedef u32 acpi_native_uint;
typedef u16 acpi_native_uint;
#define acpi_thread_id struct task_struct *

Signed-off-by: Martin J. Bligh <mbligh@google.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/executer/exmutex.c  |    6 +++---
 drivers/acpi/utilities/utdebug.c |    5 +++--
 drivers/acpi/utilities/utmutex.c |   16 +++++++++-------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff -puN drivers/acpi/executer/exmutex.c~fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64 drivers/acpi/executer/exmutex.c
--- a/drivers/acpi/executer/exmutex.c~fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64
+++ a/drivers/acpi/executer/exmutex.c
@@ -266,10 +266,10 @@ acpi_ex_release_mutex(union acpi_operand
 	     walk_state->thread->thread_id)
 	    && (obj_desc->mutex.os_mutex != ACPI_GLOBAL_LOCK)) {
 		ACPI_ERROR((AE_INFO,
-			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
-			    (u32) walk_state->thread->thread_id,
+			    "Thread %lX cannot release Mutex [%4.4s] acquired by thread %lX",
+			    (unsigned long)walk_state->thread->thread_id,
 			    acpi_ut_get_node_name(obj_desc->mutex.node),
-			    (u32) obj_desc->mutex.owner_thread->thread_id));
+			    (unsigned long)obj_desc->mutex.owner_thread->thread_id));
 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
 	}
 
diff -puN drivers/acpi/utilities/utdebug.c~fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64 drivers/acpi/utilities/utdebug.c
--- a/drivers/acpi/utilities/utdebug.c~fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64
+++ a/drivers/acpi/utilities/utdebug.c
@@ -180,8 +180,9 @@ acpi_ut_debug_print(u32 requested_debug_
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     (u32) acpi_gbl_prev_thread_id, (u32) thread_id);
+			    ("\n**** Context Switch from TID %lX to TID %lX ****\n\n",
+			     (unsigned long) acpi_gbl_prev_thread_id,
+			     (unsigned long) thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
diff -puN drivers/acpi/utilities/utmutex.c~fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64 drivers/acpi/utilities/utmutex.c
--- a/drivers/acpi/utilities/utmutex.c~fix-up-a-multitude-of-acpi-compiler-warnings-on-x86_64
+++ a/drivers/acpi/utilities/utmutex.c
@@ -243,23 +243,24 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
 #endif
 
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X attempting to acquire Mutex [%s]\n",
-			  (u32) this_thread_id, acpi_ut_get_mutex_name(mutex_id)));
+			  "Thread %lX attempting to acquire Mutex [%s]\n",
+			  (unsigned long) this_thread_id,
+			  acpi_ut_get_mutex_name(mutex_id)));
 
 	status = acpi_os_acquire_mutex(acpi_gbl_mutex_info[mutex_id].mutex,
 				       ACPI_WAIT_FOREVER);
 	if (ACPI_SUCCESS(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-				  "Thread %X acquired Mutex [%s]\n",
-				  (u32) this_thread_id,
+				  "Thread %lX acquired Mutex [%s]\n",
+				  (unsigned long) this_thread_id,
 				  acpi_ut_get_mutex_name(mutex_id)));
 
 		acpi_gbl_mutex_info[mutex_id].use_count++;
 		acpi_gbl_mutex_info[mutex_id].thread_id = this_thread_id;
 	} else {
 		ACPI_EXCEPTION((AE_INFO, status,
-				"Thread %X could not acquire Mutex [%X]",
-				(u32) this_thread_id, mutex_id));
+				"Thread %lX could not acquire Mutex [%X]",
+				(unsigned long) this_thread_id, mutex_id));
 	}
 
 	return (status);
@@ -285,7 +286,8 @@ acpi_status acpi_ut_release_mutex(acpi_m
 
 	this_thread_id = acpi_os_get_thread_id();
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX,
-			  "Thread %X releasing Mutex [%s]\n", (u32) this_thread_id,
+			  "Thread %lX releasing Mutex [%s]\n",
+			  (unsigned long) this_thread_id,
 			  acpi_ut_get_mutex_name(mutex_id)));
 
 	if (mutex_id > ACPI_MAX_MUTEX) {
_
