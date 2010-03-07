From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/3] ACPI / ACPICA: Multiple system notify handlers for the root object
Date: Mon, 8 Mar 2010 00:35:05 +0100
Message-ID: <201003080035.06046.rjw@sisk.pl>
References: <201003080034.11053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58354 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158Ab0CGXfG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Mar 2010 18:35:06 -0500
In-Reply-To: <201003080034.11053.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Following commit 3f0be67188c60ebf1b5d00354b44b4b24f5af313
(ACPI / ACPICA: Multiple system notify handlers per device) make it
possible to install multiple system notify handlers for the root
object.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evmisc.c  |   31 +++++-------
 drivers/acpi/acpica/evxface.c |  103 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 98 insertions(+), 36 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxface.c
+++ linux-2.6/drivers/acpi/acpica/evxface.c
@@ -225,6 +225,7 @@ ACPI_EXPORT_SYMBOL(acpi_remove_fixed_eve
  *                                  ACPI_SYSTEM_NOTIFY: system_handler (00-7f)
  *                                  ACPI_DEVICE_NOTIFY: driver_handler (80-ff)
  *                                  ACPI_ALL_NOTIFY:  both system and device
+ *              node               - Device the notifies will be handled for
  *              handler            - Address of the handler
  *              context            - Value passed to the handler on each GPE
  *              next               - Address of a handler object to link to
@@ -237,10 +238,12 @@ ACPI_EXPORT_SYMBOL(acpi_remove_fixed_eve
 static void
 acpi_populate_handler_object(struct acpi_object_notify_handler *handler_obj,
 			     u32 handler_type,
+			     struct acpi_namespace_node *node,
 			     acpi_notify_handler handler, void *context,
 			     struct acpi_object_notify_handler *next)
 {
 	handler_obj->handler_type = handler_type;
+	handler_obj->node = node;
 	handler_obj->handler = handler;
 	handler_obj->context = context;
 	handler_obj->next = next;
@@ -251,6 +254,7 @@ acpi_populate_handler_object(struct acpi
  * FUNCTION:    acpi_add_handler_object
  *
  * PARAMETERS:  parent_obj         - Parent of the new object
+ *              node               - Device the notifies will be handled for
  *              handler            - Address of the handler
  *              context            - Value passed to the handler on each GPE
  *
@@ -261,6 +265,7 @@ acpi_populate_handler_object(struct acpi
  ******************************************************************************/
 static acpi_status
 acpi_add_handler_object(struct acpi_object_notify_handler *parent_obj,
+			struct acpi_namespace_node *node,
 			acpi_notify_handler handler, void *context)
 {
 	struct acpi_object_notify_handler *handler_obj;
@@ -275,6 +280,7 @@ acpi_add_handler_object(struct acpi_obje
 
 	acpi_populate_handler_object(handler_obj,
 					ACPI_SYSTEM_NOTIFY,
+					node,
 					handler, context,
 					parent_obj->next);
 	parent_obj->next = handler_obj;
@@ -339,28 +345,43 @@ acpi_install_notify_handler(acpi_handle 
 	 */
 	if (device == ACPI_ROOT_OBJECT) {
 
-		/* Make sure the handler is not already installed */
-
-		if (((handler_type & ACPI_SYSTEM_NOTIFY) &&
-		     acpi_gbl_system_notify.handler) ||
-		    ((handler_type & ACPI_DEVICE_NOTIFY) &&
-		     acpi_gbl_device_notify.handler)) {
+		/* For a device notify, make sure there's no handler. */
+		if ((handler_type & ACPI_DEVICE_NOTIFY) &&
+		     acpi_gbl_device_notify.handler) {
 			status = AE_ALREADY_EXISTS;
 			goto unlock_and_exit;
 		}
 
-		if (handler_type & ACPI_SYSTEM_NOTIFY) {
-			acpi_gbl_system_notify.node = node;
-			acpi_gbl_system_notify.handler = handler;
-			acpi_gbl_system_notify.context = context;
-		}
+		/* System notifies may have more handlers installed. */
+		if ((handler_type & ACPI_SYSTEM_NOTIFY) &&
+		    acpi_gbl_device_notify.handler) {
+			if (handler_type & ACPI_DEVICE_NOTIFY) {
+				status = AE_ALREADY_EXISTS;
+				goto unlock_and_exit;
+			}
 
-		if (handler_type & ACPI_DEVICE_NOTIFY) {
-			acpi_gbl_device_notify.node = node;
-			acpi_gbl_device_notify.handler = handler;
-			acpi_gbl_device_notify.context = context;
+			status = acpi_add_handler_object(
+						&acpi_gbl_device_notify,
+						node,
+						handler,
+						context);
+			goto unlock_and_exit;
 		}
 
+		if (handler_type & ACPI_SYSTEM_NOTIFY)
+			acpi_populate_handler_object(&acpi_gbl_system_notify,
+							handler_type,
+							node,
+							handler, context,
+							NULL);
+
+		if (handler_type & ACPI_DEVICE_NOTIFY)
+			acpi_populate_handler_object(&acpi_gbl_device_notify,
+							handler_type,
+							node,
+							handler, context,
+							NULL);
+
 		/* Global notify handler installed */
 	}
 
@@ -404,6 +425,7 @@ acpi_install_notify_handler(acpi_handle 
 
 				parent_obj = &notify_obj->notify;
 				status = acpi_add_handler_object(parent_obj,
+								 node,
 								 handler,
 								 context);
 				goto unlock_and_exit;
@@ -441,6 +463,7 @@ acpi_install_notify_handler(acpi_handle 
 
 		acpi_populate_handler_object(&notify_obj->notify,
 						handler_type,
+						node,
 						handler, context,
 						NULL);
 
@@ -534,9 +557,53 @@ acpi_remove_notify_handler(acpi_handle d
 		}
 
 		if (handler_type & ACPI_SYSTEM_NOTIFY) {
-			acpi_gbl_system_notify.node = NULL;
-			acpi_gbl_system_notify.handler = NULL;
-			acpi_gbl_system_notify.context = NULL;
+			struct acpi_object_notify_handler *handler_obj;
+			struct acpi_object_notify_handler *parent_obj;
+
+			handler_obj = &acpi_gbl_system_notify;
+			parent_obj = NULL;
+			while (handler_obj->handler != handler) {
+				if (handler_obj->next) {
+					parent_obj = handler_obj;
+					handler_obj = handler_obj->next;
+				} else {
+					break;
+				}
+			}
+
+			if (handler_obj->handler != handler) {
+				status = AE_BAD_PARAMETER;
+				goto unlock_and_exit;
+			}
+
+			/*
+			 * Remove the handler.  There are three possible cases.
+			 * First, we may need to remove a nonstatic object.
+			 * Second, we may need to remove the static object's
+			 * handler data, while nonstatic objects exist.
+			 * Finally, we may need to clear the static object's
+			 * fields.
+			 */
+			if (parent_obj) {
+				/* Nonstatic object is being removed. */
+				parent_obj->next = handler_obj->next;
+				ACPI_FREE(handler_obj);
+			} else if (acpi_gbl_system_notify.next) {
+				/*
+				 * The handler matches the static object, but
+				 * there are more handler objects in the list.
+				 * Replace the static object's data with the
+				 * first next object's data and remove that
+				 * object.
+				 */
+				handler_obj = acpi_gbl_system_notify.next;
+				acpi_gbl_system_notify = *handler_obj;
+				ACPI_FREE(handler_obj);
+			} else {
+				acpi_gbl_system_notify.node = NULL;
+				acpi_gbl_system_notify.handler = NULL;
+				acpi_gbl_system_notify.context = NULL;
+			}
 		}
 
 		if (handler_type & ACPI_DEVICE_NOTIFY) {
Index: linux-2.6/drivers/acpi/acpica/evmisc.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evmisc.c
+++ linux-2.6/drivers/acpi/acpica/evmisc.c
@@ -221,9 +221,8 @@ static void ACPI_SYSTEM_XFACE acpi_ev_no
 {
 	union acpi_generic_state *notify_info =
 	    (union acpi_generic_state *)context;
-	acpi_notify_handler global_handler = NULL;
-	void *global_context = NULL;
 	union acpi_operand_object *handler_obj;
+	struct acpi_object_notify_handler *notifier = NULL;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -233,34 +232,30 @@ static void ACPI_SYSTEM_XFACE acpi_ev_no
 	 */
 	if (notify_info->notify.value <= ACPI_MAX_SYS_NOTIFY) {
 
-		/* Global system notification handler */
+		/* Global system notification */
 
-		if (acpi_gbl_system_notify.handler) {
-			global_handler = acpi_gbl_system_notify.handler;
-			global_context = acpi_gbl_system_notify.context;
-		}
+		if (acpi_gbl_system_notify.handler)
+			notifier = &acpi_gbl_system_notify;
 	} else {
-		/* Global driver notification handler */
+		/* Global driver notification */
 
-		if (acpi_gbl_device_notify.handler) {
-			global_handler = acpi_gbl_device_notify.handler;
-			global_context = acpi_gbl_device_notify.context;
-		}
+		if (acpi_gbl_device_notify.handler)
+			notifier = &acpi_gbl_device_notify;
 	}
 
-	/* Invoke the system handler first, if present */
+	/* Invoke the system handlers first, if present */
 
-	if (global_handler) {
-		global_handler(notify_info->notify.node,
-			       notify_info->notify.value, global_context);
+	while (notifier) {
+		notifier->handler(notify_info->notify.node,
+				  notify_info->notify.value,
+				  notifier->context);
+		notifier = notifier->next;
 	}
 
 	/* Now invoke the per-device handler, if present */
 
 	handler_obj = notify_info->notify.handler_obj;
 	if (handler_obj) {
-		struct acpi_object_notify_handler *notifier;
-
 		notifier = &handler_obj->notify;
 		while (notifier) {
 			notifier->handler(notify_info->notify.node,

