From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Version 20120620 linuxized patches.
Date: Fri, 29 Jun 2012 13:49:57 +0800
Message-ID: <1340948997.3328.181.camel@minggr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0qycMVR+ggZhk6/v31x5"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17250 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab2F2Ft7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jun 2012 01:49:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-0qycMVR+ggZhk6/v31x5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Len,

ACPICA Version 20120620 linuxized patches attached.
Applied on top of your acpi/next branch.

[PATCH 1/5] ACPICA: Disassembler: Emit descriptions for ACPI
[PATCH 2/5] ACPICA: Utilities: conditionally compile backslash
[PATCH 3/5] ACPICA: Update comments; no functional change
[PATCH 4/5] ACPICA: Add support for implicit notify on multiple devices
[PATCH 5/5] ACPICA: Update to version 20120620

Regards,
Lin Ming

--=-0qycMVR+ggZhk6/v31x5
Content-Disposition: attachment; filename="acpica-v20120620.patch"
Content-Type: text/x-patch; name="acpica-v20120620.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From f39c01bb24b2a7f34e2997c8191ecaba240f099a Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 29 Jun 2012 09:12:59 +0800
Subject: [PATCH 1/5] ACPICA: Disassembler: Emit descriptions for ACPI
 predefined names

For each predefined name, emit a short description within
a comment.

https://www.acpica.org/bugzilla/show_bug.cgi?id=959

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    8 ++++++++
 drivers/acpi/acpica/aclocal.h  |   15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index dec7994..92fab6a 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -462,4 +462,12 @@ ACPI_EXTERN u32 acpi_gbl_size_of_acpi_objects;
 
 #endif				/* ACPI_DEBUGGER */
 
+/*****************************************************************************
+ *
+ * Info/help support
+ *
+ ****************************************************************************/
+
+extern const struct ah_predefined_name asl_predefined_info[];
+
 #endif				/* __ACGLOBAL_H__ */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 28f6778..af7330f 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -796,6 +796,7 @@ struct acpi_parse_state {
 #define ACPI_PARSEOP_IGNORE             0x01
 #define ACPI_PARSEOP_PARAMLIST          0x02
 #define ACPI_PARSEOP_EMPTY_TERMLIST     0x04
+#define ACPI_PARSEOP_PREDEF_CHECKED     0x08
 #define ACPI_PARSEOP_SPECIAL            0x10
 
 /*****************************************************************************
@@ -1084,4 +1085,18 @@ struct acpi_debug_mem_block {
 #define ACPI_MEM_LIST_MAX               1
 #define ACPI_NUM_MEM_LISTS              2
 
+/*****************************************************************************
+ *
+ * Info/help support
+ *
+ ****************************************************************************/
+
+struct ah_predefined_name {
+	char *name;
+	char *description;
+#ifndef ACPI_ASL_COMPILER
+	char *action;
+#endif
+};
+
 #endif				/* __ACLOCAL_H__ */
-- 
1.7.10

>From fa164246ed36477a146a18cf136783ae3aeb1420 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 29 Jun 2012 09:16:30 +0800
Subject: [PATCH 2/5] ACPICA: Utilities: conditionally compile backslash
 removal function

Only used for iASL and AcpiExec.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utmisc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index e86f897..577a44e 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -50,6 +50,7 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utmisc")
 
