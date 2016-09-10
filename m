From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 26/30] ACPI-processor: Fix jump targets in
 acpi_processor_reevaluate_tstate()
Date: Sat, 10 Sep 2016 12:08:24 +0200
Message-ID: <ead11eae-dfb3-61db-a425-1d4531861c44@users.sourceforge.net>
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
Date: Tue, 6 Sep 2016 21:40:40 +0200

1. Adjust jump targets according to the current Linux coding
   style convention.

2. Delete a duplicate check then at the end.

3. Do not use curly brackets at two source code places
   where a single statement should be sufficient.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 0b4e058..994f21c 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -379,23 +379,19 @@ void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
 {
 	int result = 0;
 
-	if (action == CPU_DEAD) {
+	if (action == CPU_DEAD)
 		/* When one CPU is offline, the T-state throttling
 		 * will be invalidated.
 		 */
-		pr->flags.throttling = 0;
-		return;
-	}
+		goto disable_throttling;
 	/* the following is to recheck whether the T-state is valid for
 	 * the online CPU
 	 */
-	if (!pr->throttling.state_count) {
+	if (!pr->throttling.state_count)
 		/* If the number of T-state is invalid, it is
 		 * invalidated.
 		 */
-		pr->flags.throttling = 0;
-		return;
-	}
+		goto disable_throttling;
 	pr->flags.throttling = 1;
 
 	/* Disable throttling (if enabled).  We'll let subsequent
@@ -405,17 +401,16 @@ void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
 
 	result = acpi_processor_get_throttling(pr);
 	if (result)
-		goto end;
+		goto disable_throttling;
 
 	if (pr->throttling.state) {
 		result = acpi_processor_set_throttling(pr, 0, false);
 		if (result)
-			goto end;
+			goto disable_throttling;
 	}
-
-end:
-	if (result)
-		pr->flags.throttling = 0;
+	return;
+ disable_throttling:
+	pr->flags.throttling = 0;
 }
 /*
  * _PTC - Processor Throttling Control (and status) register location
-- 
2.10.0
