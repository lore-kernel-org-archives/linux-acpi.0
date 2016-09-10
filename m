From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 21/30] ACPI-processor: Rename jump labels in
 acpi_processor_get_tsd()
Date: Sat, 10 Sep 2016 12:03:50 +0200
Message-ID: <33b12770-ce37-1d9b-2a3f-b263981d502b@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63215 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755625AbcIJKEC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 06:04:02 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 20:50:12 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 24bd97f..2e3ef48 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -605,13 +605,13 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 	if (!tsd || (tsd->type != ACPI_TYPE_PACKAGE)) {
 		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	if (tsd->package.count != 1) {
 		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	pdomain = &(pr->throttling.domain_info);
@@ -624,19 +624,19 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Invalid _TSD data\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	if (pdomain->num_entries != ACPI_TSD_REV0_ENTRIES) {
 		printk(KERN_ERR PREFIX "Unknown _TSD:num_entries\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	if (pdomain->revision != ACPI_TSD_REV0_REVISION) {
 		printk(KERN_ERR PREFIX "Unknown _TSD:revision\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	pthrottling = &pr->throttling;
@@ -654,8 +654,7 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 		pthrottling->tsd_valid_flag = 0;
 		pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
 	}
-
-      end:
+ free_buffer:
 	kfree(buffer.pointer);
 	return result;
 }
-- 
2.10.0

