From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/16] ACPICA: Update version to 20130517
Date: Sat,  8 Jun 2013 09:01:37 +0800
Message-ID: <b3e4f6edabc8edd6f5c2a5c230393dae4bf5d323.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46310 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445Ab3FHBB4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:01:56 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Version 20130517.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 5d9bf46..1b09300 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20130418
+#define ACPI_CA_VERSION                 0x20130517
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

