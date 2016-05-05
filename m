From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 13/13] ACPICA: Update version to 20160422
Date: Thu,  5 May 2016 13:00:42 +0800
Message-ID: <c5d3df8f98ad55e17e0c259d8a7c1db536c8989d.1462418912.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com> <cover.1462418912.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29288 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297AbcEEFA4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 May 2016 01:00:56 -0400
In-Reply-To: <cover.1462418912.git.lv.zheng@intel.com>
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

