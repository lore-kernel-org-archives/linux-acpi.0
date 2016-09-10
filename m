From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/30] ACPI-processor: Use kmalloc_array() in
 acpi_processor_get_performance_states()
Date: Sat, 10 Sep 2016 11:35:38 +0200
Message-ID: <b9ad0591-b67f-bc28-26da-4da394776b84@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 10:20:10 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus reuse the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index bb01dea..78f9025 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -346,9 +346,9 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 			  pss->package.count));
 
 	pr->performance->state_count = pss->package.count;
-	pr->performance->states =
-	    kmalloc(sizeof(struct acpi_processor_px) * pss->package.count,
-		    GFP_KERNEL);
+	pr->performance->states = kmalloc_array(pss->package.count,
+						sizeof(*pr->performance->states),
+						GFP_KERNEL);
 	if (!pr->performance->states) {
 		result = -ENOMEM;
 		goto end;
-- 
2.10.0

