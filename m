From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 1/7] ACPICA: Update an info message during table load phase.
Date: Tue, 18 Oct 2016 03:02:24 +0800
Message-ID: <be449908c55dd7804f07cdcfcee13f7f624d2c0c.1476725675.git.lv.zheng@intel.com>
References: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33203 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbcJQTCe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:02:34 -0400
Received: by mail-qt0-f193.google.com with SMTP id m5so6534890qtb.0
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:02:34 -0700 (PDT)
In-Reply-To: <cover.1476725675.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 1d435008fd9ea34768df8862de9cb6fff69650f6

Only emit an extra newline for acpiexec.

Link: https://github.com/acpica/acpica/commit/1d435008
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbxfload.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 5569f63..2599e831 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -239,7 +239,7 @@ acpi_status acpi_tb_load_namespace(void)
 	}
 
 	if (!tables_failed) {
-		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n", tables_loaded));
+		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", tables_loaded));
 	} else {
 		ACPI_ERROR((AE_INFO,
 			    "%u table load failures, %u successful",
@@ -250,6 +250,10 @@ acpi_status acpi_tb_load_namespace(void)
 		status = AE_CTRL_TERMINATE;
 	}
 
+#ifdef ACPI_APPLICATION
+	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT, "\n"));
+#endif
+
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
-- 
2.7.4

