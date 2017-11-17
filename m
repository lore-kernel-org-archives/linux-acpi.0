From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 15/15] ACPICA: Update version to 20171110
Date: Fri, 17 Nov 2017 15:42:30 -0800
Message-ID: <20171117234230.913-16-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39440 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161767AbdKQXqq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:46 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d0ef5a72ca7c01acbf590e4556d19edf69a5b5c4

Version 20171110.

Link: https://github.com/acpica/acpica/commit/d0ef5a72
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f25668cce946..e02610adc07d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20170929
+#define ACPI_CA_VERSION                 0x20171110
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.13.6

