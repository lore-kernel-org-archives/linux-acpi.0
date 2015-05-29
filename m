From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPICA: Add MADT generic distributor version values for ACPI 6.0
Date: Fri, 29 May 2015 15:46:07 +0800
Message-ID: <1432885567-5924-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33367 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbbE2HqX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2015 03:46:23 -0400
Received: by padbw4 with SMTP id bw4so47988506pad.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 May 2015 00:46:22 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Al Stone <al.stone@linaro.org>, devel@acpica.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>

ACPI 6.0 specified MADT generic distributor version values, but
the detail definition is missing in ACPICA version 20150515, add
its support in this patch.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---

This is the linux version of GIC version patch, please
help to handle it, thanks!

 include/acpi/actbl1.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 06b61f0..a53530d1 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -835,6 +835,17 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 
+/* Values for version in Generic Distributor  (ACPI 6.0) */
+
+enum acpi_madt_gic_version_type {
+	ACPI_MADT_GIC_VER_UNKNOWN	= 0,
+	ACPI_MADT_GIC_VER_V1		= 1,
+	ACPI_MADT_GIC_VER_V2		= 2,
+	ACPI_MADT_GIC_VER_V3		= 3,
+	ACPI_MADT_GIC_VER_V4		= 4,
+	ACPI_MADT_GIC_VER_RESERVED	= 5	/* 5 and greater are reserved */
+};
+
 /* 13: Generic MSI Frame (ACPI 5.1) */
 
 struct acpi_madt_generic_msi_frame {
-- 
1.9.1

