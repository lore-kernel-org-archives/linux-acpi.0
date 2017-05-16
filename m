From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH v3] ACPI / APEI: Boot Error Record Table processing was needlessly complicated
Date: Tue, 16 May 2017 15:58:06 -0700
Message-ID: <20170516225806.5702-1-tony.luck@intel.com>
References: <5174133f-2588-eda1-4f98-0e457f16af0d@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:60319 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbdEPW6g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 18:58:36 -0400
In-Reply-To: <5174133f-2588-eda1-4f98-0e457f16af0d@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Quoting version 6.1 of the ACPI specification. Section 18.3.1 "Boot
Error Source" says:

  The Boot Error Region is a range of addressable memory OSPM can access
  during initialization to determine if an unhandled error condition
  occurred. System firmware must report this memory range as firmware
  reserved. The format of the Boot Error Region follow that of an Error
  Status Block, this is defined in Section 18.3.2.7. The format of the
  error status block is described by Table 18-342.

This clarifies some points that were obfuscated in earlier versions.
E.g. there is no longer a separate table to describe the format of the
"Boot Error Region" (which was identical to the "Error Status Block").
Also saying "follow that of *an* Error Status Block" makes it clear that
there is just one block (which can still contain multiple "Generic Error
Data Entry structures").

The loop inside bert_print_all() is unnecessary (but probably harmless
as the "while (remain > sizeof(struct acpi_bert_region))" loop should
terminate after we skipped over the first entry.

We can drop the "bert_print_all()" function and just move the four
relevant lines inline in "bert_init()".

Cc: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

v3:
1)  Back to just one patch (second part to delete the unused structure
    definition can fly later via ACPICA tree).
2)  Tyler Baicur ran some tests that included non-standard error support
    and found that with an invalid BERT record the kernel loops forever
    printing "section type: unknown" messages. He recommended putting
    back the cper_estatus_check() test that I'd dropped. Here's the net
    diff since v2:

                if (boot_error_region->block_status) {
+                       rc = cper_estatus_check(boot_error_region);
+                       if (rc) {
+                               pr_err(FW_BUG "Invalid error record.\n");
+                               iounmap(boot_error_region);
+                               return rc;
+                       }
                        pr_info("Error records from previous boot:\n");

 drivers/acpi/apei/bert.c | 60 +++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 12771fcf0417..2cf4c6441821 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -34,50 +34,6 @@
 
 static int bert_disable;
 
-static void __init bert_print_all(struct acpi_bert_region *region,
-				  unsigned int region_len)
-{
-	struct acpi_hest_generic_status *estatus =
-		(struct acpi_hest_generic_status *)region;
-	int remain = region_len;
-	u32 estatus_len;
-
-	if (!estatus->block_status)
-		return;
-
-	while (remain > sizeof(struct acpi_bert_region)) {
-		if (cper_estatus_check(estatus)) {
-			pr_err(FW_BUG "Invalid error record.\n");
-			return;
-		}
-
-		estatus_len = cper_estatus_len(estatus);
-		if (remain < estatus_len) {
-			pr_err(FW_BUG "Truncated status block (length: %u).\n",
-			       estatus_len);
-			return;
-		}
-
-		pr_info_once("Error records from previous boot:\n");
-
-		cper_estatus_print(KERN_INFO HW_ERR, estatus);
-
-		/*
-		 * Because the boot error source is "one-time polled" type,
-		 * clear Block Status of current Generic Error Status Block,
-		 * once it's printed.
-		 */
-		estatus->block_status = 0;
-
-		estatus = (void *)estatus + estatus_len;
-		/* No more error records. */
-		if (!estatus->block_status)
-			return;
-
-		remain -= estatus_len;
-	}
-}
-
 static int __init setup_bert_disable(char *str)
 {
 	bert_disable = 1;
@@ -89,7 +45,7 @@ __setup("bert_disable", setup_bert_disable);
 static int __init bert_check_table(struct acpi_table_bert *bert_tab)
 {
 	if (bert_tab->header.length < sizeof(struct acpi_table_bert) ||
-	    bert_tab->region_length < sizeof(struct acpi_bert_region))
+	    bert_tab->region_length < sizeof(struct acpi_hest_generic_status))
 		return -EINVAL;
 
 	return 0;
@@ -98,7 +54,7 @@ static int __init bert_check_table(struct acpi_table_bert *bert_tab)
 static int __init bert_init(void)
 {
 	struct apei_resources bert_resources;
-	struct acpi_bert_region *boot_error_region;
+	struct acpi_hest_generic_status *boot_error_region;
 	struct acpi_table_bert *bert_tab;
 	unsigned int region_len;
 	acpi_status status;
@@ -138,7 +94,17 @@ static int __init bert_init(void)
 		goto out_fini;
 	boot_error_region = ioremap_cache(bert_tab->address, region_len);
 	if (boot_error_region) {
-		bert_print_all(boot_error_region, region_len);
+		if (boot_error_region->block_status) {
+			rc = cper_estatus_check(boot_error_region);
+			if (rc) {
+				pr_err(FW_BUG "Invalid error record.\n");
+				iounmap(boot_error_region);
+				return rc;
+			}
+			pr_info("Error records from previous boot:\n");
+			cper_estatus_print(KERN_INFO HW_ERR, boot_error_region);
+			boot_error_region->block_status = 0;
+		}
 		iounmap(boot_error_region);
 	} else {
 		rc = -ENOMEM;
-- 
2.11.0

