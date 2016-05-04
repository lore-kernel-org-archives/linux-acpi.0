From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/15] ACPICA: Update version to 20160422
Date: Wed,  4 May 2016 13:49:43 +0800
Message-ID: <e29accdf28d1cac35f58e5897dbc74dd647fe02c.1462331121.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48382 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757190AbcEDFtv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 May 2016 01:49:51 -0400
In-Reply-To: <cover.1462331120.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a2327ba410e19c2aabaf34b711dbadf7d1dcf346

Version 20160422.

Link: https://github.com/acpica/acpica/commit/a2327ba4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 366b364..4e4c214 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20160318
+#define ACPI_CA_VERSION                 0x20160422
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

