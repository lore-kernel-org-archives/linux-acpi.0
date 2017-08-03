From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/15] ACPICA: EFI/EDK2: Sort acpi.h inclusion order
Date: Thu,  3 Aug 2017 14:26:44 +0800
Message-ID: <48d8502fa12b8e303ae2ee5454cd45c6ce93d766.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:40407 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdHCG0s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:26:48 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Shao Ming <smbest163@163.com>

From: Shao Ming <smbest163@163.com>

ACPICA commit 43ff22215f0fcd8ca80abec5712a07d2cc9a801d

acpi.h inclusion order need to be changed to build EDK-II ports of
acpidump on Windows as va_list is used before it's definition in that
environment. As we only need to ensure order of acenv.h/acenvex.h to
be pre/post ACPICA type definitions, inclusion order is changed to make
MSVC builds happy. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/43ff2221
Signed-off-by: "Shao, Ming" <smbest163@163.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Shao Ming <smbest163@163.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
index ca03662..0887d7c 100644
--- a/include/acpi/acpi.h
+++ b/include/acpi/acpi.h
@@ -58,10 +58,10 @@
 #include <acpi/actypes.h>		/* ACPICA data types and structures */
 #include <acpi/acexcep.h>		/* ACPICA exceptions */
 #include <acpi/actbl.h>		/* ACPI table definitions */
-#include <acpi/acoutput.h>		/* Error output and Debug macros */
 #include <acpi/acrestyp.h>		/* Resource Descriptor structs */
+#include <acpi/platform/acenvex.h>	/* Extra environment-specific items */
+#include <acpi/acoutput.h>		/* Error output and Debug macros */
 #include <acpi/acpiosxf.h>		/* OSL interfaces (ACPICA-to-OS) */
 #include <acpi/acpixf.h>		/* ACPI core subsystem external interfaces */
-#include <acpi/platform/acenvex.h>	/* Extra environment-specific items */
 
 #endif				/* __ACPI_H__ */
-- 
2.7.4

