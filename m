From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/6] acpi : remove 'usage' field in acpi_processor_cx
Date: Fri, 11 Nov 2011 00:57:30 +0100
Message-ID: <1320969451-27218-6-git-send-email-daniel.lezcano@linaro.org>
References: <1320969451-27218-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:23240 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab1KKAFR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2011 19:05:17 -0500
In-Reply-To: <1320969451-27218-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rob.lee@linaro.org

The usage field is incremented but the resulting value is never
used in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    5 -----
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 142af72..4b9ebd5 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -778,7 +778,6 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 	dev->last_residency = (int)idle_time;
 
 	local_irq_enable();
-	cx->usage++;
 	lapic_timer_state_broadcast(pr, cx, 0);
 
 	return index;
@@ -858,8 +857,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	return index;
 }
@@ -983,8 +980,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (cx->entry_method != ACPI_CSTATE_FFH)
 		current_thread_info()->status |= TS_POLLING;
 
-	cx->usage++;
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	return index;
 }
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 46bcf79..bc3449a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -60,7 +60,6 @@ struct acpi_processor_cx {
 	u8 index;
 	u32 latency;
 	u32 power;
-	u32 usage;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
 };
-- 
1.7.4.1

