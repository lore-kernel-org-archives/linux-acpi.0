From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v2] ACPI / PMIC: constify platform_device_id
Date: Wed, 29 Nov 2017 10:05:02 +0530
Message-ID: <317de9ac1d1ff31fd568ca7be10d2e4fd6be1f90.1511929854.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33371 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbdK2Ef0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Nov 2017 23:35:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, andy@infradead.org, mika.westerberg@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             Resend all changes as single patch.

 drivers/acpi/pmic/intel_pmic_bxtwc.c | 2 +-
 drivers/acpi/pmic/intel_pmic_chtwc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index 85636d7..813b829 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -260,7 +260,7 @@ static int intel_cht_wc_pmic_opregion_probe(struct platform_device *pdev)
 			&intel_cht_wc_pmic_opregion_data);
 }
 
-static struct platform_device_id cht_wc_opregion_id_table[] = {
+static const struct platform_device_id cht_wc_opregion_id_table[] = {
 	{ .name = "cht_wcove_region" },
 	{},
 };
-- 
1.9.1

