From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 23/30] ACPI-processor: Improve a size determination in
 acpi_processor_get_tsd()
Date: Sat, 10 Sep 2016 12:05:28 +0200
Message-ID: <c24e83ad-a97b-1599-7891-5e8625ed1937@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 20:55:45 +0200

Replace the specification of a data structure by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index ea1e959..dcebb4b2 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -616,7 +616,7 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 
 	pdomain = &(pr->throttling.domain_info);
 
-	state.length = sizeof(struct acpi_tsd_package);
+	state.length = sizeof(*pdomain);
 	state.pointer = pdomain;
 
 	status = acpi_extract_package(&(tsd->package.elements[0]),
-- 
2.10.0
