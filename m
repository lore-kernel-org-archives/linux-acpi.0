From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 11/11] ACPICA: Update version to 20170929
Date: Fri, 17 Nov 2017 15:40:24 -0800
Message-ID: <20171117234024.833-12-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:7763 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759566AbdKQXpd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:33 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 2399a7799d6e41ec5beca77ddff3acc77e1a4e0a

Version 20170929

Link: https://github.com/acpica/acpica/commit/2399a779
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1a4322db0274..f25668cce946 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20170831
+#define ACPI_CA_VERSION                 0x20170929
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.13.6

