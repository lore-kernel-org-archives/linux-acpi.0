From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 6/6] ACPICA: Update version to 20180105
Date: Wed, 24 Jan 2018 15:42:34 -0800
Message-ID: <20180124234234.19828-7-erik.schmauss@intel.com>
References: <20180124234234.19828-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51889 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbeAXXnX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jan 2018 18:43:23 -0500
In-Reply-To: <20180124234234.19828-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

Version 20180105.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 285d0c602b80..c2bf1255f5aa 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20171215
+#define ACPI_CA_VERSION                 0x20180105
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.14.3

