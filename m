From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/53] ACPICA: Added two new UUID values
Date: Mon,  5 Jun 2017 16:37:30 +0800
Message-ID: <3f7209704a0c3399e7f81f6de53e64516f6fe277.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32218 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbdFEIhd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:37:33 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a0168a7aca421d195e1c2b609279fa4a967dd3ac

Processor Properties. ACPI 6.2

Link: https://github.com/acpica/acpica/commit/a0168a7a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acuuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 699a199..b1a0a8a 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -78,6 +78,11 @@
 #define UUID_PERSISTENT_VIRTUAL_DISK    "5cea02c9-4d07-69d3-269f-4496fbe096f9"
 #define UUID_PERSISTENT_VIRTUAL_CD      "08018188-42cd-bb48-100f-5387d53ded3d"
 
+/* Processor Properties (ACPI 6.2) */
+
+#define UUID_CACHE_PROPERTIES           "6DC63E77-257E-4E78-A973-A21F2796898D"
+#define UUID_PHYSICAL_PROPERTY          "DDE4D59A-AA42-4349-B407-EA40F57D9FB7"
+
 /* Miscellaneous */
 
 #define UUID_PLATFORM_CAPABILITIES      "0811b06e-4a27-44f9-8d60-3cbbc22e7b48"
-- 
2.7.4

