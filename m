From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 08/30] ACPI-processor: Delete two unnecessary initialisations
 in acpi_processor_get_psd()
Date: Sat, 10 Sep 2016 11:48:03 +0200
Message-ID: <62dcd023-b2ff-d02f-5371-f9648ad397ec@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:56760 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbcIJJsQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 05:48:16 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 13:55:52 +0200

The local variables "psd" and "status" will be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index c2813cc..3f94279 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -529,11 +529,11 @@ EXPORT_SYMBOL(acpi_processor_notify_smm);
 static int acpi_processor_get_psd(struct acpi_processor	*pr)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
+	acpi_status status;
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
 	struct acpi_buffer state = {0, NULL};
-	union acpi_object  *psd = NULL;
+	union acpi_object  *psd;
 	struct acpi_psd_package *pdomain;
 
 	status = acpi_evaluate_object(pr->handle, "_PSD", NULL, &buffer);
-- 
2.10.0

