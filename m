From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 13/30] ACPI-processor: Delete an unnecessary initialisation in
 acpi_processor_ppc_notifier()
Date: Sat, 10 Sep 2016 11:55:30 +0200
Message-ID: <9965aba5-4da1-6a28-8940-04228586b525@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:61992 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752102AbcIJJzj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 05:55:39 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 19:06:18 +0200

The local variable "ppc" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 86256bd..43f8eef 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -73,7 +73,7 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
 {
 	struct cpufreq_policy *policy = data;
 	struct acpi_processor *pr;
-	unsigned int ppc = 0;
+	unsigned int ppc;
 
 	if (event == CPUFREQ_START && ignore_ppc <= 0) {
 		ignore_ppc = 0;
-- 
2.10.0

