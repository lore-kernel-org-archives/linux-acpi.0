From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 06/30] ACPI-processor: Move a success indication in
 acpi_processor_preregister_performance()
Date: Sat, 10 Sep 2016 11:44:01 +0200
Message-ID: <72f31d34-3efd-346d-1738-a57dea9df710@users.sourceforge.net>
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
Date: Tue, 6 Sep 2016 13:03:56 +0200

The local variable "retval" was initialised with a zero at the beginning
as an indication for a successful function execution despite of
the possibility that following function calls could fail.
Move the desired assignment down to the source code place where some system
clean-up is performed.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 2fc82e7..417e181 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -595,7 +595,7 @@ int acpi_processor_preregister_performance(
 		struct acpi_processor_performance __percpu *performance)
 {
 	int count_target;
-	int retval = 0;
+	int retval;
 	unsigned int i, j;
 	cpumask_var_t covered_cpus;
 	struct acpi_processor *pr;
@@ -719,6 +719,8 @@ int acpi_processor_preregister_performance(
 				     pr->performance->shared_cpu_map);
 		}
 	}
+
+	retval = 0;
  clear_cpu:
 	for_each_possible_cpu(i) {
 		pr = per_cpu(processors, i);
-- 
2.10.0
