From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 22/22] ACPICA: Update version to 20150717.
Date: Thu, 23 Jul 2015 12:54:30 +0800
Message-ID: <f27d857c1c3efae64f017bb62a37212d574bf408.1437627017.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29494 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754128AbbGWEyh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:54:37 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 8580ce04c1b7aa415c364b06e79edb8aca77dded

Version 20150717.

Link: https://github.com/acpica/acpica/commit/8580ce04
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9aa27a3..f2e2327 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20150619
+#define ACPI_CA_VERSION                 0x20150717
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

