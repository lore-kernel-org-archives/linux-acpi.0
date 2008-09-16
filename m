From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/3 (Resend)] ACPI: WMI: Enable event methods when registering notifiers
Date: Tue, 16 Sep 2008 23:36:02 +0100
Message-ID: <200809162336.02955.carlos@strangeworlds.co.uk>
References: <20080915213229.8464.20471.stgit@localhost> <20080915213246.8464.76768.stgit@localhost> <20080916221930.GA26035@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:58828 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYIPWhG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2008 18:37:06 -0400
In-Reply-To: <20080916221930.GA26035@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

From: Matthew Garrett <mjg@redhat.com>

According to the ACPI-WMI spec, event blocks may provide a function call
for enabling/disabling them. This patch adds support for making these
calls when registering or removing notifications. Without this, my Dell
firmware provides no data in the event notification.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/acpi/wmi.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index cfe2c83..5464cfc 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -217,6 +217,35 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	return 0;
 }
 
+static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
+{
+	struct guid_block *block = NULL;
+	char method[5];
+	struct acpi_object_list input;
+	union acpi_object params[1];
+	acpi_status status;
+	acpi_handle handle;
+
+	block = &wblock->gblock;
+	handle = wblock->handle;
+
+	if (!block)
+		return AE_NOT_EXIST;
+
+	input.count = 1;
+	input.pointer = params;
+	params[0].type = ACPI_TYPE_INTEGER;
+	params[0].integer.value = enable;
+
+	snprintf(method, 5, "WE%02X", block->notify_id);
+	status = acpi_evaluate_object(handle, method, &input, NULL);
+
+	if (status != AE_OK && status != AE_NOT_FOUND)
+		return status;
+	else
+		return AE_OK;
+}
+
 /*
  * Exported WMI functions
  */
@@ -427,6 +456,7 @@ acpi_status wmi_install_notify_handler(const char *guid,
 wmi_notify_handler handler, void *data)
 {
 	struct wmi_block *block;
+	acpi_status status;
 
 	if (!guid || !handler)
 		return AE_BAD_PARAMETER;
@@ -441,7 +471,9 @@ wmi_notify_handler handler, void *data)
 	block->handler = handler;
 	block->handler_data = data;
 
-	return AE_OK;
+	status = wmi_method_enable(block, 1);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
 
@@ -453,6 +485,7 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
 acpi_status wmi_remove_notify_handler(const char *guid)
 {
 	struct wmi_block *block;
+	acpi_status status;
 
 	if (!guid)
 		return AE_BAD_PARAMETER;
@@ -464,10 +497,12 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 	if (!block->handler)
 		return AE_NULL_ENTRY;
 
+	status = wmi_method_enable(block, 0);
+
 	block->handler = NULL;
 	block->handler_data = NULL;
 
-	return AE_OK;
+	return status;
 }
 EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
 
