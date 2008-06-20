From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [RFC] Allow notifications on method execution
Date: Fri, 20 Jun 2008 16:22:27 +0100
Message-ID: <20080620152227.GA11828@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47140 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168AbYFTPWb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 11:22:31 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ibm-acpi@hmh.eng.br

Various bits of hardware (some Thinkpads, for example) will execute ACPI 
methods in response to events but won't generate any notifications. It 
would be nice to be able to receive notifications on those updates in 
order to avoid polling. How about something like the following?

diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 94a6efe..00a6378 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -549,6 +549,78 @@ ACPI_EXPORT_SYMBOL(acpi_remove_notify_handler)
 
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
+acpi_install_method_handler (char *pathname, acpi_method_handler handler,
+			     void *context)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *method;
+
+	acpi_ns_get_node(ACPI_NS_ALL, pathname, 0, &node);
+	if (!node)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	method = acpi_ns_get_attached_object(node);
+
+	if (method->method.notify)
+		return_ACPI_STATUS(AE_ALREADY_EXISTS);
+
+	method->method.notify = handler;
+	method->method.context = context;
+
+	return_ACPI_STATUS(AE_OK);
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
+acpi_remove_method_handler (char *pathname, acpi_method_handler handler)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *method;
+
+	acpi_ns_get_node(ACPI_NS_ALL, pathname, 0, &node);
+	if (!node)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	method = acpi_ns_get_attached_object(node);
+
+	if (method->method.notify != handler)
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+
+	method->method.notify = NULL;
+	method->method.context = NULL;
+
+	return_ACPI_STATUS(AE_OK);
+}
+ACPI_EXPORT_SYMBOL(acpi_remove_method_handler)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_install_gpe_handler
  *
  * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 15e1702..018c929 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -445,6 +445,7 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 	struct acpi_thread_state *thread;
 	struct acpi_thread_state *prev_walk_list = acpi_gbl_current_walk_list;
 	struct acpi_walk_state *previous_walk_state;
+	struct acpi_namespace_node *method_node;
 
 	ACPI_FUNCTION_TRACE(ps_parse_aml);
 
@@ -488,6 +489,15 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 
 	status = AE_OK;
 	while (walk_state) {
+		method_node = walk_state->method_call_node;
+
+		if (method_node) {
+			union acpi_operand_object *method =
+				acpi_ns_get_attached_object(method_node);
+			if (method->method.notify)
+				method->method.notify(method->method.context);
+		}
+
 		if (ACPI_SUCCESS(status)) {
 			/*
 			 * The parse_loop executes AML until the method terminates
diff --git a/include/acpi/acobject.h b/include/acpi/acobject.h
index e9657da..86f6e59 100644
--- a/include/acpi/acobject.h
+++ b/include/acpi/acobject.h
@@ -183,6 +183,8 @@ struct acpi_object_method {
 	u32 aml_length;
 	u8 thread_count;
 	acpi_owner_id owner_id;
+	acpi_method_handler notify;
+	void *context;
 };
 
 /******************************************************************************
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2c3806e..3ee976a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -212,6 +212,13 @@ acpi_remove_notify_handler(acpi_handle device,
 			   u32 handler_type, acpi_notify_handler handler);
 
 acpi_status
+acpi_install_method_handler(char *pathname, acpi_method_handler handler,
+			    void *context);
+
+acpi_status
+acpi_remove_method_handler(char *pathname, acpi_method_handler handler);
+
+acpi_status
 acpi_install_address_space_handler(acpi_handle device,
 				   acpi_adr_space_type space_id,
 				   acpi_adr_space_handler handler,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index dfea2d4..e67bc42 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -768,6 +768,9 @@ void (*acpi_notify_handler) (acpi_handle device, u32 value, void *context);
 typedef
 void (*acpi_object_handler) (acpi_handle object, u32 function, void *data);
 
+typedef
+void (*acpi_method_handler) (void *context);
+
 typedef acpi_status(*acpi_init_handler) (acpi_handle object, u32 function);
 
 #define ACPI_INIT_DEVICE_INI        1


-- 
Matthew Garrett | mjg59@srcf.ucam.org
