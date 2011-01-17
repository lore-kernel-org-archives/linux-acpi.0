From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20110112 linuxized patches
Date: Mon, 17 Jan 2011 10:37:52 +0800
Message-ID: <1295231872.28388.95.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6SABkmM4P7Zbn//ilHYm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52738 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab1AQCh0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Jan 2011 21:37:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>


--=-6SABkmM4P7Zbn//ilHYm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA release 20110112 linuxized patches attached.
Applied on top of linux-acpi-2.6.git release branch.

Would you consider merging it for 2.6.38?

[PATCH 1/4] ACPICA: Fix namespace race condition
[PATCH 2/4] ACPICA: Debugger: Lock namespace for duration of a namespace dump
[PATCH 3/4] ACPICA: Fix issues/fault with automatic "serialized" method support
[PATCH 4/4] ACPICA: Update version to 20110112

Thanks,
Lin Ming

--=-6SABkmM4P7Zbn//ilHYm
Content-Type: application/mbox; name="acpica_v20110112.mbox"
Content-Disposition: attachment; filename="acpica_v20110112.mbox"
Content-Transfer-Encoding: 7bit

>From db0a06ca3efb4a6bf96c5136b9e07e83ab48f69f Mon Sep 17 00:00:00 2001
From: Dana Myers <dana.myers@oracle.com>
Date: Wed, 12 Jan 2011 09:09:31 +0800
Subject: [PATCH 1/4] ACPICA: Fix namespace race condition

Fixes a race condition between method execution and namespace
walks that can possibly fault. Problem was apparently introduced
in version 20100528 as a result of a performance optimization
that reduces the number of namespace walks upon method exit
by using the delete_namespace_subtree function instead of the
delete_namespace_by_owner function used previously. Bug is in
the delete_namespace_subtree function.

Signed-off-by: Dana Myers <dana.myers@oracle.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsalloc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 1e5ff80..222a23e 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -341,6 +341,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 {
 	struct acpi_namespace_node *child_node = NULL;
 	u32 level = 1;
+	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ns_delete_namespace_subtree);
 
@@ -348,6 +349,13 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 		return_VOID;
 	}
 
+	/* Lock namespace for possible update */
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_VOID;
+	}
+
 	/*
 	 * Traverse the tree of objects until we bubble back up
 	 * to where we started.
@@ -397,6 +405,7 @@ void acpi_ns_delete_namespace_subtree(struct acpi_namespace_node *parent_node)
 		}
 	}
 
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_VOID;
 }
 
-- 
1.7.3

>From f5233b7ab1118f9019137019cc8702324d4fb468 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 12 Jan 2011 09:13:31 +0800
Subject: [PATCH 2/4] ACPICA: Debugger: Lock namespace for duration of a namespace dump

Prevents issues if the namespace is changing underneath the
debugger.  Especially temporary nodes, since the debugger displays
these also.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsdump.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index a54dc39..82693c3 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -624,9 +624,22 @@ acpi_ns_dump_objects(acpi_object_type type,
 		     acpi_owner_id owner_id, acpi_handle start_handle)
 {
 	struct acpi_walk_info info;
+	acpi_status status;
 
 	ACPI_FUNCTION_ENTRY();
 
+	/*
+	 * Just lock the entire namespace for the duration of the dump.
+	 * We don't want any changes to the namespace during this time,
+	 * especially the temporary nodes since we are going to display
+	 * them also.
+	 */
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not acquire namespace mutex\n");
+		return;
+	}
+
 	info.debug_level = ACPI_LV_TABLES;
 	info.owner_id = owner_id;
 	info.display_type = display_type;
@@ -636,6 +649,8 @@ acpi_ns_dump_objects(acpi_object_type type,
 				     ACPI_NS_WALK_TEMP_NODES,
 				     acpi_ns_dump_one_object, NULL,
 				     (void *)&info, NULL);
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 }
 #endif				/* ACPI_FUTURE_USAGE */
 
-- 
1.7.3

>From 891b97cf2b740f51b941cf838c66aa8427fc4c1a Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Wed, 12 Jan 2011 09:19:43 +0800
Subject: [PATCH 3/4] ACPICA: Fix issues/fault with automatic "serialized" method support

