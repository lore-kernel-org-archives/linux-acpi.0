From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 20/30] ACPI-processor: Fix jump targets in
 acpi_processor_get_throttling_info()
Date: Sat, 10 Sep 2016 12:02:22 +0200
Message-ID: <c7e47193-19f9-d165-a20f-f86688eb774e@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:57682 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755315AbcIJKCe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Sep 2016 06:02:34 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Sep 2016 20:32:46 +0200

1. Adjust jump targets according to the current Linux coding
   style convention.

2. Delete a duplicate check then at the end.

3. Omit the explicit initialisation for the local variable "result"
   at the beginning which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 8847bca..24bd97f 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -1184,7 +1184,7 @@ int acpi_processor_set_throttling(struct acpi_processor *pr,
 
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
-	int result = 0;
+	int result;
 	struct acpi_processor_throttling *pthrottling;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -1249,7 +1249,7 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 
 	result = acpi_processor_get_throttling(pr);
 	if (result)
-		goto end;
+		goto disable_throttling;
 
 	if (pr->throttling.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -1257,13 +1257,11 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 				  pr->throttling.state));
 		result = acpi_processor_set_throttling(pr, 0, false);
 		if (result)
-			goto end;
+			goto disable_throttling;
 	}
-
-      end:
-	if (result)
-		pr->flags.throttling = 0;
-
+	return 0;
+ disable_throttling:
+	pr->flags.throttling = 0;
 	return result;
 }
 
-- 
2.10.0

