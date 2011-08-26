From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ACPI, APEI, Print resource errors in conventional format
Date: Fri, 26 Aug 2011 11:10:53 -0600
Message-ID: <20110826171052.7959.94505.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:21590 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1HZRK6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Aug 2011 13:10:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Use the normal %pR-like format for MMIO and I/O port ranges.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/apei/apei-base.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

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

