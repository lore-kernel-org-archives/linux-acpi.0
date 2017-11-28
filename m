From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/2] ACPI / PMIC: Constify platform_device_id
Date: Tue, 28 Nov 2017 15:31:51 +0530
Message-ID: <c75963e7a2e955795e18b15fe3f8ebfb2cf1cfef.1511863076.git.arvind.yadav.cs@gmail.com>
References: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
References: <cover.1511863076.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, mika.westerberg@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/pmic/intel_pmic_bxtwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index 90011aa..2012d1d 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -400,7 +400,7 @@ static int intel_bxtwc_pmic_opregion_probe(struct platform_device *pdev)
 			&intel_bxtwc_pmic_opregion_data);
 }
 
-static struct platform_device_id bxt_wc_opregion_id_table[] = {
+static const struct platform_device_id bxt_wc_opregion_id_table[] = {
 	{ .name = "bxt_wcove_region" },
 	{},
 };
-- 
1.9.1
