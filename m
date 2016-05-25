From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] acpi: cppc: Prevent cpc_desc_ptr points to the invalid data
Date: Wed, 25 May 2016 12:09:23 -0700
Message-ID: <1464203363-20599-1-git-send-email-hotran@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35044 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbcEYTKc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2016 15:10:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id g64so21390843pfb.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2016 12:10:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Duc Dang <dhdang@apm.com>, lho@apm.com, Hoan Tran <hotran@apm.com>

When CPPC fails to request PCC channel, the CPC data is freed
and cpc_desc_ptr points to the invalid data. This change prevents
this issue by moving cpc_desc_ptr assignment after PCC channel
request.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/acpi/cppc_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8adac69..85fd8f7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -595,9 +595,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
 
-	/* Plug it into this CPUs CPC descriptor. */
-	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
-
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
 	if (ret)
@@ -610,6 +607,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			goto out_free;
 	}
 
+	/* Plug PSD data into this CPUs CPC descriptor. */
+	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
+
 	/* Everything looks okay */
 	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
 
-- 
1.9.1

