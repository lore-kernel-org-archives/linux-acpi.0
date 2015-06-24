From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 28/28] ACPICA: Update version to 20150619.
Date: Wed, 24 Jun 2015 11:05:55 +0800
Message-ID: <e305660a2fba096b7fd663301af779309196a7bb.1435114812.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33871 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964845AbbFXDGC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 23:06:02 -0400
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 2fcf4f4c95e6a4875f39a929f8f92ef50cc53bb5
ACPICA commit d7a940bb308d001b5d2b196174fee36c7daa61d6

Version 20150619.

Link: https://github.com/acpica/acpica/commit/2fcf4f4c
Link: https://github.com/acpica/acpica/commit/d7a940bb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 33b4675..c1e9578 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20150515
+#define ACPI_CA_VERSION                 0x20150619
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

