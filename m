From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ghes: fix error return code in ghes_probe()
Date: Mon, 3 Jun 2013 10:08:39 +0800
Message-ID: <CAPgLHd8ONsRjZr9vKMiSR3ZgD7nD8mg+x3pM88+U6DPB=bO_XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:38419 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab3FCCIl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jun 2013 22:08:41 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg9so1249933bkc.34
        for <linux-acpi@vger.kernel.org>; Sun, 02 Jun 2013 19:08:39 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, ying.huang@intel.com, wfp5p@virginia.edu, mchehab@redhat.com, gregkh@linuxfoundation.org
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code in the acpi_gsi_to_irq() and
request_irq() error handling case instead of 0, as done elsewhere
in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/apei/ghes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 403baf4..fcd7d91 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -919,13 +919,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		break;
 	case ACPI_HEST_NOTIFY_EXTERNAL:
 		/* External interrupt vector is GSI */
-		if (acpi_gsi_to_irq(generic->notify.vector, &ghes->irq)) {
+		rc = acpi_gsi_to_irq(generic->notify.vector, &ghes->irq);
+		if (rc) {
 			pr_err(GHES_PFX "Failed to map GSI to IRQ for generic hardware error source: %d\n",
 			       generic->header.source_id);
 			goto err_edac_unreg;
 		}
-		if (request_irq(ghes->irq, ghes_irq_func,
-				0, "GHES IRQ", ghes)) {
+		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
+		if (rc) {
 			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
 			       generic->header.source_id);
 			goto err_edac_unreg;

