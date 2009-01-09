From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/94] cpuidle: Add decaying history logic to menu idle
 predictor
Date: Fri, 09 Jan 2009 04:26:39 -0500
Message-ID: <816bb611e41be29b476dc16f6297eb551bf4d747.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbZAIJ23 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LFZ6ATLFF7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:06 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>

Add decaying history of predicted idle time, instead of using the last early
wakeup. This logic helps menu governor do better job of predicting idle time.

With this change, we also measured noticable (~8%) power savings on
a DP server system with CPUs supporting deep C states, when system
was lightly loaded. There was no change to power or perf on other load
conditions.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/governors/menu.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 8d7cf3f..f1df59f 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -15,12 +15,14 @@
 #include <linux/tick.h>
 
 #define BREAK_FUZZ	4	/* 4 us */
+#define PRED_HISTORY_PCT	50
 
 struct menu_device {
 	int		last_state_idx;
 
 	unsigned int	expected_us;
 	unsigned int	predicted_us;
+	unsigned int    current_predicted_us;
 	unsigned int	last_measured_us;
 	unsigned int	elapsed_us;
 };
@@ -47,6 +49,12 @@ static int menu_select(struct cpuidle_device *dev)
 	data->expected_us =
 		(u32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
 
+	/* Recalculate predicted_us based on prediction_history_pct */
+	data->predicted_us *= PRED_HISTORY_PCT;
+	data->predicted_us += (100 - PRED_HISTORY_PCT) *
+				data->current_predicted_us;
+	data->predicted_us /= 100;
+
 	/* find the deepest idle state that satisfies our constraints */
 	for (i = CPUIDLE_DRIVER_STATE_START + 1; i < dev->state_count; i++) {
 		struct cpuidle_state *s = &dev->states[i];
@@ -97,7 +105,7 @@ static void menu_reflect(struct cpuidle_device *dev)
 		measured_us = -1;
 
 	/* Predict time until next break event */
-	data->predicted_us = max(measured_us, data->last_measured_us);
+	data->current_predicted_us = max(measured_us, data->last_measured_us);
 
 	if (last_idle_us + BREAK_FUZZ <
 	    data->expected_us - target->exit_latency) {
-- 
1.5.6.6

