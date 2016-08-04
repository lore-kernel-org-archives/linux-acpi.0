From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/30] ACPICA: EFI: Port acpidump to EDK2 environment
Date: Thu,  4 Aug 2016 16:45:32 +0800
Message-ID: <4e3fc451d9b510ec6ad3623754cf6bb58de5d81b.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45089 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932351AbcHDIpj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:45:39 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 790b8bae858d6d97da6099c9f8485d4760035a0c

Linux kernel is not affected by this change.

Link: https://github.com/acpica/acpica/commit/790b8bae
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h   |    2 +-
 include/acpi/platform/acenvex.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 3dbfa27..f9af0e0 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -220,7 +220,7 @@
  * included after including all other host environmental definitions, in
  * order to override the definitions.
  */
-#elif defined(_AED_EFI) || defined(_GNU_EFI)
+#elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
 #include "acefi.h"
 
 #else
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index b672615..58ca39c 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -67,7 +67,7 @@
  * included after including all other host environmental definitions, in
  * order to override the definitions.
  */
-#elif defined(_AED_EFI) || defined(_GNU_EFI)
+#elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
 #include "acefiex.h"
 
 #endif
-- 
1.7.10

