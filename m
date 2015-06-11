From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2] ACPICA: Add values for MADT GIC version field for ACPI 6.0
Date: Thu, 11 Jun 2015 17:51:04 +0800
Message-ID: <1434016264-4801-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32778 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbFKJvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2015 05:51:42 -0400
Received: by pdjn11 with SMTP id n11so1521541pdj.0
        for <linux-acpi@vger.kernel.org>; Thu, 11 Jun 2015 02:51:41 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>

ACPI 6.0 specified MADT generic distributor version values, but
the detail definition is missing in ACPICA version 20150515, add
its support in this patch which is needed for ARM64 ACPI based
GIC init.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
Hi Lv, Rafael,
   Could you help merge this patch for 4.2? It should be in the ACPICA
release of 20150515, but we missed that chance. This patch will be needed
for ARM64 GIC init and I prepare to upstream those patches in 4.3, so if
this patch accpeted in 4.2, it will have less dedenpence for ACPICA core
and ARM64 GIC code in next kernel version.

This patch was accepted by Bob and merged into ACPICA tree, I reworked
it on top of linux ACPICA.

Thanks
Hanjun

 include/acpi/actbl1.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index cadf21c..d382de8 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -834,6 +834,17 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 
+/* Values for Version field above */
+
+enum acpi_madt_gic_version {
+	ACPI_MADT_GIC_VERSION_NONE	= 0,
+	ACPI_MADT_GIC_VERSION_V1	= 1,
+	ACPI_MADT_GIC_VERSION_V2	= 2,
+	ACPI_MADT_GIC_VERSION_V3	= 3,
+	ACPI_MADT_GIC_VERSION_V4	= 4,
+	ACPI_MADT_GIC_VERSION_RESERVED	= 5	/* 5 and greater are reserved */
+};
+
 /* 13: Generic MSI Frame (ACPI 5.1) */
 
 struct acpi_madt_generic_msi_frame {
-- 
1.9.1

