From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH 2/4] ACPI: Add acpi_evaluate_ost() for calling _OST
Date: Tue, 10 Apr 2012 16:21:48 -0600
Message-ID: <1334096510-17319-3-git-send-email-toshi.kani@hp.com>
References: <1334096510-17319-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334096510-17319-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

Added a new function, acpi_evaluate_ost(), to utils.c.  This
function can be called from ACPI-based drivers / modules to
invoke ACPI _OST method.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/utils.c    |   34 ++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |    3 +++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index b002a47..09b48c3 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -382,3 +382,37 @@ acpi_evaluate_reference(acpi_handle handle,
 }
 
 EXPORT_SYMBOL(acpi_evaluate_reference);
+
+/*
+ * acpi_evaluate_ost: Evaluate ACPI OSPM Status Indication method
+ * @handle: ACPI device handle
+ * @source_event: source event code
+ * @status_code: status code
+ * @status_buf: optional detailed information (NULL if none)
+ */
+acpi_status
+acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
+		struct acpi_buffer *status_buf)
+{
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
+}
+EXPORT_SYMBOL(acpi_evaluate_ost);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f1c8ca6..0dac8cb 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -50,6 +50,9 @@ acpi_evaluate_reference(acpi_handle handle,
 			acpi_string pathname,
 			struct acpi_object_list *arguments,
 			struct acpi_handle_list *list);
+acpi_status
+acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
+			struct acpi_buffer *status_buf);
 
 #ifdef CONFIG_ACPI
 
-- 
1.7.7.6
