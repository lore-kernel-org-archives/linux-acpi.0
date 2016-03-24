From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/30] ACPICA: Headers: Update DMAR table for October 2014 I/O spec
Date: Thu, 24 Mar 2016 09:39:21 +0800
Message-ID: <e4813afd96946e3b30a19df17f73f27d001574cf.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 454b2ea5f0c254e97612e15994f7d4734a7931ea

Adds two flags to the DMAR table.

Link: https://github.com/acpica/acpica/commit/454b2ea5
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d6bd377..c93dbad 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -404,7 +404,7 @@ struct acpi_table_dbgp {
  *        Version 1
  *
  * Conforms to "Intel Virtualization Technology for Directed I/O",
- * Version 2.2, Sept. 2013
+ * Version 2.3, October 2014
  *
  ******************************************************************************/
 
@@ -418,6 +418,8 @@ struct acpi_table_dmar {
 /* Masks for Flags field above */
 
 #define ACPI_DMAR_INTR_REMAP        (1)
+#define ACPI_DMAR_X2APIC_OPT_OUT    (1<<1)
+#define ACPI_DMAR_X2APIC_MODE       (1<<2)
 
 /* DMAR subtable header */
 
-- 
1.7.10