History: This support changes a method to "serialized" on the fly if the
method generates an AE_ALREADY_EXISTS error, indicating the possibility
that it cannot handle reentrancy.

This fix repairs a couple of issues seen in the field, especially on
machines with many cores.

1) Delete method children only upon the exit of the last thread, so
as to not delete objects out from under running threads.

2) Set the "serialized" bit for the method only upon the exit of the
last thread, so as to not cause deadlock when running threads attempt
to exit.

3) Cleanup the use of the AML "MethodFlags" and internal method flags
so that there is no longer any confustion between the two.

Reported-by: Dana Myers <dana.myers@oracle.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acobject.h |   14 ++++++--
 drivers/acpi/acpica/amlcode.h  |    8 +----
 drivers/acpi/acpica/dsmethod.c |   62 ++++++++++++++++++++++++++++++---------
 drivers/acpi/acpica/evrgnini.c |    4 +-
 drivers/acpi/acpica/excreate.c |    8 ++--
 drivers/acpi/acpica/exdump.c   |    2 +-
 drivers/acpi/acpica/nsaccess.c |    6 ++--
 drivers/acpi/acpica/nsalloc.c  |    4 +-
 drivers/acpi/acpica/nseval.c   |    2 +-
 drivers/acpi/acpica/nsxfname.c |    5 +--
 drivers/acpi/acpica/psloop.c   |    2 +-
 drivers/acpi/acpica/psparse.c  |   25 +++++-----------
 drivers/acpi/acpica/psxface.c  |    7 ++--
 13 files changed, 85 insertions(+), 64 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index bdbfaf2..efaf9c6 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -97,8 +97,6 @@
 #define AOPOBJ_OBJECT_INITIALIZED   0x08	/* Region is initialized, _REG was run */
 #define AOPOBJ_SETUP_COMPLETE       0x10	/* Region setup is complete */
 #define AOPOBJ_INVALID              0x20	/* Host OS won't allow a Region address */
-#define AOPOBJ_MODULE_LEVEL         0x40	/* Method is actually module-level code */
-#define AOPOBJ_MODIFIED_NAMESPACE   0x80	/* Method modified the namespace */
 
 /******************************************************************************
  *
@@ -175,7 +173,7 @@ struct acpi_object_region {
 };
 
 struct acpi_object_method {
-	ACPI_OBJECT_COMMON_HEADER u8 method_flags;
+	ACPI_OBJECT_COMMON_HEADER u8 info_flags;
 	u8 param_count;
 	u8 sync_level;
 	union acpi_operand_object *mutex;
@@ -183,13 +181,21 @@ struct acpi_object_method {
 	union {
 		ACPI_INTERNAL_METHOD implementation;
 		union acpi_operand_object *handler;
-	} extra;
+	} dispatch;
 
 	u32 aml_length;
 	u8 thread_count;
 	acpi_owner_id owner_id;
 };
 
+/* Flags for info_flags field above */
+
+#define ACPI_METHOD_MODULE_LEVEL        0x01	/* Method is actually module-level code */
+#define ACPI_METHOD_INTERNAL_ONLY       0x02	/* Method is implemented internally (_OSI) */
+#define ACPI_METHOD_SERIALIZED          0x04	/* Method is serialized */
+#define ACPI_METHOD_SERIALIZED_PENDING  0x08	/* Method is to be marked serialized */
+#define ACPI_METHOD_MODIFIED_NAMESPACE  0x10	/* Method modified the namespace */
+
 /******************************************************************************
  *
  * Objects that can be notified.  All share a common notify_info area.
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 1f484ba..ac1f561 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -480,16 +480,10 @@ typedef enum {
 	AML_FIELD_ATTRIB_SMB_BLOCK_CALL = 0x0D
 } AML_ACCESS_ATTRIBUTE;
 
-/* Bit fields in method_flags byte */
+/* Bit fields in the AML method_flags byte */
 
 #define AML_METHOD_ARG_COUNT        0x07
 #define AML_METHOD_SERIALIZED       0x08
 #define AML_METHOD_SYNC_LEVEL       0xF0
 
