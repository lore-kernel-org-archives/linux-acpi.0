From: Len Brown <lenb@kernel.org>
Subject: [PATCH 42/98] ACPICA: Fix AcpiWalkNamespace race condition with table
 unload
Date: Sat, 28 Mar 2009 00:31:17 -0400
Message-ID: <8a335a2331c72e60c6b3ef09b2dedd3ba00da1b1.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22330 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbZC1Ect (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:49 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700JVK8MMEKQP@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:47 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added a reader/writer locking mechanism to allow multiple
concurrent namespace walks (readers), but a dynamic table unload
will have exclusive access to the namespace. This fixes a problem
where a table unload could delete the portion of the namespace that
is currently being examined by a walk.  Adds a new file, utlock.c
that implements the reader/writer lock mechanism. ACPICA BZ 749.

http://www.acpica.org/bugzilla/show_bug.cgi?id=749

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/Makefile   |    2 +-
 drivers/acpi/acpica/acglobal.h |    4 +
 drivers/acpi/acpica/aclocal.h  |    8 ++
 drivers/acpi/acpica/actables.h |    2 +-
 drivers/acpi/acpica/acutils.h  |   15 ++++
 drivers/acpi/acpica/dsinit.c   |   16 +++-
 drivers/acpi/acpica/exconfig.c |   13 ++--
 drivers/acpi/acpica/nsxfeval.c |   33 ++++++--
 drivers/acpi/acpica/tbinstal.c |   45 +++++++++--
 drivers/acpi/acpica/utlock.c   |  175 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utmutex.c  |   23 ++++--
 11 files changed, 303 insertions(+), 33 deletions(-)
 create mode 100644 drivers/acpi/acpica/utlock.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 3f23298..290be74 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -41,4 +41,4 @@ obj-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 
 obj-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
 		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
-		utstate.o utmutex.o utobject.o utresrc.o
+		utstate.o utmutex.o utobject.o utresrc.o utlock.o
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index f3e87ba..f431b99 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -165,6 +165,10 @@ ACPI_EXTERN u8 acpi_gbl_integer_bit_width;
 ACPI_EXTERN u8 acpi_gbl_integer_byte_width;
 ACPI_EXTERN u8 acpi_gbl_integer_nybble_width;
 
+/* Reader/Writer lock is used for namespace walk and dynamic table unload */
+
+ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
+
 /*****************************************************************************
  *
  * Mutual exlusion within ACPICA subsystem
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6feebc8..18a8d96 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -108,6 +108,14 @@ static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 #endif
 #endif
 
+/* Lock structure for reader/writer interfaces */
+
+struct acpi_rw_lock {
+	acpi_mutex writer_mutex;
+	acpi_mutex reader_mutex;
+	u32 num_readers;
+};
+
 /*
  * Predefined handles for spinlocks used within the subsystem.
  * These spinlocks are created by acpi_ut_mutex_initialize
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index d8f8c5d..01c76b8 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -79,7 +79,7 @@ void acpi_tb_delete_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_terminate(void);
 
-void acpi_tb_delete_namespace_by_owner(u32 table_index);
+acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index);
 
 acpi_status acpi_tb_allocate_owner_id(u32 table_index);
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 80d8813..897810b 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -346,6 +346,21 @@ acpi_status
 acpi_ut_execute_sxds(struct acpi_namespace_node *device_node, u8 * highest);
 
 /*
+ * utlock - reader/writer locks
+ */
+acpi_status acpi_ut_create_rw_lock(struct acpi_rw_lock *lock);
+
+void acpi_ut_delete_rw_lock(struct acpi_rw_lock *lock);
+
+acpi_status acpi_ut_acquire_read_lock(struct acpi_rw_lock *lock);
+
+acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock);
+
+acpi_status acpi_ut_acquire_write_lock(struct acpi_rw_lock *lock);
+
+void acpi_ut_release_write_lock(struct acpi_rw_lock *lock);
+
+/*
  * utobject - internal object create/delete/cache routines
  */
 union acpi_operand_object *acpi_ut_create_internal_object_dbg(const char
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index eb144b1..3aae13f 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -180,11 +180,23 @@ acpi_ds_initialize_objects(u32 table_index,
 
 	/* Walk entire namespace from the supplied root */
 
-	status = acpi_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
-				     acpi_ds_init_one_object, &info, NULL);
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/*
+	 * We don't use acpi_walk_namespace since we do not want to acquire
+	 * the namespace reader lock.
+	 */
+	status =
+	    acpi_ns_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
+				   ACPI_NS_WALK_UNLOCK, acpi_ds_init_one_object,
+				   &info, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
 	}
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
 	status = acpi_get_table_by_index(table_index, &table);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 70b39c7..3deb20a 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -520,13 +520,14 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 		}
 	}
 
