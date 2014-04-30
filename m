From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/27] ACPICA: Update version to 20140424.
Date: Wed, 30 Apr 2014 10:06:30 +0800
Message-ID: <5966390450f6161f69844cdc69fbbc5a0da64fd9.1398817613.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9873 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403AbaD3CGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2014 22:06:53 -0400
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Version 20140424.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b3b2108..4e3044c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20140325
+#define ACPI_CA_VERSION                 0x20140424
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
1.7.10

