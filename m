From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 05/30] ACPI-processor: Rename jump labels in
 acpi_processor_preregister_performance()
Date: Sat, 10 Sep 2016 11:42:36 +0200
Message-ID: <2a98baa3-3685-ba87-67c3-f9855d19bb02@users.sourceforge.net>
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
Date: Tue, 6 Sep 2016 12:38:40 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 1ebe580..2fc82e7 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -621,12 +621,12 @@ int acpi_processor_preregister_performance(
 
 		if (pr->performance) {
 			retval = -EBUSY;
-			goto err_out;
+			goto unlock;
 		}
 
 		if (!performance || !per_cpu_ptr(performance, i)) {
 			retval = -EINVAL;
-			goto err_out;
+			goto unlock;
 		}
 	}
 
@@ -644,7 +644,7 @@ int acpi_processor_preregister_performance(
 		}
 	}
 	if (retval)
-		goto err_ret;
+		goto clear_cpu;
 
 	/*
 	 * Now that we have _PSD data from all CPUs, lets setup P-state 
@@ -689,12 +689,12 @@ int acpi_processor_preregister_performance(
 
 			if (match_pdomain->num_processors != count_target) {
 				retval = -EINVAL;
-				goto err_ret;
+				goto clear_cpu;
 			}
 
 			if (pdomain->coord_type != match_pdomain->coord_type) {
 				retval = -EINVAL;
-				goto err_ret;
+				goto clear_cpu;
 			}
 
 			cpumask_set_cpu(j, covered_cpus);
@@ -719,8 +719,7 @@ int acpi_processor_preregister_performance(
 				     pr->performance->shared_cpu_map);
 		}
 	}
-
-err_ret:
+ clear_cpu:
 	for_each_possible_cpu(i) {
 		pr = per_cpu(processors, i);
 		if (!pr || !pr->performance)
@@ -734,8 +733,7 @@ err_ret:
 		}
 		pr->performance = NULL; /* Will be set for real in register */
 	}
-
-err_out:
+ unlock:
 	mutex_unlock(&performance_mutex);
 	free_cpumask_var(covered_cpus);
 	return retval;
-- 
2.10.0

