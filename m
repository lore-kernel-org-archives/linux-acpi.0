From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/30] ACPICA: Headers: Add new constants for the DBG2 ACPI table
Date: Thu, 24 Mar 2016 09:38:42 +0800
Message-ID: <6816d604b4d3edf6bf07308273dfe5d3a95f7424.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24852 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbcCXBip (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2016 21:38:45 -0400
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Bob Moore <robert.moore@intel.com>

From: Aleksey Makarov <aleksey.makarov@linaro.org>

ACPICA commit 1607b69238df9c1b2940262a17aa94ec49033278

Link: https://github.com/acpica/acpica/commit/1607b692
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>.
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index a4ef625..7702b27 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -321,7 +321,7 @@ struct acpi_csrt_descriptor {
  * DBG2 - Debug Port Table 2
  *        Version 0 (Both main table and subtables)
  *
- * Conforms to "Microsoft Debug Port Table 2 (DBG2)", May 22 2012.
+ * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10, 2015
  *
  ******************************************************************************/
 
@@ -371,6 +371,11 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
+#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
+#define ACPI_DBG2_ARM_DCC           0x000F
+#define ACPI_DBG2_BCM2835           0x0010
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
1.7.10

