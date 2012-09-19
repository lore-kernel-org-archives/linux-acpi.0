From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/3] cpuidle : rename function name "__cpuidle_register_driver"
Date: Wed, 19 Sep 2012 19:22:48 +0200
Message-ID: <1348075369-16451-2-git-send-email-daniel.lezcano@linaro.org>
References: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60411 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab2ISRWz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Sep 2012 13:22:55 -0400
Received: by wgbdr13 with SMTP id dr13so1029695wgb.1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Sep 2012 10:22:54 -0700 (PDT)
In-Reply-To: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

Clarify the purpose of the function by changing its name and
move the condition out of this function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 40cd3f3..774d2cb 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -17,9 +17,10 @@
 static struct cpuidle_driver *cpuidle_curr_driver;
 DEFINE_SPINLOCK(cpuidle_driver_lock);
 
-static void __cpuidle_register_driver(struct cpuidle_driver *drv)
+static void set_power_states(struct cpuidle_driver *drv)
 {
 	int i;
+
 	/*
 	 * cpuidle driver should set the drv->power_specified bit
 	 * before registering if the driver provides
@@ -34,10 +35,8 @@ static void __cpuidle_register_driver(struct cpuidle_driver *drv)
 	 * an power value of -1.  So we use -2, -3, etc, for other
 	 * c-states.
 	 */
-	if (!drv->power_specified) {
-		for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++)
-			drv->states[i].power_usage = -1 - i;
-	}
+	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++)
+		drv->states[i].power_usage = -1 - i;
 }
 
 
@@ -58,8 +57,10 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 		spin_unlock(&cpuidle_driver_lock);
 		return -EBUSY;
 	}
-	__cpuidle_register_driver(drv);
-	cpuidle_curr_driver = drv;
+
+	if (!drv->power_specified)
+		set_power_states(drv);
+
 	spin_unlock(&cpuidle_driver_lock);
 
 	return 0;
-- 
1.7.5.4