-/* METHOD_FLAGS_ARG_COUNT is not used internally, define additional flags */
-
-#define AML_METHOD_INTERNAL_ONLY    0x01
-#define AML_METHOD_RESERVED1        0x02
-#define AML_METHOD_RESERVED2        0x04
-
 #endif				/* __AMLCODE_H__ */
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index d94dd89..5a79f40 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -43,7 +43,6 @@
 
 #include <acpi/acpi.h>
 #include "accommon.h"
-#include "amlcode.h"
 #include "acdispat.h"
 #include "acinterp.h"
 #include "acnamesp.h"
@@ -201,7 +200,7 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 	/*
 	 * If this method is serialized, we need to acquire the method mutex.
 	 */
-	if (obj_desc->method.method_flags & AML_METHOD_SERIALIZED) {
+	if (obj_desc->method.info_flags & ACPI_METHOD_SERIALIZED) {
 		/*
 		 * Create a mutex for the method if it is defined to be Serialized
 		 * and a mutex has not already been created. We defer the mutex creation
@@ -413,8 +412,9 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 
 	/* Invoke an internal method if necessary */
 
-	if (obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
-		status = obj_desc->method.extra.implementation(next_walk_state);
+	if (obj_desc->method.info_flags & ACPI_METHOD_INTERNAL_ONLY) {
+		status =
+		    obj_desc->method.dispatch.implementation(next_walk_state);
 		if (status == AE_OK) {
 			status = AE_CTRL_TERMINATE;
 		}
@@ -579,11 +579,14 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 
 		/*
 		 * Delete any namespace objects created anywhere within the
-		 * namespace by the execution of this method. Unless this method
-		 * is a module-level executable code method, in which case we
-		 * want make the objects permanent.
+		 * namespace by the execution of this method. Unless:
+		 * 1) This method is a module-level executable code method, in which
+		 *    case we want make the objects permanent.
+		 * 2) There are other threads executing the method, in which case we
+		 *    will wait until the last thread has completed.
 		 */
-		if (!(method_desc->method.flags & AOPOBJ_MODULE_LEVEL)) {
+		if (!(method_desc->method.info_flags & ACPI_METHOD_MODULE_LEVEL)
+		    && (method_desc->method.thread_count == 1)) {
 
 			/* Delete any direct children of (created by) this method */
 
@@ -593,12 +596,17 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 			/*
 			 * Delete any objects that were created by this method
 			 * elsewhere in the namespace (if any were created).
+			 * Use of the ACPI_METHOD_MODIFIED_NAMESPACE optimizes the
+			 * deletion such that we don't have to perform an entire
+			 * namespace walk for every control method execution.
 			 */
 			if (method_desc->method.
-			    flags & AOPOBJ_MODIFIED_NAMESPACE) {
+			    info_flags & ACPI_METHOD_MODIFIED_NAMESPACE) {
 				acpi_ns_delete_namespace_by_owner(method_desc->
 								  method.
 								  owner_id);
+				method_desc->method.info_flags &=
+				    ~ACPI_METHOD_MODIFIED_NAMESPACE;
 			}
 		}
 	}
@@ -629,19 +637,43 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 		 * Serialized if it appears that the method is incorrectly written and
 		 * does not support multiple thread execution. The best example of this
 		 * is if such a method creates namespace objects and blocks. A second
-		 * thread will fail with an AE_ALREADY_EXISTS exception
+		 * thread will fail with an AE_ALREADY_EXISTS exception.
 		 *
 		 * This code is here because we must wait until the last thread exits
-		 * before creating the synchronization semaphore.
+		 * before marking the method as serialized.
 		 */
-		if ((method_desc->method.method_flags & AML_METHOD_SERIALIZED)
-		    && (!method_desc->method.mutex)) {
-			(void)acpi_ds_create_method_mutex(method_desc);
+		if (method_desc->method.
+		    info_flags & ACPI_METHOD_SERIALIZED_PENDING) {
+			if (walk_state) {
+				ACPI_INFO((AE_INFO,
+					   "Marking method %4.4s as Serialized because of AE_ALREADY_EXISTS error",
+					   walk_state->method_node->name.
+					   ascii));
+			}
+
+			/*
+			 * Method tried to create an object twice and was marked as
+			 * "pending serialized". The probable cause is that the method
+			 * cannot handle reentrancy.
+			 *
+			 * The method was created as not_serialized, but it tried to create
+			 * a named object and then blocked, causing the second thread
+			 * entrance to begin and then fail. Workaround this problem by
+			 * marking the method permanently as Serialized when the last
+			 * thread exits here.
+			 */
+			method_desc->method.info_flags &=
+			    ~ACPI_METHOD_SERIALIZED_PENDING;
+			method_desc->method.info_flags |=
+			    ACPI_METHOD_SERIALIZED;
+			method_desc->method.sync_level = 0;
 		}
 
 		/* No more threads, we can free the owner_id */
 
-		if (!(method_desc->method.flags & AOPOBJ_MODULE_LEVEL)) {
+		if (!
+		    (method_desc->method.
+		     info_flags & ACPI_METHOD_MODULE_LEVEL)) {
 			acpi_ut_release_owner_id(&method_desc->method.owner_id);
 		}
 	}
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 0b47a6d..2ef32e9 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -590,9 +590,9 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 				 * See acpi_ns_exec_module_code
 				 */
 				if (obj_desc->method.
-				    flags & AOPOBJ_MODULE_LEVEL) {
+				    info_flags & ACPI_METHOD_MODULE_LEVEL) {
 					handler_obj =
-					    obj_desc->method.extra.handler;
+					    obj_desc->method.dispatch.handler;
 				}
 				break;
 
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 3c61b48..ffac8c7 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -482,13 +482,11 @@ acpi_ex_create_method(u8 * aml_start,
 	obj_desc->method.aml_length = aml_length;
 
 	/*
-	 * Disassemble the method flags. Split off the Arg Count
-	 * for efficiency
+	 * Disassemble the method flags. Split off the arg_count, Serialized
+	 * flag, and sync_level for efficiency.
 	 */
 	method_flags = (u8) operand[1]->integer.value;
 
-	obj_desc->method.method_flags =
-	    (u8) (method_flags & ~AML_METHOD_ARG_COUNT);
 	obj_desc->method.param_count =
 	    (u8) (method_flags & AML_METHOD_ARG_COUNT);
 
@@ -497,6 +495,8 @@ acpi_ex_create_method(u8 * aml_start,
 	 * created for this method when it is parsed.
 	 */
 	if (method_flags & AML_METHOD_SERIALIZED) {
+		obj_desc->method.info_flags = ACPI_METHOD_SERIALIZED;
+
 		/*
 		 * ACPI 1.0: sync_level = 0
 		 * ACPI 2.0: sync_level = sync_level in method declaration
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index f067bbb..ff4b1e6 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -122,7 +122,7 @@ static struct acpi_exdump_info acpi_ex_dump_event[2] = {
 
 static struct acpi_exdump_info acpi_ex_dump_method[9] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_method), NULL},
-	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.method_flags), "Method Flags"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.info_flags), "Info Flags"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.param_count),
 	 "Parameter Count"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.sync_level), "Sync Level"},
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 0cd925b..cede0e3 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -163,9 +163,9 @@ acpi_status acpi_ns_root_initialize(void)
 #else
 				/* Mark this as a very SPECIAL method */
 
-				obj_desc->method.method_flags =
-				    AML_METHOD_INTERNAL_ONLY;
-				obj_desc->method.extra.implementation =
+				obj_desc->method.info_flags =
+				    ACPI_METHOD_INTERNAL_ONLY;
+				obj_desc->method.dispatch.implementation =
 				    acpi_ut_osi_implementation;
 #endif
 				break;
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 222a23e..222a984 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -234,8 +234,8 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 			 * modified the namespace. This is used for cleanup when the
 			 * method exits.
 			 */
-			walk_state->method_desc->method.flags |=
-			    AOPOBJ_MODIFIED_NAMESPACE;
+			walk_state->method_desc->method.info_flags |=
+			    ACPI_METHOD_MODIFIED_NAMESPACE;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index f52829c..a55c0d2 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -389,7 +389,7 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 	 * acpi_gbl_root_node->Object is NULL at PASS1.
 	 */
 	if ((type == ACPI_TYPE_DEVICE) && parent_node->object) {
-		method_obj->method.extra.handler =
+		method_obj->method.dispatch.handler =
 		    parent_node->object->device.handler;
 	}
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index b01e45a..0a26d73 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -603,10 +603,9 @@ acpi_status acpi_install_method(u8 *buffer)
 	method_obj->method.param_count = (u8)
 	    (method_flags & AML_METHOD_ARG_COUNT);
 
-	method_obj->method.method_flags = (u8)
-	    (method_flags & ~AML_METHOD_ARG_COUNT);
-
 	if (method_flags & AML_METHOD_SERIALIZED) {
+		method_obj->method.info_flags = ACPI_METHOD_SERIALIZED;
+
 		method_obj->method.sync_level = (u8)
 		    ((method_flags & AML_METHOD_SYNC_LEVEL) >> 4);
 	}
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 2f2e776..06edeaf 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -655,7 +655,7 @@ acpi_ps_link_module_code(union acpi_parse_object *parent_op,
 		method_obj->method.aml_start = aml_start;
 		method_obj->method.aml_length = aml_length;
 		method_obj->method.owner_id = owner_id;
-		method_obj->method.flags |= AOPOBJ_MODULE_LEVEL;
+		method_obj->method.info_flags |= ACPI_METHOD_MODULE_LEVEL;
 
 		/*
 		 * Save the parent node in next_object. This is cheating, but we
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 8d81542..3b8de11 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -55,7 +55,6 @@
 #include "acparser.h"
 #include "acdispat.h"
 #include "amlcode.h"
-#include "acnamesp.h"
 #include "acinterp.h"
 
 #define _COMPONENT          ACPI_PARSER
@@ -539,24 +538,16 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 			/* Check for possible multi-thread reentrancy problem */
 
 			if ((status == AE_ALREADY_EXISTS) &&
-			    (!walk_state->method_desc->method.mutex)) {
-				ACPI_INFO((AE_INFO,
-					   "Marking method %4.4s as Serialized because of AE_ALREADY_EXISTS error",
-					   walk_state->method_node->name.
-					   ascii));
-
+			    (!(walk_state->method_desc->method.
+			       info_flags & ACPI_METHOD_SERIALIZED))) {
 				/*
-				 * Method tried to create an object twice. The probable cause is
-				 * that the method cannot handle reentrancy.
-				 *
-				 * The method is marked not_serialized, but it tried to create
-				 * a named object, causing the second thread entrance to fail.
-				 * Workaround this problem by marking the method permanently
-				 * as Serialized.
+				 * Method is not serialized and tried to create an object
+				 * twice. The probable cause is that the method cannot
+				 * handle reentrancy. Mark as "pending serialized" now, and
+				 * then mark "serialized" when the last thread exits.
 				 */
-				walk_state->method_desc->method.method_flags |=
-				    AML_METHOD_SERIALIZED;
-				walk_state->method_desc->method.sync_level = 0;
+				walk_state->method_desc->method.info_flags |=
+				    ACPI_METHOD_SERIALIZED_PENDING;
 			}
 		}
 
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index c42f067..bc49a80 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -47,7 +47,6 @@
 #include "acdispat.h"
 #include "acinterp.h"
 #include "actables.h"
-#include "amlcode.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psxface")
@@ -285,15 +284,15 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 		goto cleanup;
 	}
 
-	if (info->obj_desc->method.flags & AOPOBJ_MODULE_LEVEL) {
+	if (info->obj_desc->method.info_flags & ACPI_METHOD_MODULE_LEVEL) {
 		walk_state->parse_flags |= ACPI_PARSE_MODULE_LEVEL;
 	}
 
 	/* Invoke an internal method if necessary */
 
-	if (info->obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
+	if (info->obj_desc->method.info_flags & ACPI_METHOD_INTERNAL_ONLY) {
 		status =
-		    info->obj_desc->method.extra.implementation(walk_state);
+		    info->obj_desc->method.dispatch.implementation(walk_state);
 		info->return_object = walk_state->return_desc;
 
 		/* Cleanup states */
-- 
1.7.3

>From 3262b18f52a5a28278021873f01add666ca72680 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 17 Jan 2011 10:31:08 +0800
Subject: [PATCH 4/4] ACPICA: Update version to 20110112

Version 20110112.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 241b8a0..6f6f749 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20101209
+#define ACPI_CA_VERSION                 0x20110112
 
 #include "actypes.h"
 #include "actbl.h"
-- 
1.7.3


--=-6SABkmM4P7Zbn//ilHYm--

