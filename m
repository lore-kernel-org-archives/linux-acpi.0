From: Duarte Silva <duartejcsilva@gmail.com>
Subject: Propose WMI patch
Date: Tue, 30 Sep 2008 12:06:35 +0100
Message-ID: <200809301206.35983.duartejcsilva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:46474 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbYI3LJA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Sep 2008 07:09:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so9559fgg.17
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2008 04:08:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I wanted to propose a ACPI-WMI API change. Instead of having, wmi_has_guid 
returning a boolean, why not returning a acpi_status. It would allow extented 
error handling, and it would look more ACPI style :)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index cfe2c83..cdff9bf 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -194,14 +194,16 @@ static bool wmi_parse_guid(const u8 *src, u8 *dest)
 	return true;
 }
 
-static bool find_guid(const char *guid_string, struct wmi_block **out)
+static acpi_status find_guid(const char *guid_string, struct wmi_block **out)
 {
 	char tmp[16], guid_input[16];
 	struct wmi_block *wblock;
 	struct guid_block *block;
 	struct list_head *p;
 
-	wmi_parse_guid(guid_string, tmp);
+	if (!wmi_parse_guid(guid_string, tmp))
+		return AE_BAD_PARAMETER;
+
 	wmi_swap_bytes(tmp, guid_input);
 
 	list_for_each(p, &wmi_blocks.list) {
@@ -211,10 +213,10 @@ static bool find_guid(const char *guid_string, struct 
wmi_block **out)
 		if (memcmp(block->guid, guid_input, 16) == 0) {
 			if (out)
 				*out = wblock;
-			return 1;
+			return AE_OK;
 		}
 	}
-	return 0;
+	return AE_NOT_FOUND;
 }
 
 /*
@@ -241,8 +243,10 @@ u32 method_id, const struct acpi_buffer *in, struct 
acpi_buffer *out)
 	union acpi_object params[3];
 	char method[4] = "WM";
 
-	if (!find_guid(guid_string, &wblock))
-		return AE_BAD_ADDRESS;
+	status = find_guid(guid_string, &wblock);
+
+	if (ACPI_FAILURE(status))
+		return status;
 
 	block = &wblock->gblock;
 	handle = wblock->handle;
@@ -303,7 +307,9 @@ struct acpi_buffer *out)
 	if (!guid_string || !out)
 		return AE_BAD_PARAMETER;
 
-	if (!find_guid(guid_string, &wblock))
+	status = find_guid(guid_string, &wblock);
+
+	if (ACPI_FAILURE(status))
 		return AE_BAD_ADDRESS;
 
 	block = &wblock->gblock;
@@ -377,6 +383,7 @@ const struct acpi_buffer *in)
 	struct guid_block *block = NULL;
 	struct wmi_block *wblock = NULL;
 	acpi_handle handle;
+	acpi_status status;
 	struct acpi_object_list input;
 	union acpi_object params[2];
 	char method[4] = "WS";
@@ -384,7 +391,9 @@ const struct acpi_buffer *in)
 	if (!guid_string || !in)
 		return AE_BAD_DATA;
 
-	if (!find_guid(guid_string, &wblock))
+	status = find_guid(guid_string, &wblock);
+
+	if (ACPI_FAILURE(status))
 		return AE_BAD_ADDRESS;
 
 	block = &wblock->gblock;
@@ -427,12 +436,14 @@ acpi_status wmi_install_notify_handler(const char *guid,
 wmi_notify_handler handler, void *data)
 {
 	struct wmi_block *block;
+	acpi_status status;
 
 	if (!guid || !handler)
 		return AE_BAD_PARAMETER;
 
-	find_guid(guid, &block);
-	if (!block)
+	status = find_guid(guid, &block);
+
+	if (ACPI_FAILURE(status))
 		return AE_NOT_EXIST;
 
 	if (block->handler)
@@ -453,12 +464,14 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
 acpi_status wmi_remove_notify_handler(const char *guid)
 {
 	struct wmi_block *block;
+	acpi_status status;
 
 	if (!guid)
 		return AE_BAD_PARAMETER;
 
-	find_guid(guid, &block);
-	if (!block)
+	status = find_guid(guid, &block);
+
+	if (ACPI_FAILURE(status))
 		return AE_NOT_EXIST;
 
 	if (!block->handler)
@@ -507,15 +520,21 @@ acpi_status wmi_get_event_data(u32 event, struct 
acpi_buffer *out)
 EXPORT_SYMBOL_GPL(wmi_get_event_data);
 
 /**
- * wmi_has_guid - Check if a GUID is available
+ * wmi_is_guid_present - Check if a GUID is available
  * @guid_string: 36 char string of the form 
fa50ff2b-f2e8-45de-83fa-65417f2f49ba
  *
  * Check if a given GUID is defined by _WDG
  */
-bool wmi_has_guid(const char *guid_string)
+acpi_status wmi_is_guid_present(const char *guid_string)
 {
 	return find_guid(guid_string, NULL);
 }
+EXPORT_SYMBOL_GPL(wmi_is_guid_present);
+
+bool wmi_has_guid(const char *guid_string)
+{
+	return ACPI_SUCCESS(find_guid(guid_string, NULL));
+}
 EXPORT_SYMBOL_GPL(wmi_has_guid);
 
 /*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 702f79d..26f9c0a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -198,6 +198,7 @@ extern acpi_status wmi_install_notify_handler(const char 
*guid,
 					wmi_notify_handler handler, void *data);
 extern acpi_status wmi_remove_notify_handler(const char *guid);
 extern acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out);
+extern acpi_status wmi_is_guid_present(const char *guid);
 extern bool wmi_has_guid(const char *guid);
 
 #endif	/* CONFIG_ACPI_WMI */
