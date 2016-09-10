From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 27/30] ACPI-processor: Delete an unnecessary initialisation in
 acpi_processor_reevaluate_tstate()
Date: Sat, 10 Sep 2016 12:09:39 +0200
Message-ID: <a6081414-e656-534c-6cf0-2e0cd8115810@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:54647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbcIJKJt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 06:09:49 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 21:42:34 +0200

The local variable "result" will be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 994f21c..d22bcfc 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -377,7 +377,7 @@ int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
 void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
 					unsigned long action)
 {
-	int result = 0;
+	int result;
 
 	if (action == CPU_DEAD)
 		/* When one CPU is offline, the T-state throttling
-- 
2.10.0

