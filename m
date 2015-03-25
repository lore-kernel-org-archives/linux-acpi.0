From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ACPI/PMIC: Fix typo in MODULE_DESCRIPTION in intel_pmic_crc.c
Date: Wed, 25 Mar 2015 23:13:08 +0900
Message-ID: <1427292788-6739-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, aaron.lu@intel.com
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This patch fix a spelling typo in MODULE_DESCRIPTION within intel_pmic_crc.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/acpi/pmic/intel_pmic_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic_crc.c b/drivers/acpi/pmic/intel_pmic_crc.c
index ef7d8ff..42df46a 100644
--- a/drivers/acpi/pmic/intel_pmic_crc.c
+++ b/drivers/acpi/pmic/intel_pmic_crc.c
@@ -207,5 +207,5 @@ static int __init intel_crc_pmic_opregion_driver_init(void)
 }
 module_init(intel_crc_pmic_opregion_driver_init);
 
-MODULE_DESCRIPTION("CrystalCove ACPI opration region driver");
+MODULE_DESCRIPTION("CrystalCove ACPI operation region driver");
 MODULE_LICENSE("GPL");
-- 
2.3.4.274.g92e625d
