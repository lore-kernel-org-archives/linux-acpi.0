From: tianyu.lan@intel.com
Subject: [PATCH] ACPI/Processor: Remove acpi_processor_get_limit_info()
Date: Tue, 13 Aug 2013 10:07:58 +0800
Message-ID: <1376359678-5826-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50530 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737Ab3HMCQa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Aug 2013 22:16:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

acpi_processor_get_limit_info() is only called in the __acpi_processor_start()
and what it does actually is just to check pr->flags.throttling and set limit.
The pr pointer has been checked in the __acpi_processor_start() before
acpi_processor_get_limit_info() being called. It doesn't make sense still to
keep it as a function. So move code to __acpi_processor_start() and remove
acpi_processor_get_limit_info().

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/processor_driver.c  |  4 +++-
 drivers/acpi/processor_thermal.c | 12 ------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bd11ef9..e534ba6 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -175,7 +175,9 @@ static int __acpi_processor_start(struct acpi_device *device)
 	acpi_processor_load_module(pr);
 #endif
 	acpi_processor_get_throttling_info(pr);
-	acpi_processor_get_limit_info(pr);
+
+	if (pr->flags.throttling)
+		pr->flags.limit = 1;
 
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index e8e6527..d1d2e7f 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -186,18 +186,6 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 
 #endif
 
-int acpi_processor_get_limit_info(struct acpi_processor *pr)
-{
-
-	if (!pr)
-		return -EINVAL;
-
-	if (pr->flags.throttling)
-		pr->flags.limit = 1;
-
-	return 0;
-}
-
 /* thermal coolign device callbacks */
 static int acpi_processor_max_state(struct acpi_processor *pr)
 {
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

