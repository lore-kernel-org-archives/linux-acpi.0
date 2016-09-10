From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 09/30] ACPI-processor: Improve a size determination in
 acpi_processor_get_psd()
Date: Sat, 10 Sep 2016 11:50:13 +0200
Message-ID: <e40acdeb-e2ba-0812-c1e0-f4f9175d819d@users.sourceforge.net>
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
Date: Tue, 6 Sep 2016 18:48:37 +0200

Replace the specification of a data structure by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 3f94279..b7e2f51 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -556,7 +556,7 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 
 	pdomain = &(pr->performance->domain_info);
 
-	state.length = sizeof(struct acpi_psd_package);
+	state.length = sizeof(*pdomain);
 	state.pointer = pdomain;
 
 	status = acpi_extract_package(&(psd->package.elements[0]),
-- 
2.10.0
