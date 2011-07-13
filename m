From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 08/17] ACPI, APEI, GHES, Support disable GHES at boot time
Date: Wed, 13 Jul 2011 13:14:19 +0800
Message-ID: <1310534068-30547-9-git-send-email-ying.huang@intel.com>
References: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Some machine may have broken firmware so that GHES and firmware first
mode should be disabled.  This patch adds support to that.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/apei/ghes.c |    8 ++++++++
 drivers/acpi/apei/hest.c |   17 +++++++++--------
 include/acpi/apei.h      |    1 +
 3 files changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -77,6 +77,9 @@ struct ghes {
 	};
 };
 
+int ghes_disable;
+module_param_named(disable, ghes_disable, bool, 0);
+
 static int ghes_panic_timeout	__read_mostly = 30;
 
 /*
@@ -665,6 +668,11 @@ static int __init ghes_init(void)
 		return -EINVAL;
 	}
 
+	if (ghes_disable) {
+		pr_info(GHES_PFX "GHES is not enabled!\n");
+		return -EINVAL;
+	}
+
 	rc = ghes_ioremap_init();
 	if (rc)
 		goto err;
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -231,16 +231,17 @@ void __init acpi_hest_init(void)
 		goto err;
 	}
 
-	rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
-	if (rc)
-		goto err;
-
-	rc = hest_ghes_dev_register(ghes_count);
-	if (!rc) {
-		pr_info(HEST_PFX "Table parsing has been initialized.\n");
-		return;
+	if (!ghes_disable) {
+		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
+		if (rc)
+			goto err;
+		rc = hest_ghes_dev_register(ghes_count);
+		if (rc)
+			goto err;
 	}
 
+	pr_info(HEST_PFX "Table parsing has been initialized.\n");
+	return;
 err:
 	hest_disable = 1;
 }
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -18,6 +18,7 @@
 
 extern int hest_disable;
 extern int erst_disable;
+extern int ghes_disable;
 
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
