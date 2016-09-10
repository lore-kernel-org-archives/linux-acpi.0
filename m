From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 03/30] ACPI-processor: Rename jump labels in
 acpi_processor_get_performance_states()
Date: Sat, 10 Sep 2016 11:40:11 +0200
Message-ID: <4d1d5a0d-a627-5566-e720-b5e3f2893558@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:56937 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752375AbcIJJkY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 05:40:24 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 11:27:45 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 004e24c..49889b1 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -339,7 +339,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	if (!pss || (pss->type != ACPI_TYPE_PACKAGE)) {
 		printk(KERN_ERR PREFIX "Invalid _PSS data\n");
 		result = -EFAULT;
-		goto end;
+		goto free_buffer;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d performance states\n",
@@ -351,7 +351,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 						GFP_KERNEL);
 	if (!pr->performance->states) {
 		result = -ENOMEM;
-		goto end;
+		goto free_buffer;
 	}
 
 	for (i = 0; i < pr->performance->state_count; i++) {
@@ -369,7 +369,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 			ACPI_EXCEPTION((AE_INFO, status, "Invalid _PSS data"));
 			result = -EFAULT;
 			kfree(pr->performance->states);
-			goto end;
+			goto free_buffer;
 		}
 
 		amd_fixup_frequency(px, i);
@@ -417,8 +417,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 
 	if (last_invalid > 0)
 		pr->performance->state_count = last_invalid;
-
-      end:
+ free_buffer:
 	kfree(buffer.pointer);
 
 	return result;
-- 
2.10.0

