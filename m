From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2] ACPI, APEI, Print resource errors in conventional format
Date: Tue, 30 Aug 2011 10:38:34 -0600
Message-ID: <20110830163834.13116.18371.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:36300 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab1H3QjA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Aug 2011 12:39:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Use the normal %pR-like format for MMIO and I/O port ranges.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/apei/apei-base.c |    8 ++++----
 drivers/acpi/apei/einj.c      |   11 ++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 8041248..8bd5f1a 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -460,9 +460,9 @@ int apei_resources_request(struct apei_resources *resources,
 				       desc);
 		if (!r) {
 			pr_err(APEI_PFX
-		"Can not request iomem region <%016llx-%016llx> for GARs.\n",
+		"Can not request [mem %#010llx-%#010llx] for %s registers\n",
 			       (unsigned long long)res->start,
-			       (unsigned long long)res->end);
+			       (unsigned long long)res->end - 1, desc);
 			res_bak = res;
 			goto err_unmap_iomem;
 		}
@@ -472,9 +472,9 @@ int apei_resources_request(struct apei_resources *resources,
 		r = request_region(res->start, res->end - res->start, desc);
 		if (!r) {
 			pr_err(APEI_PFX
-		"Can not request ioport region <%016llx-%016llx> for GARs.\n",
+		"Can not request [io  %#06llx-%#06llx] for %s registers\n",
 			       (unsigned long long)res->start,
-			       (unsigned long long)res->end);
+			       (unsigned long long)res->end - 1, desc);
 			res_bak = res;
 			goto err_unmap_ioport;
 		}
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 589b96c..d253902 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -209,9 +209,10 @@ static int __einj_error_trigger(u64 trigger_paddr)
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err(EINJ_PFX
-	"Can not request iomem region <%016llx-%016llx> for Trigger table.\n",
+	"Can not request [mem %#010llx-%#010llx] for Trigger table\n",
 		       (unsigned long long)trigger_paddr,
-		       (unsigned long long)trigger_paddr+sizeof(*trigger_tab));
+		       (unsigned long long)trigger_paddr +
+			    sizeof(*trigger_tab) - 1);
 		goto out;
 	}
 	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
@@ -232,9 +233,9 @@ static int __einj_error_trigger(u64 trigger_paddr)
 			       "APEI EINJ Trigger Table");
 	if (!r) {
 		pr_err(EINJ_PFX
-"Can not request iomem region <%016llx-%016llx> for Trigger Table Entry.\n",
-		       (unsigned long long)trigger_paddr+sizeof(*trigger_tab),
-		       (unsigned long long)trigger_paddr + table_size);
+"Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
+		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
+		       (unsigned long long)trigger_paddr + table_size - 1);
 		goto out_rel_header;
 	}
 	iounmap(trigger_tab);

