From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPICA: Fix for ill-formed GUID strings for NFIT tables.
Date: Mon, 25 May 2015 08:15:35 +0800
Message-ID: <fe13b03972c910c701b6f5745b89c8d2d841545f.1432342221.git.lv.zheng@intel.com>
References: <cover.1432175162.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57132 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbbEYAPx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 May 2015 20:15:53 -0400
In-Reply-To: <cover.1432175162.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 60052949ba2aa7377106870da69b237193d10dc1

Error in transcription from the ACPI spec.

Link: https://github.com/acpica/acpica/commit/60052949
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acuuid.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 7c6cbb0..80fe8cf 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -69,14 +69,14 @@
 
 /* NVDIMM - NFIT table */
 
-#define UUID_VOLATILE_MEMORY            "4f940573-dafd-e344-b16c-3f22d252e5d0"
-#define UUID_PERSISTENT_MEMORY          "79d3f066-f3b4-7440-ac43-0d3318b78cdb"
-#define UUID_CONTROL_REGION             "f601f792-b413-5d40-910b-299367e8234c"
-#define UUID_DATA_REGION                "3005af91-865d-0e47-a6b0-0a2db9408249"
-#define UUID_VOLATILE_VIRTUAL_DISK      "5a53ab77-fc45-4b62-5560-f7b281d1f96e"
-#define UUID_VOLATILE_VIRTUAL_CD        "30bd5a3d-7541-ce87-6d64-d2ade523c4bb"
-#define UUID_PERSISTENT_VIRTUAL_DISK    "c902ea5c-074d-69d3-269f-4496fbe096f9"
-#define UUID_PERSISTENT_VIRTUAL_CD      "88810108-cd42-48bb-100f-5387d53ded3d"
+#define UUID_VOLATILE_MEMORY            "7305944f-fdda-44e3-b16c-3f22d252e5d0"
+#define UUID_PERSISTENT_MEMORY          "66f0d379-b4f3-4074-ac43-0d3318b78cdb"
+#define UUID_CONTROL_REGION             "92f701f6-13b4-405d-910b-299367e8234c"
+#define UUID_DATA_REGION                "91af0530-5d86-470e-a6b0-0a2db9408249"
+#define UUID_VOLATILE_VIRTUAL_DISK      "77ab535a-45fc-624b-5560-f7b281d1f96e"
+#define UUID_VOLATILE_VIRTUAL_CD        "3d5abd30-4175-87ce-6d64-d2ade523c4bb"
+#define UUID_PERSISTENT_VIRTUAL_DISK    "5cea02c9-4d07-69d3-269f-4496fbe096f9"
+#define UUID_PERSISTENT_VIRTUAL_CD      "08018188-42cd-bb48-100f-5387d53ded3d"
 
 /* Miscellaneous */
 
-- 
1.7.10

