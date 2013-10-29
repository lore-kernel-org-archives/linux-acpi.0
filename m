From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/20] ACPICA: Add a check for a null node during namespace walk.
Date: Tue, 29 Oct 2013 09:29:04 +0800
Message-ID: <816367734222c4128d01f167e189db252dcce093.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35902 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757088Ab3J2B3N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:13 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Mostly for consistency. ACPICA BZ 1042.

Actually, currently no one is experiencing problem without this check as
the obj_handle is guaranteed to be valid.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1042
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsdump.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 8063385..c634854 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -715,6 +715,13 @@ acpi_ns_dump_one_object_path(acpi_handle obj_handle,
 	}
 
 	node = acpi_ns_validate_handle(obj_handle);
+	if (!node) {
+
+		/* Ignore bad node during namespace walk */
+
+		return (AE_OK);
+	}
+
 	pathname = acpi_ns_get_external_pathname(node);
 
 	path_indent = 1;
-- 
1.7.10

