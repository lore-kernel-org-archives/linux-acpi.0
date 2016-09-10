From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 16/30] ACPI-processor: Use kmalloc_array() in
 acpi_processor_get_throttling_states()
Date: Sat, 10 Sep 2016 11:58:04 +0200
Message-ID: <09d308b2-b16f-ee86-fb15-7fd11e902018@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:65454 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752805AbcIJJ6N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 05:58:13 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 19:15:02 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus reuse the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index c72e648..0a46b7f 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -533,9 +533,10 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 			  tss->package.count));
 
 	pr->throttling.state_count = tss->package.count;
-	pr->throttling.states_tss =
-	    kmalloc(sizeof(struct acpi_processor_tx_tss) * tss->package.count,
-		    GFP_KERNEL);
+	pr->throttling.states_tss = kmalloc_array(tss->package.count,
+						  sizeof(*pr->
+							 throttling.states_tss),
+						  GFP_KERNEL);
 	if (!pr->throttling.states_tss) {
 		result = -ENOMEM;
 		goto end;
-- 
2.10.0

