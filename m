From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 8/8] ACPICA: Update version to 20170831
Date: Fri, 17 Nov 2017 10:03:36 -0800
Message-ID: <20171117180336.15558-8-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117180336.15558-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161258AbdKQSIz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 13:08:55 -0500
In-Reply-To: <20171117180336.15558-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit faa9fdfbd035a14347e6a875be2a0cddb3e6fc00

Version 20170831.

Link: https://github.com/acpica/acpica/commit/faa9fdfb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 53c5e2f7bcec..e1dd1a8d42b6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20170728
+#define ACPI_CA_VERSION                 0x20170831
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.13.6

