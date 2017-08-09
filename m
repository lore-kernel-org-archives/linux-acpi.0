From: Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC PATCH 1/4] ACPICA: Add SMMUv3 device ID mapping index support
Date: Wed, 9 Aug 2017 18:53:34 +0800
Message-ID: <1502276017-63108-2-git-send-email-guohanjun@huawei.com>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:3482 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdHILEJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2017 07:04:09 -0400
In-Reply-To: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

SMMUv3 device ID mapping index is used for SMMUv3
MSIs, update the IORT to support that.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d568948..e9a9842 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -809,6 +809,7 @@ struct acpi_iort_smmu_v3 {
 	u8 pxm;
 	u8 reserved1;
 	u16 reserved2;
+	u32 id_mapping_index;
 };
 
 /* Values for Model field above */
-- 
1.7.12.4

