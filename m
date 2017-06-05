From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/53] ACPICA: Add new flags to HEST subtables
Date: Mon,  5 Jun 2017 16:38:32 +0800
Message-ID: <141849e777a76908d4916cac60ccf0616d5bbaa3.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10809 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbdFEIii (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:38 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c2c3807adb8a67e6462b731dc64be35d8b8317f8

Add GHES_ASSIST flag for ACPI 6.2
Add missing GLOBAL flag for AER structures

Link: https://github.com/acpica/acpica/commit/c2c3807a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index f57e94c..0673120 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -478,6 +478,7 @@ struct acpi_hest_aer_common {
 
 #define ACPI_HEST_FIRMWARE_FIRST        (1)
 #define ACPI_HEST_GLOBAL                (1<<1)
+#define ACPI_HEST_GHES_ASSIST           (1<<2)
 
 /*
  * Macros to access the bus/segment numbers in Bus field above:
-- 
2.7.4

