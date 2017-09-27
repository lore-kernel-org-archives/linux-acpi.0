From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 1/4] ACPICA: Add SMMUv3 device ID mapping index support
Date: Wed, 27 Sep 2017 09:20:12 +0800
Message-ID: <1506475215-2731-2-git-send-email-hanjun.guo@linaro.org>
References: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:56694 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965519AbdI0BUf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Sep 2017 21:20:35 -0400
Received: by mail-pg0-f54.google.com with SMTP id 7so6862824pgd.13
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2017 18:20:34 -0700 (PDT)
In-Reply-To: <1506475215-2731-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

SMMUv3 device ID mapping index is used for SMMUv3
MSIs, update the IORT to support that.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 686b6f8..d90277e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -810,6 +810,7 @@ struct acpi_iort_smmu_v3 {
 	u8 pxm;
 	u8 reserved1;
 	u16 reserved2;
+	u32 id_mapping_index;
 };
 
 /* Values for Model field above */
-- 
1.9.1

