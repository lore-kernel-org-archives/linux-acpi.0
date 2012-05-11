From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v3 2/7] ACPI: Add an interface to evaluate _OST
Date: Fri, 11 May 2012 10:36:58 -0600
Message-ID: <1336754223-5346-3-git-send-email-toshi.kani@hp.com>
References: <1336754223-5346-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336754223-5346-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: bhelgaas@google.com, shuahkhan@gmail.com, liuj97@gmail.com, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

Added acpi_evaluate_hotplug_opt(). All ACPI hotplug handlers must call
this function when evaluating _OST for hotplug operations. 

When CONFIG_ACPI_HOTPLUG_OST is disabled, this function is a no-op and
has no effect on the platform.

When _OST is not present on the platform, this function returns
AE_NOT_FOUND and has no effect on the platform.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/utils.c    |   38 ++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |    3 +++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index b002a47..39d7349 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -382,3 +382,41 @@ acpi_evaluate_reference(acpi_handle handle,
 }
 
 EXPORT_SYMBOL(acpi_evaluate_reference);
+
+/*
+ * acpi_evaluate_hotplug_ost: Evaluate _OST for hotplug operations
+ * @handle: ACPI device handle
+ * @source_event: source event code
+ * @status_code: status code
+ * @status_buf: optional detailed information (NULL if none)
+ */
+acpi_status
+acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
+		u32 status_code, struct acpi_buffer *status_buf)
+{
+#ifdef CONFIG_ACPI_HOTPLUG_OST
+	union acpi_object params[3] = {
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_BUFFER,}
+	};
+	struct acpi_object_list arg_list = {3, params};
+	acpi_status status;
+
+	params[0].integer.value = source_event;
+	params[1].integer.value = status_code;
+	if (status_buf != NULL) {
+		params[2].buffer.pointer = status_buf->pointer;
+		params[2].buffer.length = status_buf->length;
+	} else {
+		params[2].buffer.pointer = NULL;
+		params[2].buffer.length = 0;
+	}
+
+	status = acpi_evaluate_object(handle, "_OST", &arg_list, NULL);
+	return status;
+#else
+	return AE_OK;
+#endif
+}
+EXPORT_SYMBOL(acpi_evaluate_hotplug_ost);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f1c8ca6..7309113 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -50,6 +50,9 @@ acpi_evaluate_reference(acpi_handle handle,
 			acpi_string pathname,
 			struct acpi_object_list *arguments,
 			struct acpi_handle_list *list);
+acpi_status
+acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
+			u32 status_code, struct acpi_buffer *status_buf);
 
 #ifdef CONFIG_ACPI
 
-- 
1.7.7.6
