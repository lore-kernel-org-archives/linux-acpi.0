From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/20] ACPICA: Update version to 20150818.
Date: Tue, 25 Aug 2015 10:30:48 +0800
Message-ID: <8497b6dbdb6fcad41a97948f43c104c11f20a3a4.1440402549.git.lv.zheng@intel.com>
References: <cover.1440402549.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4966 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932766AbbHYCbJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2015 22:31:09 -0400
In-Reply-To: <cover.1440402549.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d93470de8febeecdc20633fde11cb0b200fa773b

Version 20150818.

Link: https://github.com/acpica/acpica/commit/d93470de
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d3d7ea0..c33eeab 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20150717
+#define ACPI_CA_VERSION                 0x20150818
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

