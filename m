From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/27] ACPICA: Resource Manager: Add a pointer cast for a namespace node.
Date: Mon, 31 Dec 2012 08:05:58 +0800
Message-ID: <8d0d4cea5b4e4384d226722dc360e5bca0edb94f.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36731 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:10 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: "Rafael J. Wysocki" <rjw@sisk.pl>

Add a missing cast for a namespace node pointer passed in from
an external interface. Reported Rafael Wysocki.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsutils.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 5adae5a..41b8103 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -677,7 +677,9 @@ acpi_rs_get_method_data(acpi_handle handle,
 	/* Execute the method, no parameters */
 
 	status =
-	    acpi_ut_evaluate_object(handle, path, ACPI_BTYPE_BUFFER, &obj_desc);
+	    acpi_ut_evaluate_object(ACPI_CAST_PTR
+				    (struct acpi_namespace_node, handle), path,
+				    ACPI_BTYPE_BUFFER, &obj_desc);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-- 
1.7.10

