From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/4] cpuidle : move driver checking within the lock section
Date: Tue, 25 Sep 2012 00:43:52 +0200
Message-ID: <1348526634-19029-3-git-send-email-daniel.lezcano@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43162 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2IXWoB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 18:44:01 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so2539837wib.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Sep 2012 15:44:00 -0700 (PDT)
In-Reply-To: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, pdeschrijver@nvidia.com, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

The code checks if the driver is already set without taking the lock,
but, right after, it takes the lock to assign the variable.

If it is safe to check the variable without lock, then it is safe to
assign it without lock. If it is unsafe to assign without a lock, then
it is unsafe to check it without a lock.

I don't find a path in the different drivers where that could happen
because the arch specific drivers are written in such way it is not
possible to register a driver while it is unregistered, except maybe
in a very improbable case when "intel_idle" and "processor_idle" are
competing. One could unregister a driver, while the other one is
registering.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 39ba8e1..4a0c4ab 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -85,17 +85,17 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
+	spin_lock(&cpuidle_driver_lock);
+
 	if (drv != cpuidle_curr_driver) {
 		WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
 			drv->name);
-		return;
+		goto out;
 	}
 
-	spin_lock(&cpuidle_driver_lock);
-
 	if (!WARN_ON(drv->refcnt > 0))
 		cpuidle_curr_driver = NULL;
-
+out:
 	spin_unlock(&cpuidle_driver_lock);
 }
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
-- 
1.7.5.4

