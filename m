From: "Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH] ACPI, APEI: Fix BERT resources conflict with ACPI NVS area
Date: Tue, 14 Feb 2017 10:01:13 +0800
Message-ID: <20170214020143.29713-1-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:64271 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdBNCCW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Feb 2017 21:02:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>, Fu Wei <fu.wei@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

It was reported that some firmware will use ACPI NVS area for BERT
address range.  This will cause resources conflict because the ACPI
NVS area is marked as busy already.  Fix this via excluding ACPI NVS
area when requesting IO resources for BERT.

Reported-and-tested-by: Hans Kristian Rosbach <hansr@raskesider.no>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 drivers/acpi/apei/bert.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index a05b5c0cf181..12771fcf0417 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -97,6 +97,7 @@ static int __init bert_check_table(struct acpi_table_bert *bert_tab)
 
 static int __init bert_init(void)
 {
+	struct apei_resources bert_resources;
 	struct acpi_bert_region *boot_error_region;
 	struct acpi_table_bert *bert_tab;
 	unsigned int region_len;
@@ -127,13 +128,14 @@ static int __init bert_init(void)
 	}
 
 	region_len = bert_tab->region_length;
-	if (!request_mem_region(bert_tab->address, region_len, "APEI BERT")) {
-		pr_err("Can't request iomem region <%016llx-%016llx>.\n",
-		       (unsigned long long)bert_tab->address,
-		       (unsigned long long)bert_tab->address + region_len - 1);
-		return -EIO;
-	}
-
+	apei_resources_init(&bert_resources);
+	rc = apei_resources_add(&bert_resources, bert_tab->address,
+				region_len, true);
+	if (rc)
+		return rc;
+	rc = apei_resources_request(&bert_resources, "APEI BERT");
+	if (rc)
+		goto out_fini;
 	boot_error_region = ioremap_cache(bert_tab->address, region_len);
 	if (boot_error_region) {
 		bert_print_all(boot_error_region, region_len);
@@ -142,7 +144,9 @@ static int __init bert_init(void)
 		rc = -ENOMEM;
 	}
 
-	release_mem_region(bert_tab->address, region_len);
+	apei_resources_release(&bert_resources);
+out_fini:
+	apei_resources_fini(&bert_resources);
 
 	return rc;
 }
-- 
2.11.0