+#if defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP
 /*******************************************************************************
  *
  * FUNCTION:    ut_convert_backslashes
@@ -77,6 +78,7 @@ void ut_convert_backslashes(char *pathname)
 		pathname++;
 	}
 }
+#endif
 
 /*******************************************************************************
  *
-- 
1.7.10

>From a24ffb6ee9a7779d991dbf7f7c38b6694121179c Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 29 Jun 2012 09:19:16 +0800
Subject: [PATCH 3/5] ACPICA: Update comments; no functional change

Cleanup a couple of comments.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index bbb34c9..c8e5756 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -511,14 +511,14 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_TMP", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TPC", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TPT", 1, 0}},
-	{{"_TRT", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 2_ref/6_int */
+	{{"_TRT", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 2 Ref/6 Int */
 			  {{{ACPI_PTYPE2, ACPI_RTYPE_REFERENCE, 2, ACPI_RTYPE_INTEGER}, 6, 0}},
 
-	{{"_TSD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5_int with count */
+	{{"_TSD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5 Int with count */
 			  {{{ACPI_PTYPE2_COUNT,ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
 
 	{{"_TSP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TSS", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5_int */
+	{{"_TSS", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5 Int */
 			  {{{ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
 
 	{{"_TST", 0, ACPI_RTYPE_INTEGER}},
-- 
1.7.10

>From 4cafe72b533217e631676cad107f1a3dab3d4620 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 29 Jun 2012 10:04:17 +0800
Subject: [PATCH 4/5] ACPICA: Add support for implicit notify on multiple
 devices

Adds basic support to allow multiple devices to be implicitly
notified.

This change is partially derived from original commit 981858b("ACPI /
ACPICA: Implicit notify for multiple devices") by Rafael.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Jung-uk Kim <jkim@freebsd.org>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |   11 +++-
 drivers/acpi/acpica/evgpe.c     |   22 ++++----
 drivers/acpi/acpica/evgpeutil.c |   20 ++++++++
 drivers/acpi/acpica/evxfgpe.c   |  106 +++++++++++++++++++++++++--------------
 4 files changed, 109 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index af7330f..6b225e8 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -404,6 +404,13 @@ struct acpi_gpe_handler_info {
 	u8 originally_enabled;  /* True if GPE was originally enabled */
 };
 
+/* Notify info for implicit notify, multiple device objects */
+
+struct acpi_gpe_notify_info {
+	struct acpi_namespace_node *device_node;	/* Device to be notified */
+	struct acpi_gpe_notify_info *next;
+};
+
 struct acpi_gpe_notify_object {
 	struct acpi_namespace_node *node;
 	struct acpi_gpe_notify_object *next;
@@ -412,7 +419,7 @@ struct acpi_gpe_notify_object {
 union acpi_gpe_dispatch_info {
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level */
 	struct acpi_gpe_handler_info *handler;  /* Installed GPE handler */
-	struct acpi_gpe_notify_object device;   /* List of _PRW devices for implicit notify */
+	struct acpi_gpe_notify_info *notify_list;	/* List of _PRW devices for implicit notifies */
 };
 
 /*
@@ -420,7 +427,7 @@ union acpi_gpe_dispatch_info {
  * NOTE: Important to keep this struct as small as possible.
  */
 struct acpi_gpe_event_info {
-	union acpi_gpe_dispatch_info dispatch;	/* Either Method or Handler */
+	union acpi_gpe_dispatch_info dispatch;	/* Either Method, Handler, or notify_list */
 	struct acpi_gpe_register_info *register_info;	/* Backpointer to register info */
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 8ba0e5f..afbd5cb 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -466,7 +466,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	acpi_status status;
 	struct acpi_gpe_event_info *local_gpe_event_info;
 	struct acpi_evaluate_info *info;
-	struct acpi_gpe_notify_object *notify_object;
+	struct acpi_gpe_notify_info *notify;
 
 	ACPI_FUNCTION_TRACE(ev_asynch_execute_gpe_method);
 
@@ -517,17 +517,17 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		 * completes. The notify handlers are NOT invoked synchronously
 		 * from this thread -- because handlers may in turn run other
 		 * control methods.
+		 *
+		 * June 2012: Expand implicit notify mechanism to support
+		 * notifies on multiple device objects.
 		 */
-		status = acpi_ev_queue_notify_request(
-				local_gpe_event_info->dispatch.device.node,
-				ACPI_NOTIFY_DEVICE_WAKE);
-
-		notify_object = local_gpe_event_info->dispatch.device.next;
-		while (ACPI_SUCCESS(status) && notify_object) {
-			status = acpi_ev_queue_notify_request(
-					notify_object->node,
-					ACPI_NOTIFY_DEVICE_WAKE);
-			notify_object = notify_object->next;
+		notify = local_gpe_event_info->dispatch.notify_list;
+		while (ACPI_SUCCESS(status) && notify) {
+			status =
+			    acpi_ev_queue_notify_request(notify->device_node,
+							 ACPI_NOTIFY_DEVICE_WAKE);
+
+			notify = notify->next;
 		}
 
 		break;
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 3c43796..0c33c62 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -347,6 +347,8 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			    void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_gpe_notify_info *notify;
+	struct acpi_gpe_notify_info *next;
 	u32 i;
 	u32 j;
 
@@ -365,10 +367,28 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 			if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 			    ACPI_GPE_DISPATCH_HANDLER) {
+
+				/* Delete an installed handler block */
+
 				ACPI_FREE(gpe_event_info->dispatch.handler);
 				gpe_event_info->dispatch.handler = NULL;
 				gpe_event_info->flags &=
 				    ~ACPI_GPE_DISPATCH_MASK;
+			} else if ((gpe_event_info->
+				 flags & ACPI_GPE_DISPATCH_MASK) ==
+				ACPI_GPE_DISPATCH_NOTIFY) {
+
+				/* Delete the implicit notification device list */
+
+				notify = gpe_event_info->dispatch.notify_list;
+				while (notify) {
+					next = notify->next;
+					ACPI_FREE(notify);
+					notify = next;
+				}
+				gpe_event_info->dispatch.notify_list = NULL;
+				gpe_event_info->flags &=
+				    ~ACPI_GPE_DISPATCH_MASK;
 			}
 		}
 	}
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 86f9b34..2ce4409 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -197,12 +197,12 @@ acpi_status
 acpi_setup_gpe_for_wake(acpi_handle wake_device,
 			acpi_handle gpe_device, u32 gpe_number)
 {
-	acpi_status status = AE_BAD_PARAMETER;
+	acpi_status status;
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_namespace_node *device_node;
-	struct acpi_gpe_notify_object *notify_object;
+	struct acpi_gpe_notify_info *notify;
+	struct acpi_gpe_notify_info *new_notify;
 	acpi_cpu_flags flags;
-	u8 gpe_dispatch_mask;
 
 	ACPI_FUNCTION_TRACE(acpi_setup_gpe_for_wake);
 
@@ -216,63 +216,95 @@ acpi_setup_gpe_for_wake(acpi_handle wake_device,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
+	/* Handle root object case */
+
+	if (wake_device == ACPI_ROOT_OBJECT) {
+		device_node = acpi_gbl_root_node;
+	} else {
+		device_node = ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
+	}
+
+	/* Validate WakeDevice is of type Device */
+
+	if (device_node->type != ACPI_TYPE_DEVICE) {
+		return_ACPI_STATUS (AE_BAD_PARAMETER);
+	}
+
+	/*
+	 * Allocate a new notify object up front, in case it is needed.
+	 * Memory allocation while holding a spinlock is a big no-no
+	 * on some hosts.
+	 */
+	new_notify = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_notify_info));
+	if (!new_notify) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
 		goto unlock_and_exit;
 	}
 
-	if (wake_device == ACPI_ROOT_OBJECT) {
-		goto out;
-	}
-
 	/*
 	 * If there is no method or handler for this GPE, then the
-	 * wake_device will be notified whenever this GPE fires (aka
-	 * "implicit notify") Note: The GPE is assumed to be
+	 * wake_device will be notified whenever this GPE fires. This is
+	 * known as an "implicit notify". Note: The GPE is assumed to be
 	 * level-triggered (for windows compatibility).
 	 */
-	gpe_dispatch_mask = gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK;
-	if (gpe_dispatch_mask != ACPI_GPE_DISPATCH_NONE
-	    && gpe_dispatch_mask != ACPI_GPE_DISPATCH_NOTIFY) {
-		goto out;
-	}
-
-	/* Validate wake_device is of type Device */
-
-	device_node = ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
-	if (device_node->type != ACPI_TYPE_DEVICE) {
-		goto unlock_and_exit;
+	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	    ACPI_GPE_DISPATCH_NONE) {
+		/*
+		 * This is the first device for implicit notify on this GPE.
+		 * Just set the flags here, and enter the NOTIFY block below.
+		 */
+		gpe_event_info->flags =
+		    (ACPI_GPE_DISPATCH_NOTIFY | ACPI_GPE_LEVEL_TRIGGERED);
 	}
 
-	if (gpe_dispatch_mask == ACPI_GPE_DISPATCH_NONE) {
-		gpe_event_info->flags = (ACPI_GPE_DISPATCH_NOTIFY |
-					 ACPI_GPE_LEVEL_TRIGGERED);
-		gpe_event_info->dispatch.device.node = device_node;
-		gpe_event_info->dispatch.device.next = NULL;
-	} else {
-		/* There are multiple devices to notify implicitly. */
-
-		notify_object = ACPI_ALLOCATE_ZEROED(sizeof(*notify_object));
-		if (!notify_object) {
-			status = AE_NO_MEMORY;
-			goto unlock_and_exit;
+	/*
+	 * If we already have an implicit notify on this GPE, add
+	 * this device to the notify list.
+	 */
+	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	    ACPI_GPE_DISPATCH_NOTIFY) {
+
+		/* Ensure that the device is not already in the list */
+
+		notify = gpe_event_info->dispatch.notify_list;
+		while (notify) {
+			if (notify->device_node == device_node) {
+				status = AE_ALREADY_EXISTS;
+				goto unlock_and_exit;
+			}
+			notify = notify->next;
 		}
 
-		notify_object->node = device_node;
-		notify_object->next = gpe_event_info->dispatch.device.next;
-		gpe_event_info->dispatch.device.next = notify_object;
+		/* Add this device to the notify list for this GPE */
+
+		new_notify->device_node = device_node;
+		new_notify->next = gpe_event_info->dispatch.notify_list;
+		gpe_event_info->dispatch.notify_list = new_notify;
+		new_notify = NULL;
 	}
 
- out:
+	/* Mark the GPE as a possible wake event */
+
 	gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
 	status = AE_OK;
 
- unlock_and_exit:
+unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	/* Delete the notify object if it was not used above */
+
+	if (new_notify) {
+		ACPI_FREE(new_notify);
+	}
 	return_ACPI_STATUS(status);
 }
 ACPI_EXPORT_SYMBOL(acpi_setup_gpe_for_wake)
-- 
1.7.10

>From 6b12452431a695ae68fb9398f50f4ed422371194 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 29 Jun 2012 11:06:33 +0800
Subject: [PATCH 5/5] ACPICA: Update to version 20120620

Version 20120620.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 381c940..18f023a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20120518
+#define ACPI_CA_VERSION                 0x20120620
 
 #include "acconfig.h"
 #include "actypes.h"
-- 
1.7.10


--=-0qycMVR+ggZhk6/v31x5--

