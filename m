From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 17/53] ACPICA: Add support for new SRAT subtable
Date: Mon,  5 Jun 2017 16:38:47 +0800
Message-ID: <7385f815e3f1dbbae2658c2d0ecf6a5ce51a5db4.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23602 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbdFEIiu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:50 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5bc67f63918da249bfe279ee461d152bb3e6f55b

GIC ITS Affinity (ACPI 6.2)

Link: https://github.com/acpica/acpica/commit/5bc67f63
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 171fc51..6b8714a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1406,7 +1406,8 @@ enum acpi_srat_type {
 	ACPI_SRAT_TYPE_MEMORY_AFFINITY = 1,
 	ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY = 2,
 	ACPI_SRAT_TYPE_GICC_AFFINITY = 3,
-	ACPI_SRAT_TYPE_RESERVED = 4	/* 4 and greater are reserved */
+	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,	/* ACPI 6.2 */
+	ACPI_SRAT_TYPE_RESERVED = 5	/* 5 and greater are reserved */
 };
 
 /*
@@ -1478,6 +1479,15 @@ struct acpi_srat_gicc_affinity {
 
 #define ACPI_SRAT_GICC_ENABLED     (1)	/* 00: Use affinity structure */
 
+/* 4: GCC ITS Affinity (ACPI 6.2) */
+
+struct acpi_srat_gic_its_affinity {
+	struct acpi_subtable_header header;
+	u32 proximity_domain;
+	u16 reserved;
+	u32 its_id;
+};
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
2.7.4

