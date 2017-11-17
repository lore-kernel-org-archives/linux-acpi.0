From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 04/15] ACPICA: iasl: Add SMMUv3 device ID mapping index support
Date: Fri, 17 Nov 2017 15:42:19 -0800
Message-ID: <20171117234230.913-5-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759953AbdKQXqh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:37 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Hanjun Guo <hanjun.guo@linaro.org>

ACPICA commit 5c371879e035122c5807752f42247fd091d107d6

SMMUv3 device ID mapping index is used for SMMUv3
MSI which is introduced in IORT spec revision c,
add its support for iasl.

Tested with iasl -t IORT then get the right SMMUv3
node in iort.asl.

Link: https://github.com/acpica/acpica/commit/5c371879
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2623f9d72e46..0d60d5df14f8 100644
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
2.13.6