-	/*
-	 * Delete the entire namespace under this table Node
-	 * (Offset contains the table_id)
-	 */
-	acpi_tb_delete_namespace_by_owner(table_index);
-	(void)acpi_tb_release_owner_id(table_index);
+	/* Delete the portion of the namespace owned by this table */
+
+	status = acpi_tb_delete_namespace_by_owner(table_index);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
+	(void)acpi_tb_release_owner_id(table_index);
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 
 	/* Table unloaded, remove a reference to the ddb_handle object */
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 2583a66..0450540 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -475,21 +475,40 @@ acpi_walk_namespace(acpi_object_type type,
 	}
 
 	/*
-	 * Lock the namespace around the walk.
-	 * The namespace will be unlocked/locked around each call
-	 * to the user function - since this function
-	 * must be allowed to make Acpi calls itself.
+	 * Need to acquire the namespace reader lock to prevent interference
+	 * with any concurrent table unloads (which causes the deletion of
+	 * namespace objects). We cannot allow the deletion of a namespace node
+	 * while the user function is using it. The exception to this are the
+	 * nodes created and deleted during control method execution -- these
+	 * nodes are marked as temporary nodes and are ignored by the namespace
+	 * walk. Thus, control methods can be executed while holding the
+	 * namespace deletion lock (and the user function can execute control
+	 * methods.)
+	 */
+	status = acpi_ut_acquire_read_lock(&acpi_gbl_namespace_rw_lock);
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+
+	/*
+	 * Lock the namespace around the walk. The namespace will be
+	 * unlocked/locked around each call to the user function - since the user
+	 * function must be allowed to make ACPICA calls itself (for example, it
+	 * will typically execute control methods during device enumeration.)
 	 */
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		goto unlock_and_exit;
 	}
 
 	status = acpi_ns_walk_namespace(type, start_object, max_depth,
-					ACPI_NS_WALK_UNLOCK,
-					user_function, context, return_value);
+					ACPI_NS_WALK_UNLOCK, user_function,
+					context, return_value);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+      unlock_and_exit:
+	(void)acpi_ut_release_read_lock(&acpi_gbl_namespace_rw_lock);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index c379930..f865d5a 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -434,27 +434,56 @@ void acpi_tb_terminate(void)
  *
  * PARAMETERS:  table_index         - Table index
  *
- * RETURN:      None
+ * RETURN:      Status
  *
  * DESCRIPTION: Delete all namespace objects created when this table was loaded.
  *
  ******************************************************************************/
 
