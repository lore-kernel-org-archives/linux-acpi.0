From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/20] ACPICA: Update comment: no functional change.
Date: Tue, 29 Oct 2013 09:29:57 +0800
Message-ID: <a144048b82c692c1e4cd2a7a4aaea106634128f2.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13734 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2BaF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:05 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Adds a comment to clarify reason for using ACPI_FREE_BUFFER directly
instead of ACPI_FREE.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c |    2 +-
 include/acpi/actypes.h         |   10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index a6e3bca..ce2a845 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -139,7 +139,7 @@ acpi_evaluate_object_typed(acpi_handle handle,
 
 		/* Caller used ACPI_ALLOCATE_BUFFER, free the return buffer */
 
-		ACPI_FREE(return_buffer->pointer);
+		ACPI_FREE_BUFFER(*return_buffer);
 		return_buffer->pointer = NULL;
 	}
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 63909d9..0bb23e6 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -919,9 +919,13 @@ struct acpi_buffer {
 	void *pointer;		/* pointer to buffer */
 };
 
-/* Free a buffer created in an struct acpi_buffer via ACPI_ALLOCATE_LOCAL_BUFFER */
-
-#define ACPI_FREE_BUFFER(b)         ACPI_FREE(b.pointer)
+/*
+ * Free a buffer created in an struct acpi_buffer via ACPI_ALLOCATE_BUFFER.
+ * Note: We use acpi_os_free here because acpi_os_allocate was used to allocate
+ * the buffer. This purposefully bypasses the internal allocation tracking
+ * mechanism (if it is enabled).
+ */
+#define ACPI_FREE_BUFFER(b)         acpi_os_free((b).pointer)
 
 /*
  * name_type for acpi_get_name
-- 
1.7.10

