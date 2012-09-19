From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/3] cpuidle : remove trailing carriage return
Date: Wed, 19 Sep 2012 19:22:49 +0200
Message-ID: <1348075369-16451-3-git-send-email-daniel.lezcano@linaro.org>
References: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58631 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613Ab2ISRW4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Sep 2012 13:22:56 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1415928wib.1
        for <linux-acpi@vger.kernel.org>; Wed, 19 Sep 2012 10:22:56 -0700 (PDT)
In-Reply-To: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

This mindless patch is just about removing some trailing
carriage returns.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 774d2cb..fc8bfc2 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -39,7 +39,6 @@ static void set_power_states(struct cpuidle_driver *drv)
 		drv->states[i].power_usage = -1 - i;
 }
 
-
 /**
  * cpuidle_register_driver - registers a driver
  * @drv: the driver
@@ -65,7 +64,6 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_register_driver);
 
 /**
@@ -93,5 +91,4 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
 	cpuidle_curr_driver = NULL;
 	spin_unlock(&cpuidle_driver_lock);
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
-- 
1.7.5.4

