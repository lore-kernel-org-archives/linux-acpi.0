From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 12/30] ACPI-processor: Rename jump labels in
 acpi_processor_ppc_notifier()
Date: Sat, 10 Sep 2016 11:54:20 +0200
Message-ID: <8fb3294e-fe35-6494-b1ce-3fa7620e6f61@users.sourceforge.net>
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
Date: Tue, 6 Sep 2016 19:04:05 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/processor_perflib.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 07e5e59..86256bd 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -90,18 +90,17 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
 
 	pr = per_cpu(processors, policy->cpu);
 	if (!pr || !pr->performance)
-		goto out;
+		goto unlock;
 
 	ppc = (unsigned int)pr->performance_platform_limit;
 
 	if (ppc >= pr->performance->state_count)
-		goto out;
+		goto unlock;
 
 	cpufreq_verify_within_limits(policy, 0,
 				     pr->performance->states[ppc].
 				     core_frequency * 1000);
-
-      out:
+ unlock:
 	mutex_unlock(&performance_mutex);
 
 	return 0;
-- 
2.10.0

