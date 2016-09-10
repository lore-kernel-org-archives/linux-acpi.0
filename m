From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 30/30] ACPI-processor: Improve jump targets in
 acpi_processor_update_tsd_coord()
Date: Sat, 10 Sep 2016 12:12:41 +0200
Message-ID: <2e07f4be-9036-6834-4603-3713073fb672@users.sourceforge.net>
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
Date: Tue, 6 Sep 2016 22:18:30 +0200

* Adjust jump targets according to the current Linux coding
  style convention.

* Delete a duplicate check then.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_throttling.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 79ba9b78..b45f6c3 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -97,11 +97,9 @@ static int acpi_processor_update_tsd_coord(void)
 		 */
 		if (!pthrottling->tsd_valid_flag) {
 			retval = -EINVAL;
-			break;
+			goto free_cpumask;
 		}
 	}
-	if (retval)
-		goto err_ret;
 
 	for_each_possible_cpu(i) {
 		pr = per_cpu(processors, i);
@@ -147,12 +145,12 @@ static int acpi_processor_update_tsd_coord(void)
 			 */
 			if (match_pdomain->num_processors != count_target) {
 				retval = -EINVAL;
-				goto err_ret;
+				goto free_cpumask;
 			}
 
 			if (pdomain->coord_type != match_pdomain->coord_type) {
 				retval = -EINVAL;
-				goto err_ret;
+				goto free_cpumask;
 			}
 
 			cpumask_set_cpu(j, covered_cpus);
@@ -180,8 +178,7 @@ static int acpi_processor_update_tsd_coord(void)
 				     pthrottling->shared_cpu_map);
 		}
 	}
-
-err_ret:
+ free_cpumask:
 	free_cpumask_var(covered_cpus);
 
 	for_each_possible_cpu(i) {
-- 
2.10.0
