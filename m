From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6/6] cpuidle : add cpuidle_register_states function
Date: Fri,  7 Sep 2012 12:19:32 +0200
Message-ID: <1347013172-12465-7-git-send-email-daniel.lezcano@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50147 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651Ab2IGKTw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 06:19:52 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1284300bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 03:19:51 -0700 (PDT)
In-Reply-To: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

The tegra3 and big.LITTLE architecture have different cpu latencies.
This API allows to specify a different cpu latency for a specific cpu.

With the previous patches, we use the per cpuidle device states pointer,
this function overrides this pointer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/cpuidle/cpuidle.c |   21 +++++++++++++++++++++
 include/linux/cpuidle.h   |   10 +++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 062f54e..ebb10c9 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -487,6 +487,27 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
 
+int cpuidle_register_states(struct cpuidle_device *dev,
+			    struct cpuidle_state *states,
+			    int state_count)
+{
+	if (!dev || !states)
+		return -EINVAL;
+
+	if (state_count <= 0)
+		return -EINVAL;
+
+	cpuidle_pause_and_lock();
+
+	dev->states = states;
+	dev->state_count = state_count;
+
+	cpuidle_resume_and_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpuidle_register_states);
+
 #ifdef CONFIG_SMP
 
 static void smp_callback(void *v)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 5cf18b5..85cabfd 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -151,7 +151,9 @@ extern void cpuidle_driver_unref(void);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
 extern int cpuidle_register_device(struct cpuidle_device *dev);
 extern void cpuidle_unregister_device(struct cpuidle_device *dev);
-
+extern int cpuidle_register_states(struct cpuidle_device *dev,
+				   struct cpuidle_state *states,
+				   int state_count);
 extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern void cpuidle_pause(void);
@@ -163,7 +165,6 @@ extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
 				int (*enter)(struct cpuidle_device *dev,
 					struct cpuidle_driver *drv, int index));
 extern int cpuidle_play_dead(void);
-
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
@@ -176,7 +177,10 @@ static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
-
+static inline  int cpuidle_register_states(struct cpuidle_device *dev,
+					   struct cpuidle_state *states,
+					   int state_count)
+{ return -ENODEV; }
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline void cpuidle_pause(void) { }
-- 
1.7.5.4