-void acpi_tb_delete_namespace_by_owner(u32 table_index)
+acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index)
 {
 	acpi_owner_id owner_id;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(tb_delete_namespace_by_owner);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	if (table_index >= acpi_gbl_root_table_list.count) {
+
+		/* The table index does not exist */
 
-	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
-	if (table_index < acpi_gbl_root_table_list.count) {
-		owner_id =
-		    acpi_gbl_root_table_list.tables[table_index].owner_id;
-	} else {
 		(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
-		return;
+		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
+	/* Get the owner ID for this table, used to delete namespace nodes */
+
+	owner_id = acpi_gbl_root_table_list.tables[table_index].owner_id;
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+
+	/*
+	 * Need to acquire the namespace writer lock to prevent interference
+	 * with any concurrent namespace walks. The interpreter must be
+	 * released during the deletion since the acquisition of the deletion
+	 * lock may block, and also since the execution of a namespace walk
+	 * must be allowed to use the interpreter.
+	 */
+	acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
+	status = acpi_ut_acquire_write_lock(&acpi_gbl_namespace_rw_lock);
+
 	acpi_ns_delete_namespace_by_owner(owner_id);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	acpi_ut_release_write_lock(&acpi_gbl_namespace_rw_lock);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_INTERPRETER);
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/utlock.c b/drivers/acpi/acpica/utlock.c
new file mode 100644
index 0000000..25e0312
--- /dev/null
+++ b/drivers/acpi/acpica/utlock.c
@@ -0,0 +1,175 @@
+/******************************************************************************
+ *
+ * Module Name: utlock - Reader/Writer lock interfaces
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2009, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utlock")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_create_rw_lock
+ *              acpi_ut_delete_rw_lock
+ *
+ * PARAMETERS:  Lock                - Pointer to a valid RW lock
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Reader/writer lock creation and deletion interfaces.
+ *
+ ******************************************************************************/
+acpi_status acpi_ut_create_rw_lock(struct acpi_rw_lock *lock)
+{
+	acpi_status status;
+
+	lock->num_readers = 0;
+	status = acpi_os_create_mutex(&lock->reader_mutex);
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+
+	status = acpi_os_create_mutex(&lock->writer_mutex);
+	return status;
+}
+
+void acpi_ut_delete_rw_lock(struct acpi_rw_lock *lock)
+{
+
+	acpi_os_delete_mutex(lock->reader_mutex);
+	acpi_os_delete_mutex(lock->writer_mutex);
+
+	lock->num_readers = 0;
+	lock->reader_mutex = NULL;
+	lock->writer_mutex = NULL;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_acquire_read_lock
+ *              acpi_ut_release_read_lock
+ *
+ * PARAMETERS:  Lock                - Pointer to a valid RW lock
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Reader interfaces for reader/writer locks. On acquisition,
+ *              only the first reader acquires the write mutex. On release,
+ *              only the last reader releases the write mutex. Although this
+ *              algorithm can in theory starve writers, this should not be a
+ *              problem with ACPICA since the subsystem is infrequently used
+ *              in comparison to (for example) an I/O system.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_acquire_read_lock(struct acpi_rw_lock *lock)
+{
+	acpi_status status;
+
+	status = acpi_os_acquire_mutex(lock->reader_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+
+	/* Acquire the write lock only for the first reader */
+
+	lock->num_readers++;
+	if (lock->num_readers == 1) {
+		status =
+		    acpi_os_acquire_mutex(lock->writer_mutex,
+					  ACPI_WAIT_FOREVER);
+	}
+
+	acpi_os_release_mutex(lock->reader_mutex);
+	return status;
+}
+
+acpi_status acpi_ut_release_read_lock(struct acpi_rw_lock *lock)
+{
+	acpi_status status;
+
+	status = acpi_os_acquire_mutex(lock->reader_mutex, ACPI_WAIT_FOREVER);
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+
+	/* Release the write lock only for the very last reader */
+
+	lock->num_readers--;
+	if (lock->num_readers == 0) {
+		acpi_os_release_mutex(lock->writer_mutex);
+	}
+
+	acpi_os_release_mutex(lock->reader_mutex);
+	return status;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_acquire_write_lock
+ *              acpi_ut_release_write_lock
+ *
+ * PARAMETERS:  Lock                - Pointer to a valid RW lock
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Writer interfaces for reader/writer locks. Simply acquire or
+ *              release the writer mutex associated with the lock. Acquisition
+ *              of the lock is fully exclusive and will block all readers and
+ *              writers until it is released.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_acquire_write_lock(struct acpi_rw_lock *lock)
+{
+	acpi_status status;
+
+	status = acpi_os_acquire_mutex(lock->writer_mutex, ACPI_WAIT_FOREVER);
+	return status;
+}
+
+void acpi_ut_release_write_lock(struct acpi_rw_lock *lock)
+{
+
+	acpi_os_release_mutex(lock->writer_mutex);
+}
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 14eb52c..26c93a7 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -60,7 +60,8 @@ static acpi_status acpi_ut_delete_mutex(acpi_mutex_handle mutex_id);
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Create the system mutex objects.
+ * DESCRIPTION: Create the system mutex objects. This includes mutexes,
+ *              spin locks, and reader/writer locks.
  *
  ******************************************************************************/
 
@@ -71,9 +72,8 @@ acpi_status acpi_ut_mutex_initialize(void)
 
 	ACPI_FUNCTION_TRACE(ut_mutex_initialize);
 
-	/*
-	 * Create each of the predefined mutex objects
-	 */
+	/* Create each of the predefined mutex objects */
+
 	for (i = 0; i < ACPI_NUM_MUTEX; i++) {
 		status = acpi_ut_create_mutex(i);
 		if (ACPI_FAILURE(status)) {
@@ -86,6 +86,9 @@ acpi_status acpi_ut_mutex_initialize(void)
 	spin_lock_init(acpi_gbl_gpe_lock);
 	spin_lock_init(acpi_gbl_hardware_lock);
 
+	/* Create the reader/writer lock for namespace access */
+
+	status = acpi_ut_create_rw_lock(&acpi_gbl_namespace_rw_lock);
 	return_ACPI_STATUS(status);
 }
 
@@ -97,7 +100,8 @@ acpi_status acpi_ut_mutex_initialize(void)
  *
  * RETURN:      None.
  *
- * DESCRIPTION: Delete all of the system mutex objects.
+ * DESCRIPTION: Delete all of the system mutex objects. This includes mutexes,
+ *              spin locks, and reader/writer locks.
  *
  ******************************************************************************/
 
@@ -107,9 +111,8 @@ void acpi_ut_mutex_terminate(void)
 
 	ACPI_FUNCTION_TRACE(ut_mutex_terminate);
 
-	/*
-	 * Delete each predefined mutex object
-	 */
+	/* Delete each predefined mutex object */
+
 	for (i = 0; i < ACPI_NUM_MUTEX; i++) {
 		(void)acpi_ut_delete_mutex(i);
 	}
@@ -118,6 +121,10 @@ void acpi_ut_mutex_terminate(void)
 
 	acpi_os_delete_lock(acpi_gbl_gpe_lock);
 	acpi_os_delete_lock(acpi_gbl_hardware_lock);
+
+	/* Delete the reader/writer lock */
+
+	acpi_ut_delete_rw_lock(&acpi_gbl_namespace_rw_lock);
 	return_VOID;
 }
 
-- 
1.6.0.6

