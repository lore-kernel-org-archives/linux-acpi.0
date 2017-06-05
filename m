From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 08/53] ACPICA: Tables: Fix defined values for MADT PCAT_COMPAT flag
Date: Mon,  5 Jun 2017 16:37:49 +0800
Message-ID: <b952167c3092b950866be1489931b81e8e922671.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:57832 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdFEIhw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:37:52 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Janosch Hildebrand <jnosh+git@jnosh.com>, Bob Moore <robert.moore@intel.com>

From: Janosch Hildebrand <jnosh+git@jnosh.com>

ACPICA commit c0292548a43bdc5d83d5be2953b663e60b6f12b4

fixes #224

Link: https://github.com/acpica/acpica/issues/224
Link: https://github.com/acpica/acpica/commit/c0292548
Signed-off-by: Janosch Hildebrand <jnosh+git@jnosh.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 49d5487..070f322 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -822,8 +822,8 @@ struct acpi_table_madt {
 
 /* Values for PCATCompat flag */
 
-#define ACPI_MADT_DUAL_PIC          0
-#define ACPI_MADT_MULTIPLE_APIC     1
+#define ACPI_MADT_DUAL_PIC          1
+#define ACPI_MADT_MULTIPLE_APIC     0
 
 /* Values for MADT subtable type in struct acpi_subtable_header */
 
-- 
2.7.4

