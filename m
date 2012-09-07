From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/6] cpuidle : add a pointer for cpuidle_state in the cpuidle_device
Date: Fri,  7 Sep 2012 12:19:30 +0200
Message-ID: <1347013172-12465-5-git-send-email-daniel.lezcano@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46113 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651Ab2IGKTs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 06:19:48 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1284302bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 03:19:47 -0700 (PDT)
In-Reply-To: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

This patch adds a pointer to the cpuidle_state array in the cpuidle_device
structure. When the cpuidle_device is initialized, the pointer is assigned
from the driver's cpuidle states array.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/cpuidle/cpuidle.c |    4 +++-
 include/linux/cpuidle.h   |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index e28f6ea..ef0e936 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -317,8 +317,10 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 		return 0;
 	if (!drv || !cpuidle_curr_governor)
 		return -EIO;
-	if (!dev->state_count)
+	if (!dev->state_count) {
 		dev->state_count = drv->state_count;
+		dev->states = drv->states;
+	}
 
 	if (dev->registered == 0) {
 		ret = __cpuidle_register_device(dev);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 279b1ea..5cf18b5 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -96,6 +96,7 @@ struct cpuidle_device {
 
 	int			last_residency;
 	int			state_count;
+	struct cpuidle_state    *states;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 
-- 
1.7.5.4

