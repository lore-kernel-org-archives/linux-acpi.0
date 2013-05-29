From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/7] ACPICA: Predefined name support: Remove unused local variable
Date: Wed, 29 May 2013 10:09:20 +0800
Message-ID: <79e0d7abeac9f6f4dfecd25efa23f78ede74cb3f.1367913047.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367913046.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48707 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934963Ab3E2CJ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 May 2013 22:09:27 -0400
In-Reply-To: <cover.1367913046.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

"Pathname" is no longer used.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nspredef.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 7ab7ddb..5c83a8b 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -104,13 +104,10 @@ acpi_ns_check_return_value(struct acpi_namespace_node *node,
 {
 	acpi_status status;
 	const union acpi_predefined_info *predefined;
-	char *pathname;
-
-	predefined = info->predefined;
-	pathname = info->full_pathname;
 
 	/* If not a predefined name, we cannot validate the return object */
 
+	predefined = info->predefined;
 	if (!predefined) {
 		return (AE_OK);
 	}
-- 
1.7.10

