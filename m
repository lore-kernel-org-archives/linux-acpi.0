From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 7/7] ACPICA: Update version to 20160930
Date: Tue, 18 Oct 2016 03:04:13 +0800
Message-ID: <a25b454252f1968e435643802de1a733338af3a0.1476725675.git.lv.zheng@intel.com>
References: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34363 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935258AbcJQTE1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:04:27 -0400
Received: by mail-qk0-f196.google.com with SMTP id n189so14974091qke.1
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:04:27 -0700 (PDT)
In-Reply-To: <cover.1476725675.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit cb8dfc8157ae54aadb1beb31d996db9327438183

Version 20160930.

Link: https://github.com/acpica/acpica/commit/cb8dfc81
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 07ab21e..5c7356a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20160831
+#define ACPI_CA_VERSION                 0x20160930
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.7.4

