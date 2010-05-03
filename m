From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/2] acpi: Provide interface for driver notification on method call
Date: Mon,  3 May 2010 16:02:59 -0400
Message-ID: <1272916980-11835-1-git-send-email-mjg@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

It's sometimes useful for a driver to receive notifications in response
to an ACPI event even if there's no explicit notification in the bytecode.
Add an interface to allow drivers to register for callbacks when a given
method is executed.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/acpica/acobject.h |    2 +
 drivers/acpi/acpica/dsmethod.c |    5 ++
 drivers/acpi/acpica/evxface.c  |  103 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |    7 +++
 include/acpi/actypes.h         |    2 +
 5 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index cde18ea..b46b23c 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -188,6 +188,8 @@ struct acpi_object_method {
 	u32 aml_length;
 	u8 thread_count;
 	acpi_owner_id owner_id;
+	acpi_osd_exec_callback notify;
+	void *context;
 };
 
 /******************************************************************************
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 7210392..a453cda 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -420,6 +420,11 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 		}
 	}
 
+	if (obj_desc->method.notify) {
+		acpi_os_execute(OSL_NOTIFY_HANDLER, obj_desc->method.notify,
+				obj_desc->method.context);
+	}
+
 	return_ACPI_STATUS(status);
 
       cleanup:
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index b407579..af81832 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -653,6 +653,109 @@ ACPI_EXPORT_SYMBOL(acpi_remove_notify_handler)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_install_method_handler
+ *
+ * PARAMETERS:  Oathname        - The method for which notifies will be handled
+ *              Handler         - Address of the handler
+ *              Context         - Value passed to the handler on each call
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a handler for notifies on ACPI method execution
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_install_method_handler (acpi_handle handle, acpi_method_handler handler,
+			     void *context)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *method;
+	acpi_status status;
+
+	if (!handle || !handler)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	node = acpi_ns_validate_handle(handle);
+
+	if (!node) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	method = acpi_ns_get_attached_object(node);
+
+	if (method->method.notify) {
+		status = AE_ALREADY_EXISTS;
+		goto unlock_and_exit;
+	}
+
+	method->method.notify = handler;
+	method->method.context = context;
+
+unlock_and_exit:
+	acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_install_method_handler)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_remove_method_handler
+ *
+ * PARAMETERS:  Pathname        - The method for which notifies will be handled
+ *              Handler         - Address of the handler
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove a handler for notifies on ACPI method execution
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_remove_method_handler (acpi_handle handle, acpi_method_handler handler)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *method;
+	acpi_status status;
+
+	if (!handle || !handler)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	node = acpi_ns_validate_handle(handle);
+
+	if (!node) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	method = acpi_ns_get_attached_object(node);
+
+	if (method->method.notify != handler) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	method->method.notify = NULL;
+	method->method.context = NULL;
+
+unlock_and_exit:
+	acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_remove_method_handler)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_install_gpe_handler
  *
  * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4447a04..21e7646 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -240,6 +240,13 @@ acpi_remove_notify_handler(acpi_handle device,
 			   u32 handler_type, acpi_notify_handler handler);
 
 acpi_status
+acpi_install_method_handler(acpi_handle handle, acpi_method_handler handler,
+			    void *context);
+
+acpi_status
+acpi_remove_method_handler(acpi_handle handle, acpi_method_handler handler);
+
+acpi_status
 acpi_install_address_space_handler(acpi_handle device,
 				   acpi_adr_space_type space_id,
 				   acpi_adr_space_handler handler,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3f08e64..bf2fcf8 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -916,6 +916,8 @@ void (*acpi_notify_handler) (acpi_handle device, u32 value, void *context);
 typedef
 void (*acpi_object_handler) (acpi_handle object, void *data);
 
+typedef void (*acpi_method_handler) (void *context);
+
 typedef acpi_status(*acpi_init_handler) (acpi_handle object, u32 function);
 
 #define ACPI_INIT_DEVICE_INI        1
-- 
1.7.0.1

