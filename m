From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 2/3] GHES: Move memory initialisation to ghes_probe()
Date: Tue,  1 Aug 2017 14:36:07 +0100
Message-ID: <20170801133608.21017-3-punit.agrawal@arm.com>
References: <20170801133608.21017-1-punit.agrawal@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752202AbdHANhG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Aug 2017 09:37:06 -0400
In-Reply-To: <20170801133608.21017-1-punit.agrawal@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Punit Agrawal <punit.agrwal@arm.com>, James Morse <james.morse@arm.com>

During the driver init, the ghes driver initialises some data structures
which are only used if a GHES platform device is probed. Similarly, the
init function also checks for support for firmware first mode.

Create a function, ghes_common_init(), that performs the initialisations
and checks that are currently performed on driver init. The function is
called when the GHES device is probed.

Delaying initialisation and checks until probe has the added benefit of
reducing driver prints on systems that do not support ACPI APEI.

Signed-off-by: Punit Agrawal <punit.agrwal@arm.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 007b38abcb34..befb18338acb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1088,12 +1088,53 @@ static inline void ghes_nmi_init_cxt(void)
 }
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
+static int ghes_common_init(void)
+{
+	int rc;
+	static bool initialised;
+
+	if (initialised)
+		return 0;
+
+	ghes_nmi_init_cxt();
+
+	rc = ghes_ioremap_init();
+	if (rc)
+		goto err;
+
+	rc = ghes_estatus_pool_init();
+	if (rc)
+		goto err_ioremap_exit;
+
+	rc = apei_osc_setup();
+	if (rc == 0 && osc_sb_apei_support_acked)
+		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit and WHEA _OSC.\n");
+	else if (rc == 0 && !osc_sb_apei_support_acked)
+		pr_info(GHES_PFX "APEI firmware first mode is enabled by WHEA _OSC.\n");
+	else if (rc && osc_sb_apei_support_acked)
+		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
+	else
+		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
+
+	initialised = true;
+	return 0;
+
+err_ioremap_exit:
+	ghes_ioremap_exit();
+err:
+	return rc;
+}
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes = NULL;
 
-	int rc = -EINVAL;
+	int rc;
+
+	rc = ghes_common_init();
+	if (rc)
+		return rc;
 
 	generic = *(struct acpi_hest_generic **)ghes_dev->dev.platform_data;
 	if (!generic->enabled)
@@ -1268,8 +1309,6 @@ static struct platform_driver ghes_platform_driver = {
 
 static int __init ghes_init(void)
 {
-	int rc;
-
 	if (acpi_disabled)
 		return -ENODEV;
 
@@ -1283,36 +1322,6 @@ static int __init ghes_init(void)
 		return -EINVAL;
 	}
 
-	ghes_nmi_init_cxt();
-
-	rc = ghes_ioremap_init();
-	if (rc)
-		goto err;
-
-	rc = ghes_estatus_pool_init();
-	if (rc)
-		goto err_ioremap_exit;
-
-	rc = platform_driver_register(&ghes_platform_driver);
-	if (rc)
-		goto err_pool_exit;
-
-	rc = apei_osc_setup();
-	if (rc == 0 && osc_sb_apei_support_acked)
-		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit and WHEA _OSC.\n");
-	else if (rc == 0 && !osc_sb_apei_support_acked)
-		pr_info(GHES_PFX "APEI firmware first mode is enabled by WHEA _OSC.\n");
-	else if (rc && osc_sb_apei_support_acked)
-		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
-	else
-		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
-
-	return 0;
-err_pool_exit:
-	ghes_estatus_pool_exit();
-err_ioremap_exit:
-	ghes_ioremap_exit();
-err:
-	return rc;
+	return platform_driver_register(&ghes_platform_driver);
 }
 device_initcall(ghes_init);
-- 
2.11.0

