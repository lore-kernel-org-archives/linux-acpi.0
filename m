From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] ACPI / PMIC: AXP288: use builtin_platform_driver
Date: Fri, 18 Nov 2016 22:12:25 +0800
Message-ID: <7746cfe83ca3e96ccdf503669db3ace0e3081b7f.1479455552.git.geliangtang@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36303 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbcKROO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Nov 2016 09:14:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index e6e991a..32abbb9 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -258,8 +258,4 @@ static struct platform_driver intel_xpower_pmic_opregion_driver = {
 	},
 };
 
-static int __init intel_xpower_pmic_opregion_driver_init(void)
-{
-	return platform_driver_register(&intel_xpower_pmic_opregion_driver);
-}
-device_initcall(intel_xpower_pmic_opregion_driver_init);
+builtin_platform_driver(intel_xpower_pmic_opregion_driver);
-- 
2.9.3

