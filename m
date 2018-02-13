From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 7/7] ACPICA: Update version to 20180209
Date: Tue, 13 Feb 2018 10:52:22 -0800
Message-ID: <20180213185222.12441-8-erik.schmauss@intel.com>
References: <20180213185222.12441-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19327 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965509AbeBMSxB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Feb 2018 13:53:01 -0500
In-Reply-To: <20180213185222.12441-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 6e3468837f9f32f64c7d0a6e20bf0d2579411d43

Version 20180209.

Link: https://github.com/acpica/acpica/commit/6e346883
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 84c946882589..ecd22e45ce3b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20180105
+#define ACPI_CA_VERSION                 0x20180209
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.14.3

