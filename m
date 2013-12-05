From: al.stone@linaro.org
Subject: [PATCH] ACPI: correct minor typos
Date: Thu,  5 Dec 2013 11:14:16 -0700
Message-ID: <1386267256-9506-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39468 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab3LESO0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 13:14:26 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so30698978ief.10
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2013 10:14:25 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Correct "coolign" to "cooling" and "*_ptg" to "*_pctg" as intended.

This changes comment text only.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/processor_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index d1d2e7f..1ea79739 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -186,14 +186,14 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 
 #endif
 
-/* thermal coolign device callbacks */
+/* thermal cooling device callbacks */
 static int acpi_processor_max_state(struct acpi_processor *pr)
 {
 	int max_state = 0;
 
 	/*
 	 * There exists four states according to
-	 * cpufreq_thermal_reduction_ptg. 0, 1, 2, 3
+	 * cpufreq_thermal_reduction_pctg. 0, 1, 2, 3
 	 */
 	max_state += cpufreq_get_max_state(pr->id);
 	if (pr->flags.throttling)
-- 
1.8.3.1

