From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 03/11] ACPI, APEI, Print resource errors in conventional format
Date: Thu,  8 Dec 2011 11:25:42 +0800
Message-ID: <1323314750-8185-4-git-send-email-ying.huang@intel.com>
References: <1323314750-8185-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323314750-8185-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use the normal %pR-like format for MMIO and I/O port ranges.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/apei-base.c |    8 ++++----
 drivers/acpi/apei/einj.c      |   11 ++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -460,9 +460,9 @@ int apei_resources_request(struct apei_r
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
@@ -472,9 +472,9 @@ int apei_resources_request(struct apei_r
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
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -209,9 +209,10 @@ static int __einj_error_trigger(u64 trig
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
@@ -232,9 +233,9 @@ static int __einj_error_trigger(u64 trig
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
