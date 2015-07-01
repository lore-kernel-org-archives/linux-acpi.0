From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 12/26] ACPICA: ACPI 6.0: Add values for MADT GIC version field.
Date: Wed,  1 Jul 2015 14:44:10 +0800
Message-ID: <551c6e6c5a36225afee1a5e65d4932ed5a06a538.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43606 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbbGAGof (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:44:35 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Bob Moore <robert.moore@intel.com>

From: Hanjun Guo <hanjun.guo@linaro.org>

ACPICA commit 4b100dc43e8baee8c8b4891b23bc7ad03eba6a28

Support for the new version field in the generic distributor
subtable. Hanjun Guo <hanjun.guo@linaro.org>

Link: https://github.com/acpica/acpica/commit/4b100dc4
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl1.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 06b61f0..fcd5709 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -835,6 +835,17 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 
+/* Values for Version field above */
+
+enum acpi_madt_gic_version {
+	ACPI_MADT_GIC_VERSION_NONE = 0,
+	ACPI_MADT_GIC_VERSION_V1 = 1,
+	ACPI_MADT_GIC_VERSION_V2 = 2,
+	ACPI_MADT_GIC_VERSION_V3 = 3,
+	ACPI_MADT_GIC_VERSION_V4 = 4,
+	ACPI_MADT_GIC_VERSION_RESERVED = 5	/* 5 and greater are reserved */
+};
+
 /* 13: Generic MSI Frame (ACPI 5.1) */
 
 struct acpi_madt_generic_msi_frame {
-- 
1.7.10

